Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA99595815
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiHPKXs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 06:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbiHPKX3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 06:23:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DAB49D;
        Tue, 16 Aug 2022 01:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC8E6B81600;
        Tue, 16 Aug 2022 08:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DBBC43142;
        Tue, 16 Aug 2022 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660640125;
        bh=6n3Q6HFtuoS0aqei1qVQEAN9dLtTgtFHYg5ZMtWgmdM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RIrdhv2L++R9B7NVcULn/MFe2yWVTWil7/x0z+QgCuxoLi56Te2x7fVxohp0zo5P0
         TRlS18WPalZcqx7AZoN1HUZflhAKuhJJobaXcJsW/77JgkDZioxj9JteyweO+jWFGP
         3BOiI/jew1VtRfTTYIqtGjm40jl1fwrEN+C5183uYVIiHRvia3uFOoSFKTURjhHQuv
         s5iwMcwrj4E8l4MF2NrabK3n8WhRLR0UzCZAxsTlOOMAPI32WFz0f2Fq+rbJ8t9ROm
         /eyIz3UpCbH+hDlqH07gSL1F6Gw6fIvAdbnUQ0Q3Y1DQ0F7DFHxfYNeXSLxZLdYBpw
         uHqWNAWBHLB/A==
Received: by mail-vk1-f179.google.com with SMTP id bi51so4835823vkb.5;
        Tue, 16 Aug 2022 01:55:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo0vB32f2dVbaKGlTK7MtnpSW10r/mLNdHChpkMoH7kvqyG9PUH9
        4cOzxX83E+H9xpEfA0drYDX/WQoDhSzE9kQo0CI=
X-Google-Smtp-Source: AA6agR41lNj0NRZWyNSR4D+cfVnHLXTfSPG0BgFBv7VZX3HC2Ss685tM9xCBahwF47dMx9/eSkYvg3jnneVv/opfd/Y=
X-Received: by 2002:a1f:9d13:0:b0:376:7f81:9b85 with SMTP id
 g19-20020a1f9d13000000b003767f819b85mr8677102vke.18.1660640124487; Tue, 16
 Aug 2022 01:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220815124803.3332991-1-chenhuacai@loongson.cn>
 <20220815124803.3332991-2-chenhuacai@loongson.cn> <CAK8P3a2P=XSM1_eD-UkvHaQ8Y4ak4BPAAABg2LxNBhyWhhO4uA@mail.gmail.com>
In-Reply-To: <CAK8P3a2P=XSM1_eD-UkvHaQ8Y4ak4BPAAABg2LxNBhyWhhO4uA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 16 Aug 2022 16:55:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ow1WwVdwk4ekQU_aA+dFrUoL3SBrL9Esn9Td-rJKJcg@mail.gmail.com>
Message-ID: <CAAhV-H6ow1WwVdwk4ekQU_aA+dFrUoL3SBrL9Esn9Td-rJKJcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Add ACPI-based generic laptop driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Tue, Aug 16, 2022 at 3:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Aug 15, 2022 at 2:48 PM Huacai Chen <chenhuacai@loongson.cn> wrot=
e:
> >
> > From: Jianmin Lv <lvjianmin@loongson.cn>
> >
> > This add ACPI-based generic laptop driver for Loongson-3. Some of the
> > codes are derived from drivers/platform/x86/thinkpad_acpi.c.
> >
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/platform/loongarch/Kconfig          |  18 +
> >  drivers/platform/loongarch/Makefile         |   1 +
> >  drivers/platform/loongarch/generic-laptop.c | 775 ++++++++++++++++++++
> >  3 files changed, 794 insertions(+)
> >  create mode 100644 drivers/platform/loongarch/generic-laptop.c
> >
> > diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loon=
garch/Kconfig
> > index a1542843b0ad..086212d57251 100644
> > --- a/drivers/platform/loongarch/Kconfig
> > +++ b/drivers/platform/loongarch/Kconfig
> > @@ -23,4 +23,22 @@ config CPU_HWMON
> >         help
> >           Loongson-3A/3B/3C CPU HWMon (temperature sensor) driver.
> >
> > +config GENERIC_LAPTOP
> > +       tristate "Generic Loongson-3A Laptop Driver"
> > +       depends on MACH_LOONGSON64
> > +       depends on ACPI
> > +       depends on INPUT
> > +       select BACKLIGHT_CLASS_DEVICE
> > +       select BACKLIGHT_LCD_SUPPORT
> > +       select HWMON
> > +       select INPUT_EVDEV
> > +       select INPUT_SPARSEKMAP
> > +       select LCD_CLASS_DEVICE
> > +       select LEDS_CLASS
> > +       select POWER_SUPPLY
> > +       select VIDEO_OUTPUT_CONTROL
> > +       default y
> > +       help
> > +         ACPI-based Loongson-3 family laptops generic driver.
>
> It's rather bad style to 'select' entire subsystems from a device
> driver. This may be
> unavoidable in some cases, but please try to make it possible to build th=
e
> driver when some or all of the other subsystems are disabled. In a lot
> of subsystems,
> there is an API stub like
OK, the Kconfig should be cleaned up, I will remove those unneeded
lines, and convert some others to "depends on".

>
> > +/*********************************************************************=
*******
> > + *********************************************************************=
*******
> > + *
> > + * ACPI Helpers and device model
> > + *
> > + *********************************************************************=
*******
> > + *********************************************************************=
*******/
>
> Try to follow the normal commenting style
OK, thanks.

>
> > +/* ACPI basic handles */
> > +
> > +static int acpi_evalf(acpi_handle handle,
> > +                     int *res, char *method, char *fmt, ...);
> > +static acpi_handle ec_handle;
>
> Instead of forward function declarations, try sorting the functions in
> call order,
> which has the benefit of making more sense to most readers.
OK, thanks.

