Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA97A4016
	for <lists+linux-arch@lfdr.de>; Mon, 18 Sep 2023 06:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjIREjc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 00:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbjIREjO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 00:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB9A109
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2023 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695011901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzMmP6/zgsWd+5OqGjuqADEa5yIk7Th2EFtqn3v9+E0=;
        b=YZ1qvjdEm0eSkM8OsksU1athBdS4A8ZMkqq8uadfqQe4mrhDrumWgdiVfa3O5mEioAvAnO
        JDrBx+PBg652fX0X9t5uSjAlT4r3q16tOeYwHhyHZm7GWYfNDrqu9nu48G1qZtpy5lU9wa
        ZXQ6GVvQCf7Gbw/5KJqDdl+vGEaKjsM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-sM7SKV2_M9C-Y21jh5o2UA-1; Mon, 18 Sep 2023 00:38:20 -0400
X-MC-Unique: sM7SKV2_M9C-Y21jh5o2UA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c456e605easo13861505ad.2
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2023 21:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695011899; x=1695616699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzMmP6/zgsWd+5OqGjuqADEa5yIk7Th2EFtqn3v9+E0=;
        b=vAaK6nytQ5MURxqhq5tFkrlr2py7Hx+6XWhXALtEXZStqke2E27JQ2jGTnAxTirC69
         lR6Pfnp1m1dqGwOomWv4DcNteY4WlI2IKfiPhtjYK2HOv+xYC2CuOBSOmjjBHYIBNMNR
         Ztqet/IecX+Z4s0pj/5chxSfR5v1tVfPzNkYW03pv8atTHYv6+EYAo7AfThhQE3aEGMq
         s5TwoOkUDgAspBgCU8T3JDZzjgfT3UHC+AX3KL+vHQnpqAIwhUkvjFdGZH21tafg8oHG
         dSiU+011x7qZARRa0FAxJ5D2MvJYDAMbPbdJKMoM2UwQ32Tl8kBtx89G8J2kInC1gHY0
         hDeg==
X-Gm-Message-State: AOJu0YxzG9OzZrNtGcGmZq14emP7CGtnXbmq6qJNLY79fUmPBw/GM90B
        axOHlnp3IMXnIM4uUWXsy+zgsX0tvUH4hcA97rSG4UXPNyXYcPB9IZxO8YHQjCITbW2y06iJ07S
        BiHoBjTDWTMuKzkfGT/BFYw/vJxXQIQ==
X-Received: by 2002:a17:903:2783:b0:1c4:1089:887d with SMTP id jw3-20020a170903278300b001c41089887dmr7556765plb.3.1695011898760;
        Sun, 17 Sep 2023 21:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeSL0ocTJIKkzpLkWb/n99b9zzJCshhAa0pU0c6Fh0POTC0xKzg/5jZAqM1VM9TTL6+osffQ==
X-Received: by 2002:a17:903:2783:b0:1c4:1089:887d with SMTP id jw3-20020a170903278300b001c41089887dmr7556751plb.3.1695011898391;
        Sun, 17 Sep 2023 21:38:18 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b001bb9f104328sm7342815pls.146.2023.09.17.21.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 21:38:17 -0700 (PDT)
Message-ID: <7b5f8dda-93c9-6338-15a5-acf76910c35b@redhat.com>
Date:   Mon, 18 Sep 2023 14:38:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 14/35] ACPI: Only enumerate enabled (or functional)
 devices
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-15-james.morse@arm.com>
 <20230914132732.00006908@Huawei.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230914132732.00006908@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 9/14/23 22:27, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:38:02 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Today the ACPI enumeration code 'visits' all devices that are present.
