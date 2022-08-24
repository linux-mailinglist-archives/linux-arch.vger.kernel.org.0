Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8570F59F270
	for <lists+linux-arch@lfdr.de>; Wed, 24 Aug 2022 06:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiHXENo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Aug 2022 00:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiHXENn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 00:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED213DF21;
        Tue, 23 Aug 2022 21:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62F676184B;
        Wed, 24 Aug 2022 04:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2825C43470;
        Wed, 24 Aug 2022 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661314420;
        bh=GUM84QY7d2Ky3/adSC6ItqwjOjuK/Is4EhnHOBu5wEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sRWBPbmfn7JTfrcaOlLJBEx6iUIyMk2eVpieaik6cqVtG2AJFz0E5fMr9Jqi3DEsg
         PhP7LeLjL2CnlaCFKGbmg2F4JwlzpDGtSiIJWNhe8gjLXz78y2DO8cwU7p8eQahd5Q
         fA5sfaza3hI6uT0Zu9qPP6k0Ua34EpUX8juoyVUksv5mDE/3C0KEZ7vMuNp4WAPR5v
         ghoJQjHyGKoMlhyJpdOPDAYWcg9OCUCW1fcmF21SajQKEqRK0crCA3QuvVDDjuA6Bd
         7WaQLVczXFJF7Rwg1i9A1yl9cLNO7aMrECBWvXnB/eIQ4PCVnKf6KN/qgFaLawHeVl
         eWqwm6BcNz8DQ==
Received: by mail-vs1-f50.google.com with SMTP id c3so16396312vsc.6;
        Tue, 23 Aug 2022 21:13:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ybQqhQgtaeOKbpFPDsp89c8VFiwPXjoj1YSNm/zcBBkbHC4Or
        gzyV0U5Zdai0G+pfQj522ZsPXWdUYatfAKq9orc=
X-Google-Smtp-Source: AA6agR75RBi2nYZHXY1llDvXlb6CLdUupMOpY1rnhNgrj08BAfitA6R+s+D3v2SR9Zd2wV0mjWcup9kE/Q53iYjmyaU=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr10975066vsu.43.1661314419496; Tue, 23
 Aug 2022 21:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
 <20220818042208.2896457-2-chenhuacai@loongson.cn> <CAJZ5v0gbs+ZTh-Mc8kkdtg05yzsvGjkkTuA5oHF_X=CphmqVYQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gbs+ZTh-Mc8kkdtg05yzsvGjkkTuA5oHF_X=CphmqVYQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 24 Aug 2022 12:13:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4gQ29Oa7x5tAByqxGYpaxfobRw-DAagUFS=FnmgGDtSQ@mail.gmail.com>
Message-ID: <CAAhV-H4gQ29Oa7x5tAByqxGYpaxfobRw-DAagUFS=FnmgGDtSQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Rafael,

