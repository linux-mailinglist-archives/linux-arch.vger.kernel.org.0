Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79E5BB797
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIQJmQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 05:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIQJmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 05:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A984D3CBEE
        for <linux-arch@vger.kernel.org>; Sat, 17 Sep 2022 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663407724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhhigsQkFus/Q9RDJvWEegfQtScyRNuZVUMB/uZHcas=;
        b=JL0pUPmP+DKGHazqT610Znio6VP9m8PEA4xsLm9VasdP7qZFPN6KVf/y/1jEy6MrxZa1VU
        +hkr89Pw5XOdEQtcXtRYHPDxLhmj69DjEblbuWhnwRRHycfcRfgClf94QHMA8b3qOs1tWy
        kxcsrhFf2e4HDCFjNTxiBIFZ2oUUUwk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-T6VIOn6cOFqGmhdhsDO9wg-1; Sat, 17 Sep 2022 05:42:00 -0400
X-MC-Unique: T6VIOn6cOFqGmhdhsDO9wg-1
Received: by mail-ed1-f72.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so9144893edb.2
        for <linux-arch@vger.kernel.org>; Sat, 17 Sep 2022 02:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RhhigsQkFus/Q9RDJvWEegfQtScyRNuZVUMB/uZHcas=;
        b=Wj0EBLhEqDOohwioC7kGzc/asblCsPjPwaprA+qKIvb0tw9jkmm5z0mjPbK5yNClW7
         y/3gv/qBT1wz08dw7hvzyiLtqAD1MATVH3gbkGI8SOs30nERhMoI6u+2Cl+VSKCnIUPb
         CRFhVAj3lez2pJKkFAeh3depTEgZ2RFxkCzZUCVGv6KnRI9Wr+xuOdfKKj7Jf1M/tIPT
         WP5sGjtw6MgD0hFedXqYMhAhx6jvKceR6rVLe4CMjpqk48EChwaHEx/4V74GVYSJLKI9
         X6fdrhGbkKwxXuNy0RnnvmOIPdWBPfaqO+uczoWthcPiKhzuscnUoBS7CdyELlqKuXtA
         ThpA==
X-Gm-Message-State: ACrzQf1jpgPSrmwc10f3f45nECAQI4rb/CoDXRTIMxg8meSDP3iYz8rJ
        YFAK92XqE3cvimmgZz9/Rp3LefF1hO/fLG7UBfc4eBvMLekFf0nVHsj0me6B8XBL8e216LsEJLE
        xGiWb2fOW3v2ydMNlBIz9ag==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr7084359edh.355.1663407718481;
        Sat, 17 Sep 2022 02:41:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ekvzbjrJuuVHWWAqCB+9odNCTYaamL/odKSPgNBoNL68l5E+gb5XxdMYMrlUNVpQWTUI06A==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr7084339edh.355.1663407718200;
        Sat, 17 Sep 2022 02:41:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906328100b0077909095acasm12009556ejw.143.2022.09.17.02.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 02:41:57 -0700 (PDT)
Message-ID: <acc6927d-360b-97d8-cdc8-19c8f4cae5a3@redhat.com>
Date:   Sat, 17 Sep 2022 11:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH V3] LoongArch: Add ACPI-based generic laptop driver
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-acpi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220917065250.1671718-1-chenhuacai@loongson.cn>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220917065250.1671718-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai Chen,

On 9/17/22 08:52, Huacai Chen wrote:
> From: Jianmin Lv <lvjianmin@loongson.cn>
> 
> This add ACPI-based generic laptop driver for Loongson-3. Some of the
> codes are derived from drivers/platform/x86/thinkpad_acpi.c.
> 
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Fix problems pointed out by Arnd.
> V3: Use platform driver instead of acpi driver.
> 
>  drivers/platform/Kconfig                    |   3 +
>  drivers/platform/Makefile                   |   1 +
>  drivers/platform/loongarch/Kconfig          |  30 +
>  drivers/platform/loongarch/Makefile         |   1 +
>  drivers/platform/loongarch/generic-laptop.c | 627 ++++++++++++++++++++

This is a new top-level directory under drivers/platform. Have you
already thought about which subsystem maintainer is going to be
responsible for merging changing in this directory and sending
the changes to Linus Torvalds?

You may have noticed that I'm the maintainer of:

drivers/platform/mellanox
drivers/platform/olpc
drivers/platform/surface
drivers/platform/x86

But those all are x86 systems, so I'm not sure how qualified I'm
to also take care of the loongarch stuff.

To the other people in the Cc and volunteers to take up maintainership
for this (once it is ready to be merged) ?

>  5 files changed, 662 insertions(+)
>  create mode 100644 drivers/platform/loongarch/Kconfig
>  create mode 100644 drivers/platform/loongarch/Makefile
>  create mode 100644 drivers/platform/loongarch/generic-laptop.c
> 
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index b437847b6237..9c68e2def2cb 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -2,6 +2,9 @@
>  if MIPS
>  source "drivers/platform/mips/Kconfig"
>  endif
> +if LOONGARCH
> +source "drivers/platform/loongarch/Kconfig"
> +endif

