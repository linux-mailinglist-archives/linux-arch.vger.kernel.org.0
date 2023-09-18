Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A117A564A
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 01:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjIRXos (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 19:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjIRXor (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 19:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FA9B
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695080638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVlOSfQ+Cs92BylKR+M/JB7hqrVK10vOpKWpaqimizU=;
        b=gti5wqkPNzoHb41DYIPLbqGF7s7ANHSvaG1kZ6jj7gGIDVbDZzXIHCRCpo8ScSz7n/WNTX
        3Uh9CJ82Zw17p9iTh6mnhGm6CaKfO3OwXOU/Ug25DktkMSznqEkL3IYz29Y8oVoNxvejuq
        lytGQR5Vjv2lQSeoikVQIKiEIe0R8AE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-WolOlWBnOLKZS-FlNKnhTQ-1; Mon, 18 Sep 2023 19:43:57 -0400
X-MC-Unique: WolOlWBnOLKZS-FlNKnhTQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-56f75e70190so3898525a12.3
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 16:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695080636; x=1695685436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVlOSfQ+Cs92BylKR+M/JB7hqrVK10vOpKWpaqimizU=;
        b=WO+tNDHitYYSrMUZRyfO5jyeIgiKPdonC3pJB+yXIDJwR0R27YYfRTdHAY2fQybTr5
         mZ0+rI+XXgw6KC2KWxz4RXtQW39EEgWp3J3Wz1AMZUuPc4CBySvCQ9DaF65fjxrIjPxI
         KIScpNMz2tbcLZaphRrwzXYA3+RrL0pKouVg5P+h82c5M55aX3G0tif3yRyY2pVwha2f
         zG4Tl3ZmriUm0XOoM6Q7X+v1a1MyZXimnZiHCABDGlTv57OxNLUGcW6JKrM2sQwXrgW/
         1CL3JsRbdAKLrXcquOZZyDXoymTHtW2gcut3A44IjVbnoRcPpJ+4bzeKvalVo44HxK6y
         viGA==
X-Gm-Message-State: AOJu0YwBvHc8XgnhEkTuJvbU+93RUufzuxKGfG5laAQ0k3qCFSgV4tIx
        TZETSZSzxy7NUZuw+Ul3YOIlZyqav5eCfdGYGZbhR+xFXFz/e65hN0poldRHiluuVxI1V747cXg
        EQZy2Sujc1N9TNu7GdP1qpg==
X-Received: by 2002:a05:6a20:430d:b0:118:e70:6f7d with SMTP id h13-20020a056a20430d00b001180e706f7dmr10495452pzk.10.1695080635945;
        Mon, 18 Sep 2023 16:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFKOy814XSQK8TdPjNzCWuHRcOodlWCLUpNrs1TYBainKT1BB0hWvhf0Gyqm0LB88Jzxx1dQ==
X-Received: by 2002:a05:6a20:430d:b0:118:e70:6f7d with SMTP id h13-20020a056a20430d00b001180e706f7dmr10495432pzk.10.1695080635630;
        Mon, 18 Sep 2023 16:43:55 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b001bc68602e54sm8823472plb.142.2023.09.18.16.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 16:43:54 -0700 (PDT)
Message-ID: <ebfa8b5c-c09f-a1e6-e6ec-f4f3cda9de03@redhat.com>
Date:   Tue, 19 Sep 2023 09:43:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 14/35] ACPI: Only enumerate enabled (or functional)
 devices
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-15-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-15-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/14/23 02:38, James Morse wrote:
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
> ---
> If this change causes problems on deployed hardware, I suggest an
> arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> acpi_dev_ready_for_enumeration() to only check the present bit.
> ---
>   drivers/acpi/device_pm.c    |  2 +-
>   drivers/acpi/device_sysfs.c |  2 +-
>   drivers/acpi/internal.h     |  1 -
>   drivers/acpi/property.c     |  2 +-
>   drivers/acpi/scan.c         | 23 +++++++++++++----------
>   5 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index f007116a8427..76c38478a502 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
>   		return -EINVAL;
>   
>   	device->power.state = ACPI_STATE_UNKNOWN;
> -	if (!acpi_device_is_present(device)) {
> +	if (!acpi_dev_ready_for_enumeration(device)) {
>   		device->flags.initialized = false;
>   		return -ENXIO;
>   	}
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index b9bbf0746199..16e586d74aa2 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
>   	struct acpi_hardware_id *id;
>   
>   	/* Avoid unnecessarily loading modules for non present devices. */
> -	if (!acpi_device_is_present(acpi_dev))
> +	if (!acpi_dev_ready_for_enumeration(acpi_dev))
>   		return 0;
>   
>   	/*
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 866c7c4ed233..a1b45e345bcc 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -107,7 +107,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
>   void acpi_device_remove_files(struct acpi_device *dev);
>   void acpi_device_add_finalize(struct acpi_device *device);
>   void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> -bool acpi_device_is_present(const struct acpi_device *adev);
>   bool acpi_device_is_battery(struct acpi_device *adev);
>   bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>   					const struct device *dev);
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 413e4fcadcaf..e03f00b98701 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1418,7 +1418,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
>   	if (!is_acpi_device_node(fwnode))
>   		return false;
>   
> -	return acpi_device_is_present(to_acpi_device_node(fwnode));
> +	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
>   }
>   
>   static const void *
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 17ab875a7d4e..f898591ce05f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
>   	int error;
>   
>   	acpi_bus_get_status(adev);
> -	if (acpi_device_is_present(adev)) {
> +	if (acpi_dev_ready_for_enumeration(adev)) {
>   		/*
>   		 * This function is only called for device objects for which
>   		 * matching scan handlers exist.  The only situation in which
> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
>   	int error;
>   
>   	acpi_bus_get_status(adev);
> -	if (!acpi_device_is_present(adev)) {
> +	if (!acpi_dev_ready_for_enumeration(adev)) {
>   		acpi_scan_device_not_enumerated(adev);
>   		return 0;
>   	}
> @@ -1908,11 +1908,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
>   	return true;
>   }
>   
> -bool acpi_device_is_present(const struct acpi_device *adev)
> -{
> -	return adev->status.present || adev->status.functional;
> -}
> -
>   static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>   				       const char *idstr,
>   				       const struct acpi_device_id **matchid)
> @@ -2375,16 +2370,24 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>    * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for enumeration
>    * @device: Pointer to the &struct acpi_device to check
>    *
> - * Check if the device is present and has no unmet dependencies.
> + * Check if the device is functional or enabled and has no unmet dependencies.
>    *
> - * Return true if the device is ready for enumeratino. Otherwise, return false.
> + * Return true if the device is ready for enumeration. Otherwise, return false.
>    */
>   bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>   {
>   	if (device->flags.honor_deps && device->dep_unmet)
>   		return false;
>   
> -	return acpi_device_is_present(device);
> +	/*
> +	 * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> +	 * (!present && functional) for certain types of devices that should be
> +	 * enumerated.
> +	 */
> +	if (!device->status.present && !device->status.enabled)
> +		return device->status.functional;
> +
> +	return device->status.present && device->status.enabled;
>   }
>   EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>   

Looking at Salil's latest branch (vcpu-hotplug-RFCv2-rc7), there are 3 possible statuses:

   0x0       when CPU isn't present
   0xD       when CPU is present, but not enabled
   0xF       when CPU is present and enabled

Previously, the ACPI device is enumerated on 0xD and 0xF. We want to avoid the enumeration
on 0xD since the processor isn't ready for enumeration in this specific case. The changed
check (device->status.present && device->status.enabled) can ensure it. So the addition
of checking @device->state.functional seems irrelevant to ARM64 vCPU hot-add? I guess we
probably want a relaxation after the condition (device->status.present || device->status.enabled)
becomes a more strict one (device->status.present && device->status.enabled)

Thanks,
Gavin

