Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56D959FB45
	for <lists+linux-arch@lfdr.de>; Wed, 24 Aug 2022 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiHXN0A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 24 Aug 2022 09:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiHXNZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 09:25:51 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916A6716F;
        Wed, 24 Aug 2022 06:25:49 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-334dc616f86so459689767b3.8;
        Wed, 24 Aug 2022 06:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7cbDIEj52nXDcaWk/kgnXNvkPGG+xPTE/vNVMjKSpQA=;
        b=W15PejLgliH/GPaCDXqQZUjA8MDo6d/y/IK6Ao/ZT65V4TCoE8zYoGMzjbz1p7bdc/
         Pw6HlTlpkBxfls4SxSljgWCR5vZ2GpfsaItkJZWJQsX3upvdrQLb31evjeqIfPjQdC/q
         M9WesYOqJDrPWqEGksYY9EmC6LGA0i3SIZNWgj9JRnV+GwY2kkiG9cQEfEmXfmeIfuId
         zLSpffEz0ZUGV2HBxrBicCxI+JoPs+ZO0BVzVIZ6+m7vyzmqLf+v3SHQyrcoiWXlRIGL
         s6JY7bISmg+7TaC18E12T3GuYs3nBzgCwmAzYMQuhfdgnkPvF+PAJZ5GI+oIwov+Z0Hu
         nIug==
X-Gm-Message-State: ACgBeo0wDmPPhnIb1eLH8R0669jPYY/XjU4ZC01KcBwC8VMWsiZWo026
        75/75/hBBzPduqMA1ZOX1QLLlJWzTR719ip0pMg=
X-Google-Smtp-Source: AA6agR6J/SPv6fh2jSRxtjNgTcO1F728//gphLwaxuetuj4NDUluy9YV1dXX1VPan+E8kuFZ780oq3bXV96r8Pase0w=
X-Received: by 2002:a25:664a:0:b0:695:e7cc:9a20 with SMTP id
 z10-20020a25664a000000b00695e7cc9a20mr9146085ybm.153.1661347548070; Wed, 24
 Aug 2022 06:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
 <20220818042208.2896457-2-chenhuacai@loongson.cn> <CAJZ5v0gbs+ZTh-Mc8kkdtg05yzsvGjkkTuA5oHF_X=CphmqVYQ@mail.gmail.com>
 <CAAhV-H4gQ29Oa7x5tAByqxGYpaxfobRw-DAagUFS=FnmgGDtSQ@mail.gmail.com>
