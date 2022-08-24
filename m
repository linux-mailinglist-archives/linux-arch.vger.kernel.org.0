Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B8359FE33
	for <lists+linux-arch@lfdr.de>; Wed, 24 Aug 2022 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiHXPYl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Aug 2022 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXPYj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 11:24:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4BF98D24;
        Wed, 24 Aug 2022 08:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50AA3B82572;
        Wed, 24 Aug 2022 15:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DD9C4347C;
        Wed, 24 Aug 2022 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661354674;
        bh=2fkOMQHqxqjtYMHlc4rvy/3o3c3F5gsQpBhYwl4Wzq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V1MBkFkXrHTsAgPAbfGPopv18VDZTwRFk0IMXDH5cWdsF35Wn0WgqPZhP1EX2AgYa
         Hc985Ha3Eo0SQNkeLPBlaFrSyuIm5CczoNfy0Ht25X7s2JOZPhJO+NfoyjKmPq0ib+
         +YhktFGYiGpCzqGWIoxELM4JzIhr96q0Hh49t+gYkQ8sOJnDphc4ZWUW27bMXLQXIj
         FDEXC1IWzuZUNJhMet52gPTbV1JyBc/iJQEe7VHay3Ujd3pEveuPR1rGcJuQ4GchPR
         DTMeKh5m7s56iVI1s6rqJ4JCupqlqA/IIXC3av3NtsPSxHGMlIdJpgxqwohz+XBtB2
         SjBSdAONUIS9A==
Received: by mail-vs1-f50.google.com with SMTP id l7so17633247vsc.0;
        Wed, 24 Aug 2022 08:24:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo3/eISVfH0/Wq64QDC3vh0Ovms+rzMwWEm13sf20jN9JR16f1Sd
        wYBiRj3XWnNfcMrOsMUA+WCGxQGDqY6JEMu77uI=
X-Google-Smtp-Source: AA6agR6jR0uZZaufKv1EA4RXYZnp9oD8F2qLy3BR/aN1fjTDN1/qfmJupx32TWpT5On5izzTaTnzKyZWfn3uF3OIZ1M=
X-Received: by 2002:a05:6102:3a70:b0:390:81fc:3f39 with SMTP id
 bf16-20020a0561023a7000b0039081fc3f39mr3417958vsb.84.1661354672783; Wed, 24
 Aug 2022 08:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
 <20220818042208.2896457-2-chenhuacai@loongson.cn> <CAJZ5v0gbs+ZTh-Mc8kkdtg05yzsvGjkkTuA5oHF_X=CphmqVYQ@mail.gmail.com>
 <CAAhV-H4gQ29Oa7x5tAByqxGYpaxfobRw-DAagUFS=FnmgGDtSQ@mail.gmail.com> <CAJZ5v0jY+DaBp-Nmxx-_drbKSg=2_bEZfd0yoOTovCsJTNn2GA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jY+DaBp-Nmxx-_drbKSg=2_bEZfd0yoOTovCsJTNn2GA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 24 Aug 2022 23:24:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6YXdUUquV6oyy8Loj1fxD=fnTo3=96Srrv-mCUqQ_P8Q@mail.gmail.com>
Message-ID: <CAAhV-H6YXdUUquV6oyy8Loj1fxD=fnTo3=96Srrv-mCUqQ_P8Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] LoongArch: Add ACPI-based generic laptop driver
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>, loongarch@lists.linux.dev,
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

Hi, Rafael,

