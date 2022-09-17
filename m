Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551415BB927
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 17:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiIQPjY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 11:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQPjX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 11:39:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D699332AA2;
        Sat, 17 Sep 2022 08:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C044B80CAE;
        Sat, 17 Sep 2022 15:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9C4C433D6;
        Sat, 17 Sep 2022 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663429157;
        bh=YYDZb7cgWkAAMz0Nq44P6jmJ46q5teXqm7cBbCBh+7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HxsFdlRGh2kN1NgILEErnPDWhZsvSKuMnLLBA/ptbhaDZRXmYOMwh1cmlV2S/zITi
         FcyE1C5a8LzsXDHjS5daKGrbBtRd2WUb7Rg0x3b79XQl74iHtzwg5wYDrhKfJn6Zhc
         GbtJrw2jkajNZVQi06lZ7z9PxLXyxR7UnsA18Rd4gJBrzx2etWBCJQ2K6cVTVLZlfE
         0naA+siQ6U+7csMNltqPSWeyv9UbTsCfzS5OllLJK0Ti1w+KRcnNVdfSVzxfjU5sO1
         UBmcs1RYjpKVFWqbYxy3pWnnLsEwsslfabim/4dKkJdPXI63Ggb47XviKInfi7w0gA
         HidDyYYJjmOZg==
Received: by mail-vs1-f44.google.com with SMTP id 129so25697694vsi.10;
        Sat, 17 Sep 2022 08:39:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf3efIaej2Xy9OnLS14GfICEdwITPZn7YwPeSR9pzvcH1E7bQTeZ
        /PGIHX7pnsxsmq3jus+14BdEBAfB2qyQqob8VSo=
X-Google-Smtp-Source: AMsMyM6Fzv5EcbW38lJuuoJCQBEvKLvyY1n9RBJUawWys4j3cAExBetakppBzfT7c6uXhDhYdpBc/R85Fk+ooYFlCzI=
X-Received: by 2002:a67:d491:0:b0:398:1bbc:bc85 with SMTP id
 g17-20020a67d491000000b003981bbcbc85mr3783191vsj.59.1663429156000; Sat, 17
 Sep 2022 08:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220917065250.1671718-1-chenhuacai@loongson.cn> <80b46671-6d01-f2a2-7b9b-cb4c27cc87c6@redhat.com>
In-Reply-To: <80b46671-6d01-f2a2-7b9b-cb4c27cc87c6@redhat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 17 Sep 2022 23:39:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7zwtJ06=2LQXg_uonRA8vzUif4AQNbzF_L2jewf7cVTA@mail.gmail.com>
Message-ID: <CAAhV-H7zwtJ06=2LQXg_uonRA8vzUif4AQNbzF_L2jewf7cVTA@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add ACPI-based generic laptop driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mark Gross <markgross@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Hans,

On Sat, Sep 17, 2022 at 6:00 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi again,
>
> On 9/17/22 08:52, Huacai Chen wrote:
> > From: Jianmin Lv <lvjianmin@loongson.cn>
> >
> > This add ACPI-based generic laptop driver for Loongson-3. Some of the
> > codes are derived from drivers/platform/x86/thinkpad_acpi.c.
> >
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Fix problems pointed out by Arnd.
> > V3: Use platform driver instead of acpi driver.
>
> A couple more notes which I noticed just after sending my previous email:
>
> > +#define ACPI_LAPTOP_VERSION "1.0"
> > +#define ACPI_LAPTOP_NAME "loongson-laptop"
> > +#define ACPI_LAPTOP_DESC "Loongson Laptop/all-in-one ACPI Driver"
> > +#define ACPI_LAPTOP_FILE ACPI_LAPTOP_NAME "_acpi"
> > +#define ACPI_LAPTOP_DRVR_NAME ACPI_LAPTOP_FILE
> > +#define ACPI_LAPTOP_ACPI_EVENT_PREFIX "loongson"
>
> Do you really need / use all these defines ?
All unneeded macros will be removed, thanks.

>
> > +static const struct acpi_device_id loongson_htk_device_ids[] = {
> > +     {LOONGSON_ACPI_HKEY_HID, 0},
> > +     {"", 0},
> > +};
>
> You will want to put a:
>
> MODULE_DEVICE_TABLE(acpi, loongson_htk_device_ids);
>
> line here for proper automatic loading when build as a module.
OK, thanks.

