Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86335BB7A1
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIQKAQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 06:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQKAP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 06:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE72A97C
        for <linux-arch@vger.kernel.org>; Sat, 17 Sep 2022 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663408813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCkLSP0E4yxXlnFgQrKphv334iYRQIwNmCq8vrighrE=;
        b=Du853I1sULCtJ/dKA4KJJWaBrpe8cJ2x+DiXaKHIkq0KtP6W4krzQYsMN0eSlAUi87wA1c
        xx0c4fN706OUu318+IPeRjgie4Q9vkh84H2w5Ms5Da+lbnO3EguUx+m6xl9VHdjHBm2R53
        AFn6QAgvr/apnuAyVBqwyDQZ4SMCohE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-397-f_rUIJmlN6OoYYwHIXc49g-1; Sat, 17 Sep 2022 06:00:11 -0400
X-MC-Unique: f_rUIJmlN6OoYYwHIXc49g-1
Received: by mail-ed1-f69.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so16614935edc.13
        for <linux-arch@vger.kernel.org>; Sat, 17 Sep 2022 03:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SCkLSP0E4yxXlnFgQrKphv334iYRQIwNmCq8vrighrE=;
        b=MWKovnCAKwDwe+ECSZz0V49QyL3W+ko4T0KcN+u0cjXMVbksfPgiFZX/CSKR67WpkD
         PIybnLy5bzZ4/M/hMeLEajm2MTakqUGIcr35ishVDAzuT8/nDPjL1PQelzzuiX4QsE/1
         8P7cv3Vfzii1Hy3NP72qziPHBd9bw3N1TWApwLnCUEqkl+JdFSdXytxnbScXjRYFFfSC
         pkRI34dOJ2W6Vv5atwiOLcZnlq/CInY82hCAqyKzja6EVKv3uM+O17PYO8HpDSkjf3/Z
         HWdvEr8uOjywhpSpxecBTsn84cIDp6EUFpDZgoGafk7v1AbnkoI1OHnKj/sf3V8rKgwP
         s9Kw==
X-Gm-Message-State: ACrzQf0QjATki+Nlv+OPBDX97tLEc/NKvuxVzKhdcZLkeLc4SteLbDAz
        4l8B/9hQBPDUko8llzm7diC2p/h3UIC0E94/7eBtOhDqhszdH0DDdjdqmXP9q5MkEtykJjQo5Tn
        UejwD8fnOfk4GIkqOib074g==
X-Received: by 2002:aa7:d315:0:b0:44e:6647:9dae with SMTP id p21-20020aa7d315000000b0044e66479daemr7168780edq.280.1663408810457;
        Sat, 17 Sep 2022 03:00:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4T08btJRM8tjbkuSclLPEK5zBDHbsD6cG4vTOxt5rh4g4XMjMbhikELcnrODmfgTROgquMkw==
X-Received: by 2002:aa7:d315:0:b0:44e:6647:9dae with SMTP id p21-20020aa7d315000000b0044e66479daemr7168764edq.280.1663408810249;
        Sat, 17 Sep 2022 03:00:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ky17-20020a170907779100b0073bf84be798sm11985183ejc.142.2022.09.17.03.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 03:00:09 -0700 (PDT)
Message-ID: <80b46671-6d01-f2a2-7b9b-cb4c27cc87c6@redhat.com>
Date:   Sat, 17 Sep 2022 12:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH V3] LoongArch: Add ACPI-based generic laptop driver
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-acpi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220917065250.1671718-1-chenhuacai@loongson.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220917065250.1671718-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi again,

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

A couple more notes which I noticed just after sending my previous email:

> +#define ACPI_LAPTOP_VERSION "1.0"
> +#define ACPI_LAPTOP_NAME "loongson-laptop"
> +#define ACPI_LAPTOP_DESC "Loongson Laptop/all-in-one ACPI Driver"
> +#define ACPI_LAPTOP_FILE ACPI_LAPTOP_NAME "_acpi"
> +#define ACPI_LAPTOP_DRVR_NAME ACPI_LAPTOP_FILE
> +#define ACPI_LAPTOP_ACPI_EVENT_PREFIX "loongson"

Do you really need / use all these defines ?

> +static const struct acpi_device_id loongson_htk_device_ids[] = {
> +	{LOONGSON_ACPI_HKEY_HID, 0},
> +	{"", 0},
> +};

You will want to put a:

MODULE_DEVICE_TABLE(acpi, loongson_htk_device_ids);

line here for proper automatic loading when build as a module.

> +
> +static struct platform_driver loongson_hotkey_driver = {
> +	.probe		= loongson_hotkey_probe,
> +	.driver		= {
> +		.name	= "loongson-hotkey",
> +		.owner	= THIS_MODULE,
> +		.pm	= pm_ptr(&loongson_hotkey_pm),
> +		.acpi_match_table = ACPI_PTR(loongson_htk_device_ids),

Since you unconditionally define loongson_htk_device_ids above;
and since you have a "depends on ACPI" in your Kconfig, you can drop
the ACPI_PTR() here, just use loongson_htk_device_ids directly.

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

I see above that you have only 1 subdriver. Do you expect there to be
more in the future ?  If not then it would be better to just completely
remove the subdriver abstraction and simply do everything directly
from the main probe/remove functions (see below).

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

All of generic_acpi_laptop_init should be done from loongson_hotkey_probe()
and instead of using global variables all data you need should be in a struct
and that struct should be alloc-ed from loongson_hotkey_probe() and then tied
to the platform_device using platform_set_drvdata() and retreived on remove
using platform_get_drvdata() and on suspend/resume using dev_get_drvdata().

> +static void __exit generic_acpi_laptop_exit(void)
> +{
> +	if (generic_inputdev) {
> +		if (input_device_registered)
> +			input_unregister_device(generic_inputdev);
> +		else
> +			input_free_device(generic_inputdev);
> +	}
> +}

This should be done from a remove function which then gets set as the
remove callback in loongson_hotkey_driver.

I see at a quick glance that you based this driver on thinkpad_acpi.c
but that is a very old driver which does a bunch of things in old,
deprecated ways which are hard to fix for userspace API compatibility
reasons.

Now a days we try to avoid global variables and also custom 
module_init()/module_exit() functions.

> +module_init(generic_acpi_laptop_init);
> +module_exit(generic_acpi_laptop_exit);

Once the work of these 2 functions is done from loongson_hotkey_driver.probe /
loongson_hotkey_driver.remove, you can replace this with:

module_platform_driver(loongson_hotkey_driver);

> +
> +MODULE_ALIAS("platform:acpi-laptop");

This is not necessary, what you need for autoloading is the:

MODULE_DEVICE_TABLE(acpi, loongson_htk_device_ids);

mentioned above.

> +MODULE_AUTHOR("Jianmin Lv <lvjianmin@loongson.cn>");
> +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> +MODULE_DESCRIPTION(ACPI_LAPTOP_DESC);

You only use the ACPI_LAPTOP_DESC #define once, please just
put its contents directly here.

> +MODULE_VERSION(ACPI_LAPTOP_VERSION);

Modules having there own versioning separate from the kernel
is something from the past. Please drop the MODULE_VERSION() line
and the ACPI_LAPTOP_VERSION #define.

> +MODULE_LICENSE("GPL");

Regards,

Hans