On Wed, Aug 24, 2022 at 9:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Wed, Aug 24, 2022 at 6:13 AM Huacai Chen <chenhuacai@kernel.org> wrote=
:
> >
> > Hi, Rafael,
> >
> > On Wed, Aug 24, 2022 at 12:49 AM Rafael J. Wysocki <rafael@kernel.org> =
wrote:
> > >
> > > On Thu, Aug 18, 2022 at 6:23 AM Huacai Chen <chenhuacai@loongson.cn> =
wrote:
> > > >
> > > > From: Jianmin Lv <lvjianmin@loongson.cn>
> > > >
> > > > This add ACPI-based generic laptop driver for Loongson-3. Some of t=
he
> > > > codes are derived from drivers/platform/x86/thinkpad_acpi.c.
> > > >
> > > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > > V2: Fix problems pointed out by Arnd.
> > > >
> > > >  drivers/platform/loongarch/Kconfig          |  12 +
> > > >  drivers/platform/loongarch/Makefile         |   1 +
> > > >  drivers/platform/loongarch/generic-laptop.c | 747 ++++++++++++++++=
++++
> > > >  3 files changed, 760 insertions(+)
> > > >  create mode 100644 drivers/platform/loongarch/generic-laptop.c
> > > >
> > > > diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/=
loongarch/Kconfig
> > > > index a1542843b0ad..61ed83227d36 100644
> > > > --- a/drivers/platform/loongarch/Kconfig
> > > > +++ b/drivers/platform/loongarch/Kconfig
> > > > @@ -23,4 +23,16 @@ config CPU_HWMON
> > > >         help
> > > >           Loongson-3A/3B/3C CPU HWMon (temperature sensor) driver.
> > > >
> > > > +config GENERIC_LAPTOP
> > > > +       tristate "Generic Loongson-3 Laptop Driver"
> > > > +       depends on ACPI
> > > > +       depends on BACKLIGHT_CLASS_DEVICE
> > > > +       depends on INPUT
> > > > +       depends on MACH_LOONGSON64
> > > > +       select INPUT_EVDEV
> > > > +       select INPUT_SPARSEKMAP
> > > > +       default y
> > > > +       help
> > > > +         ACPI-based Loongson-3 family laptops generic driver.
> > > > +
> > > >  endif # LOONGARCH_PLATFORM_DEVICES
> > > > diff --git a/drivers/platform/loongarch/Makefile b/drivers/platform=
/loongarch/Makefile
> > > > index 8dfd03924c37..9d6f69f2319d 100644
> > > > --- a/drivers/platform/loongarch/Makefile
> > > > +++ b/drivers/platform/loongarch/Makefile
> > > > @@ -1 +1,2 @@
> > > >  obj-$(CONFIG_CPU_HWMON) +=3D cpu_hwmon.o
> > > > +obj-$(CONFIG_GENERIC_LAPTOP) +=3D generic-laptop.o
> > > > diff --git a/drivers/platform/loongarch/generic-laptop.c b/drivers/=
platform/loongarch/generic-laptop.c
> > > > new file mode 100644
> > > > index 000000000000..90c866f29702
> > > > --- /dev/null
> > > > +++ b/drivers/platform/loongarch/generic-laptop.c
> > > > @@ -0,0 +1,747 @@
> > > > +/*
> > > > + *  Generic Loongson processor based LAPTOP/ALL-IN-ONE driver
> > > > + *
> > > > + *  Jianmin Lv <lvjianmin@loongson.cn>
> > > > + *  Huacai Chen <chenhuacai@loongson.cn>
> > > > + *
> > > > + * Copyright (C) 2022 Loongson Technology Corporation Limited
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/string.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/input.h>
> > > > +#include <linux/acpi.h>
> > > > +#include <linux/uaccess.h>
> > > > +#include <linux/input/sparse-keymap.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/backlight.h>
> > > > +#include <acpi/video.h>
> > > > +
> > > > +/* ACPI HIDs */
> > > > +#define LOONGSON_ACPI_HKEY_HID "LOON0000"
> > > > +#define LOONGSON_ACPI_EC_HID   "PNP0C09"
> > > > +
> > > > +/* Main driver */
> > > > +
> > > > +#define ACPI_LAPTOP_VERSION "1.0"
> > > > +#define ACPI_LAPTOP_NAME "loongson-laptop"
> > > > +#define ACPI_LAPTOP_DESC "Loongson Laptop/all-in-one ACPI Driver"
> > > > +#define ACPI_LAPTOP_FILE ACPI_LAPTOP_NAME "_acpi"
> > > > +#define ACPI_LAPTOP_DRVR_NAME ACPI_LAPTOP_FILE
> > > > +#define ACPI_LAPTOP_ACPI_EVENT_PREFIX "loongson"
> > > > +
> > > > +/* Driver-wide structs and misc. variables */
> > > > +
> > > > +struct generic_struct;
> > > > +
> > > > +struct generic_acpi_drv_struct {
> > > > +       u32 type;
> > > > +       acpi_handle *handle;
> > > > +       const struct acpi_device_id *hid;
> > > > +       struct acpi_device *device;
> > > > +       struct acpi_driver *driver;
> > > > +       void (*notify)(struct generic_struct *, u32);
> > > > +};
> > > > +
> > > > +struct generic_struct {
> > > > +       char *name;
> > > > +
> > > > +       int (*init)(struct generic_struct *);
> > > > +
> > > > +       struct generic_acpi_drv_struct *acpi;
> > > > +
> > > > +       struct {
> > > > +               u8 acpi_driver_registered;
> > > > +               u8 acpi_notify_installed;
> > > > +       } flags;
> > > > +};
> > > > +
> > > > +
> > > > +static struct {
> > > > +       u32 input_device_registered:1;
> > > > +} generic_features;
> > > > +
> > > > +static int hotkey_status_get(int *status);
> > > > +static int loongson_laptop_backlight_update(struct backlight_devic=
e *bd);
> > > > +
> > > > +/* 1. ACPI Helpers and device model */
> > > > +
> > > > +/* ACPI basic handles */
> > > > +
> > > > +static acpi_handle ec_handle;
> > > > +
> > > > +#define GENERIC_HANDLE(object, parent, paths...)                  =
     \
