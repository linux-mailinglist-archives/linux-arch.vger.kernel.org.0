Return-Path: <linux-arch+bounces-2579-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF6885D89A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94AF284E67
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 13:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11369E02;
	Wed, 21 Feb 2024 13:01:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC069DE7;
	Wed, 21 Feb 2024 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520501; cv=none; b=S2f91djg/vpA2eCvVQwcUNNiEProipxVTbP/bfvMY+JGnFWE+xUm7RnWuL10tEUOJnWQtqU1Sp+F+Qa2RsWB8RM+ZABfkDoFYbMh1RqFqA8k9yCNPa8Xsb20g/2Bp6rNBgb1pZuBgLKMRnmKXMyrGFKjHZGXuuDR7qz6WWNtkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520501; c=relaxed/simple;
	bh=G8om0rjQqyR9YE7G64KIEc9TeoQTTAye6vsya03M/GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkHDS0SjzPGa+UtJm27FaRWnE8bA+EUoZ5q5Dc04y161q2AheEytlkxspUsj4ysHxuwplAx1aUo0wn3tQYChCTNJszmzpXyU6BnLaRfh+lCuHe8YRMjMU3GmXVX7xSuQnURAL5ZQAHe+9zEIEav4ZhXIWJq5hlc5ORzOV2EG6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e46cfe4696so18681a34.0;
        Wed, 21 Feb 2024 05:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708520498; x=1709125298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjTBZ2pIGn9m58ISTRb7N/9rqc6EyvNm/w9doeAfA6w=;
        b=Ckg0yHQbXMtkgQeAZ5roPP0AqwGzJ5wZcNng/T526K8jbKfZBdjW//pc9Y9cdBx+or
         ukTUvMNSfDWg2DY0RpjiSWTgdUVyBNwtTBJCSsMTyfvxpfJUE1Pem2x8nac1TCwbx3nA
         OYS/dzAGeYOR1fg/iK5nG47IrZqN4P7Oq2/MKbixrojat85ESJkmAzHsfR6H6wow7Ev+
         desnYXppeXocSXbs4kW9PR9Xvfex5vVb3VFIN1qch3SUArQbTNh7VwqijaI1RLlSZUg6
         Nz+PM4nf4IE9ifENr8REuTTFkSVdzp3mXRz1UAvEPju5xggVCHfJOq348xSLCD0/MJ2y
         ZIIg==
X-Forwarded-Encrypted: i=1; AJvYcCUHj2TUEpCcEt7Pwurtf5XgFBcyB/JZjAwCio6Cvm4xZDUCBeaYL/fm7PHdDVh76yetPqyaC9b0dKFFARO61YhnGMavCJvLD6gWfjnBzWxDJleikTrA3cLuU2peUADhWEX9eKLgT6jPOQdD8p4ug2UUp8VOrYgNh6eV9/XUSP5NNgNGHPenJvIYkmAKNcOwxIuf1XiA49XYVYN3DbDpNmZSS5zKd/QcKr3HwNCk27H2c0N58HdvFmljIKFJ9QVplsX2lLJ0nwfrQBuE6DTeWqtCTzhIXH0shmlRA6riMt0EBY4qV/XwgHabJjqIs9SJ+8L/+iF5yg==
X-Gm-Message-State: AOJu0Yy5s+FaPyugC2iBfVRR9aPb4Tv79BRfZohi1ymUinztZtSPqML1
	D5kbfLOXKT/HyCCI+SNePkFLvOuhPGgdiBF2NK+mwZ1J+aDxT74YrjoBUo+TXtt6pPI8FYzb4ap
	Gl2ZbHue266Mn5HPRF6IputUcAaI=
X-Google-Smtp-Source: AGHT+IGrzug+PujlOK+ami5erNuOPXqroiinzWAlTGq+qHXgSdwbuVfvzPw7EC411PEupBookFreEymZbaJtTChjoS8=
X-Received: by 2002:a4a:e89a:0:b0:5a0:168b:d91 with SMTP id
 g26-20020a4ae89a000000b005a0168b0d91mr1141177ooe.1.1708520497860; Wed, 21 Feb
 2024 05:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Feb 2024 14:01:25 +0100
Message-ID: <CAJZ5v0gJHq41HzGadwSu7yxJF_tidiX09ZMMV3j4L3bhmPwhaQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 01/15] ACPI: Only enumerate enabled (or functional)
 processor devices
