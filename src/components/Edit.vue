<template>
    <div id="edit">
        <h1>Edit a visit</h1>
        <p>(doesn't work)</p>
        <el-row :gutter="20">
            <el-col :span="12" :offset="6">
                <el-card class="box-card" shadow="always">
                    <el-form
                            label-width="120px"
                            class="demo-dynamic"
                            @submit.native.prevent
                    >
                        <el-form-item label="Visits time">
                            <el-col :span="11">
                                <el-date-picker type="date" placeholder="Pick a date" style="width: 100%;"></el-date-picker>
                            </el-col>
                            <el-col class="line" :span="2">-</el-col>
                            <el-col :span="11">
                                <el-time-picker type="fixed-time" placeholder="Pick a time" style="width: 100%;"></el-time-picker>
                            </el-col>
                        </el-form-item>
                        <el-form-item label="Owner">
                            <el-autocomplete
                                    :fetch-suggestions="querySearchAsync"
                                    placeholder="Please choose"
                                    @select="handleSelect"
                            ></el-autocomplete>
                        </el-form-item>
                        <el-form-item label="Pet">
                            <el-select placeholder="Select">
                                <el-option>
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="Visit type">
                            <el-select placeholder="Select">
                                <el-option>
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="Overview">
                            <el-input
                                    type="textarea"
                                    :autosize="{ minRows: 2, maxRows: 4}"
                                    placeholder="Please input">
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
        name: 'Edit',
        data() {
            return {

            }
        },
        methods: {
            submitForm() {}
        }
    }
</script>

<style>

</style>