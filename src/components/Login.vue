<template>
    <div class="login">
        <el-row :gutter="20">
            <el-col :span="12" :offset="6">
                <el-card class="box-card" shadow="always">
                    <el-form
                        :model="dynamicValidateForm"
                        ref="dynamicValidateForm"
                        label-width="120px"
                        class="demo-dynamic"
                        @submit="submitForm('dynamicValidateForm')"
                    >

                        <el-form-item
                            prop="email"
                            label="Email"
                            :rules="[
                                { required: true, message: 'Please input email address', trigger: 'blur' },
                                { type: 'email', message: 'Please input correct email address', trigger: ['blur', 'change'] }
                            ]"
                        >
                            <el-input v-model="dynamicValidateForm.email"></el-input>
                        </el-form-item>

                        <el-form-item
                            label="Password"
                            prop="pass"
                            :rules="[
                                { required: true, message: 'Please input password', trigger: 'blur'}
                            ]"
                        >
                            <el-input
                                type="password"
                                v-model="dynamicValidateForm.pass"
                                auto-complete="off"
                            >
                            </el-input>
                        </el-form-item>

                        <el-form-item>
                            <el-button
                                type="primary"
                                @click="submitForm('dynamicValidateForm')"
                            >Submit</el-button>
                        </el-form-item>
                    </el-form>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    export default {
        name: 'Login',
        data() {
            return {
                dynamicValidateForm: {
                    email: '',
                    pass: ''
                }
            }
        },
        methods: {
            submitForm(formName) {
                // TODO: if POST request returns true, redirect to all todays visits page
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.axios
                            .post('http://localhost:9999/api/validate', this.dynamicValidateForm)
                            .then( (response) => {
                                if (response.data == true) {
                                    this.$router.push('/all');
                                } else {
                                    alert('try again');
                                }
                            });
                    } else {
                        return false;
                    }
                });
            }
        },
        mounted() {
            document.title = this.$options.name;
        }
    }
</script>

<style>
    .el-row {
        margin-bottom: 20px;
        &:last-child {
            margin-bottom: 0;
         }
    }
    .el-col {
        border-radius: 4px;
    }
</style>
