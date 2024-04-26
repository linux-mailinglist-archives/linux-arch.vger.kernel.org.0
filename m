Return-Path: <linux-arch+bounces-3990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273778B343D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22F2287D35
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644F13F42E;
	Fri, 26 Apr 2024 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAJFlKQU"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872713F425
	for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124186; cv=none; b=b9b3jlZoRa1SYBi4QTT3P0utRMJOPOPZLFsbmxMkCxf440C2WTDIW2PdBu1swxz+sC/YAUxX+BSYb8Af0g9ZTi9dRDcyYeo5fedb6Y26faLgZaPZVwsl48gcnJw6FhylVdlTObvNpnRKZBt2eKEt8ABUS+sCJHnGTQIwxrmJzjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124186; c=relaxed/simple;
	bh=Y3jENvyu7fKPEdBvKAbLTUiG9vM1ldEliX0y6fpkZxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYbW+hzwQ2XAC3JABjecvAJBTT2lwsmOuJAPdLsWaiwze2XPBfA9dH+G6kHWw7OFk/9uhzWK6k+e3KZzUHhoOjCV4p0LKHtd5g3WDTRb1B6ZQ5E+/Q4cO/PQDhcRz6KVzjnE5bxZ5mIeWF5cwCHvbEHY75sPV0UCgsQpqXhwFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAJFlKQU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714124184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qExq3Nq0hUqrQo4qRdmB4OoXaEaQNPNwgb/ED5v1FgA=;
	b=NAJFlKQUOtD8Xyw1KldI5jzjzoZPg4rSl8CObnjHlCwVsIoCXxa0/ew5Gbg5KYmImMU/OX
	5A4afiBufnudk7BM787q+EKyayAs7SIr+9PxwW8gk7b8KXBZbK6BMkLGKUE2bwqwP1K6fx
	/w93e8BoyRtaGATLoprfd+dpzsnjrwE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-ymLuJ2JQPiOo-zojfQj0Dg-1; Fri, 26 Apr 2024 05:36:22 -0400
X-MC-Unique: ymLuJ2JQPiOo-zojfQj0Dg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e2ae0153e2so20881985ad.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 02:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124181; x=1714728981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qExq3Nq0hUqrQo4qRdmB4OoXaEaQNPNwgb/ED5v1FgA=;
        b=HbNOnWuFxc88qmijBWUPJyGf9RmQHI4akueauQQuoNAM6tLwl0FUZwLGF6MknZzO40
         p6i53DijuF/vBLN4+JD9xIQURn+bh/r6A1IA7CikdJNVG4XW6VEXJAT23Z4AXSXH9wVz
         l5ZOA4uKdwDfIN2Owz/4AW0VzEAZ1BHksYz4uJfIhDB4KEVn3Lwka9P/MMSPxzdI2gUo
         vSzVPridybDtPlT8HGmPnpuZU5/9Ho24fJ2w78dppyUPJljNdf5AvgxTOoSnNKBCKZFS
         QPvFdstxltCERwEQgg1lMGR5EkfqpmUa1WlroaGvfffR2KbhoVh/FHW6c/BjgJp5sV2k
         +ABw==
X-Forwarded-Encrypted: i=1; AJvYcCVRwpYgoCWRkXLRj27yQQghFtx8+khS9L02TQ4x+8LEUfxaL+8qC1rgfeabG5s/HOXv7W28IlgTqr3v2BY5F1s3x6H6YJOCpEKOpA==
X-Gm-Message-State: AOJu0YwEepnT9eAxcEENf1hyts96FR9JdHNelKMMzCbxP+lxVRp2rwPL
	qC5muAggjc24nUwlgSzVLSP1a3j3jLx3L9bT8O+qV97m63zD4oUPQNAq9UsxzDEIgZ5AEaHARcy
	iyma2VtiDpxEV5+aibfmnKKGtTv9/pdaoELotOLgcDRjVFONZONAm4ntrTs8=
X-Received: by 2002:a17:902:e743:b0:1e9:13eb:9082 with SMTP id p3-20020a170902e74300b001e913eb9082mr2650396plf.0.1714124181178;
        Fri, 26 Apr 2024 02:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+kB8MtLlnQihsmOFiAsNTY4H/hnM+mV/Y1YJ7mzin6YbOqhwE6PJBBN0k7jOFD1Z7EzpxaA==
X-Received: by 2002:a17:902:e743:b0:1e9:13eb:9082 with SMTP id p3-20020a170902e74300b001e913eb9082mr2650377plf.0.1714124180801;
        Fri, 26 Apr 2024 02:36:20 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001e556734814sm15079254plf.134.2024.04.26.02.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:36:20 -0700 (PDT)
Message-ID: <e4628e32-8e76-4db4-9c85-b1246186f3be@redhat.com>
Date: Fri, 26 Apr 2024 19:36:10 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/16] arm64: psci: Ignore DENIED CPUs
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-13-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-13-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:54, Jonathan Cameron wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a CPU is marked as disabled, but online capable in the MADT, PSCI
> applies some firmware policy to control when it can be brought online.
> PSCI returns DENIED to a CPU_ON request if this is not currently
> permitted. The OS can learn the current policy from the _STA enabled bit.
> 
> Handle the PSCI DENIED return code gracefully instead of printing an
> error.
> 
> See https://developer.arm.com/documentation/den0022/f/?lang=en page 58.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [ morse: Rewrote commit message ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: No change
> ---
>   arch/arm64/kernel/psci.c | 2 +-
>   arch/arm64/kernel/smp.c  | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 29a8e444db83..fabd732d0a2d 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
>   {
>   	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
>   	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
> -	if (err)
> +	if (err && err != -EPERM)
>   		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
>   
>   	return err;
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4ced34f62dab..dc0e0b3ec2d4 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -132,7 +132,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>   	/* Now bring the CPU into our world */
>   	ret = boot_secondary(cpu, idle);
>   	if (ret) {
> -		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
> +		if (ret != -EPERM)
> +			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>   		return ret;
>   	}
>   

The changes in smp.c are based the assumption that PSCI is the only backend, which
isn't true. So we probably need move this error message to specific backend, which
could be PSCI, ACPI parking protocol, or smp_spin_table.

Thanks,
Gavin