>>
>> This is a problem for arm64, where CPUs are always present, but not
>> always enabled. When a device-check occurs because the firmware-policy
>> has changed and a CPU is now enabled, the following error occurs:
>> | acpi ACPI0007:48: Enumeration failure
>>
>> This is ultimately because acpi_dev_ready_for_enumeration() returns
>> true for a device that is not enabled. The ACPI Processor driver
>> will not register such CPUs as they are not 'decoding their resources'.
>>
>> Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
>> ACPI allows a device to be functional instead of maintaining the
>> present and enabled bit. Make this behaviour an explicit check with
>> a reference to the spec, and then check the present and enabled bits.
> 
> "and the" only applies if the functional route hasn't been followed
> "if not this case check the present and enabled bits."
> 
>> This is needed to avoid enumerating present && functional devices that
>> are not enabled.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>> If this change causes problems on deployed hardware, I suggest an
>> arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
>> acpi_dev_ready_for_enumeration() to only check the present bit.
>> ---
>>   drivers/acpi/device_pm.c    |  2 +-
>>   drivers/acpi/device_sysfs.c |  2 +-
>>   drivers/acpi/internal.h     |  1 -
>>   drivers/acpi/property.c     |  2 +-
>>   drivers/acpi/scan.c         | 23 +++++++++++++----------
>>   5 files changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>> index f007116a8427..76c38478a502 100644
>> --- a/drivers/acpi/device_pm.c
>> +++ b/drivers/acpi/device_pm.c
>> @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
>>   		return -EINVAL;
>>   
>>   	device->power.state = ACPI_STATE_UNKNOWN;
>> -	if (!acpi_device_is_present(device)) {
>> +	if (!acpi_dev_ready_for_enumeration(device)) {
>>   		device->flags.initialized = false;
>>   		return -ENXIO;
>>   	}
>> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
>> index b9bbf0746199..16e586d74aa2 100644
>> --- a/drivers/acpi/device_sysfs.c
>> +++ b/drivers/acpi/device_sysfs.c
>> @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
>>   	struct acpi_hardware_id *id;
>>   
>>   	/* Avoid unnecessarily loading modules for non present devices. */
>> -	if (!acpi_device_is_present(acpi_dev))
>> +	if (!acpi_dev_ready_for_enumeration(acpi_dev))
>>   		return 0;
>>   
>>   	/*
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 866c7c4ed233..a1b45e345bcc 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -107,7 +107,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
>>   void acpi_device_remove_files(struct acpi_device *dev);
>>   void acpi_device_add_finalize(struct acpi_device *device);
>>   void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
>> -bool acpi_device_is_present(const struct acpi_device *adev);
>>   bool acpi_device_is_battery(struct acpi_device *adev);
>>   bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>>   					const struct device *dev);
>> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
>> index 413e4fcadcaf..e03f00b98701 100644
>> --- a/drivers/acpi/property.c
>> +++ b/drivers/acpi/property.c
>> @@ -1418,7 +1418,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
>>   	if (!is_acpi_device_node(fwnode))
>>   		return false;
>>   
>> -	return acpi_device_is_present(to_acpi_device_node(fwnode));
>> +	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
>>   }
>>   
>>   static const void *
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 17ab875a7d4e..f898591ce05f 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
>>   	int error;
>>   
>>   	acpi_bus_get_status(adev);
>> -	if (acpi_device_is_present(adev)) {
>> +	if (acpi_dev_ready_for_enumeration(adev)) {
>>   		/*
>>   		 * This function is only called for device objects for which
>>   		 * matching scan handlers exist.  The only situation in which
>> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
>>   	int error;
>>   
>>   	acpi_bus_get_status(adev);
>> -	if (!acpi_device_is_present(adev)) {
>> +	if (!acpi_dev_ready_for_enumeration(adev)) {
>>   		acpi_scan_device_not_enumerated(adev);
>>   		return 0;
>>   	}
>> @@ -1908,11 +1908,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
>>   	return true;
>>   }
>>   
>> -bool acpi_device_is_present(const struct acpi_device *adev)
>> -{
>> -	return adev->status.present || adev->status.functional;
>> -}
>> -
>>   static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>>   				       const char *idstr,
>>   				       const struct acpi_device_id **matchid)
>> @@ -2375,16 +2370,24 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>>    * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for enumeration
>>    * @device: Pointer to the &struct acpi_device to check
>>    *
>> - * Check if the device is present and has no unmet dependencies.
>> + * Check if the device is functional or enabled and has no unmet dependencies.
>>    *
>> - * Return true if the device is ready for enumeratino. Otherwise, return false.
>> + * Return true if the device is ready for enumeration. Otherwise, return false.
>>    */
>>   bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>>   {
>>   	if (device->flags.honor_deps && device->dep_unmet)
>>   		return false;
>>   
>> -	return acpi_device_is_present(device);
>> +	/*
>> +	 * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
>> +	 * (!present && functional) for certain types of devices that should be
>> +	 * enumerated.
> 
> I'd call out the fact that enumeration isn't same as "device driver should be loaded"
> which is the thing that functional is supposed to indicate should not happen.
> 
>> +	 */
>> +	if (!device->status.present && !device->status.enabled)
> 
> In theory no need to check !enabled if !present
> "If bit [0] is cleared, then bit 1 must also be cleared (in other words, a device that is not present cannot be enabled)."
> We could report an ACPI bug if that's seen.  If that bug case is ignored this code can
> become the simpler.
> 
> 	if (device->status.present)
> 		return device->status_enabled;
> 	else
> 		return device->status.functional;
> 
> Or the following also valid here (as functional should be set for enabled present devices
> unless they failed diagnostics).
> 
> 	if (dev->status.functional)
> 		return true;
> 	return device->status.present && device->status.enabled;
> 
> On assumption we want to enumerate dead devices for debug purposes...
> 

I think it's worthy to include the words about the synchronization between present/enabled
bits into comments, outlined by Jonathan, to help readers to understand the code. Something
like below for the comments:

	/*
          * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
	 * (!present && functional) for certain types of devices that should be
          * enumerated. Note that the enabled bit can't be set until the present
          * bit is set.
          */

> 
>> +		return device->status.functional;
>> +
>> +	return device->status.present && device->status.enabled;
> 
> 
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>>   


Thanks,
Gavin

