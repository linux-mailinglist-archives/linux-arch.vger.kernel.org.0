Return-Path: <linux-arch+bounces-2410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD29856E55
	for <lists+linux-arch@lfdr.de>; Thu, 15 Feb 2024 21:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E663B21024
	for <lists+linux-arch@lfdr.de>; Thu, 15 Feb 2024 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679C13A895;
	Thu, 15 Feb 2024 20:10:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D241A81;
	Thu, 15 Feb 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027853; cv=none; b=YGFZkw/RsnK/PXvvGZ6Jtzt7/BL23h5pElCyILpUTz27GGMDHqeEfC4MUnmW3oWRVZ7BlQDw96F5Fm2LE8T0Xn2SOfaRg0Z5eDhjeavdrHZqpRp4N+ceAl75PaDcPb2kH1gg1ls6+x06+/iHWWxahuAJmq/1myyOaq7ZdatwKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027853; c=relaxed/simple;
	bh=KWacMN9bKt8TXc2E1qM1MQU5P2gj1Hsam/+L01L4dKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TykVS5OdMk5BbnOKWlkH8tz6sZ8dQlTo8yB+EIzNTEWRphLtucsHyWnDM1qTxuOboP+atylSAaJlikSuAPCsWS2UeEAezgZdv0EieRWBT5Dmhpq0cGHPD4lZAGzMVzwn+5yNXcCijn2/09/00TJATWk6STqYrVPivWcPuNm1VV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59d8455a001so164702eaf.0;
        Thu, 15 Feb 2024 12:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027851; x=1708632651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5QgqQoXz8wizig56vqi0Oac+indEXSPpBlHYNqWGu8=;
        b=UY3NiuWZk29xW0BRkoQ44vxNCLg/rvszwHUxKby9x63trdrYtydkVvUY1/tZntEDm1
         MQoWWHZJFbAWEsH8XINTXww38aHxyvyFovq2Y6gwvXmrRZXLdE+71HKA3iix+/cSpkxt
         k8S6HA1Yt3HlSM0WHdWYwihrK4Ac+1w9Kv4ZJWHiDSrfuLx3XwvpEN+m/We5q1wkDaAv
         BeoHX7sq5EU1ShxYwk6TBwjNKI5e1F9C86J5/i+TC9rz7ispJxKSzkcpWaQJ8njBm+Xv
         Y6eV2+dcM9acxfVhvu5MvlLvxShPy1k5R6QJwauZTXiCqPB8EIZRz/TrGx2l6oTCbbUe
         yZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUqeQiV2wpLNTEY3QFABvo47g6vaDGT2Fu9HcTyuuNs+lkHq+HBeGjbqKGUdplB6kRXRBYAENgPLYfbS4vudJHiY/O1R/VtN0EzdZV7XYmrfTfqiiA/zVPzr+p3Sw1kXJDVZO2mLntUR2VjE33rpqAW9E47tEwDsbC5Sp3FcjgZPgGo7oLJCqiVekl6Y2dXcDq7cBC6xMfpKvKt6FDeCQT+gdJSvzQRFO2DN5jtpCmO88UdcH/t111L/N8qO7v3RLEOhoHiTnIkiRakaYhni1YRfJSFrWaL9LWsI9SMNLE2hrHSfQ0adbOZMxJg5NYW6L7OioLQCw==
X-Gm-Message-State: AOJu0YyIV4HBAGGNY9mQelxNqloQxUZ+6Ov8iWHXXclIA0UUe6wn9L34
	nfSeVrmGC0vCvBzY/jm9V8TsnNu/1vbjDv3hOwaX1Jkzgrgq/qCJbtblKnVg6AshSS3D6dwOV78
	6wtCkQ9+gZJvkDti+z0QG1B8Au5g=
X-Google-Smtp-Source: AGHT+IHkVX1K8sj+CkxR6/GyZWC/g8VGhJA3m1sRCcpy+7lmARmO8dgH6PnptuwtNDNHiVSlDhhEi0CLuZvIHBcTUt0=
X-Received: by 2002:a05:6820:134d:b0:59f:881f:9318 with SMTP id
 b13-20020a056820134d00b0059f881f9318mr3192843oow.0.1708027850728; Thu, 15 Feb
 2024 12:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2024 21:10:39 +0100
Message-ID: <CAJZ5v0hY_LXp41WMVPhiLosPe7YVzF38Uz=EhmJqVwqFn==Upw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 01/15] ACPI: Only enumerate enabled (or functional)
 processor devices
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
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

I can queue this up for 6.9 as it looks like the rest of the series
will still need some work.  What do you think?