In-Reply-To: <CAAhV-H4gQ29Oa7x5tAByqxGYpaxfobRw-DAagUFS=FnmgGDtSQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Aug 2022 15:25:36 +0200
Message-ID: <CAJZ5v0jY+DaBp-Nmxx-_drbKSg=2_bEZfd0yoOTovCsJTNn2GA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] LoongArch: Add ACPI-based generic laptop driver
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 24, 2022 at 6:13 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Rafael,
>
> On Wed, Aug 24, 2022 at 12:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Aug 18, 2022 at 6:23 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > From: Jianmin Lv <lvjianmin@loongson.cn>
> > >
> > > This add ACPI-based generic laptop driver for Loongson-3. Some of the
> > > codes are derived from drivers/platform/x86/thinkpad_acpi.c.
> > >
> > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > V2: Fix problems pointed out by Arnd.
> > >
> > >  drivers/platform/loongarch/Kconfig          |  12 +
> > >  drivers/platform/loongarch/Makefile         |   1 +
> > >  drivers/platform/loongarch/generic-laptop.c | 747 ++++++++++++++++++++
> > >  3 files changed, 760 insertions(+)
> > >  create mode 100644 drivers/platform/loongarch/generic-laptop.c
> > >
> > > diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loongarch/Kconfig
> > > index a1542843b0ad..61ed83227d36 100644
> > > --- a/drivers/platform/loongarch/Kconfig
> > > +++ b/drivers/platform/loongarch/Kconfig
> > > @@ -23,4 +23,16 @@ config CPU_HWMON
> > >         help
> > >           Loongson-3A/3B/3C CPU HWMon (temperature sensor) driver.
> > >
> > > +config GENERIC_LAPTOP
> > > +       tristate "Generic Loongson-3 Laptop Driver"
> > > +       depends on ACPI
> > > +       depends on BACKLIGHT_CLASS_DEVICE
> > > +       depends on INPUT
> > > +       depends on MACH_LOONGSON64
> > > +       select INPUT_EVDEV
> > > +       select INPUT_SPARSEKMAP
> > > +       default y
> > > +       help
> > > +         ACPI-based Loongson-3 family laptops generic driver.
> > > +
> > >  endif # LOONGARCH_PLATFORM_DEVICES
> > > diff --git a/drivers/platform/loongarch/Makefile b/drivers/platform/loongarch/Makefile
> > > index 8dfd03924c37..9d6f69f2319d 100644
> > > --- a/drivers/platform/loongarch/Makefile
> > > +++ b/drivers/platform/loongarch/Makefile
> > > @@ -1 +1,2 @@
> > >  obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
> > > +obj-$(CONFIG_GENERIC_LAPTOP) += generic-laptop.o
> > > diff --git a/drivers/platform/loongarch/generic-laptop.c b/drivers/platform/loongarch/generic-laptop.c
> > > new file mode 100644
> > > index 000000000000..90c866f29702
> > > --- /dev/null
> > > +++ b/drivers/platform/loongarch/generic-laptop.c
> > > @@ -0,0 +1,747 @@
> > > +/*
> > > + *  Generic Loongson processor based LAPTOP/ALL-IN-ONE driver
> > > + *
> > > + *  Jianmin Lv <lvjianmin@loongson.cn>
> > > + *  Huacai Chen <chenhuacai@loongson.cn>
> > > + *
> > > + * Copyright (C) 2022 Loongson Technology Corporation Limited
> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/init.h>
> > > +#include <linux/types.h>
> > > +#include <linux/string.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/input.h>
> > > +#include <linux/acpi.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/input/sparse-keymap.h>
> > > +#include <linux/device.h>
> > > +#include <linux/backlight.h>
> > > +#include <acpi/video.h>
> > > +
> > > +/* ACPI HIDs */
> > > +#define LOONGSON_ACPI_HKEY_HID "LOON0000"
> > > +#define LOONGSON_ACPI_EC_HID   "PNP0C09"
> > > +
> > > +/* Main driver */
> > > +
> > > +#define ACPI_LAPTOP_VERSION "1.0"
> > > +#define ACPI_LAPTOP_NAME "loongson-laptop"
> > > +#define ACPI_LAPTOP_DESC "Loongson Laptop/all-in-one ACPI Driver"
> > > +#define ACPI_LAPTOP_FILE ACPI_LAPTOP_NAME "_acpi"
> > > +#define ACPI_LAPTOP_DRVR_NAME ACPI_LAPTOP_FILE
> > > +#define ACPI_LAPTOP_ACPI_EVENT_PREFIX "loongson"
> > > +
> > > +/* Driver-wide structs and misc. variables */
> > > +
> > > +struct generic_struct;
> > > +
> > > +struct generic_acpi_drv_struct {
> > > +       u32 type;
> > > +       acpi_handle *handle;
> > > +       const struct acpi_device_id *hid;
> > > +       struct acpi_device *device;
> > > +       struct acpi_driver *driver;
> > > +       void (*notify)(struct generic_struct *, u32);
> > > +};
> > > +
> > > +struct generic_struct {
> > > +       char *name;
> > > +
> > > +       int (*init)(struct generic_struct *);
> > > +
> > > +       struct generic_acpi_drv_struct *acpi;
> > > +
> > > +       struct {
> > > +               u8 acpi_driver_registered;
> > > +               u8 acpi_notify_installed;
> > > +       } flags;
> > > +};
> > > +
> > > +
> > > +static struct {
> > > +       u32 input_device_registered:1;
> > > +} generic_features;
> > > +
> > > +static int hotkey_status_get(int *status);
> > > +static int loongson_laptop_backlight_update(struct backlight_device *bd);
> > > +
> > > +/* 1. ACPI Helpers and device model */
> > > +
> > > +/* ACPI basic handles */
> > > +
> > > +static acpi_handle ec_handle;
> > > +
> > > +#define GENERIC_HANDLE(object, parent, paths...)                       \
> > > +       static acpi_handle  object##_handle;                    \
> > > +       static const acpi_handle * const object##_parent __initconst =  \
> > > +                                               &parent##_handle; \
> > > +       static char *object##_paths[] __initdata = { paths }
> > > +
> > > +GENERIC_HANDLE(hkey, ec, "\\_SB.HKEY", "^HKEY", "HKEY",);
> > > +
> > > +/* ACPI device model */
> > > +
> > > +#define GENERIC_ACPIHANDLE_INIT(object) \
> > > +       drv_acpi_handle_init(#object, &object##_handle, *object##_parent, \
> > > +               object##_paths, ARRAY_SIZE(object##_paths))
> > > +
> > > +static void __init drv_acpi_handle_init(const char *name,
> > > +                          acpi_handle *handle, const acpi_handle parent,
> > > +                          char **paths, const int num_paths)
> > > +{
> > > +       int i;
> > > +       acpi_status status;
> > > +
> > > +       for (i = 0; i < num_paths; i++) {
> > > +               status = acpi_get_handle(parent, paths[i], handle);
> > > +               if (ACPI_SUCCESS(status))
> > > +                       return;
> > > +       }
> > > +
> > > +       *handle = NULL;
> > > +}
> > > +static acpi_status __init generic_acpi_handle_locate_callback(acpi_handle handle,
> > > +                                       u32 level, void *context, void **return_value)
> > > +{
> > > +       *(acpi_handle *)return_value = handle;
> > > +
> > > +       return AE_CTRL_TERMINATE;
> > > +}
> > > +
> > > +static void __init generic_acpi_handle_locate(const char *name,
> > > +               const char *hid, acpi_handle *handle)
> > > +{
> > > +       acpi_status status;
> > > +       acpi_handle device_found;
> > > +
> > > +       BUG_ON(!name || !hid || !handle);
> > > +
> > > +       *handle = NULL;
> > > +
> > > +       memset(&device_found, 0, sizeof(device_found));
> > > +       status = acpi_get_devices(hid, generic_acpi_handle_locate_callback,
> > > +                                 (void *)name, &device_found);
> > > +
> > > +       if (ACPI_SUCCESS(status))
> > > +               *handle = device_found;
> > > +}
> > > +
> > > +static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *data)
> > > +{
> > > +       struct generic_struct *sub_driver = data;
> > > +
> > > +       if (!sub_driver || !sub_driver->acpi || !sub_driver->acpi->notify)
> > > +               return;
> > > +       sub_driver->acpi->notify(sub_driver, event);
> > > +}
> > > +
> > > +static int __init setup_acpi_notify(struct generic_struct *sub_driver)
> > > +{
> > > +       acpi_status status;
> > > +
> > > +       BUG_ON(!sub_driver->acpi);
> > > +
> > > +       if (!*sub_driver->acpi->handle)
> > > +               return 0;
> > > +
> > > +       sub_driver->acpi->device = acpi_fetch_acpi_dev(*sub_driver->acpi->handle);
> > > +       if (!sub_driver->acpi->device) {
> > > +               pr_err("acpi_fetch_acpi_dev(%s) failed\n", sub_driver->name);
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       sub_driver->acpi->device->driver_data = sub_driver;
> > > +       sprintf(acpi_device_class(sub_driver->acpi->device), "%s/%s",
> > > +               ACPI_LAPTOP_ACPI_EVENT_PREFIX,
> > > +               sub_driver->name);
> > > +
> > > +       status = acpi_install_notify_handler(*sub_driver->acpi->handle,
> > > +                       sub_driver->acpi->type, dispatch_acpi_notify, sub_driver);
> > > +       if (ACPI_FAILURE(status)) {
> > > +               if (status == AE_ALREADY_EXISTS) {
> > > +                       pr_notice("Another device driver is already "
> > > +                                 "handling %s events\n", sub_driver->name);
> > > +               } else {
> > > +                       pr_err("acpi_install_notify_handler(%s) failed: %s\n",
> > > +                              sub_driver->name, acpi_format_exception(status));
> > > +               }
> > > +               return -ENODEV;
> > > +       }
> > > +       sub_driver->flags.acpi_notify_installed = 1;
> > > +       return 0;
> > > +}
> > > +
> > > +static int __init tpacpi_device_add(struct acpi_device *device)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > > +static struct input_dev *generic_inputdev;
> > > +
> > > +static int loongson_generic_suspend(struct device *dev)
> > > +{
> > > +       return 0;
> > > +}
> > > +static int loongson_generic_resume(struct device *dev)
> > > +{
> > > +       int status = 0;
> > > +       struct key_entry ke;
> > > +       struct backlight_device *bd;
> > > +
> > > +       /*
> > > +        * Only if the firmware supports SW_LID event model, we can handle the
> > > +        * event. This is for the consideration of development board without
> > > +        * EC.
> > > +        */
> > > +       if (test_bit(SW_LID, generic_inputdev->swbit)) {
> > > +               if (hotkey_status_get(&status))
> > > +                       return -EIO;
> > > +               /*
> > > +                * The input device sw element records the last lid status.
> > > +                * When the system is awakened by other wake-up sources,
> > > +                * the lid event will also be reported. The judgment of
> > > +                * adding SW_LID bit which in sw element can avoid this
> > > +                * case.
> > > +                *
> > > +                * input system will drop lid event when current lid event
> > > +                * value and last lid status in the same data set，which
> > > +                * data set inclue zero set and no zero set. so laptop
> > > +                * driver doesn't report repeated events.
> > > +                *
> > > +                * Lid status is generally 0, but hardware exception is
> > > +                * considered. So add lid status confirmation.
> > > +                */
> > > +               if (test_bit(SW_LID, generic_inputdev->sw) && !(status & (1 << SW_LID))) {
> > > +                       ke.type = KE_SW;
> > > +                       ke.sw.value = (u8)status;
> > > +                       ke.sw.code = SW_LID;
> > > +                       sparse_keymap_report_entry(generic_inputdev, &ke,
> > > +                                       1, true);
> > > +               }
> > > +       }
> > > +
> > > +       bd = backlight_device_get_by_type(BACKLIGHT_PLATFORM);
> > > +       if (bd) {
> > > +               loongson_laptop_backlight_update(bd) ?
> > > +               pr_warn("Loongson_backlight: resume brightness failed") :
> > > +               pr_info("Loongson_backlight: resume brightness %d\n", bd->props.brightness);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static DEFINE_SIMPLE_DEV_PM_OPS(loongson_generic_pm,
> > > +               loongson_generic_suspend, loongson_generic_resume);
> > > +
> > > +static int __init register_generic_subdriver(struct generic_struct *sub_driver)
> > > +{
> > > +       int rc;
> > > +
> > > +       BUG_ON(!sub_driver->acpi);
> > > +
> > > +       sub_driver->acpi->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
> >
> > Please don't use acpi_driver here.  Use a platform driver instead and
> > bind to the platform device created by the ACPI subsystem for your
> > ACPI device object.
> This is derived from register_tpacpi_subdriver() in thinkpad_acpi.c,
> that means thinkpad also uses the wrong method?

That driver is one of the known exceptions mentioned by me.

Thanks!
