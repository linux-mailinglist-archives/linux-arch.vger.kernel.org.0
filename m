Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1715EC5BA
	for <lists+linux-arch@lfdr.de>; Tue, 27 Sep 2022 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiI0ORS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Sep 2022 10:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiI0ORR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Sep 2022 10:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA27AE9F2
        for <linux-arch@vger.kernel.org>; Tue, 27 Sep 2022 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664288234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUl86Po1e9YfTZVo8ayh3TaEumAOCT9jGLnDiIK3570=;
        b=HWZte4E1GYVqw/JeNQ0sHjzFek/EcuuJSXrfcZKkb9jLkJ5cGyXBFtUIuoMZg7puzlzyUX
        BPdEbyjnr4rFSJupQ1BeWiR8+7rcS613TyWrlB+SHj0EJiAYaYWcdbnTrdhFfmdp/1vmJT
        y+bxDzFqGOyqzH268AGeiqCjz4vYGpU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-Vu1fW__7P6GbCROXwbMsLg-1; Tue, 27 Sep 2022 10:17:12 -0400
X-MC-Unique: Vu1fW__7P6GbCROXwbMsLg-1
Received: by mail-ed1-f71.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so7974123edd.11
        for <linux-arch@vger.kernel.org>; Tue, 27 Sep 2022 07:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JUl86Po1e9YfTZVo8ayh3TaEumAOCT9jGLnDiIK3570=;
        b=ax1LOnPfZHTvAWYNsXwlICql0Z9x7OvNOJYQxIqgV71usdmFdBE7OehzgBU2u2sibZ
         bPhhRY5sWm7LrZzLTqp3f6UcsgdEwKkpA9MqnZpQQWHQk+SKZLMC6ibyD2ThdcNYFdVY
         GIe9PHnsBeXN4/q+szvr8cQQd0iJq0Xy8O4fGbUDxkrNU+hEaHdWBo4xJXJaGaB0pz57
         aeKp6NctneEH4knn7z6sUDbqpMu/exPjMdMViGPPQaN4TFzKa7mkwem8uAAF1/Pkrggy
         0ftkAplvzyw7B0RgFDHSy72eyaS537o8zOGG2lK+XoOPgGqaK9K8z47usqeXuwgsuZtJ
         UhyQ==
X-Gm-Message-State: ACrzQf30QcKRCmrv5CToZl9VIj6mirQOnTu5/mEAiuV/YT9DCGaYc6Ud
        WpXw/wfblIMev4MGqk2jWAKXg9e3rNtVYBzINSV7WPzF71Yn5lB+VkL//ZEpr8AL/djEiUSDVPj
        uP4OpTvjaDhalXjMp/E92Vg==
X-Received: by 2002:a17:907:e9e:b0:783:1a8c:9198 with SMTP id ho30-20020a1709070e9e00b007831a8c9198mr12896626ejc.202.1664288231166;
        Tue, 27 Sep 2022 07:17:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7tdpvB5IeYC/OBizCLH1zDzPtZByqFT5M2W0RzespwGwcgjJTrqFwveTtDzjMya915EWu1Hw==
X-Received: by 2002:a17:907:e9e:b0:783:1a8c:9198 with SMTP id ho30-20020a1709070e9e00b007831a8c9198mr12896584ejc.202.1664288230779;
        Tue, 27 Sep 2022 07:17:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id t7-20020a170906a10700b0074136cac2e7sm860833ejy.81.2022.09.27.07.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:17:09 -0700 (PDT)
Message-ID: <d2b1e9e7-18d6-c51c-5c8c-77ba1eae580d@redhat.com>
Date:   Tue, 27 Sep 2022 16:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH V4] LoongArch: Add ACPI-based generic laptop driver
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-acpi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220919021540.2873061-1-chenhuacai@loongson.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220919021540.2873061-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 9/19/22 04:15, Huacai Chen wrote:
> From: Jianmin Lv <lvjianmin@loongson.cn>
> 
> This add ACPI-based generic laptop driver for Loongson-3. Some of the
> codes are derived from drivers/platform/x86/thinkpad_acpi.c.
> 
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

I am afraid that due to my workload, I will not have time to do
a full review of this driver anytime soon.

I hope that one of the other folks in the Cc who have done partial
reviews (like me) can do a full review and give their ack for
getting this merged.

Regards,

Hans