To: Russell King <rmk+kernel@armlinux.org.uk>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:49=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> Today the ACPI enumeration code 'visits' all devices that are present.
>
> This is a problem for arm64, where CPUs are always present, but not
> always enabled. When a device-check occurs because the firmware-policy
> has changed and a CPU is now enabled, the following error occurs:
> | acpi ACPI0007:48: Enumeration failure
>
> This is ultimately because acpi_dev_ready_for_enumeration() returns
> true for a device that is not enabled. The ACPI Processor driver
> will not register such CPUs as they are not 'decoding their resources'.
>
> ACPI allows a device to be functional instead of maintaining the
> present and enabled bit, but we can't simply check the enabled bit
> for all devices since firmware can be buggy.
>
> If ACPI indicates that the device is present and enabled, then all well
> and good, we can enumate it. However, if the device is present and not
> enabled, then we also check whether the device is a processor device
> to limit the impact of this new check to just processor devices.
>
> This avoids enumerating present && functional processor devices that
> are not enabled.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>  * Incorporate comment suggestion by Gavin Shan.
> Changes since RFC v3:
>  * Fixed "sert" typo.
> Changes since RFC v3 (smaller series):
>  * Restrict checking the enabled bit to processor devices, update
>    commit comments.
>  * Use Rafael's suggestion in
>    https://lore.kernel.org/r/5760569.DvuYhMxLoT@kreacher
>  * Updated with a fix - see:
>    https://lore.kernel.org/all/Zbe8WQRASx6D6RaG@shell.armlinux.org.uk/
> ---
>  drivers/acpi/acpi_processor.c | 11 +++++++++
>  drivers/acpi/device_pm.c      |  2 +-
>  drivers/acpi/device_sysfs.c   |  2 +-
>  drivers/acpi/internal.h       |  4 ++-
>  drivers/acpi/property.c       |  2 +-
>  drivers/acpi/scan.c           | 46 +++++++++++++++++++++++++++--------
>  6 files changed, 53 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 4fe2ef54088c..cf7c1cca69dd 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -626,6 +626,17 @@ static struct acpi_scan_handler processor_handler =
=3D {
>         },
>  };
>
> +bool acpi_device_is_processor(const struct acpi_device *adev)
> +{
> +       if (adev->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> +               return true;
> +
> +       if (adev->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> +               return false;
> +
> +       return acpi_scan_check_handler(adev, &processor_handler);
> +}
> +
>  static int acpi_processor_container_attach(struct acpi_device *dev,
>                                            const struct acpi_device_id *i=
d)
>  {
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 3b4d048c4941..e3c80f3b3b57 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
>                 return -EINVAL;
>
>         device->power.state =3D ACPI_STATE_UNKNOWN;
> -       if (!acpi_device_is_present(device)) {
> +       if (!acpi_dev_ready_for_enumeration(device)) {

Sorry for failing to catch this earlier, but this change affects
non-processor devices possibly adversely.

Namely, one of the differences between acpi_device_is_present() and
acpi_dev_ready_for_enumeration() is the (device->flags.honor_deps &&
device->dep_unmet) check in the latter which is not present in the
former which may cause the power_manageable flag to be unset for
devices with dependencies, although they are in fact power-manageable.

The replacement here cannot be made.

>                 device->flags.initialized =3D false;
>                 return -ENXIO;
>         }
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 23373faa35ec..a0256d2493a7 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_devi=
ce *acpi_dev, char *modalia
>         struct acpi_hardware_id *id;
>
>         /* Avoid unnecessarily loading modules for non present devices. *=
/
> -       if (!acpi_device_is_present(acpi_dev))
> +       if (!acpi_dev_ready_for_enumeration(acpi_dev))

The replacement here is incorrect for an analogous reason as above: it
may cause modalias creation to be skipped for devices with unmet
dependencies that are not processors and matching modules for them
should be loaded.

In fact, this replacement doesn't even have a functional effect on
processors, because there are no modules matching the processor device
ID AFAICS.

>                 return 0;
>
>         /*
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 6588525c45ef..1bc8b6db60c5 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug=
_profile *hotplug,
>  int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler=
,
>                                        const char *hotplug_profile_name);
>  void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, boo=
l val);
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +                            struct acpi_scan_handler *handler);
>
>  #ifdef CONFIG_DEBUG_FS
>  extern struct dentry *acpi_debugfs_dir;
> @@ -121,7 +123,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
>  void acpi_device_remove_files(struct acpi_device *dev);
>  void acpi_device_add_finalize(struct acpi_device *device);
>  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> -bool acpi_device_is_present(const struct acpi_device *adev);
>  bool acpi_device_is_battery(struct acpi_device *adev);
>  bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>                                         const struct device *dev);
> @@ -133,6 +134,7 @@ int acpi_bus_register_early_device(int type);
>  const struct acpi_device *acpi_companion_match(const struct device *dev)=
;
>  int __acpi_device_uevent_modalias(const struct acpi_device *adev,
>                                   struct kobj_uevent_env *env);
> +bool acpi_device_is_processor(const struct acpi_device *adev);
>
>  /* ---------------------------------------------------------------------=
-----
>                                    Power Resource
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index a6ead5204046..9f8d54038770 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1486,7 +1486,7 @@ static bool acpi_fwnode_device_is_available(const s=
truct fwnode_handle *fwnode)
>         if (!is_acpi_device_node(fwnode))
>                 return false;
>
> -       return acpi_device_is_present(to_acpi_device_node(fwnode));
> +       return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode)=
);

This, again, may break non-processor devices with dependencies in
subtle ways and it doesn't have a functional effect on processors
AFAICS.

>  }
>
>  static const void *
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e6ed1ba91e5c..fd2e8b3a5749 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device =
*adev)
>         int error;
>
>         acpi_bus_get_status(adev);
> -       if (acpi_device_is_present(adev)) {
> +       if (acpi_dev_ready_for_enumeration(adev)) {

It looks to me like there are two purposes of this replacement.  One
is to handle the removal case which is analogous to the
acpi_scan_bus_check() case below.

The other purpose seems to be to avoid the dev_warn() message printed
when acpi_processor_add() does not return 1 for a processor device
that is not enabled.

However, this message arguably should not be printed at all so long as
acpi_bus_scan() succeeds, because hot-adding a device without a
matching scan handler is entirely valid.

I'll send a patch to fix this shortly.

In addition to that, it would suffice to make acpi_processor_add()
check the enabled bit and return 0 early when it is clear.  I'll send
a patch for this either.

>                 /*
>                  * This function is only called for device objects for wh=
ich
>                  * matching scan handlers exist.  The only situation in w=
hich
> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *ad=
ev, void *not_used)
>         int error;
>
>         acpi_bus_get_status(adev);
> -       if (!acpi_device_is_present(adev)) {
> +       if (!acpi_dev_ready_for_enumeration(adev)) {

Indeed, the enabled bit should be checked here, along with the present
and functional bits, but it would be better to move that check to
acpi_bus_trim_one() or even acpi_processor_remove(), so the
not-present-but-functional case is handled correctly.  And the
acpi_scan_device_check() case could then be handled analogously.
Another patch to be sent.

>                 acpi_scan_device_not_enumerated(adev);
>                 return 0;
>         }
> @@ -1917,11 +1917,6 @@ static bool acpi_device_should_be_hidden(acpi_hand=
le handle)
>         return true;
>  }
>
> -bool acpi_device_is_present(const struct acpi_device *adev)
> -{
> -       return adev->status.present || adev->status.functional;
> -}
> -
>  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler=
,
>                                        const char *idstr,
>                                        const struct acpi_device_id **matc=
hid)
> @@ -1942,6 +1937,18 @@ static bool acpi_scan_handler_matching(struct acpi=
_scan_handler *handler,
>         return false;
>  }
>
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +                            struct acpi_scan_handler *handler)
> +{
> +       struct acpi_hardware_id *hwid;
> +
> +       list_for_each_entry(hwid, &adev->pnp.ids, list)
> +               if (acpi_scan_handler_matching(handler, hwid->id, NULL))
> +                       return true;
> +
> +       return false;
> +}
> +
>  static struct acpi_scan_handler *acpi_scan_match_handler(const char *ids=
tr,
>                                         const struct acpi_device_id **mat=
chid)
>  {
> @@ -2405,16 +2412,35 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>   * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready fo=
r enumeration
>   * @device: Pointer to the &struct acpi_device to check
>   *
> - * Check if the device is present and has no unmet dependencies.
> + * Check if the device is functional or enabled and has no unmet depende=
ncies.
>   *
> - * Return true if the device is ready for enumeratino. Otherwise, return=
 false.
> + * Return true if the device is ready for enumeration. Otherwise, return=
 false.
>   */
>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>  {
>         if (device->flags.honor_deps && device->dep_unmet)
>                 return false;
>
> -       return acpi_device_is_present(device);
> +       /*
> +        * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to ret=
urn
> +        * (!present && functional) for certain types of devices that sho=
uld be
> +        * enumerated. Note that the enabled bit should not be set unless=
 the
> +        * present bit is set.
> +        *
> +        * However, limit this only to processor devices to reduce possib=
le
> +        * regressions with firmware.
> +        */
> +       if (!device->status.present)
> +               return device->status.functional;
> +
> +       /*
> +        * Fast path - if enabled is set, avoid the more expensive test t=
o
> +        * check whether this device is a processor.
> +        */
> +       if (device->status.enabled)
> +               return true;
> +
> +       return !acpi_device_is_processor(device);
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>
> --

