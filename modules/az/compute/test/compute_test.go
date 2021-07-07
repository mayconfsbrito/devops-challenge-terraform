package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestIT_HelloWorldExample(t *testing.T) {
	t.Parallel()

	// Generate a random name to prevent a naming conflict
	uniqueID := random.UniqueId()
	testname := fmt.Sprintf("test-name-%s", uniqueID)

	// Specify the test case folder and "-var" options
	tfOptions := &terraform.Options{
		TerraformDir: "../../../composition/dev",
		Vars: map[string]interface{}{
			"name": testname,
		},
	}

	// Defer terraform destroy til the end of the test
	defer terraform.Destroy(t, tfOptions)

	// run terraform init, and terraform apply and capture the homepage value
	terraform.InitAndApply(t, tfOptions)

}