>
> > +#ifdef CONFIG_PM
> > +static int loongson_generic_suspend(struct device *dev)
> > +{
> > +       return 0;
> > +}
> > +static int loongson_generic_resume(struct device *dev)
> > +{
> > +       int status =3D 0;
> > +       struct key_entry ke;
> > +       struct backlight_device *bd;
> > +
> > +       /*
> > +        * Only if the firmware supports SW_LID event model, we can han=
dle the
> > +        * event. This is for the consideration of development board wi=
thout
> > +        * EC.
> > +        */
> > +       if (test_bit(SW_LID, generic_inputdev->swbit)) {
> > +               if (hotkey_status_get(&status))
> > +                       return -EIO;
> > +               /*
> > +                * The input device sw element records the last lid sta=
tus.
> > +                * When the system is awakened by other wake-up sources=
,
> > +                * the lid event will also be reported. The judgment of
> > +                * adding SW_LID bit which in sw element can avoid this
> > +                * case.
> > +                *
> > +                * input system will drop lid event when current lid ev=
ent
> > +                * value and last lid status in the same data set=EF=BC=
=8Cwhich
> > +                * data set inclue zero set and no zero set. so laptop
> > +                * driver doesn't report repeated events.
> > +                *
> > +                * Lid status is generally 0, but hardware exception is
> > +                * considered. So add lid status confirmation.
> > +                */
> > +               if (test_bit(SW_LID, generic_inputdev->sw) && !(status =
& (1 << SW_LID))) {
> > +                       ke.type =3D KE_SW;
> > +                       ke.sw.value =3D (u8)status;
> > +                       ke.sw.code =3D SW_LID;
> > +                       sparse_keymap_report_entry(generic_inputdev, &k=
e,
> > +                                       1, true);
> > +               }
> > +       }
> > +
> > +       bd =3D backlight_device_get_by_type(BACKLIGHT_PLATFORM);
> > +       if (bd) {
> > +               loongson_laptop_backlight_update(bd) ?
> > +               pr_warn("Loongson_backlight:resume brightness failed") =
:
> > +               pr_info("Loongson_backlight:resume brightness %d\n", bd=
->props.brightness);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(loongson_generic_pm,
> > +               loongson_generic_suspend, loongson_generic_resume);
> > +#endif
>
>
> Instead of the #ifdef, use the newer DEFINE_SIMPLE_DEV_PM_OPS() in place
> of SIMPLE_DEV_PM_OPS() so the code will always be parsed but left out
> when CONFIG_PM is disabled.
OK, thanks.

>
> > +
> > +static int __init register_generic_subdriver(struct generic_struct *su=
b_driver)
> > +{
> > +       int rc;
> > +
> > +       BUG_ON(!sub_driver->acpi);
> > +
> > +       sub_driver->acpi->driver =3D kzalloc(sizeof(struct acpi_driver)=
, GFP_KERNEL);
> > +       if (!sub_driver->acpi->driver) {
> > +               pr_err("failed to allocate memory for ibm->acpi->driver=
\n");
> > +               return -ENOMEM;
> > +       }
>
> Drivers should be statically allocated. Usually you want one 'struct
> acpi_driver' or
> 'struct platform_driver' per file, so you can just use 'module_acpi_drive=
r()'.
I found that "subdriver" in other laptop drivers also uses dynamical
allocation, because there may be various numbers of subdrivers. I want
to keep it, at least in the next version for review.

>
> > +int ec_get_brightness(void)
> > +{
> > +       int status =3D 0;
> > +
> > +       if (!hkey_handle)
> > +               return -ENXIO;
> > +
> > +       if (!acpi_evalf(hkey_handle, &status, "ECBG", "d"))
> > +               return -EIO;
> > +
> > +       if (status < 0)
> > +               return status;
> > +
> > +       return status;
> > +}
> > +EXPORT_SYMBOL(ec_get_brightness);
>
> The name is too generic to have it in the global namespace for a platform
> specific driver. Use a prefix to make it clear which driver this belongs =
to.
>
> Not sure this function warrants an export though, it looks like you could
> just have it in the caller module.
Yes, they should be static.

>
> > +
> > +int turn_off_backlight(void)
> > +{
> > +       int status;
> > +       union acpi_object arg0 =3D { ACPI_TYPE_INTEGER };
> > +       struct acpi_object_list args =3D { 1, &arg0 };
> > +
> > +       arg0.integer.value =3D 0;
> > +       status =3D acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
> > +       if (ACPI_FAILURE(status)) {
> > +               pr_info("Loongson lvds error: 0x%x\n", status);
> > +               return -ENODEV;
> > +       }
> > +
> > +       return 0;
> > +}
>
> Again, the name is too generic for a global function.
Yes, they should be renamed.

>
> I suspect that if you split out the backlight handling into a separate
> driver, you can avoid
> the 'select' statements completely and make that driver 'depends on
> BACKLIGHT_CLASS_DEVICE'
> or move it within the 'if BACKLIGHT_CLASS_DEVICE' section of
> drivers/video/backlight/Kconfig.
>
>
> > +static struct generic_acpi_drv_struct ec_event_acpidriver =3D {
> > +       .hid =3D loongson_htk_device_ids,
> > +       .notify =3D event_notify,
> > +       .handle =3D &hkey_handle,
> > +       .type =3D ACPI_DEVICE_NOTIFY,
> > +};
>
> Same here, this can probably just be an input driver in drivers/input.
It seems the existing "laptop drivers" are also complex drivers to
bind several "subdrivers" together.

Huacai
>
>        Arnd
>