Please drop the "if LOONGARCH" and "endif" and instead
add a "depends on LOONGARCH" to "menuconfig LOONGARCH_PLATFORM_DEVICES"
in drivers/platform/loongarch/Kconfig, like all the other subdirs are
doing.

MIPS is the only one using an if directly in drivers/platform/Kconfig
and it would be nice to get rid of the "if MIPS" so that
drivers/platform/Kconfig consistenly just sources all subdir Kconfig-s
leaving the dependency handling to the lower dir Kconfig. At a minimum
we don't want to add more if-s.





>  
>  source "drivers/platform/goldfish/Kconfig"
>  
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
> index 000000000000..c2b15f0628b4
> --- /dev/null
> +++ b/drivers/platform/loongarch/Kconfig
> @@ -0,0 +1,30 @@
> +#
> +# LoongArch Platform Specific Drivers
> +#
> +
> +menuconfig LOONGARCH_PLATFORM_DEVICES
> +	bool "LoongArch Platform Specific Device Drivers"
> +	default LOONGARCH

You only source this if LOONGARCH is set, so this is just a fancy
way of writing "default y". If you want to have this enabled by
default for loongarch builds, just use default y.



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
> +config GENERIC_LAPTOP

Please make this "config LOONGARCH_GENERIC_LAPTOP", the Kconfig symbol space
is global so GENERIC_LAPTOP is a bit too generic :)

> +	tristate "Generic Loongson-3 Laptop Driver"
> +	depends on ACPI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on INPUT
> +	depends on MACH_LOONGSON64

Would it make sense to move this depends on into the LOONGARCH_PLATFORM_DEVICES
section ?

> +	select INPUT_EVDEV

No this should never be selected by a driver. If you want this to be
available to userspace it should be enabled in the kernel-s config
when building the kernel. You could put this in a defconfig file
for your arch if you want but it does not belong here.

> +	select INPUT_SPARSEKMAP
> +	default y
> +	help
> +	  ACPI-based Loongson-3 family laptops generic driver.
> +
> +endif # LOONGARCH_PLATFORM_DEVICES
> diff --git a/drivers/platform/loongarch/Makefile b/drivers/platform/loongarch/Makefile
> new file mode 100644
> index 000000000000..3fc44f06125a
> --- /dev/null
> +++ b/drivers/platform/loongarch/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_GENERIC_LAPTOP) += generic-laptop.o

So now the module name is going to be generic-laptop too. The module name namespace
is global, so this IMHO is a bit too generic, please prefix this with
loongarch (just like the Kconfig symbol).

Note I have not looked at the actual driver code below, this is not a full review.

Regards,

Hans



> diff --git a/drivers/platform/loongarch/generic-laptop.c b/drivers/platform/loongarch/generic-laptop.c
> new file mode 100644
> index 000000000000..4198c0542711
> --- /dev/null
> +++ b/drivers/platform/loongarch/generic-laptop.c
> @@ -0,0 +1,627 @@
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
> +#define ACPI_LAPTOP_VERSION "1.0"
> +#define ACPI_LAPTOP_NAME "loongson-laptop"
> +#define ACPI_LAPTOP_DESC "Loongson Laptop/all-in-one ACPI Driver"
> +#define ACPI_LAPTOP_FILE ACPI_LAPTOP_NAME "_acpi"
> +#define ACPI_LAPTOP_DRVR_NAME ACPI_LAPTOP_FILE
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
> +static const struct acpi_device_id loongson_htk_device_ids[] = {
> +	{LOONGSON_ACPI_HKEY_HID, 0},
> +	{"", 0},
> +};
> +
> +static struct platform_driver loongson_hotkey_driver = {
> +	.probe		= loongson_hotkey_probe,
> +	.driver		= {
> +		.name	= "loongson-hotkey",
> +		.owner	= THIS_MODULE,
> +		.pm	= pm_ptr(&loongson_hotkey_pm),
> +		.acpi_match_table = ACPI_PTR(loongson_htk_device_ids),
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
> +	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
> +		hotkey_backlight_set(false);
> +	else
> +		hotkey_backlight_set(true);
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
> +		"Loongson Generic Laptop/All-in-one Extra Buttons";
> +	generic_inputdev->phys = ACPI_LAPTOP_DRVR_NAME "/input0";
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
> +MODULE_ALIAS("platform:acpi-laptop");
> +MODULE_AUTHOR("Jianmin Lv <lvjianmin@loongson.cn>");
> +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> +MODULE_DESCRIPTION(ACPI_LAPTOP_DESC);
> +MODULE_VERSION(ACPI_LAPTOP_VERSION);
> +MODULE_LICENSE("GPL");

