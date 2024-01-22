Return-Path: <linux-arch+bounces-1409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F616835BBD
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 08:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32581F22529
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F5C18E03;
	Mon, 22 Jan 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiyr3Goz"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B018C2A
	for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908983; cv=none; b=tQO1h46l/ildBNEKzwacT6znjFrMcMuDX/ihf7K2QusY38iHvB3WVgxwSPQPhxuRa9eTSX0ofx8gHpRhtlUK3UxxjsNsim8Am9QTdwp+LrPrMeuQkEPmbapALwwSKazDasixKsgVEl0aEmifkw5FHtsbNtFI9U9i57ca6LrTznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908983; c=relaxed/simple;
	bh=Llzbm9oUkBIrng0jHN+0KXkIbMGgbqqoOcPr8oYO5Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgchvrda3e34T88f7RS2wfbIuGakOk5cShHzd+n2+kY1fpU3z/4Y2K/FMWTfygGjiAcyD0qnTjc8PhG8D3j7FbSGimFczgF6Pmo4qIXJhLbe0GD9mno6mb/dtbzGy2HbBadUdJV4YJsvk1OGpsk+5qBYqTWAvj932id35boh1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iiyr3Goz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705908980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7h2DVEhrlBFS3xqWaYiNz0NtwDtYA/pt6g+Gnzcrd4=;
	b=iiyr3GozHwHBjv4qEVWOfDdK9aNzFhOD0/ktsP9DPUx3HpTGDVA9mqofxFjfWPyUq/vn69
	LD8H0o6nWxm30CgZnytvUZMWjnJOVI4in0elp1ZC1QixwpI7aX5rp0UXzzLYMJKvL6QxrK
	XjoSporqTSr7Cm9Hf6uBp8qdn9W4WXw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-8j1yYAazNjy3vTSHmVPtVw-1; Mon, 22 Jan 2024 02:36:17 -0500
X-MC-Unique: 8j1yYAazNjy3vTSHmVPtVw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29028587648so1244539a91.0
        for <linux-arch@vger.kernel.org>; Sun, 21 Jan 2024 23:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705908672; x=1706513472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7h2DVEhrlBFS3xqWaYiNz0NtwDtYA/pt6g+Gnzcrd4=;
        b=Bykg09aoaRZIWZKljt0FvMRrNpBcF1kLQ8z1Ikn7w8Av09YmgLXMgu7sBoaIb6kCjv
         ont0VRZ0LDmNMDwKyXAY1mesPKD3MXcS6952MPfx+jlQSedkuvFeAAjS+o00u14j70yv
         2W30VeU6+xU4SAikNcD5ccP3v3MKr6P/4dSEbdD21Av51/pGlfdcyFk7F3kee+FqERCS
         X1nJtBy21VklpDbNWkdy9dbCH5MstY407HYFEBQTFXyXikB9s6dE8AHvP+p8ir7p0U6C
         /N/alPcx390G5lQYyXoD3hcZNKjq8cdQDWW9Zna7z6lVaHvJsm45usfzc1sZwP4h+1Tw
         DuZg==
X-Gm-Message-State: AOJu0Yxz0pHgTHGilgKSTxw5/6QPgH1RN7iBJLQL5K0Lp9En8bZJ/3cj
	lOunuv0DrDZ84rP6tYySJJ7dP8I5To+9u0aTRGJhbheqHWkA7rZfV7RqMVXZFT0vMac5R4831YI
	h63AgoyvokMlKt2WyOk37xRxshBdlZurz9oY2YwtKvcIZLTKsYuh9hnponrA=
X-Received: by 2002:a17:90a:b903:b0:28e:88d9:c314 with SMTP id p3-20020a17090ab90300b0028e88d9c314mr1170539pjr.11.1705908672210;
        Sun, 21 Jan 2024 23:31:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDCgmKu6d5PIapALN9UiADEjI2hUkrZBK0fyw5g8iUtS6EUbQqGF86PDL0wCSAJC+g9XfSAg==
X-Received: by 2002:a17:90a:b903:b0:28e:88d9:c314 with SMTP id p3-20020a17090ab90300b0028e88d9c314mr1170530pjr.11.1705908671822;
        Sun, 21 Jan 2024 23:31:11 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id li9-20020a17090b48c900b0028b3539cd97sm8995232pjb.20.2024.01.21.23.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 23:31:11 -0800 (PST)
Message-ID: <38d6eed5-05ff-4019-bc82-fc7356013c40@redhat.com>
Date: Mon, 22 Jan 2024 17:31:00 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional)
 devices
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org,
 acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk> <20231215161539.00000940@Huawei.com>
 <5760569.DvuYhMxLoT@kreacher> <20240102143925.00004361@Huawei.com>
 <20240111101949.000075dc@Huawei.com> <ZZ/CR/6Voec066DR@shell.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZZ/CR/6Voec066DR@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/11/24 20:26, Russell King (Oracle) wrote:
