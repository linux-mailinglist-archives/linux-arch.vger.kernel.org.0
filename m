Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1197A5869
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 06:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjISEcC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 00:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjISEcB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 00:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B610E
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 21:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695097875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tujQrNvl4PrxqMiJg4NQJAeEUSLfcAURkaot9IyEWb0=;
        b=hlaOSo41osQ3Fwnre2sp51uPxy8BAq0AlrPPSeBnAlDgfJfu4wzb80F8MS2bgPWXRS1Zun
        iocSP/YUy7xNk14eBODhRmxfdk09xN8EhMgCdjHk0MMPIa/pJM6N5il8XXuqqruR3TEjnv
        A9B0Pb09jbPx83hI5sv9+Md3e0eRyNU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-jEp-aYroP5SyRjXfNJ3DNw-1; Tue, 19 Sep 2023 00:31:13 -0400
X-MC-Unique: jEp-aYroP5SyRjXfNJ3DNw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c4103c26ccso51062675ad.3
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 21:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695097872; x=1695702672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tujQrNvl4PrxqMiJg4NQJAeEUSLfcAURkaot9IyEWb0=;
        b=i9mEe2JR9PTigUXP4ncwCbmAVMC3gCfXxoTSQZvla+vCxO0BRkx5LIQ2zZR7NsYgAR
         LBqiv59JRHQwF2O4XD1W+3cgupyaUA3E1CRzKEgx8q5tFReqkLdjwkyQrFZMswwCjU4P
         YgtKDOMnKYCC7idbFxuohMWT6sxyQ4e5KKDdUW0gxQEdXILx3gtfbSAWgifxaQoCIHRF
         vhEbCwpBnE3G3znk3osf+LucvO4k+wH6SKlGosf53wXyzhUAW9q/p/oS4OGjjGdHGOJ/
         Rgl1JB6ga3qWegsHltHhL2VmfDxU344EuqcmQrNd0LpMrrbC7nPXr0Xj83LDr48BM+w3
         EoHg==
X-Gm-Message-State: AOJu0Yyvzolr6LnitgF40IwmP7gNqTZsyYG3gDksr4aoWrqffn/8y7fJ
        Z8V0G3tDfsnqZg88FDiP058wnMIrxvt6igHPrUif5Smlr2KA545Ryp9AXPHUFyG9I379pf3R9C6
        gQKlUU8YtNi1sVhNfozl8yw==
X-Received: by 2002:a17:902:7e8a:b0:1c1:ed61:e058 with SMTP id z10-20020a1709027e8a00b001c1ed61e058mr9604508pla.16.1695097872165;
        Mon, 18 Sep 2023 21:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0jjbVQCYx0HrEgkOAsu8m5j5UqVtkKvnOrxhTmEgF6XxUE6+/pZbGU0AbafmkGXTMtnwJTA==
X-Received: by 2002:a17:902:7e8a:b0:1c1:ed61:e058 with SMTP id z10-20020a1709027e8a00b001c1ed61e058mr9604496pla.16.1695097871847;
        Mon, 18 Sep 2023 21:31:11 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902b60700b001b9f032bb3dsm9059276pls.3.2023.09.18.21.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 21:31:11 -0700 (PDT)
Message-ID: <89a36ddc-5354-5ee0-2066-11a8d4ae1806@redhat.com>
Date:   Tue, 19 Sep 2023 14:31:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 31/35] arm64: psci: Ignore DENIED CPUs
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
 <20230913163823.7880-32-james.morse@arm.com>
 <20230914170155.000065cf@Huawei.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230914170155.000065cf@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/15/23 02:01, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:38:19 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> When a CPU is marked as disabled, but online capable in the MADT, PSCI
>> applies some firmware policy to control when it can be brought online.
>> PSCI returns DENIED to a CPU_ON request if this is not currently
>> permitted. The OS can learn the current policy from the _STA enabled bit.
>>
>> Handle the PSCI DENIED return code gracefully instead of printing an
>> error.
> 
> Specification reference would be good particularly as it's only been
> added as a possibility fairly recently.
> 

https://developer.arm.com/documentation/den0022/f/?lang=en   page-58

It seems DENIED is the best matched indicator.

>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> [ morse: Rewrote commit message ]
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>>   arch/arm64/kernel/psci.c     | 2 +-
>>   arch/arm64/kernel/smp.c      | 3 ++-
>>   drivers/firmware/psci/psci.c | 2 ++
>>   3 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index 29a8e444db83..4fcc0cdd757b 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
>>   {
>>   	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
>>   	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
>> -	if (err)
>> +	if (err && err != -EPROBE_DEFER)
> 
> Hmm. EPROBE_DEFER has very specific meaning around driver requesting a retry
> when some other bit of the system has finished booting.
> I'm not sure it's a good idea for this use case.  Maybe just keep to EPERM
> as psci_to_linux_errno() will return anyway.  Seems valid to me, or
> is the requirement to use EPROBE_DEFER coming from further up the stack?
> 

I agree with Jonathan that -EPERM from psci_to_linux_errno(DENIED) is
good enough here. Actually, I think we need to bail from bringing up
the CPU once error is raised on psci_ops.cpu_on() and avoid reporting
it as error with help of -EPROBE_DEFER. -EPERM can serve the same
purpose.

> 
> 
>>   		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
>>   
>>   	return err;
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 8c8f55721786..e958db987665 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -124,7 +124,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>   	/* Now bring the CPU into our world */
>>   	ret = boot_secondary(cpu, idle);
>>   	if (ret) {
>> -		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>> +		if (ret != -EPROBE_DEFER)
>> +			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>>   		return ret;
>>   	}
>>   
>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>> index d9629ff87861..f7ab3fed3528 100644
>> --- a/drivers/firmware/psci/psci.c
>> +++ b/drivers/firmware/psci/psci.c
>> @@ -218,6 +218,8 @@ static int __psci_cpu_on(u32 fn, unsigned long cpuid, unsigned long entry_point)
>>   	int err;
>>   
>>   	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
>> +	if (err == PSCI_RET_DENIED)
>> +		return -EPROBE_DEFER;
>>   	return psci_to_linux_errno(err);
>>   }
>>   

Thanks,
Gavin

