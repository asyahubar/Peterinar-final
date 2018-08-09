<template>
    <div id="create">
        <h1>Add new visit</h1>
        <el-row :gutter="20">
            <el-col :span="12" :offset="6">
                <el-card class="box-card" shadow="always">
                    <el-form
                            :model="formData"
                            ref="formData"
                            label-width="120px"
                            class="demo-dynamic"
                            @submit.native.prevent
                    >
                        <el-form-item label="Visits time">
                            <el-col :span="11">
                                <el-date-picker type="date" placeholder="Pick a date" v-model="formData.date" style="width: 100%;"></el-date-picker>
                            </el-col>
                            <el-col class="line" :span="2">-</el-col>
                            <el-col :span="11">
                                <el-time-picker type="fixed-time" placeholder="Pick a time" v-model="formData.time" style="width: 100%;"></el-time-picker>
                            </el-col>
                        </el-form-item>
                        <el-form-item label="Owner">
                            <el-autocomplete
                                    v-model="pickedOwner"
                                    :fetch-suggestions="querySearchAsync"
                                    placeholder="Please choose"
                                    @select="handleSelect"
                            ></el-autocomplete>
                        </el-form-item>
                        <el-form-item label="Pet">
                            <el-select v-model="formData.petId" placeholder="Select">
                                <el-option
                                        v-for="item in pets"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="Visit type">
                            <el-select v-model="formData.visitTypeId" placeholder="Select">
                                <el-option
                                        v-for="item in visitTypes"
                                        :key="item.id"
                                        :label="item.title"
                                        :value="item.id">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="Overview">
                            <el-input
                                    type="textarea"
                                    :autosize="{ minRows: 2, maxRows: 4}"
                                    placeholder="Please input"
                                    v-model="formData.overview">
                            </el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button @click="submitForm" type="primary">Submit</el-button>
                        </el-form-item>
                    </el-form>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    export default {
        name: 'Create',
        data() {
            return {
                formData: {
                    date: '',
                    time: '',
                    ownerId: '',
                    petId: '',
                    visitTypeId: '',
                    overview: ''
                },
                owners: [],
                pickedOwner: '',
                timeout:  null,
                pets: [],
                visitTypes: []
            }
        },
        computed: {
            timestamp() {
                let ts = Date.parse(this.formData.time);
                ts = parseInt(ts.toString().substring(0, 10));
                return ts;
            }
        },
        methods: {
            submitForm() {
                let newData = {
                    date: this.timestamp,
                    overview: this.formData.overview,
                    customer_id: this.formData.ownerId,
                    pet_id: this.formData.petId,
                    visit_type_id: this.formData.visitTypeId
                };
                let isFull = 0;
                Object.keys(newData).forEach((key) => {
                    if (newData[key].length > 0) {
                        isFull++;
                    } else if (newData.date > 0) {
                        isFull++;
                    }
                });
                if (isFull === Object.keys(newData).length) {
                    this.axios
                        .post('http://localhost:9999/api/visit/add', this.formData)
                        .then(() => {
                            alert('added!');
                            this.$router.push('/all');
                        });
                }

            },
            handleSelect(item) {
                this.formData.ownerId = item.id;
                this.axios
                    .get('http://localhost:9999/api/owner/' + item.id + '/pets')
                    .then((response) => {
                        this.pets = response.data;
                    });
            },
            querySearchAsync(queryString, cb) {
                let picks = this.owners;
                let results = queryString ? picks.filter(this.createFilter(queryString)) : picks;
                clearTimeout(this.timeout);
                this.timeout = setTimeout(() => {
                    cb(results);
                }, 2000 * Math.random());
            },
            createFilter(queryString) {
                return (pick) => {
                    return (pick.name.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
                };
            },
            getOwners() {
                this.axios
                    .get('http://localhost:9999/api/owners')
                    .then((response) => {
                        this.owners = response.data;
                        this.owners.forEach((val) => {
                            val['value'] = val['name'];
                        })
                    });
            },
            getVisitTypes() {
                this.axios
                    .get('http://localhost:9999/api/visittypes')
                    .then((response) => {
                        this.visitTypes = response.data;
                    });
            }
        },
        mounted() {
            document.title = this.$options.name;
            this.getOwners();
            this.getVisitTypes();
        }
    }
</script>

<style>
    .el-card {
        background-color: #F2F6FC;
    }
</style>