> On Thu, Jan 11, 2024 at 10:19:49AM +0000, Jonathan Cameron wrote:
>> On Tue, 2 Jan 2024 14:39:25 +0000
>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>>
>>> On Fri, 15 Dec 2023 20:47:31 +0100
>>> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>>>
>>>> On Friday, December 15, 2023 5:15:39 PM CET Jonathan Cameron wrote:
>>>>> On Fri, 15 Dec 2023 15:31:55 +0000
>>>>> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>>>>>      
>>>>>> On Thu, Dec 14, 2023 at 07:37:10PM +0100, Rafael J. Wysocki wrote:
>>>>>>> On Thu, Dec 14, 2023 at 7:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Thu, Dec 14, 2023 at 7:10 PM Russell King (Oracle)
>>>>>>>> <linux@armlinux.org.uk> wrote:
>>>>>>>>> I guess we need something like:
>>>>>>>>>
>>>>>>>>>          if (device->status.present)
>>>>>>>>>                  return device->device_type != ACPI_BUS_TYPE_PROCESSOR ||
>>>>>>>>>                         device->status.enabled;
>>>>>>>>>          else
>>>>>>>>>                  return device->status.functional;
>>>>>>>>>
>>>>>>>>> so we only check device->status.enabled for processor-type devices?
>>>>>>>>
>>>>>>>> Yes, something like this.
>>>>>>>
>>>>>>> However, that is not sufficient, because there are
>>>>>>> ACPI_BUS_TYPE_DEVICE devices representing processors.
>>>>>>>
>>>>>>> I'm not sure about a clean way to do it ATM.
>>>>>>
>>>>>> Ok, how about:
>>>>>>
>>>>>> static bool acpi_dev_is_processor(const struct acpi_device *device)
>>>>>> {
>>>>>> 	struct acpi_hardware_id *hwid;
>>>>>>
>>>>>> 	if (device->device_type == ACPI_BUS_TYPE_PROCESSOR)
>>>>>> 		return true;
>>>>>>
>>>>>> 	if (device->device_type != ACPI_BUS_TYPE_DEVICE)
>>>>>> 		return false;
>>>>>>
>>>>>> 	list_for_each_entry(hwid, &device->pnp.ids, list)
>>>>>> 		if (!strcmp(ACPI_PROCESSOR_OBJECT_HID, hwid->id) ||
>>>>>> 		    !strcmp(ACPI_PROCESSOR_DEVICE_HID, hwid->id))
>>>>>> 			return true;
>>>>>>
>>>>>> 	return false;
>>>>>> }
>>>>>>
>>>>>> and then:
>>>>>>
>>>>>> 	if (device->status.present)
>>>>>> 		return !acpi_dev_is_processor(device) || device->status.enabled;
>>>>>> 	else
>>>>>> 		return device->status.functional;
>>>>>>
>>>>>> ?
>>>>>>      
>>>>> Changing it to CPU only for now makes sense to me and I think this code snippet should do the
>>>>> job.  Nice and simple.
>>>>
>>>> Well, except that it does checks that are done elsewhere slightly
>>>> differently, which from the maintenance POV is not nice.
>>>>
>>>> Maybe something like the appended patch (untested).
>>>
>>> Hi Rafael,
>>>
>>> As far as I can see that's functionally equivalent, so looks good to me.
>>> I'm not set up to test this today though, so will defer to Russell on whether
>>> there is anything missing
>>>
>>> Thanks for putting this together.
>>
>> This is rather embarrassing...
>>
>> I span this up on a QEMU instance with some prints to find out we need
>> the !acpi_device_is_processor() restriction.
>> On my 'random' test setup it fails on one device. ACPI0017 - which I
>> happen to know rather well. It's the weird pseudo device that lets
>> a CXL aware OS know there is a CEDT table to probe.
>>
>> Whilst I really don't like that hack (it is all about making software
>> distribution of out of tree modules easier rather than something
>> fundamental), I'm the CXL QEMU maintainer :(
>>
>> Will fix that, but it shows there is at least one broken firmware out
>> there.
>>
>> On plus side, Rafael's code seems to work as expected and lets that
>> buggy firwmare carry on working :) So lets pretend the bug in qemu
>> is a deliberate test case!
> 
> Lol, thanks for a test case and showing that Rafael's approach is
> indeed necessary.
> 
> Would your test quality for a tested-by for this? For reference, this
> is my current version below with Rafael's update:
> 
> 8<====
> From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Subject: [PATCH] ACPI: Only enumerate enabled (or functional) processor
>   devices
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
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>   * Incorporate comment suggestion by Gavin Shan.
> Changes since RFC v3:
>   * Fixed "sert" typo.
> Changes since RFC v3 (smaller series):
>   * Restrict checking the enabled bit to processor devices, update
>     commit comments.
>   * Use Rafael's suggestion in
>     https://lore.kernel.org/r/5760569.DvuYhMxLoT@kreacher
> ---
>   drivers/acpi/acpi_processor.c | 11 ++++++++
>   drivers/acpi/device_pm.c      |  2 +-
>   drivers/acpi/device_sysfs.c   |  2 +-
>   drivers/acpi/internal.h       |  4 ++-
>   drivers/acpi/property.c       |  2 +-
>   drivers/acpi/scan.c           | 49 ++++++++++++++++++++++++++++-------
>   6 files changed, 56 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 4fe2ef54088c..cf7c1cca69dd 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -626,6 +626,17 @@ static struct acpi_scan_handler processor_handler = {
>   	},
>   };
>   
> +bool acpi_device_is_processor(const struct acpi_device *adev)
> +{
> +	if (adev->device_type == ACPI_BUS_TYPE_PROCESSOR)
> +		return true;
> +
> +	if (adev->device_type != ACPI_BUS_TYPE_DEVICE)
> +		return false;
> +
> +	return acpi_scan_check_handler(adev, &processor_handler);
> +}
> +
>   static int acpi_processor_container_attach(struct acpi_device *dev,
>   					   const struct acpi_device_id *id)
>   {
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 3b4d048c4941..e3c80f3b3b57 100644
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
> index 23373faa35ec..a0256d2493a7 100644
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
> index 866c7c4ed233..9388d4c8674a 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
>   int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
>   				       const char *hotplug_profile_name);
>   void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val);
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +			     struct acpi_scan_handler *handler);
>   
>   #ifdef CONFIG_DEBUG_FS
>   extern struct dentry *acpi_debugfs_dir;
> @@ -107,7 +109,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
>   void acpi_device_remove_files(struct acpi_device *dev);
>   void acpi_device_add_finalize(struct acpi_device *device);
>   void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> -bool acpi_device_is_present(const struct acpi_device *adev);
>   bool acpi_device_is_battery(struct acpi_device *adev);
>   bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>   					const struct device *dev);
> @@ -119,6 +120,7 @@ int acpi_bus_register_early_device(int type);
>   const struct acpi_device *acpi_companion_match(const struct device *dev);
>   int __acpi_device_uevent_modalias(const struct acpi_device *adev,
>   				  struct kobj_uevent_env *env);
> +bool acpi_device_is_processor(const struct acpi_device *adev);
>   
>   /* --------------------------------------------------------------------------
>                                     Power Resource
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 6979a3f9f90a..14d6948fd88a 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1420,7 +1420,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
>   	if (!is_acpi_device_node(fwnode))
>   		return false;
>   
> -	return acpi_device_is_present(to_acpi_device_node(fwnode));
> +	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
>   }
>   
>   static const void *
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 02bb2cce423f..f94d1f744bcc 100644
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
> @@ -1913,11 +1913,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
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
> @@ -1938,6 +1933,18 @@ static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>   	return false;
>   }
>   
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +			     struct acpi_scan_handler *handler)
> +{
> +	struct acpi_hardware_id *hwid;
> +
> +	list_for_each_entry(hwid, &adev->pnp.ids, list)
> +		if (acpi_scan_handler_matching(handler, hwid->id, NULL))
> +			return true;
> +
> +	return false;
> +}
> +
>   static struct acpi_scan_handler *acpi_scan_match_handler(const char *idstr,
>   					const struct acpi_device_id **matchid)
>   {
> @@ -2381,16 +2388,38 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
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
> +	 * enumerated. Note that the enabled bit should not be set unless the
> +	 * present bit is set.
> +	 *
> +	 * However, limit this only to processor devices to reduce possible
> +	 * regressions with firmware.
> +	 */
> +	if (device->status.functional)
> +		return true;
> +
> +	if (!device->status.present)
> +		return false;
> +
> +	/*
> +	 * Fast path - if enabled is set, avoid the more expensive test to
> +	 * check whether this device is a processor.
> +	 */
> +	if (device->status.enabled)
> +		return true;
> +

It may be worthy to replace 'if enabled is set' with 'if the enabled bit is set',
to be consistent with the terminologies used in the above comments.

Apart from it, the patch itself looks good to me.

> +	return !acpi_device_is_processor(device);
>   }
>   EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>   

Thanks,
Gavin