> > > > +       static acpi_handle  object##_handle;                    \
> > > > +       static const acpi_handle * const object##_parent __initcons=
t =3D  \
> > > > +                                               &parent##_handle; \
> > > > +       static char *object##_paths[] __initdata =3D { paths }
> > > > +
> > > > +GENERIC_HANDLE(hkey, ec, "\\_SB.HKEY", "^HKEY", "HKEY",);
> > > > +
> > > > +/* ACPI device model */
> > > > +
> > > > +#define GENERIC_ACPIHANDLE_INIT(object) \
> > > > +       drv_acpi_handle_init(#object, &object##_handle, *object##_p=
arent, \
> > > > +               object##_paths, ARRAY_SIZE(object##_paths))
> > > > +
> > > > +static void __init drv_acpi_handle_init(const char *name,
> > > > +                          acpi_handle *handle, const acpi_handle p=
arent,
> > > > +                          char **paths, const int num_paths)
> > > > +{
> > > > +       int i;
> > > > +       acpi_status status;
> > > > +
> > > > +       for (i =3D 0; i < num_paths; i++) {
> > > > +               status =3D acpi_get_handle(parent, paths[i], handle=
);
> > > > +               if (ACPI_SUCCESS(status))
> > > > +                       return;
> > > > +       }
> > > > +
> > > > +       *handle =3D NULL;
> > > > +}
> > > > +static acpi_status __init generic_acpi_handle_locate_callback(acpi=
_handle handle,
> > > > +                                       u32 level, void *context, v=
oid **return_value)
> > > > +{
> > > > +       *(acpi_handle *)return_value =3D handle;
> > > > +
> > > > +       return AE_CTRL_TERMINATE;
> > > > +}
> > > > +
> > > > +static void __init generic_acpi_handle_locate(const char *name,
> > > > +               const char *hid, acpi_handle *handle)
> > > > +{
> > > > +       acpi_status status;
> > > > +       acpi_handle device_found;
> > > > +
> > > > +       BUG_ON(!name || !hid || !handle);
> > > > +
> > > > +       *handle =3D NULL;
> > > > +
> > > > +       memset(&device_found, 0, sizeof(device_found));
> > > > +       status =3D acpi_get_devices(hid, generic_acpi_handle_locate=
_callback,
> > > > +                                 (void *)name, &device_found);
> > > > +
> > > > +       if (ACPI_SUCCESS(status))
> > > > +               *handle =3D device_found;
> > > > +}
> > > > +
> > > > +static void dispatch_acpi_notify(acpi_handle handle, u32 event, vo=
id *data)
> > > > +{
> > > > +       struct generic_struct *sub_driver =3D data;
> > > > +
> > > > +       if (!sub_driver || !sub_driver->acpi || !sub_driver->acpi->=
notify)
> > > > +               return;
> > > > +       sub_driver->acpi->notify(sub_driver, event);
> > > > +}
> > > > +
> > > > +static int __init setup_acpi_notify(struct generic_struct *sub_dri=
ver)
> > > > +{
> > > > +       acpi_status status;
> > > > +
> > > > +       BUG_ON(!sub_driver->acpi);
> > > > +
> > > > +       if (!*sub_driver->acpi->handle)
> > > > +               return 0;
> > > > +
> > > > +       sub_driver->acpi->device =3D acpi_fetch_acpi_dev(*sub_drive=
r->acpi->handle);
> > > > +       if (!sub_driver->acpi->device) {
> > > > +               pr_err("acpi_fetch_acpi_dev(%s) failed\n", sub_driv=
er->name);
> > > > +               return -ENODEV;
> > > > +       }
> > > > +
> > > > +       sub_driver->acpi->device->driver_data =3D sub_driver;
> > > > +       sprintf(acpi_device_class(sub_driver->acpi->device), "%s/%s=
",
> > > > +               ACPI_LAPTOP_ACPI_EVENT_PREFIX,
> > > > +               sub_driver->name);
> > > > +
> > > > +       status =3D acpi_install_notify_handler(*sub_driver->acpi->h=
andle,
> > > > +                       sub_driver->acpi->type, dispatch_acpi_notif=
y, sub_driver);
> > > > +       if (ACPI_FAILURE(status)) {
> > > > +               if (status =3D=3D AE_ALREADY_EXISTS) {
> > > > +                       pr_notice("Another device driver is already=
 "
> > > > +                                 "handling %s events\n", sub_drive=
r->name);
> > > > +               } else {
> > > > +                       pr_err("acpi_install_notify_handler(%s) fai=
led: %s\n",
> > > > +                              sub_driver->name, acpi_format_except=
ion(status));
> > > > +               }
> > > > +               return -ENODEV;
> > > > +       }
> > > > +       sub_driver->flags.acpi_notify_installed =3D 1;
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int __init tpacpi_device_add(struct acpi_device *device)
> > > > +{
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static struct input_dev *generic_inputdev;
> > > > +
> > > > +static int loongson_generic_suspend(struct device *dev)
> > > > +{
> > > > +       return 0;
> > > > +}
> > > > +static int loongson_generic_resume(struct device *dev)
> > > > +{
> > > > +       int status =3D 0;
> > > > +       struct key_entry ke;
> > > > +       struct backlight_device *bd;
> > > > +
> > > > +       /*
> > > > +        * Only if the firmware supports SW_LID event model, we can=
 handle the
> > > > +        * event. This is for the consideration of development boar=
d without
> > > > +        * EC.
> > > > +        */
> > > > +       if (test_bit(SW_LID, generic_inputdev->swbit)) {
> > > > +               if (hotkey_status_get(&status))
> > > > +                       return -EIO;
> > > > +               /*
> > > > +                * The input device sw element records the last lid=
 status.
> > > > +                * When the system is awakened by other wake-up sou=
rces,
> > > > +                * the lid event will also be reported. The judgmen=
t of
> > > > +                * adding SW_LID bit which in sw element can avoid =
this
> > > > +                * case.
> > > > +                *
> > > > +                * input system will drop lid event when current li=
d event
> > > > +                * value and last lid status in the same data set=
=EF=BC=8Cwhich
> > > > +                * data set inclue zero set and no zero set. so lap=
top
> > > > +                * driver doesn't report repeated events.
> > > > +                *
> > > > +                * Lid status is generally 0, but hardware exceptio=
n is
> > > > +                * considered. So add lid status confirmation.
> > > > +                */
> > > > +               if (test_bit(SW_LID, generic_inputdev->sw) && !(sta=
tus & (1 << SW_LID))) {
> > > > +                       ke.type =3D KE_SW;
> > > > +                       ke.sw.value =3D (u8)status;
> > > > +                       ke.sw.code =3D SW_LID;
> > > > +                       sparse_keymap_report_entry(generic_inputdev=
, &ke,
> > > > +                                       1, true);
> > > > +               }
> > > > +       }
> > > > +
> > > > +       bd =3D backlight_device_get_by_type(BACKLIGHT_PLATFORM);
> > > > +       if (bd) {
> > > > +               loongson_laptop_backlight_update(bd) ?
> > > > +               pr_warn("Loongson_backlight: resume brightness fail=
ed") :
> > > > +               pr_info("Loongson_backlight: resume brightness %d\n=
", bd->props.brightness);
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static DEFINE_SIMPLE_DEV_PM_OPS(loongson_generic_pm,
> > > > +               loongson_generic_suspend, loongson_generic_resume);
> > > > +
> > > > +static int __init register_generic_subdriver(struct generic_struct=
 *sub_driver)
> > > > +{
> > > > +       int rc;
> > > > +
> > > > +       BUG_ON(!sub_driver->acpi);
> > > > +
> > > > +       sub_driver->acpi->driver =3D kzalloc(sizeof(struct acpi_dri=
ver), GFP_KERNEL);
> > >
> > > Please don't use acpi_driver here.  Use a platform driver instead and
> > > bind to the platform device created by the ACPI subsystem for your
> > > ACPI device object.
> > This is derived from register_tpacpi_subdriver() in thinkpad_acpi.c,
> > that means thinkpad also uses the wrong method?
>
> That driver is one of the known exceptions mentioned by me.
OK, could you please give me an example of binding for this type, thanks.

Huacai
>
> Thanks!
>
