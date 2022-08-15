Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0217A593FB6
	for <lists+linux-arch@lfdr.de>; Mon, 15 Aug 2022 23:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiHOU4l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 15 Aug 2022 16:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbiHOUz7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Aug 2022 16:55:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837303B96D;
        Mon, 15 Aug 2022 12:11:27 -0700 (PDT)
Received: from mail-ej1-f54.google.com ([209.85.218.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mt8cD-1nUs320rnN-00tSsO; Mon, 15 Aug 2022 21:11:25 +0200
Received: by mail-ej1-f54.google.com with SMTP id kb8so15123889ejc.4;
        Mon, 15 Aug 2022 12:11:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo0rqwsIxsiW2VP81zvFYA2ZCXhwUvUXEK5fwcbtS5Up6oTmj2zG
        IZxOrYcqbOKYb9OBFrEkD68ZSjcC5rLbGkMib/c=
X-Google-Smtp-Source: AA6agR4JuiQKPqjpyvBzGbvr5VKRMH2RGu991D7gP5wwEtHkuPtwIFkYm248LOmAveMDVMtCW9KS23hCkpF4P8janIg=
X-Received: by 2002:a17:907:7609:b0:730:d70a:1efc with SMTP id
 jx9-20020a170907760900b00730d70a1efcmr11292737ejc.766.1660590684735; Mon, 15
 Aug 2022 12:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220815124803.3332991-1-chenhuacai@loongson.cn> <20220815124803.3332991-2-chenhuacai@loongson.cn>
In-Reply-To: <20220815124803.3332991-2-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Aug 2022 21:11:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2P=XSM1_eD-UkvHaQ8Y4ak4BPAAABg2LxNBhyWhhO4uA@mail.gmail.com>
Message-ID: <CAK8P3a2P=XSM1_eD-UkvHaQ8Y4ak4BPAAABg2LxNBhyWhhO4uA@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Add ACPI-based generic laptop driver
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:8XZ1b1yzcJf46FYpJIwHcvb45dl3hcJf6186Uak9VjdylUj1zQa
 0V7eooOXpTPEuQ+9ZhGluZCM0mymtKX8lucrnVSsRkpZaPgDAZbXbpmZ8zAMaedbxCOfmy7
 aeXKNuXfZTX4n7CA+7r1dC0ssLKTTc5+Kd9NRzp59kJkRwnQsqytCbS85w0evrcI79B00mg
 ubEZGMDc5eoJQrskJ5WFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehWCil1M6iE=:NFbddb4kxWRcK5i8dsWCeZ
 yVYqxaJbmNBGbpUmc7yAXQb35zXlNNEkJNuzAvykse5Mnsr6ZUEP20wmy2ztWfrDiE7LwwiZQ
 3Jl4fLGrIRX5SvPsRyJEze4dMqVu2yv5SXgAXn+Q3SdicRoeIu3i/su+PVtGUdx/qD9cVdinN
 TsK7fEJiGTiblRTyauctM1UDDzRs5hdXMrBU8GxsNNhmOc8NeJrZUUNB7RxrWOPaHb+CgJyKv
 TPxohDkOBYlFr65jP0b9ZMAHKMhaT602SjaxOuHruaXVHSVlv83wt7SLOLOgUFACgPraXcOad
 3tyJsSK6xeUhBtCzrZhGLDjCDXfAu4c0DjCvp0cx3vnlAd8ZOUalrgZfaTVBw3lrev/w/mqy/
 kvlGKWMKIb5jo06jiMdZTrLDPTiGIVwBGQv8tzYvFcbumly7YptMcHhX79e/bVqMCRYV64jJ4
 VDB+soVlgWwQhifeEZZRe+fhf0vS0JwldHEf1nvoiEAzNbRu7fsqH/77Z6so3/ttDhxCN4UD6
 SYSEITmGotCI23/PWQho0RwkdGvjB792kH2CzwHQFV2TZLqPaRylSzz0ws/4GaFUyK9XYIwcH
 WMFE5+kayMoI/Lknv+H0uDe06RVPs0UcJzcvyWHeNlIZfn04KMjf+tHBybYOWACblKdi0e+tE
 HfPeF7rdu05ns0CN5gNWf5H6gnlXmd0+sCefQict3slM60KpvA7kR379U8pKb5ADW1DDdpF9p
 sqp6C8VWt8EuskAA1Occ70GJKbRrYg6HWoTXCrxUGRCk6O45g1VRE5Prrq971BFe9yGBrkA8f
 xU4cgY7FdazwmdUAkHoKXCn31rgn1f+lZhsEVGKy5L3DvwG678Gj48tP3+DZCGfpYJQD3Kmdb
 Rwl8EIoc1m0H+N3/zwbA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 15, 2022 at 2:48 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> From: Jianmin Lv <lvjianmin@loongson.cn>
>
> This add ACPI-based generic laptop driver for Loongson-3. Some of the
> codes are derived from drivers/platform/x86/thinkpad_acpi.c.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/platform/loongarch/Kconfig          |  18 +
>  drivers/platform/loongarch/Makefile         |   1 +
>  drivers/platform/loongarch/generic-laptop.c | 775 ++++++++++++++++++++
>  3 files changed, 794 insertions(+)
>  create mode 100644 drivers/platform/loongarch/generic-laptop.c
>
> diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loongarch/Kconfig
> index a1542843b0ad..086212d57251 100644
> --- a/drivers/platform/loongarch/Kconfig
> +++ b/drivers/platform/loongarch/Kconfig
> @@ -23,4 +23,22 @@ config CPU_HWMON
>         help
>           Loongson-3A/3B/3C CPU HWMon (temperature sensor) driver.
>
> +config GENERIC_LAPTOP
> +       tristate "Generic Loongson-3A Laptop Driver"
> +       depends on MACH_LOONGSON64
> +       depends on ACPI
> +       depends on INPUT
> +       select BACKLIGHT_CLASS_DEVICE
> +       select BACKLIGHT_LCD_SUPPORT
> +       select HWMON
> +       select INPUT_EVDEV
> +       select INPUT_SPARSEKMAP
> +       select LCD_CLASS_DEVICE
> +       select LEDS_CLASS
> +       select POWER_SUPPLY
> +       select VIDEO_OUTPUT_CONTROL
> +       default y
> +       help
> +         ACPI-based Loongson-3 family laptops generic driver.

It's rather bad style to 'select' entire subsystems from a device
driver. This may be
unavoidable in some cases, but please try to make it possible to build the
driver when some or all of the other subsystems are disabled. In a lot
of subsystems,
there is an API stub like

> +/****************************************************************************
> + ****************************************************************************
> + *
> + * ACPI Helpers and device model
> + *
> + ****************************************************************************
> + ****************************************************************************/

Try to follow the normal commenting style

> +/* ACPI basic handles */
> +
> +static int acpi_evalf(acpi_handle handle,
> +                     int *res, char *method, char *fmt, ...);
> +static acpi_handle ec_handle;

Instead of forward function declarations, try sorting the functions in
call order,
which has the benefit of making more sense to most readers.

> +#ifdef CONFIG_PM
> +static int loongson_generic_suspend(struct device *dev)
> +{
> +       return 0;
> +}
> +static int loongson_generic_resume(struct device *dev)
> +{
> +       int status = 0;
> +       struct key_entry ke;
> +       struct backlight_device *bd;
> +
> +       /*
> +        * Only if the firmware supports SW_LID event model, we can handle the
> +        * event. This is for the consideration of development board without
> +        * EC.
> +        */
> +       if (test_bit(SW_LID, generic_inputdev->swbit)) {
> +               if (hotkey_status_get(&status))
> +                       return -EIO;
> +               /*
> +                * The input device sw element records the last lid status.
> +                * When the system is awakened by other wake-up sources,
> +                * the lid event will also be reported. The judgment of
> +                * adding SW_LID bit which in sw element can avoid this
> +                * case.
> +                *
> +                * input system will drop lid event when current lid event
> +                * value and last lid status in the same data set，which
> +                * data set inclue zero set and no zero set. so laptop
> +                * driver doesn't report repeated events.
> +                *
> +                * Lid status is generally 0, but hardware exception is
> +                * considered. So add lid status confirmation.
> +                */
> +               if (test_bit(SW_LID, generic_inputdev->sw) && !(status & (1 << SW_LID))) {
> +                       ke.type = KE_SW;
> +                       ke.sw.value = (u8)status;
> +                       ke.sw.code = SW_LID;
> +                       sparse_keymap_report_entry(generic_inputdev, &ke,
> +                                       1, true);
> +               }
> +       }
> +
> +       bd = backlight_device_get_by_type(BACKLIGHT_PLATFORM);
> +       if (bd) {
> +               loongson_laptop_backlight_update(bd) ?
> +               pr_warn("Loongson_backlight:resume brightness failed") :
> +               pr_info("Loongson_backlight:resume brightness %d\n", bd->props.brightness);
> +       }
> +
> +       return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(loongson_generic_pm,
> +               loongson_generic_suspend, loongson_generic_resume);
> +#endif


Instead of the #ifdef, use the newer DEFINE_SIMPLE_DEV_PM_OPS() in place
of SIMPLE_DEV_PM_OPS() so the code will always be parsed but left out
when CONFIG_PM is disabled.

> +
> +static int __init register_generic_subdriver(struct generic_struct *sub_driver)
> +{
> +       int rc;
> +
> +       BUG_ON(!sub_driver->acpi);
> +
> +       sub_driver->acpi->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
> +       if (!sub_driver->acpi->driver) {
> +               pr_err("failed to allocate memory for ibm->acpi->driver\n");
> +               return -ENOMEM;
> +       }

Drivers should be statically allocated. Usually you want one 'struct
acpi_driver' or
'struct platform_driver' per file, so you can just use 'module_acpi_driver()'.

> +int ec_get_brightness(void)
> +{
> +       int status = 0;
> +
> +       if (!hkey_handle)
> +               return -ENXIO;
> +
> +       if (!acpi_evalf(hkey_handle, &status, "ECBG", "d"))
> +               return -EIO;
> +
> +       if (status < 0)
> +               return status;
> +
> +       return status;
> +}
> +EXPORT_SYMBOL(ec_get_brightness);

The name is too generic to have it in the global namespace for a platform
specific driver. Use a prefix to make it clear which driver this belongs to.

Not sure this function warrants an export though, it looks like you could
just have it in the caller module.

> +
> +int turn_off_backlight(void)
> +{
> +       int status;
> +       union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +       struct acpi_object_list args = { 1, &arg0 };
> +
> +       arg0.integer.value = 0;
> +       status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
> +       if (ACPI_FAILURE(status)) {
> +               pr_info("Loongson lvds error: 0x%x\n", status);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}

Again, the name is too generic for a global function.

I suspect that if you split out the backlight handling into a separate
driver, you can avoid
the 'select' statements completely and make that driver 'depends on
BACKLIGHT_CLASS_DEVICE'
or move it within the 'if BACKLIGHT_CLASS_DEVICE' section of
drivers/video/backlight/Kconfig.


> +static struct generic_acpi_drv_struct ec_event_acpidriver = {
> +       .hid = loongson_htk_device_ids,
> +       .notify = event_notify,
> +       .handle = &hkey_handle,
> +       .type = ACPI_DEVICE_NOTIFY,
> +};

Same here, this can probably just be an input driver in drivers/input.

       Arnd