On Wed, Aug 24, 2022 at 12:49 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Thu, Aug 18, 2022 at 6:23 AM Huacai Chen <chenhuacai@loongson.cn> wrot=
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
> > V2: Fix problems pointed out by Arnd.
> >
> >  drivers/platform/loongarch/Kconfig          |  12 +
> >  drivers/platform/loongarch/Makefile         |   1 +
> >  drivers/platform/loongarch/generic-laptop.c | 747 ++++++++++++++++++++
> >  3 files changed, 760 insertions(+)
> >  create mode 100644 drivers/platform/loongarch/generic-laptop.c
> >
> > diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loon=
garch/Kconfig
> > index a1542843b0ad..61ed83227d36 100644
> > --- a/drivers/platform/loongarch/Kconfig
> > +++ b/drivers/platform/loongarch/Kconfig
> > @@ -23,4 +23,16 @@ config CPU_HWMON
> >         help
> >           Loongson-3A/3B/3C CPU HWMon (temperature sensor) driver.
> >
> > +config GENERIC_LAPTOP
> > +       tristate "Generic Loongson-3 Laptop Driver"
> > +       depends on ACPI
> > +       depends on BACKLIGHT_CLASS_DEVICE
> > +       depends on INPUT
> > +       depends on MACH_LOONGSON64
> > +       select INPUT_EVDEV
> > +       select INPUT_SPARSEKMAP
> > +       default y
> > +       help
> > +         ACPI-based Loongson-3 family laptops generic driver.
> > +
> >  endif # LOONGARCH_PLATFORM_DEVICES
> > diff --git a/drivers/platform/loongarch/Makefile b/drivers/platform/loo=
ngarch/Makefile
> > index 8dfd03924c37..9d6f69f2319d 100644
> > --- a/drivers/platform/loongarch/Makefile
> > +++ b/drivers/platform/loongarch/Makefile
> > @@ -1 +1,2 @@
> >  obj-$(CONFIG_CPU_HWMON) +=3D cpu_hwmon.o
> > +obj-$(CONFIG_GENERIC_LAPTOP) +=3D generic-laptop.o
> > diff --git a/drivers/platform/loongarch/generic-laptop.c b/drivers/plat=
form/loongarch/generic-laptop.c
> > new file mode 100644
> > index 000000000000..90c866f29702
> > --- /dev/null
> > +++ b/drivers/platform/loongarch/generic-laptop.c
> > @@ -0,0 +1,747 @@
> > +/*
> > + *  Generic Loongson processor based LAPTOP/ALL-IN-ONE driver
> > + *
> > + *  Jianmin Lv <lvjianmin@loongson.cn>
> > + *  Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/types.h>
> > +#include <linux/string.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/input.h>
> > +#include <linux/acpi.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/input/sparse-keymap.h>
> > +#include <linux/device.h>
> > +#include <linux/backlight.h>
> > +#include <acpi/video.h>
> > +
> > +/* ACPI HIDs */
> > +#define LOONGSON_ACPI_HKEY_HID "LOON0000"
> > +#define LOONGSON_ACPI_EC_HID   "PNP0C09"
> > +
> > +/* Main driver */
> > +
> > +#define ACPI_LAPTOP_VERSION "1.0"
> > +#define ACPI_LAPTOP_NAME "loongson-laptop"
> > +#define ACPI_LAPTOP_DESC "Loongson Laptop/all-in-one ACPI Driver"
> > +#define ACPI_LAPTOP_FILE ACPI_LAPTOP_NAME "_acpi"
> > +#define ACPI_LAPTOP_DRVR_NAME ACPI_LAPTOP_FILE
> > +#define ACPI_LAPTOP_ACPI_EVENT_PREFIX "loongson"
> > +
> > +/* Driver-wide structs and misc. variables */
> > +
> > +struct generic_struct;
> > +
> > +struct generic_acpi_drv_struct {
> > +       u32 type;
> > +       acpi_handle *handle;
> > +       const struct acpi_device_id *hid;
> > +       struct acpi_device *device;
> > +       struct acpi_driver *driver;
> > +       void (*notify)(struct generic_struct *, u32);
> > +};
> > +
> > +struct generic_struct {
> > +       char *name;
> > +
> > +       int (*init)(struct generic_struct *);
> > +
> > +       struct generic_acpi_drv_struct *acpi;
> > +
> > +       struct {
> > +               u8 acpi_driver_registered;
> > +               u8 acpi_notify_installed;
> > +       } flags;
> > +};
> > +
> > +
> > +static struct {
> > +       u32 input_device_registered:1;
> > +} generic_features;
> > +
> > +static int hotkey_status_get(int *status);
> > +static int loongson_laptop_backlight_update(struct backlight_device *b=
d);
> > +
> > +/* 1. ACPI Helpers and device model */
> > +
> > +/* ACPI basic handles */
> > +
> > +static acpi_handle ec_handle;
> > +
> > +#define GENERIC_HANDLE(object, parent, paths...)                      =
 \
