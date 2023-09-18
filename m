Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AEA7A4049
	for <lists+linux-arch@lfdr.de>; Mon, 18 Sep 2023 07:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjIRFEG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbjIRFD5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 01:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F80611C
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2023 22:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695013387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCDoXZnQJiBgGjXOi0ciKhKqeO4OfqPdXpxnEdvp7mI=;
        b=AV4KHs5YbFYMHe/6ShsgeXmv3+JXfTyjpFXM0/0I4go/70Jluhl5XxxMREiOMmwePL0JrQ
        1Cw4lPTte/eZrRhQXCrhQTFDo0R4DK4GbKxLb30+ZHbdyEAONkXqzBSmY84r84YhP2JthG
        euNlLc0SYjoeTHnIdKXuF1a9wzz39uM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-cKp3H30cPyqFx0lcqNNbWg-1; Mon, 18 Sep 2023 01:03:02 -0400
X-MC-Unique: cKp3H30cPyqFx0lcqNNbWg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68fc99d05aeso4080983b3a.2
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2023 22:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695013381; x=1695618181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCDoXZnQJiBgGjXOi0ciKhKqeO4OfqPdXpxnEdvp7mI=;
        b=FW0ftbwICyVxhp+EPNu8qwtGCjiicytbhp4xl7rQtIXHKcPzrRPYmumkg11uUC9W3j
         UgI4bD86QYGFDT+6g/lZfopGwKWIqpvnI8LwFOYr1cZKwicKej5nq7YysafSRW0ckaoF
         uvV9X+Ei7KB8qthTG9ux0Xc/bN9ww11Ze2hKqOngqL9238IvO02mgf9ooigrNK7uu0ak
         X8nWWeQ3bocqd+9KuWVrsZ5Qj3frStDi/sRD62AHNQbplhiP7Xlb2MCW8lMYuYy7xyaX
         XvDafWMlWZZPBb639dXSrzyPjDT6otnYLB2KbBKv/fkyS0VZWV2qflc/H8yiA6Idjw4Q
         xBKA==
X-Gm-Message-State: AOJu0YyUz55Oxkm9DSp+Z9xTraqErYIoJVzI4h6VOv+VmU1F1FEsSggB
        vB9J3ny38YpCnaZEnaoDQ3WL+482p9jXZEiXJavtG0QpAEPJGuHLyf8VO8oLOvnlHpKb4u+GIDI
        +VIsVlWt0RdzOmBkoILjqlg==
X-Received: by 2002:a05:6a00:2344:b0:68e:43ed:d30b with SMTP id j4-20020a056a00234400b0068e43edd30bmr6879610pfj.21.1695013381113;
        Sun, 17 Sep 2023 22:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqmnfE9QFPe9E5tdKFUUF/pg2T2yxaduIzlP4FnKDLuVWyov/hE0tCEtGqZQwTLT17gzDFFw==
X-Received: by 2002:a05:6a00:2344:b0:68e:43ed:d30b with SMTP id j4-20020a056a00234400b0068e43edd30bmr6879587pfj.21.1695013380748;
        Sun, 17 Sep 2023 22:03:00 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id j26-20020aa783da000000b00687a4b70d1esm6322062pfn.218.2023.09.17.22.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 22:03:00 -0700 (PDT)
Message-ID: <50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.com>
Date:   Mon, 18 Sep 2023 15:02:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 15/35] ACPI: processor: Add support for processors
 described as container packages
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
 <20230913163823.7880-16-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-16-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 9/14/23 02:38, James Morse wrote:
> ACPI has two ways of describing processors in the DSDT. Either as a device
> object with HID ACPI0007, or as a type 'C' package inside a Processor
> Container. The ACPI processor driver probes CPUs described as devices, but
> not those described as packages.
> 
> Duplicate descriptions are not allowed, the ACPI processor driver already
> parses the UID from both devices and containers. acpi_processor_get_info()
> returns an error if the UID exists twice in the DSDT.
> 
> The missing probe for CPUs described as packages creates a problem for
> moving the cpu_register() calls into the acpi_processor driver, as CPUs
> described like this don't get registered, leading to errors from other
> subsystems when they try to add new sysfs entries to the CPU node.
> (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> 
> To fix this, parse the processor container and call acpi_processor_add()
> for each processor that is discovered like this. The processor container
> handler is added with acpi_scan_add_handler(), so no detach call will
> arrive.
> 
> Qemu TCG describes CPUs using packages in a processor container.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/acpi_processor.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 

I don't understand the last sentence of the commit log. QEMU
always have "ACPI0007" for the processor devices.

#define ACPI_PROCESSOR_DEVICE_HID      "ACPI0007"
#define ACPI_PROCESSOR_OBJECT_HID      "LNXCPU"

[gshan@gshan q]$ git grep ACPI0007
hw/acpi/cpu.c:                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
hw/arm/virt-acpi-build.c:        aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
hw/riscv/virt-acpi-build.c:            aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
[gshan@gshan q]$ git grep LNXCPU

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c0839bcf78c1..b4bde78121bb 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -625,9 +625,31 @@ static struct acpi_scan_handler processor_handler = {
>   	},
>   };
>   
> +static acpi_status acpi_processor_container_walk(acpi_handle handle,
> +						 u32 lvl,
> +						 void *context,
> +						 void **rv)
> +{
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	adev = acpi_get_acpi_dev(handle);
> +	if (!adev)
> +		return AE_ERROR;
> +
> +	status = acpi_processor_add(adev, &processor_device_ids[0]);
> +	acpi_put_acpi_dev(adev);
> +
> +	return status;
> +}
> +
>   static int acpi_processor_container_attach(struct acpi_device *dev,
>   					   const struct acpi_device_id *id)
>   {
> +	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, dev->handle,
> +			    ACPI_UINT32_MAX, acpi_processor_container_walk,
> +			    NULL, NULL, NULL);
> +
>   	return 1;
>   }
>   

Thanks,
Gavin

