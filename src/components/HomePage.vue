<template>
    <div id="homepage">
        <h1>Todays visits</h1>
        <el-row>
            <el-button @click="createLink">Add new visit</el-button>
            <el-button plain @click="logout">Log out</el-button>
        </el-row>
        <el-table
                v-loading="loading"
                :data="tableInfo"
                stripe
                border
                height="800"
                style="width: 80%; margin: auto">
            <el-table-column
                    prop="date"
                    label="Date"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="customer_id.name"
                    label="Booked by">
            </el-table-column>
            <el-table-column
                    prop="pet_id"
                    label="Pet"
                    width="300">
                <template slot-scope="scope">
                    {{ scope.row.pet_id.name }}
                    <img :src="scope.row.pet_id.image">
                </template>
            </el-table-column>
            <el-table-column
                    prop="visit_type_id.title"
                    label="Visit type">
            </el-table-column>
            <el-table-column
                    prop="id"
                    label="More">
                <template slot-scope="scope">
                    <el-button @click="editVisit(scope.row.id)" type="primary" icon="el-icon-edit" circle></el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
    export default {
        name: 'HomePage',
        data() {
            return {
                tableInfo: [],
                loading: true
            }
        },
        computed: {
        },
        mounted() {
            //TODO: axios request for visits data and save them into tableData as one
            setTimeout(this.loadData, 3000);
            document.title = this.$options.name;
        },
        methods: {
            loadData() {
                this.axios
                    .get('http://localhost:9999/api/visits')
                    .then((response) => {
                        this.tableInfo = response.data;
                        this.loading = false;
                    })
            },
            createLink() {
                this.$router.push({ path: '/create' });
            },
            editVisit(id) {
                this.$router.push({ path: '/edit/' + id });
            },
            logout() {}
        }
    }
</script>

<style>

</style>