> > +       static acpi_handle  object##_handle;                    \
> > +       static const acpi_handle * const object##_parent __initconst =
=3D  \
> > +                                               &parent##_handle; \
> > +       static char *object##_paths[] __initdata =3D { paths }
> > +
> > +GENERIC_HANDLE(hkey, ec, "\\_SB.HKEY", "^HKEY", "HKEY",);
> > +
> > +/* ACPI device model */
> > +
> > +#define GENERIC_ACPIHANDLE_INIT(object) \
> > +       drv_acpi_handle_init(#object, &object##_handle, *object##_paren=
t, \
> > +               object##_paths, ARRAY_SIZE(object##_paths))
> > +
> > +static void __init drv_acpi_handle_init(const char *name,
> > +                          acpi_handle *handle, const acpi_handle paren=
t,
> > +                          char **paths, const int num_paths)
> > +{
> > +       int i;
> > +       acpi_status status;
> > +
> > +       for (i =3D 0; i < num_paths; i++) {
> > +               status =3D acpi_get_handle(parent, paths[i], handle);
> > +               if (ACPI_SUCCESS(status))
> > +                       return;
> > +       }
> > +
> > +       *handle =3D NULL;
> > +}
> > +static acpi_status __init generic_acpi_handle_locate_callback(acpi_han=
dle handle,
> > +                                       u32 level, void *context, void =
**return_value)
> > +{
> > +       *(acpi_handle *)return_value =3D handle;
> > +
> > +       return AE_CTRL_TERMINATE;
> > +}
> > +
> > +static void __init generic_acpi_handle_locate(const char *name,
> > +               const char *hid, acpi_handle *handle)
> > +{
> > +       acpi_status status;
> > +       acpi_handle device_found;
> > +
> > +       BUG_ON(!name || !hid || !handle);
> > +
> > +       *handle =3D NULL;
> > +
> > +       memset(&device_found, 0, sizeof(device_found));
> > +       status =3D acpi_get_devices(hid, generic_acpi_handle_locate_cal=
lback,
> > +                                 (void *)name, &device_found);
> > +
> > +       if (ACPI_SUCCESS(status))
> > +               *handle =3D device_found;
> > +}
> > +
> > +static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *=
data)
> > +{
> > +       struct generic_struct *sub_driver =3D data;
> > +
> > +       if (!sub_driver || !sub_driver->acpi || !sub_driver->acpi->noti=
fy)
> > +               return;
> > +       sub_driver->acpi->notify(sub_driver, event);
> > +}
> > +
> > +static int __init setup_acpi_notify(struct generic_struct *sub_driver)
> > +{
> > +       acpi_status status;
> > +
> > +       BUG_ON(!sub_driver->acpi);
> > +
> > +       if (!*sub_driver->acpi->handle)
> > +               return 0;
> > +
> > +       sub_driver->acpi->device =3D acpi_fetch_acpi_dev(*sub_driver->a=
cpi->handle);
> > +       if (!sub_driver->acpi->device) {
> > +               pr_err("acpi_fetch_acpi_dev(%s) failed\n", sub_driver->=
name);
> > +               return -ENODEV;
> > +       }
> > +
> > +       sub_driver->acpi->device->driver_data =3D sub_driver;
> > +       sprintf(acpi_device_class(sub_driver->acpi->device), "%s/%s",
> > +               ACPI_LAPTOP_ACPI_EVENT_PREFIX,
> > +               sub_driver->name);
> > +
> > +       status =3D acpi_install_notify_handler(*sub_driver->acpi->handl=
e,
> > +                       sub_driver->acpi->type, dispatch_acpi_notify, s=
ub_driver);
> > +       if (ACPI_FAILURE(status)) {
> > +               if (status =3D=3D AE_ALREADY_EXISTS) {
> > +                       pr_notice("Another device driver is already "
> > +                                 "handling %s events\n", sub_driver->n=
ame);
> > +               } else {
> > +                       pr_err("acpi_install_notify_handler(%s) failed:=
 %s\n",
> > +                              sub_driver->name, acpi_format_exception(=
status));
> > +               }
> > +               return -ENODEV;
> > +       }
> > +       sub_driver->flags.acpi_notify_installed =3D 1;
> > +       return 0;
> > +}
> > +
> > +static int __init tpacpi_device_add(struct acpi_device *device)
> > +{
> > +       return 0;
> > +}
> > +
> > +static struct input_dev *generic_inputdev;
> > +
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
> > +               pr_warn("Loongson_backlight: resume brightness failed")=
 :
> > +               pr_info("Loongson_backlight: resume brightness %d\n", b=
d->props.brightness);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(loongson_generic_pm,
> > +               loongson_generic_suspend, loongson_generic_resume);
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
>
> Please don't use acpi_driver here.  Use a platform driver instead and
> bind to the platform device created by the ACPI subsystem for your
> ACPI device object.
This is derived from register_tpacpi_subdriver() in thinkpad_acpi.c,
that means thinkpad also uses the wrong method?

