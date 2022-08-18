Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4C597E02
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 07:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiHRFUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 01:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbiHRFUY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 01:20:24 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BF75391;
        Wed, 17 Aug 2022 22:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1660800016; bh=SgVBJVWdM7mPnuOEs8oO5YhK1kHzXlfd2l8GQm0hQX8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JEDGnGtWoZT7HnEQdf95l2qQ0okKQsVU9jf+n2hYglf2ZSQIW+n5VrLgPsyaGfFr1
         FLznT8pCzwsGOrJfMx9LXNIzNgx5vm1h1m1CkLlqJLCAFfB4eiF35T0Da4ka+BD1iU
         MQzJqPBIwtoVvli/6XpsCa0W12AvOF8skEcO9eZc=
Received: from [100.100.57.219] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 61F0260074;
        Thu, 18 Aug 2022 13:20:16 +0800 (CST)
Message-ID: <e7eff3be-430c-d82a-a45e-ad8a2cbf069b@xen0n.name>
Date:   Thu, 18 Aug 2022 13:20:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:105.0)
 Gecko/20100101 Thunderbird/105.0a1
Subject: Re: [PATCH V2 1/2] LoongArch: Add CPU HWMon platform driver
Content-Language: en-US
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
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xi Ruoyao <xry111@xry111.site>
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220818042208.2896457-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022/8/18 12:22, Huacai Chen wrote:
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

Can the name be made more specific? I know the name didn't change from 
when it's introduced years ago, but since the code never went upstream 
we can do better this time.

Also, it may be better to simply place this hwmon driver under, ahem, 
drivers/hwmon. Similar drivers for x86 (coretemp, k8temp, k10temp and 
fam15h_power) are all residing in drivers/hwmon, and new users will most 
probably look there.

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

In what unit? It seems to be 1/1000th of degrees Celsius.

You may need to add accompanying documentation under Documentation/hwmon 
as well. The docs for coretemp and k10temp can serve as good reference.

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

No other hwmon driver does this. It's the thermal subsystem's 
responsibility it seems.

> +}
> +
> +static int __init loongson_hwmon_init(void)
> +{
> +	int i, value, temp_max = 0;
> +
> +	pr_info("Loongson Hwmon Enter...\n");

No need for this message...

> +
> +	nr_packages = loongson_sysconf.nr_cpus /
> +		loongson_sysconf.cores_per_package;
> +
> +	cpu_hwmon_dev = hwmon_device_register_with_groups(NULL, "cpu_hwmon",
> +							  NULL, cpu_hwmon_groups);
> +	if (IS_ERR(cpu_hwmon_dev)) {
> +		pr_err("hwmon_device_register fail!\n");

Include the return value in log message?

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

Seems to be "initial CPU temperature threshold" instead. (And if you 
remove the threshold setting altogether per the earlier review comment, 
this message should get removed anyway.)

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

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

