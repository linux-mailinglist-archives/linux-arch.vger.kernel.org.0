Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22B7A405F
	for <lists+linux-arch@lfdr.de>; Mon, 18 Sep 2023 07:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbjIRFNm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 01:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbjIRFNK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 01:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033910F
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2023 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695013937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvD4w7PAsOCgYRxHcY6j9ap1d1nMri/tShexuoBxwd4=;
        b=XiXQe0Tq2Q7TzAKV8sGV5Gt4DLnRaGOD+pew9f8/0l/9wA2cJbOERJQY9++spBTaq6/zso
        cCSSTWbyJ8+YdSeYSQoU9exUcTgI8vra3HkLT9wfZAwSxPGWhJ7tXgvdoHN3P+t4liydbc
        9W9+6k790ArsLwBBdE1RQTfOYD9XC6Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-O5blaao3OpedGQHBSd_FIg-1; Mon, 18 Sep 2023 01:12:15 -0400
X-MC-Unique: O5blaao3OpedGQHBSd_FIg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c4375c1406so18555475ad.1
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2023 22:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695013935; x=1695618735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvD4w7PAsOCgYRxHcY6j9ap1d1nMri/tShexuoBxwd4=;
        b=Q/LPsrMVm+ayEwb6LiwLgCBbSh0VJGB0IfSaiP3KlEI07oqo0JSqpQXoUvkKRb/Cpv
         5XgFaT9b4MRou0EzOk+Hz95lC7Bijrj0NWeMX3DtDt9/Gv4Vygcpq29Q2FbqLIYxpwid
         PwoT3Yz/XkHKWtLLF4EUByGdp/Oxefsat7u6Vu/l10kUP7fOdSesi6uaujoLfszJo17s
         pthcwUnTCqoyUuaTwxXkBYdrHnFrxdA9fykg/G/SwDDPW4iF+LKm04c688UnEqOzbYrT
         9Yv/6G9ip/KJFLpXgUdb8FPNfGcY2Nz0ZrFxUm092au2nHzc6PdKgVTZ9DNuDQwHmOY6
         bV+A==
X-Gm-Message-State: AOJu0YytEtScqK9dtapHHSqagxdU/p93CxUPXkdTHtXeFsDMgJY97Dnl
        vs4ihRjmhtThx3zN+gsejOWdcBGq9QVtyoUgYhDfHPxmQBvmfkHAMmXLwFfvNZwdDWuGjHTvNOW
        g0jfnlzgzlw6k3mZUlZaeeg==
X-Received: by 2002:a17:902:eaca:b0:1c4:7c4:b2e9 with SMTP id p10-20020a170902eaca00b001c407c4b2e9mr6684109pld.43.1695013934903;
        Sun, 17 Sep 2023 22:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/7pnXIEKKH9Y4xbdbZZMMMlJPYbU0PFmQT4cuwBEhJkBJkFtdh/KKkgvjoRXAdFFzPtKhhA==
X-Received: by 2002:a17:902:eaca:b0:1c4:7c4:b2e9 with SMTP id p10-20020a170902eaca00b001c407c4b2e9mr6684091pld.43.1695013934621;
        Sun, 17 Sep 2023 22:12:14 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b001b80d399730sm3243326pls.242.2023.09.17.22.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 22:12:14 -0700 (PDT)
Message-ID: <82ce8528-49ae-3937-4020-0666fe416c0a@redhat.com>
Date:   Mon, 18 Sep 2023 15:12:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 16/35] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
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
 <20230913163823.7880-17-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-17-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 9/14/23 02:38, James Morse wrote:
> ACPI has two descriptions of CPUs, one in the MADT/APIC table, the other
> in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
> says "Each processor in the system must be declared in the ACPI
> namespace"). Having two descriptions allows firmware authors to get
> this wrong.
> 
> If CPUs are described in the MADT/APIC, they will be brought online
> early during boot. Once the register_cpu() calls are moved to ACPI,
> they will be based on the DSDT description of the CPUs. When CPUs are
> missing from the DSDT description, they will end up online, but not
> registered.
> 
> Add a helper that runs after acpi_init() has completed to register
> CPUs that are online, but weren't found in the DSDT. Any CPU that
> is registered by this code triggers a firmware-bug warning and kernel
> taint.
> 
> Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
> is configured.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/acpi_processor.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index b4bde78121bb..a01e315aa16a 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -790,6 +790,25 @@ void __init acpi_processor_init(void)
>   	acpi_pcc_cpufreq_init();
>   }
>   
> +static int __init acpi_processor_register_missing_cpus(void)
> +{
> +	int cpu;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	for_each_online_cpu(cpu) {
> +		if (!get_cpu_device(cpu)) {
> +			pr_err_once(FW_BUG "CPU %u has no ACPI namespace description!\n", cpu);
> +			add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +			arch_register_cpu(cpu);
> +		}
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall_sync(acpi_processor_register_missing_cpus);
> +
>   #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
>   /**
>    * acpi_processor_claim_cst_control - Request _CST control from the platform.