> ---
> V2: Fix problems pointed out by Arnd.
> V3: Use platform driver instead of acpi driver.
> V4: 1, Fix problems pointed out by Hans de Goede.
>     2, Fix build errors and warnings reported by kernel test robot.
> 
>  drivers/platform/Kconfig                     |   2 +
>  drivers/platform/Makefile                    |   1 +
>  drivers/platform/loongarch/Kconfig           |  31 +
>  drivers/platform/loongarch/Makefile          |   1 +
>  drivers/platform/loongarch/loongson-laptop.c | 622 +++++++++++++++++++
>  5 files changed, 657 insertions(+)
>  create mode 100644 drivers/platform/loongarch/Kconfig
>  create mode 100644 drivers/platform/loongarch/Makefile
>  create mode 100644 drivers/platform/loongarch/loongson-laptop.c
> 
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index b437847b6237..dbd327712205 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -3,6 +3,8 @@ if MIPS
>  source "drivers/platform/mips/Kconfig"
>  endif
>  
> +source "drivers/platform/loongarch/Kconfig"
> +
>  source "drivers/platform/goldfish/Kconfig"
>  
>  source "drivers/platform/chrome/Kconfig"
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 4de08ef4ec9d..41640172975a 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  obj-$(CONFIG_X86)		+= x86/
> +obj-$(CONFIG_LOONGARCH)		+= loongarch/
>  obj-$(CONFIG_MELLANOX_PLATFORM)	+= mellanox/
>  obj-$(CONFIG_MIPS)		+= mips/
>  obj-$(CONFIG_OLPC_EC)		+= olpc/
> diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loongarch/Kconfig
> new file mode 100644
> index 000000000000..5633e4d73991
> --- /dev/null
> +++ b/drivers/platform/loongarch/Kconfig
> @@ -0,0 +1,31 @@
> +#
> +# LoongArch Platform Specific Drivers
> +#
> +
> +menuconfig LOONGARCH_PLATFORM_DEVICES
> +	bool "LoongArch Platform Specific Device Drivers"
> +	default y
> +	depends on LOONGARCH
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
> +config LOONGSON_LAPTOP
> +	tristate "Generic Loongson-3 Laptop Driver"
> +	depends on ACPI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on INPUT
> +	depends on MACH_LOONGSON64
> +	select ACPI_VIDEO
> +	select INPUT_SPARSEKMAP
> +	default y
> +	help
> +	  ACPI-based Loongson-3 family laptops generic driver.
> +
> +endif # LOONGARCH_PLATFORM_DEVICES
> diff --git a/drivers/platform/loongarch/Makefile b/drivers/platform/loongarch/Makefile
> new file mode 100644
> index 000000000000..f43ab03db1a2
> --- /dev/null
> +++ b/drivers/platform/loongarch/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_LOONGSON_LAPTOP) += loongson-laptop.o
> diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
> new file mode 100644
> index 000000000000..5a994f179de9
> --- /dev/null
> +++ b/drivers/platform/loongarch/loongson-laptop.c
> @@ -0,0 +1,622 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Generic Loongson processor based LAPTOP/ALL-IN-ONE driver
> + *
> + *  Jianmin Lv <lvjianmin@loongson.cn>
> + *  Huacai Chen <chenhuacai@loongson.cn>
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/backlight.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <acpi/video.h>
> +
> +/* 1. Driver-wide structs and misc. variables */
> +
> +/* ACPI HIDs */
> +#define LOONGSON_ACPI_EC_HID	"PNP0C09"
> +#define LOONGSON_ACPI_HKEY_HID	"LOON0000"
> +
> +#define ACPI_LAPTOP_NAME "loongson-laptop"
> +#define ACPI_LAPTOP_ACPI_EVENT_PREFIX "loongson"
> +
> +#define MAX_ACPI_ARGS			3
> +#define GENERIC_HOTKEY_MAP_MAX		64
> +
> +#define GENERIC_EVENT_TYPE_OFF		12
> +#define GENERIC_EVENT_TYPE_MASK		0xF000
> +#define GENERIC_EVENT_CODE_MASK		0x0FFF
> +
> +struct generic_sub_driver {
> +	u32 type;
> +	char *name;
> +	acpi_handle *handle;
> +	struct acpi_device *device;
> +	struct platform_driver *driver;
> +	int (*init)(struct generic_sub_driver *sub_driver);
> +	void (*notify)(struct generic_sub_driver *sub_driver, u32 event);
> +	u8 acpi_notify_installed;
> +};
> +
> +static u32 input_device_registered;
> +static struct input_dev *generic_inputdev;
> +
> +static acpi_handle hotkey_handle;
> +static struct key_entry hotkey_keycode_map[GENERIC_HOTKEY_MAP_MAX];
> +
> +static int loongson_laptop_backlight_update(struct backlight_device *bd);
> +
> +/* 2. ACPI Helpers and device model */
> +
> +static int acpi_evalf(acpi_handle handle, int *res, char *method, char *fmt, ...)
> +{
> +	char res_type;
> +	char *fmt0 = fmt;
> +	va_list ap;
> +	int success, quiet;
> +	acpi_status status;
> +	struct acpi_object_list params;
> +	struct acpi_buffer result, *resultp;
> +	union acpi_object in_objs[MAX_ACPI_ARGS], out_obj;
> +
> +	if (!*fmt) {
> +		pr_err("acpi_evalf() called with empty format\n");
> +		return 0;
> +	}
> +
> +	if (*fmt == 'q') {
> +		quiet = 1;
> +		fmt++;
> +	} else
> +		quiet = 0;
> +
> +	res_type = *(fmt++);
> +
> +	params.count = 0;
> +	params.pointer = &in_objs[0];
> +
> +	va_start(ap, fmt);
> +	while (*fmt) {
> +		char c = *(fmt++);
> +		switch (c) {
> +		case 'd':	/* int */
> +			in_objs[params.count].integer.value = va_arg(ap, int);
> +			in_objs[params.count++].type = ACPI_TYPE_INTEGER;
> +			break;
> +			/* add more types as needed */
> +		default:
> +			pr_err("acpi_evalf() called with invalid format character '%c'\n", c);
> +			va_end(ap);
> +			return 0;
> +		}
> +	}
> +	va_end(ap);
> +
> +	if (res_type != 'v') {
> +		result.length = sizeof(out_obj);
> +		result.pointer = &out_obj;
> +		resultp = &result;
> +	} else
> +		resultp = NULL;
> +
> +	status = acpi_evaluate_object(handle, method, &params, resultp);
> +
> +	switch (res_type) {
> +	case 'd':		/* int */
> +		success = (status == AE_OK && out_obj.type == ACPI_TYPE_INTEGER);
> +		if (success && res)
> +			*res = out_obj.integer.value;
> +		break;
> +	case 'v':		/* void */
> +		success = status == AE_OK;
> +		break;
> +		/* add more types as needed */
> +	default:
> +		pr_err("acpi_evalf() called with invalid format character '%c'\n", res_type);
> +		return 0;
> +	}
> +
> +	if (!success && !quiet)
> +		pr_err("acpi_evalf(%s, %s, ...) failed: %s\n",
> +		       method, fmt0, acpi_format_exception(status));
> +
> +	return success;
> +}
> +
> +static int hotkey_status_get(int *status)
> +{
> +	if (!acpi_evalf(hotkey_handle, status, "GSWS", "d"))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *data)
> +{
> +	struct generic_sub_driver *sub_driver = data;
> +
> +	if (!sub_driver || !sub_driver->notify)
> +		return;
> +	sub_driver->notify(sub_driver, event);
> +}
> +
> +static int __init setup_acpi_notify(struct generic_sub_driver *sub_driver)
> +{
> +	acpi_status status;
> +
> +	if (!*sub_driver->handle)
> +		return 0;
> +
> +	sub_driver->device = acpi_fetch_acpi_dev(*sub_driver->handle);
> +	if (!sub_driver->device) {
> +		pr_err("acpi_fetch_acpi_dev(%s) failed\n", sub_driver->name);
> +		return -ENODEV;
> +	}
> +
> +	sub_driver->device->driver_data = sub_driver;
> +	sprintf(acpi_device_class(sub_driver->device), "%s/%s",
> +		ACPI_LAPTOP_ACPI_EVENT_PREFIX, sub_driver->name);
> +
> +	status = acpi_install_notify_handler(*sub_driver->handle,
> +			sub_driver->type, dispatch_acpi_notify, sub_driver);
> +	if (ACPI_FAILURE(status)) {
> +		if (status == AE_ALREADY_EXISTS) {
> +			pr_notice("Another device driver is already "
> +				  "handling %s events\n", sub_driver->name);
> +		} else {
> +			pr_err("acpi_install_notify_handler(%s) failed: %s\n",
> +			       sub_driver->name, acpi_format_exception(status));
> +		}
> +		return -ENODEV;
> +	}
> +	sub_driver->acpi_notify_installed = 1;
> +
> +	return 0;
> +}
> +
> +static int loongson_hotkey_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int loongson_hotkey_resume(struct device *dev)
> +{
> +	int status = 0;
> +	struct key_entry ke;
> +	struct backlight_device *bd;
> +
> +	/*
> +	 * Only if the firmware supports SW_LID event model, we can handle the
> +	 * event. This is for the consideration of development board without EC.
> +	 */
> +	if (test_bit(SW_LID, generic_inputdev->swbit)) {
> +		if (hotkey_status_get(&status) < 0)
> +			return -EIO;
> +		/*
> +		 * The input device sw element records the last lid status.
> +		 * When the system is awakened by other wake-up sources,
> +		 * the lid event will also be reported. The judgment of
> +		 * adding SW_LID bit which in sw element can avoid this
> +		 * case.
> +		 *
> +		 * Input system will drop lid event when current lid event
> +		 * value and last lid status in the same. So laptop driver
> +		 * doesn't report repeated events.
> +		 *
> +		 * Lid status is generally 0, but hardware exception is
> +		 * considered. So add lid status confirmation.
> +		 */
> +		if (test_bit(SW_LID, generic_inputdev->sw) && !(status & (1 << SW_LID))) {
> +			ke.type = KE_SW;
> +			ke.sw.value = (u8)status;
> +			ke.sw.code = SW_LID;
> +			sparse_keymap_report_entry(generic_inputdev, &ke, 1, true);
> +		}
> +	}
> +
> +	bd = backlight_device_get_by_type(BACKLIGHT_PLATFORM);
> +	if (bd) {
> +		loongson_laptop_backlight_update(bd) ?
> +		pr_warn("Loongson_backlight: resume brightness failed") :
> +		pr_info("Loongson_backlight: resume brightness %d\n", bd->props.brightness);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(loongson_hotkey_pm,
> +		loongson_hotkey_suspend, loongson_hotkey_resume);
> +
> +static int loongson_hotkey_probe(struct platform_device *pdev)
> +{
> +	hotkey_handle = ACPI_HANDLE(&pdev->dev);
> +
> +	if (!hotkey_handle)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id loongson_device_ids[] = {
> +	{LOONGSON_ACPI_HKEY_HID, 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_device_ids);
> +
> +static struct platform_driver loongson_hotkey_driver = {
> +	.probe		= loongson_hotkey_probe,
> +	.driver		= {
> +		.name	= "loongson-hotkey",
> +		.owner	= THIS_MODULE,
> +		.pm	= pm_ptr(&loongson_hotkey_pm),
> +		.acpi_match_table = loongson_device_ids,
> +	},
> +};
> +
> +static int hotkey_map(void)
> +{
> +	u32 index;
> +	acpi_status status;
> +	struct acpi_buffer buf;
> +	union acpi_object *pack;
> +
> +	buf.length = ACPI_ALLOCATE_BUFFER;
> +	status = acpi_evaluate_object_typed(hotkey_handle, "KMAP", NULL, &buf, ACPI_TYPE_PACKAGE);
> +	if (status != AE_OK) {
> +		pr_err("ACPI exception: %s\n", acpi_format_exception(status));
> +		return -1;
> +	}
> +	pack = buf.pointer;
> +	for (index = 0; index < pack->package.count; index++) {
> +		union acpi_object *element, *sub_pack;
> +
> +		sub_pack = &pack->package.elements[index];
> +
> +		element = &sub_pack->package.elements[0];
> +		hotkey_keycode_map[index].type = element->integer.value;
> +		element = &sub_pack->package.elements[1];
> +		hotkey_keycode_map[index].code = element->integer.value;
> +		element = &sub_pack->package.elements[2];
> +		hotkey_keycode_map[index].keycode = element->integer.value;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hotkey_backlight_set(bool enable)
> +{
> +	if (!acpi_evalf(hotkey_handle, NULL, "VCBL", "vd", enable ? 1 : 0))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int ec_get_brightness(void)
> +{
> +	int status = 0;
> +
> +	if (!hotkey_handle)
> +		return -ENXIO;
> +
> +	if (!acpi_evalf(hotkey_handle, &status, "ECBG", "d"))
> +		return -EIO;
> +
> +	if (status < 0)
> +		return status;
> +
> +	return status;
> +}
> +
> +static int ec_set_brightness(int level)
> +{
> +
> +	int ret = 0;
> +
> +	if (!hotkey_handle)
> +		return -ENXIO;
> +
> +	if (!acpi_evalf(hotkey_handle, NULL, "ECBS", "vd", level))
> +		ret = -EIO;
> +
> +	return ret;
> +}
> +
> +static int ec_backlight_level(u8 level)
> +{
> +	int status = 0;
> +
> +	if (!hotkey_handle)
> +		return -ENXIO;
> +
> +	if (!acpi_evalf(hotkey_handle, &status, "ECLL", "d"))
> +		return -EIO;
> +
> +	if ((status < 0) || (level > status))
> +		return status;
> +
> +	if (!acpi_evalf(hotkey_handle, &status, "ECSL", "d"))
> +		return -EIO;
> +
> +	if ((status < 0) || (level < status))
> +		return status;
> +
> +	return level;
> +}
> +
> +static int loongson_laptop_backlight_update(struct backlight_device *bd)
> +{
> +	int lvl = ec_backlight_level(bd->props.brightness);
> +
> +	if (lvl < 0)
> +		return -EIO;
> +	if (ec_set_brightness(lvl))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int loongson_laptop_get_brightness(struct backlight_device *bd)
> +{
> +	u8 level;
> +
> +	level = ec_get_brightness();
> +	if (level < 0)
> +		return -EIO;
> +
> +	return level;
> +}
> +
> +static const struct backlight_ops backlight_laptop_ops = {
> +	.update_status = loongson_laptop_backlight_update,
> +	.get_brightness = loongson_laptop_get_brightness,
> +};
> +
> +static int laptop_backlight_register(void)
> +{
> +	int status = 0;
> +	struct backlight_properties props;
> +
> +	memset(&props, 0, sizeof(props));
> +
> +	if (!acpi_evalf(hotkey_handle, &status, "ECLL", "d"))
> +		return -EIO;
> +
> +	props.brightness = 1;
> +	props.max_brightness = status;
> +	props.type = BACKLIGHT_PLATFORM;
> +
> +	backlight_device_register("loongson_laptop",
> +				NULL, NULL, &backlight_laptop_ops, &props);
> +
> +	return 0;
> +}
> +
> +int loongson_laptop_turn_on_backlight(void)
> +{
> +	int status;
> +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +	struct acpi_object_list args = { 1, &arg0 };
> +
> +	arg0.integer.value = 1;
> +	status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		pr_info("Loongson lvds error: 0x%x\n", status);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +int loongson_laptop_turn_off_backlight(void)
> +{
> +	int status;
> +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +	struct acpi_object_list args = { 1, &arg0 };
> +
> +	arg0.integer.value = 0;
> +	status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		pr_info("Loongson lvds error: 0x%x\n", status);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init event_init(struct generic_sub_driver *sub_driver)
> +{
> +	int ret;
> +
> +	ret = hotkey_map();
> +	if (ret < 0) {
> +		pr_err("Failed to parse keymap from DSDT\n");
> +		return ret;
> +	}
> +
> +	ret = sparse_keymap_setup(generic_inputdev, hotkey_keycode_map, NULL);
> +	if (ret < 0) {
> +		pr_err("Failed to setup input device keymap\n");
> +		input_free_device(generic_inputdev);
> +
> +		return ret;
> +	}
> +
> +	/*
> +	 * This hotkey driver handle backlight event when
> +	 * acpi_video_get_backlight_type() gets acpi_backlight_vendor
> +	 */
> +	if (acpi_video_get_backlight_type() == acpi_backlight_vendor)
> +		hotkey_backlight_set(true);
> +	else
> +		hotkey_backlight_set(false);
> +
> +	pr_info("ACPI: enabling firmware HKEY event interface...\n");
> +
> +	return ret;
> +}
> +
> +static void event_notify(struct generic_sub_driver *sub_driver, u32 event)
> +{
> +	int type, scan_code;
> +	struct key_entry *ke = NULL;
> +
> +	scan_code = event & GENERIC_EVENT_CODE_MASK;
> +	type = (event & GENERIC_EVENT_TYPE_MASK) >> GENERIC_EVENT_TYPE_OFF;
> +	ke = sparse_keymap_entry_from_scancode(generic_inputdev, scan_code);
> +	if (ke) {
> +		if (type == KE_SW) {
> +			int status = 0;
> +
> +			if (hotkey_status_get(&status) < 0)
> +				return;
> +
> +			ke->sw.value = !!(status & (1 << ke->sw.code));
> +		}
> +		sparse_keymap_report_entry(generic_inputdev, ke, 1, true);
> +	}
> +}
> +
> +/* 3. Infrastructure */
> +
> +static void generic_subdriver_exit(struct generic_sub_driver *sub_driver);
> +
> +static int __init generic_subdriver_init(struct generic_sub_driver *sub_driver)
> +{
> +	int ret;
> +
> +	BUG_ON(!sub_driver);
> +
> +	if (!sub_driver || !sub_driver->driver)
> +		return -EINVAL;
> +
> +	ret = platform_driver_register(sub_driver->driver);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (sub_driver->init)
> +		sub_driver->init(sub_driver);
> +
> +	if (sub_driver->notify) {
> +		ret = setup_acpi_notify(sub_driver);
> +		if (ret == -ENODEV) {
> +			ret = 0;
> +			goto err_out;
> +		}
> +		if (ret < 0)
> +			goto err_out;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	generic_subdriver_exit(sub_driver);
> +	return (ret < 0) ? ret : 0;
> +}
> +
> +static void generic_subdriver_exit(struct generic_sub_driver *sub_driver)
> +{
> +
> +	if (sub_driver->acpi_notify_installed) {
> +		acpi_remove_notify_handler(*sub_driver->handle,
> +					   sub_driver->type, dispatch_acpi_notify);
> +		sub_driver->acpi_notify_installed = 0;
> +	}
> +}
> +
> +static struct generic_sub_driver generic_sub_drivers[] __refdata = {
> +	{
> +		.name = "hotkey",
> +		.init = event_init,
> +		.notify = event_notify,
> +		.handle = &hotkey_handle,
> +		.type = ACPI_DEVICE_NOTIFY,
> +		.driver = &loongson_hotkey_driver,
> +	},
> +};
> +
> +static int __init generic_acpi_laptop_init(void)
> +{
> +	bool ec_found;
> +	int i, ret, status;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	/* The EC device is required */
> +	ec_found = acpi_dev_found(LOONGSON_ACPI_EC_HID);
> +	if (!ec_found)
> +		return -ENODEV;
> +
> +	/* Enable SCI for EC */
> +	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
> +
> +	generic_inputdev = input_allocate_device();
> +	if (!generic_inputdev) {
> +		pr_err("Unable to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Prepare input device, but don't register */
> +	generic_inputdev->name =
> +		"Loongson Generic Laptop/All-in-One Extra Buttons";
> +	generic_inputdev->phys = ACPI_LAPTOP_NAME "/input0";
> +	generic_inputdev->id.bustype = BUS_HOST;
> +	generic_inputdev->dev.parent = NULL;
> +
> +	/* Init subdrivers */
> +	for (i = 0; i < ARRAY_SIZE(generic_sub_drivers); i++) {
> +		ret = generic_subdriver_init(&generic_sub_drivers[i]);
> +		if (ret < 0) {
> +			input_free_device(generic_inputdev);
> +			return ret;
> +		}
> +	}
> +
> +	ret = input_register_device(generic_inputdev);
> +	if (ret < 0) {
> +		input_free_device(generic_inputdev);
> +		pr_err("Unable to register input device\n");
> +		return ret;
> +	}
> +
> +	input_device_registered = 1;
> +
> +	if (acpi_evalf(hotkey_handle, &status, "ECBG", "d")) {
> +		pr_info("Loongson Laptop used, init brightness is 0x%x\n", status);
> +		ret = laptop_backlight_register();
> +		if (ret < 0)
> +			pr_err("Loongson Laptop: laptop-backlight device register failed\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit generic_acpi_laptop_exit(void)
> +{
> +	if (generic_inputdev) {
> +		if (input_device_registered)
> +			input_unregister_device(generic_inputdev);
> +		else
> +			input_free_device(generic_inputdev);
> +	}
> +}
> +
> +module_init(generic_acpi_laptop_init);
> +module_exit(generic_acpi_laptop_exit);
> +
> +MODULE_AUTHOR("Jianmin Lv <lvjianmin@loongson.cn>");
> +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson Laptop/All-in-One ACPI Driver");
> +MODULE_LICENSE("GPL");