>
> > +
> > +static struct platform_driver loongson_hotkey_driver = {
> > +     .probe          = loongson_hotkey_probe,
> > +     .driver         = {
> > +             .name   = "loongson-hotkey",
> > +             .owner  = THIS_MODULE,
> > +             .pm     = pm_ptr(&loongson_hotkey_pm),
> > +             .acpi_match_table = ACPI_PTR(loongson_htk_device_ids),
>
> Since you unconditionally define loongson_htk_device_ids above;
> and since you have a "depends on ACPI" in your Kconfig, you can drop
> the ACPI_PTR() here, just use loongson_htk_device_ids directly.
OK, thanks.

>
> > +static int __init generic_acpi_laptop_init(void)
> > +{
> > +     bool ec_found;
> > +     int i, ret, status;
> > +
> > +     if (acpi_disabled)
> > +             return -ENODEV;
> > +
> > +     /* The EC device is required */
> > +     ec_found = acpi_dev_found(LOONGSON_ACPI_EC_HID);
> > +     if (!ec_found)
> > +             return -ENODEV;
> > +
> > +     /* Enable SCI for EC */
> > +     acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
> > +
> > +     generic_inputdev = input_allocate_device();
> > +     if (!generic_inputdev) {
> > +             pr_err("Unable to allocate input device\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Prepare input device, but don't register */
> > +     generic_inputdev->name =
> > +             "Loongson Generic Laptop/All-in-one Extra Buttons";
> > +     generic_inputdev->phys = ACPI_LAPTOP_DRVR_NAME "/input0";
> > +     generic_inputdev->id.bustype = BUS_HOST;
> > +     generic_inputdev->dev.parent = NULL;
> > +
> > +     /* Init subdrivers */
> > +     for (i = 0; i < ARRAY_SIZE(generic_sub_drivers); i++) {
> > +             ret = generic_subdriver_init(&generic_sub_drivers[i]);
> > +             if (ret < 0) {
> > +                     input_free_device(generic_inputdev);
> > +                     return ret;
> > +             }
> > +     }
>
> I see above that you have only 1 subdriver. Do you expect there to be
> more in the future ?  If not then it would be better to just completely
> remove the subdriver abstraction and simply do everything directly
> from the main probe/remove functions (see below).
At this time we only add the most basic subdriver, and more subdrivers
will be added, so I want to keep it here.

>
> > +
> > +     ret = input_register_device(generic_inputdev);
> > +     if (ret < 0) {
> > +             input_free_device(generic_inputdev);
> > +             pr_err("Unable to register input device\n");
> > +             return ret;
> > +     }
> > +
> > +     input_device_registered = 1;
> > +
> > +     if (acpi_evalf(hotkey_handle, &status, "ECBG", "d")) {
> > +             pr_info("Loongson Laptop used, init brightness is 0x%x\n", status);
> > +             ret = laptop_backlight_register();
> > +             if (ret < 0)
> > +                     pr_err("Loongson Laptop: laptop-backlight device register failed\n");
> > +     }
> > +
> > +     return 0;
> > +}
>
> All of generic_acpi_laptop_init should be done from loongson_hotkey_probe()
> and instead of using global variables all data you need should be in a struct
> and that struct should be alloc-ed from loongson_hotkey_probe() and then tied
> to the platform_device using platform_set_drvdata() and retreived on remove
> using platform_get_drvdata() and on suspend/resume using dev_get_drvdata().
>
> > +static void __exit generic_acpi_laptop_exit(void)
> > +{
> > +     if (generic_inputdev) {
> > +             if (input_device_registered)
> > +                     input_unregister_device(generic_inputdev);
> > +             else
> > +                     input_free_device(generic_inputdev);
> > +     }
> > +}
>
> This should be done from a remove function which then gets set as the
> remove callback in loongson_hotkey_driver.
>
> I see at a quick glance that you based this driver on thinkpad_acpi.c
> but that is a very old driver which does a bunch of things in old,
> deprecated ways which are hard to fix for userspace API compatibility
> reasons.
>
> Now a days we try to avoid global variables and also custom
> module_init()/module_exit() functions.
>
> > +module_init(generic_acpi_laptop_init);
> > +module_exit(generic_acpi_laptop_exit);
>
> Once the work of these 2 functions is done from loongson_hotkey_driver.probe /
> loongson_hotkey_driver.remove, you can replace this with:
>
> module_platform_driver(loongson_hotkey_driver);
>
> > +
> > +MODULE_ALIAS("platform:acpi-laptop");
>
> This is not necessary, what you need for autoloading is the:
>
> MODULE_DEVICE_TABLE(acpi, loongson_htk_device_ids);
>
> mentioned above.
OK, thanks.

>
> > +MODULE_AUTHOR("Jianmin Lv <lvjianmin@loongson.cn>");
> > +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> > +MODULE_DESCRIPTION(ACPI_LAPTOP_DESC);
>
> You only use the ACPI_LAPTOP_DESC #define once, please just
> put its contents directly here.
OK, thanks.

>
> > +MODULE_VERSION(ACPI_LAPTOP_VERSION);
>
> Modules having there own versioning separate from the kernel
> is something from the past. Please drop the MODULE_VERSION() line
> and the ACPI_LAPTOP_VERSION #define.
OK, thanks.

Huacai
>
> > +MODULE_LICENSE("GPL");
>
> Regards,
>
> Hans
>