Huacai
>
> > +       if (!sub_driver->acpi->driver) {
> > +               pr_err("Failed to allocate memory for ibm->acpi->driver=
\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       sprintf(sub_driver->acpi->driver->name, "%s_%s", ACPI_LAPTOP_NA=
ME, sub_driver->name);
> > +       sub_driver->acpi->driver->ids =3D sub_driver->acpi->hid;
> > +       sub_driver->acpi->driver->ops.add =3D &tpacpi_device_add;
> > +       sub_driver->acpi->driver->drv.pm =3D pm_ptr(&loongson_generic_p=
m);
> > +       rc =3D acpi_bus_register_driver(sub_driver->acpi->driver);
> > +       if (rc < 0) {
> > +               pr_err("acpi_bus_register_driver(%s) failed: %d\n", sub=
_driver->name, rc);
> > +               kfree(sub_driver->acpi->driver);
> > +               sub_driver->acpi->driver =3D NULL;
> > +       } else if (!rc)
> > +               sub_driver->flags.acpi_driver_registered =3D 1;
> > +
> > +       return rc;
> > +}
> > +
> > +#define MAX_ACPI_ARGS 3
> > +
> > +static int acpi_evalf(acpi_handle handle,
> > +                     int *res, char *method, char *fmt, ...)
> > +{
> > +       char res_type;
> > +       char *fmt0 =3D fmt;
> > +       va_list ap;
> > +       int success, quiet;
> > +       acpi_status status;
> > +       struct acpi_object_list params;
> > +       struct acpi_buffer result, *resultp;
> > +       union acpi_object in_objs[MAX_ACPI_ARGS], out_obj;
> > +
> > +       if (!*fmt) {
> > +               pr_err("acpi_evalf() called with empty format\n");
> > +               return 0;
> > +       }
> > +
> > +       if (*fmt =3D=3D 'q') {
> > +               quiet =3D 1;
> > +               fmt++;
> > +       } else
> > +               quiet =3D 0;
> > +
> > +       res_type =3D *(fmt++);
> > +
> > +       params.count =3D 0;
> > +       params.pointer =3D &in_objs[0];
> > +
> > +       va_start(ap, fmt);
> > +       while (*fmt) {
> > +               char c =3D *(fmt++);
> > +               switch (c) {
> > +               case 'd':       /* int */
> > +                       in_objs[params.count].integer.value =3D va_arg(=
ap, int);
> > +                       in_objs[params.count++].type =3D ACPI_TYPE_INTE=
GER;
> > +                       break;
> > +                       /* add more types as needed */
> > +               default:
> > +                       pr_err("acpi_evalf() called with invalid format=
 character '%c'\n",
> > +                              c);
> > +                       va_end(ap);
> > +                       return 0;
> > +               }
> > +       }
> > +       va_end(ap);
> > +
> > +       if (res_type !=3D 'v') {
> > +               result.length =3D sizeof(out_obj);
> > +               result.pointer =3D &out_obj;
> > +               resultp =3D &result;
> > +       } else
> > +               resultp =3D NULL;
> > +
> > +       status =3D acpi_evaluate_object(handle, method, &params, result=
p);
> > +
> > +       switch (res_type) {
> > +       case 'd':               /* int */
> > +               success =3D (status =3D=3D AE_OK &&
> > +                          out_obj.type =3D=3D ACPI_TYPE_INTEGER);
> > +               if (success && res)
> > +                       *res =3D out_obj.integer.value;
> > +               break;
> > +       case 'v':               /* void */
> > +               success =3D status =3D=3D AE_OK;
> > +               break;
> > +               /* add more types as needed */
> > +       default:
> > +               pr_err("acpi_evalf() called with invalid format charact=
er '%c'\n",
> > +                      res_type);
> > +               return 0;
> > +       }
> > +
> > +       if (!success && !quiet)
> > +               pr_err("acpi_evalf(%s, %s, ...) failed: %s\n",
> > +                      method, fmt0, acpi_format_exception(status));
> > +
> > +       return success;
> > +}
> > +
> > +/* Loongson generic laptop firmware event model */
> > +
> > +#define GENERIC_HOTKEY_MAP_MAX 64
> > +#define METHOD_NAME__KMAP      "KMAP"
> > +static struct key_entry hotkey_keycode_map[GENERIC_HOTKEY_MAP_MAX];
> > +
> > +static int hotkey_map(void)
> > +{
> > +       u32 index;
> > +       acpi_status status;
> > +       struct acpi_buffer buf;
> > +       union acpi_object *pack;
> > +
> > +       buf.length =3D ACPI_ALLOCATE_BUFFER;
> > +       status =3D acpi_evaluate_object_typed(hkey_handle, METHOD_NAME_=
_KMAP, NULL, &buf, ACPI_TYPE_PACKAGE);
> > +       if (status !=3D AE_OK) {
> > +               pr_err("ACPI exception: %s\n", acpi_format_exception(st=
atus));
> > +               return -1;
> > +       }
> > +       pack =3D buf.pointer;
> > +       for (index =3D 0; index < pack->package.count; index++) {
> > +               union acpi_object *sub_pack =3D &pack->package.elements=
[index];
> > +               union acpi_object *element =3D &sub_pack->package.eleme=
nts[0];
> > +
> > +               hotkey_keycode_map[index].type =3D element->integer.val=
ue;
> > +               element =3D &sub_pack->package.elements[1];
> > +               hotkey_keycode_map[index].code =3D element->integer.val=
ue;
> > +               element =3D &sub_pack->package.elements[2];
> > +               hotkey_keycode_map[index].keycode =3D element->integer.=
value;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int hotkey_backlight_set(bool enable)
> > +{
> > +       if (!acpi_evalf(hkey_handle, NULL, "VCBL", "vd", enable ? 1 : 0=
))
> > +               return -EIO;
> > +
> > +       return 0;
> > +}
> > +
> > +static int __init event_init(struct generic_struct *sub_driver)
> > +{
> > +       int ret;
> > +
> > +       GENERIC_ACPIHANDLE_INIT(hkey);
> > +       ret =3D hotkey_map();
> > +       if (ret < 0) {
> > +               pr_err("Failed to parse keymap from DSDT\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D sparse_keymap_setup(generic_inputdev, hotkey_keycode_ma=
p, NULL);
> > +       if (ret < 0) {
> > +               pr_err("Failed to setup input device keymap\n");
> > +               input_free_device(generic_inputdev);
> > +
> > +               return ret;
> > +       }
> > +
> > +       /*
> > +        * This hotkey driver handle backlight event when
> > +        * acpi_video_get_backlight_type() gets acpi_backlight_vendor
> > +        */
> > +       if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
> > +               hotkey_backlight_set(false);
> > +       else
> > +               hotkey_backlight_set(true);
> > +
> > +       pr_info("ACPI: enabling firmware HKEY event interface...\n");
> > +
> > +       return ret;
> > +}
> > +
> > +#define GENERIC_EVENT_TYPE_OFF         12
> > +#define GENERIC_EVENT_MASK             0xFFF
> > +
> > +static int ec_get_brightness(void)
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
> > +
> > +static int ec_set_brightness(int level)
> > +{
> > +
> > +       int ret =3D 0;
> > +
> > +       if (!hkey_handle)
> > +               return -ENXIO;
> > +
> > +       if (!acpi_evalf(hkey_handle, NULL, "ECBS", "vd", level))
> > +               ret =3D -EIO;
> > +
> > +       return ret;
> > +}
> > +
> > +static int ec_backlight_level(u8 level)
> > +{
> > +       int status =3D 0;
> > +
> > +       if (!hkey_handle)
> > +               return -ENXIO;
> > +
> > +       if (!acpi_evalf(hkey_handle, &status, "ECLL", "d"))
> > +               return -EIO;
> > +
> > +       if ((status < 0) || (level > status))
> > +               return status;
> > +
> > +       if (!acpi_evalf(hkey_handle, &status, "ECSL", "d"))
> > +               return -EIO;
> > +
> > +       if ((status < 0) || (level < status))
> > +               return status;
> > +
> > +       return level;
> > +}
> > +
> > +static int loongson_laptop_backlight_update(struct backlight_device *b=
d)
> > +{
> > +       int lvl =3D ec_backlight_level(bd->props.brightness);
> > +
> > +       if (lvl < 0)
> > +               return -EIO;
> > +       if (ec_set_brightness(lvl))
> > +               return -EIO;
> > +
> > +       return 0;
> > +}
> > +
> > +static int loongson_laptop_get_brightness(struct backlight_device *bd)
> > +{
> > +       u8 level;
> > +
> > +       level =3D ec_get_brightness();
> > +       if (level < 0)
> > +               return -EIO;
> > +
> > +       return level;
> > +}
> > +
> > +static const struct backlight_ops backlight_laptop_ops =3D {
> > +       .update_status =3D loongson_laptop_backlight_update,
> > +       .get_brightness =3D loongson_laptop_get_brightness,
> > +};
> > +
> > +static int laptop_backlight_register(void)
> > +{
> > +       int status =3D 0;
> > +       struct backlight_properties props;
> > +
> > +       memset(&props, 0, sizeof(props));
> > +       props.type =3D BACKLIGHT_PLATFORM;
> > +
> > +       if (!acpi_evalf(hkey_handle, &status, "ECLL", "d"))
> > +               return -EIO;
> > +
> > +       props.brightness =3D 1;
> > +       props.max_brightness =3D status;
> > +
> > +       backlight_device_register("loongson_laptop",
> > +                               NULL, NULL, &backlight_laptop_ops, &pro=
ps);
> > +
> > +       return 0;
> > +}
> > +
> > +int loongson_laptop_turn_on_backlight(void)
> > +{
> > +       int status;
> > +       union acpi_object arg0 =3D { ACPI_TYPE_INTEGER };
> > +       struct acpi_object_list args =3D { 1, &arg0 };
> > +
> > +       arg0.integer.value =3D 1;
> > +       status =3D acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
> > +       if (ACPI_FAILURE(status)) {
> > +               pr_info("Loongson lvds error: 0x%x\n", status);
> > +               return -ENODEV;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int loongson_laptop_turn_off_backlight(void)
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
> > +
> > +static int hotkey_status_get(int *status)
> > +{
> > +       if (!acpi_evalf(hkey_handle, status, "GSWS", "d"))
> > +               return -EIO;
> > +
> > +       return 0;
> > +}
> > +
> > +static void event_notify(struct generic_struct *sub_driver, u32 event)
> > +{
> > +       struct key_entry *ke =3D NULL;
> > +       int scan_code =3D event & GENERIC_EVENT_MASK;
> > +       int type =3D (event >> GENERIC_EVENT_TYPE_OFF) & 0xF;
> > +
> > +       ke =3D sparse_keymap_entry_from_scancode(generic_inputdev, scan=
_code);
> > +       if (ke) {
> > +               if (type =3D=3D KE_SW) {
> > +                       int status =3D 0;
> > +
> > +                       if (hotkey_status_get(&status))
> > +                               return;
> > +
> > +                       ke->sw.value =3D !!(status & (1 << ke->sw.code)=
);
> > +               }
> > +               sparse_keymap_report_entry(generic_inputdev, ke, 1, tru=
e);
> > +       }
> > +}
> > +
> > +static const struct acpi_device_id loongson_htk_device_ids[] =3D {
> > +       {LOONGSON_ACPI_HKEY_HID, 0},
> > +       {"", 0},
> > +};
> > +
> > +static struct generic_acpi_drv_struct ec_event_acpidriver =3D {
> > +       .hid =3D loongson_htk_device_ids,
> > +       .notify =3D event_notify,
> > +       .handle =3D &hkey_handle,
> > +       .type =3D ACPI_DEVICE_NOTIFY,
> > +};
> > +
> > +/* 2. Infrastructure */
> > +
> > +static int __init probe_for_generic(void)
> > +{
> > +       if (acpi_disabled)
> > +               return -ENODEV;
> > +
> > +       /* The EC handler is required */
> > +       generic_acpi_handle_locate("ec", LOONGSON_ACPI_EC_HID, &ec_hand=
le);
> > +       if (!ec_handle)
> > +               return -ENODEV;
> > +
> > +       return 0;
> > +}
> > +
> > +static void generic_exit(struct generic_struct *sub_driver)
> > +{
> > +
> > +       if (sub_driver->flags.acpi_notify_installed) {
> > +               BUG_ON(!sub_driver->acpi);
> > +               acpi_remove_notify_handler(*sub_driver->acpi->handle,
> > +                                          sub_driver->acpi->type,
> > +                                          dispatch_acpi_notify);
> > +               sub_driver->flags.acpi_notify_installed =3D 0;
> > +       }
> > +
> > +       if (sub_driver->flags.acpi_driver_registered) {
> > +               BUG_ON(!sub_driver->acpi);
> > +               acpi_bus_unregister_driver(sub_driver->acpi->driver);
> > +               kfree(sub_driver->acpi->driver);
> > +               sub_driver->acpi->driver =3D NULL;
> > +               sub_driver->flags.acpi_driver_registered =3D 0;
> > +       }
> > +
> > +}
> > +
> > +static int __init generic_subdriver_init(struct generic_struct *sub_dr=
iver)
> > +{
> > +       int ret;
> > +
> > +       BUG_ON(sub_driver =3D=3D NULL);
> > +
> > +       if (sub_driver->init)
> > +               sub_driver->init(sub_driver);
> > +
> > +       if (sub_driver->acpi) {
> > +               if (sub_driver->acpi->hid) {
> > +                       ret =3D register_generic_subdriver(sub_driver);
> > +                       if (ret)
> > +                               goto err_out;
> > +               }
> > +
> > +               if (sub_driver->acpi->notify) {
> > +                       ret =3D setup_acpi_notify(sub_driver);
> > +                       if (ret =3D=3D -ENODEV) {
> > +                               ret =3D 0;
> > +                               goto err_out;
> > +                       }
> > +                       if (ret < 0)
> > +                               goto err_out;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +
> > +err_out:
> > +       generic_exit(sub_driver);
> > +       return (ret < 0) ? ret : 0;
> > +}
> > +
> > +/* Module init, exit, parameters */
> > +static struct generic_struct generic_sub_drivers[] __initdata =3D {
> > +       {
> > +               .name =3D "EC Event",
> > +               .init =3D event_init,
> > +               .acpi =3D &ec_event_acpidriver,
> > +       },
> > +};
> > +
> > +static void generic_acpi_laptop_exit(void);
> > +
> > +static int __init generic_acpi_laptop_init(void)
> > +{
> > +       int i, ret, status;
> > +
> > +       ret =3D probe_for_generic();
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       generic_inputdev =3D input_allocate_device();
> > +       if (!generic_inputdev) {
> > +               pr_err("Unable to allocate input device\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       /* Prepare input device, but don't register */
> > +       generic_inputdev->name =3D
> > +               "Loongson Generic Laptop/All-in-one Extra Buttons";
> > +       generic_inputdev->phys =3D ACPI_LAPTOP_DRVR_NAME "/input0";
> > +       generic_inputdev->id.bustype =3D BUS_HOST;
> > +       generic_inputdev->dev.parent =3D NULL;
> > +
> > +       /* Init subdrivers */
> > +       for (i =3D 0; i < ARRAY_SIZE(generic_sub_drivers); i++) {
> > +               ret =3D generic_subdriver_init(&generic_sub_drivers[i])=
;
> > +               if (ret < 0) {
> > +                       generic_acpi_laptop_exit();
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       ret =3D input_register_device(generic_inputdev);
> > +       if (ret < 0) {
> > +               pr_err("Unable to register input device\n");
> > +               generic_acpi_laptop_exit();
> > +               return ret;
> > +       }
> > +
> > +       generic_features.input_device_registered =3D 1;
> > +
> > +       if (acpi_evalf(hkey_handle, &status, "ECBG", "d")) {
> > +               pr_info("Loongson Laptop used, init brightness is 0x%x\=
n", status);
> > +               ret =3D laptop_backlight_register();
> > +               if (ret < 0)
> > +                       pr_err("Loongson Laptop: laptop-backlight devic=
e register failed\n");
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void __exit generic_acpi_laptop_exit(void)
> > +{
> > +       if (generic_inputdev) {
> > +               if (generic_features.input_device_registered)
> > +                       input_unregister_device(generic_inputdev);
> > +               else
> > +                       input_free_device(generic_inputdev);
> > +       }
> > +}
> > +
> > +module_init(generic_acpi_laptop_init);
> > +module_exit(generic_acpi_laptop_exit);
> > +
> > +MODULE_ALIAS("platform:acpi-laptop");
> > +MODULE_AUTHOR("Jianmin Lv <lvjianmin@loongson.cn>");
> > +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> > +MODULE_DESCRIPTION(ACPI_LAPTOP_DESC);
> > +MODULE_VERSION(ACPI_LAPTOP_VERSION);
> > +MODULE_LICENSE("GPL");
> > --
> > 2.31.1
> >
