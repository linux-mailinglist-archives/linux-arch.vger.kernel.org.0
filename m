Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD32597EFB
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiHRHJG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 03:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiHRHJF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 03:09:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC91B81B00;
        Thu, 18 Aug 2022 00:09:02 -0700 (PDT)
Received: from [10.20.42.22] (unknown [10.20.42.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32t05f1iUK4DAA--.14351S3;
        Thu, 18 Aug 2022 15:08:37 +0800 (CST)
Subject: Re: [PATCH V2 1/2] LoongArch: Add CPU HWMon platform driver
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-acpi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xi Ruoyao <xry111@xry111.site>
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <98d716a4-04de-ff32-1bbc-cac576989a87@loongson.cn>
Date:   Thu, 18 Aug 2022 15:08:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220818042208.2896457-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx32t05f1iUK4DAA--.14351S3
X-Coremail-Antispam: 1UD129KBjvJXoW3CF47KF47try7WFy7Xr43Wrg_yoWkWr1Upr
        W5JFWfCF4UW3Z7tw1qva17u3yYvrs0kay7WF9ru34rAFsxXry7GF97A3y5ZrnakFW5XrWa
        qF15WF4DCa90qaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
        v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr
        1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I don't think we need the driver any more, we have thermal zone based 
acpi which implemented more functions include the function here.

And, the driver will conflict with acpi thermal 
driver(drivers/acpi/thermal.c), which leads to confusion with users.

On 2022/8/18 下午12:22, Huacai Chen wrote:
> This add CPU HWMon (temperature sensor) platform driver for Loongson-3.
> 
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Fix build warning reported by lkp.
> 
>   drivers/platform/Kconfig               |   3 +
>   drivers/platform/Makefile              |   1 +
>   drivers/platform/loongarch/Kconfig     |  26 ++++
>   drivers/platform/loongarch/Makefile    |   1 +
>   drivers/platform/loongarch/cpu_hwmon.c | 194 +++++++++++++++++++++++++
>   5 files changed, 225 insertions(+)
>   create mode 100644 drivers/platform/loongarch/Kconfig
>   create mode 100644 drivers/platform/loongarch/Makefile
>   create mode 100644 drivers/platform/loongarch/cpu_hwmon.c
> 
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index b437847b6237..9c68e2def2cb 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -2,6 +2,9 @@
>   if MIPS
>   source "drivers/platform/mips/Kconfig"
>   endif
> +if LOONGARCH
> +source "drivers/platform/loongarch/Kconfig"
> +endif
>   
>   source "drivers/platform/goldfish/Kconfig"
>   
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 4de08ef4ec9d..41640172975a 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -4,6 +4,7 @@
>   #
>   
>   obj-$(CONFIG_X86)		+= x86/
> +obj-$(CONFIG_LOONGARCH)		+= loongarch/
>   obj-$(CONFIG_MELLANOX_PLATFORM)	+= mellanox/
>   obj-$(CONFIG_MIPS)		+= mips/
>   obj-$(CONFIG_OLPC_EC)		+= olpc/
> diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loongarch/Kconfig
> new file mode 100644
> index 000000000000..a1542843b0ad
> --- /dev/null
> +++ b/drivers/platform/loongarch/Kconfig
> @@ -0,0 +1,26 @@
> +#
> +# LoongArch Platform Specific Drivers
> +#
> +
> +menuconfig LOONGARCH_PLATFORM_DEVICES
> +	bool "LoongArch Platform Specific Device Drivers"
> +	default LOONGARCH
> +	help
> +	  Say Y here to get to see options for device drivers of various
> +	  LoongArch platforms, including vendor-specific laptop/desktop
> +	  extension and hardware monitor drivers. This option itself does
> +	  not add any kernel code.
> +
> +	  If you say N, all options in this submenu will be skipped and disabled.
> +
> +if LOONGARCH_PLATFORM_DEVICES
> +
> +config CPU_HWMON
> +	bool "Loongson CPU HWMon Driver"
> +	depends on MACH_LOONGSON64
> +	select HWMON
> +	default y
> +	help
> +	  Loongson-3A/3B/3C CPU HWMon (temperature sensor) driver.
> +
> +endif # LOONGARCH_PLATFORM_DEVICES
> diff --git a/drivers/platform/loongarch/Makefile b/drivers/platform/loongarch/Makefile
> new file mode 100644
> index 000000000000..8dfd03924c37
> --- /dev/null
> +++ b/drivers/platform/loongarch/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
> diff --git a/drivers/platform/loongarch/cpu_hwmon.c b/drivers/platform/loongarch/cpu_hwmon.c
> new file mode 100644
> index 000000000000..71a462426397
> --- /dev/null
> +++ b/drivers/platform/loongarch/cpu_hwmon.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/jiffies.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +
> +#include <asm/loongson.h>
> +
> +static int nr_packages;
> +static struct device *cpu_hwmon_dev;
> +
> +static int loongson3_cpu_temp(int cpu)
> +{
> +	u32 reg;
> +
> +	reg = iocsr_read32(LOONGARCH_IOCSR_CPUTEMP) & 0xff;
> +
> +	return (int)((s8)reg) * 1000;
> +}
> +
> +static ssize_t cpu_temp_label(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	int id = (to_sensor_dev_attr(attr))->index - 1;
> +	return sprintf(buf, "CPU %d Temperature\n", id);
> +}
> +
> +static ssize_t get_cpu_temp(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	int id = (to_sensor_dev_attr(attr))->index - 1;
> +	int value = loongson3_cpu_temp(id);
> +	return sprintf(buf, "%d\n", value);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, get_cpu_temp, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp1_label, 0444, cpu_temp_label, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_input, 0444, get_cpu_temp, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp2_label, 0444, cpu_temp_label, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp3_input, 0444, get_cpu_temp, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp3_label, 0444, cpu_temp_label, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp4_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp4_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp7_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp7_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp8_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp8_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp9_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp9_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp10_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp10_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp11_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp11_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp12_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp12_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp13_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp13_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp14_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp14_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp15_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp15_label, 0444, cpu_temp_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp16_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp16_label, 0444, cpu_temp_label, NULL, 4);
> +
> +static struct attribute *cpu_hwmon_attributes[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_label.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_label.dev_attr.attr,
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
> +	&sensor_dev_attr_temp4_label.dev_attr.attr,
> +	&sensor_dev_attr_temp5_input.dev_attr.attr,
> +	&sensor_dev_attr_temp5_label.dev_attr.attr,
> +	&sensor_dev_attr_temp6_input.dev_attr.attr,
> +	&sensor_dev_attr_temp6_label.dev_attr.attr,
> +	&sensor_dev_attr_temp7_input.dev_attr.attr,
> +	&sensor_dev_attr_temp7_label.dev_attr.attr,
> +	&sensor_dev_attr_temp8_input.dev_attr.attr,
> +	&sensor_dev_attr_temp8_label.dev_attr.attr,
> +	&sensor_dev_attr_temp9_input.dev_attr.attr,
> +	&sensor_dev_attr_temp9_label.dev_attr.attr,
> +	&sensor_dev_attr_temp10_input.dev_attr.attr,
> +	&sensor_dev_attr_temp10_label.dev_attr.attr,
> +	&sensor_dev_attr_temp11_input.dev_attr.attr,
> +	&sensor_dev_attr_temp11_label.dev_attr.attr,
> +	&sensor_dev_attr_temp12_input.dev_attr.attr,
> +	&sensor_dev_attr_temp12_label.dev_attr.attr,
> +	&sensor_dev_attr_temp13_input.dev_attr.attr,
> +	&sensor_dev_attr_temp13_label.dev_attr.attr,
> +	&sensor_dev_attr_temp14_input.dev_attr.attr,
> +	&sensor_dev_attr_temp14_label.dev_attr.attr,
> +	&sensor_dev_attr_temp15_input.dev_attr.attr,
> +	&sensor_dev_attr_temp15_label.dev_attr.attr,
> +	&sensor_dev_attr_temp16_input.dev_attr.attr,
> +	&sensor_dev_attr_temp16_label.dev_attr.attr,
> +	NULL
> +};
> +static umode_t cpu_hwmon_is_visible(struct kobject *kobj,
> +				    struct attribute *attr, int i)
> +{
> +	int id = i / 2;
> +
> +	if (id < nr_packages)
> +		return attr->mode;
> +	return 0;
> +}
> +
> +static struct attribute_group cpu_hwmon_group = {
> +	.attrs = cpu_hwmon_attributes,
> +	.is_visible = cpu_hwmon_is_visible,
> +};
> +
> +static const struct attribute_group *cpu_hwmon_groups[] = {
> +	&cpu_hwmon_group,
> +	NULL
> +};
> +
> +static int cpu_initial_threshold = 72000;
> +static int cpu_thermal_threshold = 96000;
> +module_param(cpu_thermal_threshold, int, 0644);
> +MODULE_PARM_DESC(cpu_thermal_threshold, "cpu thermal threshold (96000 (default))");
> +
> +static struct delayed_work thermal_work;
> +
> +static void do_thermal_timer(struct work_struct *work)
> +{
> +	int i, value, temp_max = 0;
> +
> +	for (i=0; i<nr_packages; i++) {
> +		value = loongson3_cpu_temp(i);
> +		if (value > temp_max)
> +			temp_max = value;
> +	}
> +
> +	if (temp_max <= cpu_thermal_threshold)
> +		schedule_delayed_work(&thermal_work, msecs_to_jiffies(5000));
> +	else
> +		orderly_poweroff(true);
> +}
> +
> +static int __init loongson_hwmon_init(void)
> +{
> +	int i, value, temp_max = 0;
> +
> +	pr_info("Loongson Hwmon Enter...\n");
> +
> +	nr_packages = loongson_sysconf.nr_cpus /
> +		loongson_sysconf.cores_per_package;
> +
> +	cpu_hwmon_dev = hwmon_device_register_with_groups(NULL, "cpu_hwmon",
> +							  NULL, cpu_hwmon_groups);
> +	if (IS_ERR(cpu_hwmon_dev)) {
> +		pr_err("hwmon_device_register fail!\n");
> +		return PTR_ERR(cpu_hwmon_dev);
> +	}
> +
> +	for (i = 0; i < nr_packages; i++) {
> +		value = loongson3_cpu_temp(i);
> +		if (value > temp_max)
> +			temp_max = value;
> +	}
> +
> +	pr_info("Initial CPU temperature is %d (highest).\n", temp_max);
> +	if (temp_max > cpu_initial_threshold)
> +		cpu_thermal_threshold += temp_max - cpu_initial_threshold;
> +
> +	INIT_DEFERRABLE_WORK(&thermal_work, do_thermal_timer);
> +	schedule_delayed_work(&thermal_work, msecs_to_jiffies(20000));
> +
> +	return 0;
> +}
> +
> +static void __exit loongson_hwmon_exit(void)
> +{
> +	cancel_delayed_work_sync(&thermal_work);
> +	hwmon_device_unregister(cpu_hwmon_dev);
> +}
> +
> +module_init(loongson_hwmon_init);
> +module_exit(loongson_hwmon_exit);
> +
> +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson CPU Hwmon driver");
> +MODULE_LICENSE("GPL");
> 

