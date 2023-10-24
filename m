Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA507D5A24
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 20:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbjJXSHo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 24 Oct 2023 14:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343929AbjJXSHn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 14:07:43 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E813010DC;
        Tue, 24 Oct 2023 11:07:39 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1eb7a8d9610so267596fac.0;
        Tue, 24 Oct 2023 11:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698170859; x=1698775659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQTNvNBcefpx8R3X1mnWwpUfG0oIl7IhX9lq//tJ6c8=;
        b=iPC0R1rDQ/mLHAy6pi+YsuBM7Orn+TDxR1dRerwo3ZKJVhIozXLR4EZgiQvOctEfeu
         5sVxaSLiVtIt6q3Rw/7oj0rmvRUiXrztH6W3HRz/yPj7Vxq23HpvFe/AcVAwH71GlZEV
         hBOpUVFuaLfkdTZw08n3JPgtfwfsL7wx5WKxxdQa6hPf6zL84iXggZNdemn5UQCUnw+n
         GAtZJoUExOevhJfJtuKLmisslraeqe6RWRCtxnYVdGcaYtqAwpqbbb+BNKeAYOIbQAnD
         qYK60tOCmIi/J+hKvQpSSZWOeNmQf23/0K15t1w3w9Kw5YdoAcrdXjpzEJlhYSZfG6G9
         MQGg==
X-Gm-Message-State: AOJu0YzofwkWpVYoy3ucP5HRtlng40jWOHNOpe/jR/S9c7JnZfXCy2A1
        9BIOYQ8TnX1vUTyprv2OjWU0dr0BR6l9QQTZuFk=
X-Google-Smtp-Source: AGHT+IFgKJJuhi8Fn+oYQw2beWPiWDcHgwYutcTjQl/p/NDnzJosiVcRh4Pmi6U/8cGoxSv4c+8jWId2r72zu79T530=
X-Received: by 2002:a05:6870:9e97:b0:1e9:9f9b:eb7a with SMTP id
 pu23-20020a0568709e9700b001e99f9beb7amr16188516oab.4.1698170859120; Tue, 24
 Oct 2023 11:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk> <E1qvJA5-00AqQa-TL@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qvJA5-00AqQa-TL@rmk-PC.armlinux.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 20:07:28 +0200
Message-ID: <CAJZ5v0hhEeyDEMHnVQEiXzaKK07TSnE6GJhuTW97-XEb9CoSHQ@mail.gmail.com>
Subject: Re: [PATCH 18/39] ACPI: Only enumerate enabled (or functional) devices
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 24, 2023 at 5:17 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
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
> Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
> ACPI allows a device to be functional instead of maintaining the
> present and enabled bit. Make this behaviour an explicit check with
> a reference to the spec, and then check the present and enabled bits.
> This is needed to avoid enumerating present && functional devices that
> are not enabled.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> If this change causes problems on deployed hardware, I suggest an

TBH, I am expecting problems to be there.

If something has been interpreted in a specific way for several years,
then changing that interpretation is just incompatible with the entire
installed base, at least potentially.

It is not even possible to estimate the potential adverse impact of
this change, as it causes a firmware-provided bit that has never been
taken into account so far to become meaningful and it does so for
every device in the system.

It will be very hard to convince me that this change is a good idea.

> arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> acpi_dev_ready_for_enumeration() to only check the present bit.

But this can work as long as the given arch does not care about
platforms in which the "enabled" bit may not be set as expected for
some devices.

>
> Changes since RFC v2:
>  * Incorporate comment suggestion by Gavin Shan.
> Other review comments from Jonathan Cameron not yet addressed.
> ---
>  drivers/acpi/device_pm.c    |  2 +-
>  drivers/acpi/device_sysfs.c |  2 +-
>  drivers/acpi/internal.h     |  1 -
>  drivers/acpi/property.c     |  2 +-
>  drivers/acpi/scan.c         | 24 ++++++++++++++----------
>  5 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index f007116a8427..76c38478a502 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
>                 return -EINVAL;
>
>         device->power.state = ACPI_STATE_UNKNOWN;
> -       if (!acpi_device_is_present(device)) {
> +       if (!acpi_dev_ready_for_enumeration(device)) {
>                 device->flags.initialized = false;
>                 return -ENXIO;
>         }
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index b9bbf0746199..16e586d74aa2 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
>         struct acpi_hardware_id *id;
>
>         /* Avoid unnecessarily loading modules for non present devices. */
> -       if (!acpi_device_is_present(acpi_dev))
> +       if (!acpi_dev_ready_for_enumeration(acpi_dev))
>                 return 0;
>
>         /*
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 866c7c4ed233..a1b45e345bcc 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -107,7 +107,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
>  void acpi_device_remove_files(struct acpi_device *dev);
>  void acpi_device_add_finalize(struct acpi_device *device);
>  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> -bool acpi_device_is_present(const struct acpi_device *adev);
>  bool acpi_device_is_battery(struct acpi_device *adev);
>  bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>                                         const struct device *dev);
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 413e4fcadcaf..e03f00b98701 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1418,7 +1418,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
>         if (!is_acpi_device_node(fwnode))
>                 return false;
>
> -       return acpi_device_is_present(to_acpi_device_node(fwnode));
> +       return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
>  }
>
>  static const void *
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 17ab875a7d4e..06e9bb4a633f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
>         int error;
>
>         acpi_bus_get_status(adev);
> -       if (acpi_device_is_present(adev)) {
> +       if (acpi_dev_ready_for_enumeration(adev)) {
>                 /*
>                  * This function is only called for device objects for which
>                  * matching scan handlers exist.  The only situation in which
> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
>         int error;
>
>         acpi_bus_get_status(adev);
> -       if (!acpi_device_is_present(adev)) {
> +       if (!acpi_dev_ready_for_enumeration(adev)) {
>                 acpi_scan_device_not_enumerated(adev);
>                 return 0;
>         }
> @@ -1908,11 +1908,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
>         return true;
>  }
>
> -bool acpi_device_is_present(const struct acpi_device *adev)
> -{
> -       return adev->status.present || adev->status.functional;
> -}
> -
>  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>                                        const char *idstr,
>                                        const struct acpi_device_id **matchid)
> @@ -2375,16 +2370,25 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>   * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for enumeration
>   * @device: Pointer to the &struct acpi_device to check
>   *
> - * Check if the device is present and has no unmet dependencies.
> + * Check if the device is functional or enabled and has no unmet dependencies.
>   *
> - * Return true if the device is ready for enumeratino. Otherwise, return false.
> + * Return true if the device is ready for enumeration. Otherwise, return false.
>   */
>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>  {
>         if (device->flags.honor_deps && device->dep_unmet)
>                 return false;
>
> -       return acpi_device_is_present(device);
> +       /*
> +        * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> +        * (!present && functional) for certain types of devices that should be
> +        * enumerated. Note that the enabled bit can't be sert until the present
> +        * bit is set.
> +        */
> +       if (device->status.present)
> +               return device->status.enabled;
> +       else
> +               return device->status.functional;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>
> --
> 2.30.2
>
