Return-Path: <linux-arch+bounces-96-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D447E6785
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 11:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F141C20A86
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD167182C2;
	Thu,  9 Nov 2023 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fc9VgENE"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB911802E
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 10:13:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F182D72
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 02:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699524819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rYhpoB4lYmS4MLIzZUo4ZMf6R8bUZVPeYV6RdLZieo=;
	b=Fc9VgENEm2PmhajBqiD0Bt6akMJUrQf1W7VLT/FaQ2jffXs7/DpjVkYMiXfSeTSlZsUIpD
	XOa9icpjTB9LBy9OznyZG270mCoQnl3xVDwvdPu91coidzV/RW+RXB6vn1cSlu2DBIsRz2
	cC5DVn5IKgsfsh8erOnphvYnwKZlQ3Y=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Je5fXkCTPQiCv6B7dtsAXA-1; Thu, 09 Nov 2023 05:13:37 -0500
X-MC-Unique: Je5fXkCTPQiCv6B7dtsAXA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2800be2d781so188007a91.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2023 02:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524814; x=1700129614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rYhpoB4lYmS4MLIzZUo4ZMf6R8bUZVPeYV6RdLZieo=;
        b=RePBtyqY3M66cT4hv9+OPOaU1B3EFYRF/1xirhXF+3kTtEUx9ROutm4QJApe4sOdSd
         c3fZOVK/O2/3DCbKYXa0yNyMhz3wDtSKH5MJVhpRAZtkoOxXfgxp4xe2KmFyU5wWZH31
         u9AL8DyjfllkzhpbguPWSD01ecCNScBWI8OKJdLKuTHHuip2LTKtsy0hFX6jhjJvrIKD
         peblqRrK2sfw7YQWUTBPKdM1yHbhL6WHIFzhYbsy1Ruo0ESC46TuPEc4k893uAbliz/A
         IAoU3F4w+BctN3474e0QefihXp5fbzj4Jb/OX8+FF9PsYmRDIJOo/kozqesfDEQD/NBO
         ef7A==
X-Gm-Message-State: AOJu0YxaZ4V0iM7CYPWsM3RhsD7AsnVXy/I6KXMfVeD5oR5whPNSVcxw
	AAxUy9g2wrqpJYMNxd7opp1V3Pl3x44usOyptOg2U/bJfLyqqIei8TiNmIhp4JRaevDYbREbsHJ
	6gqF4YNsML7vYj8xoeCRvog==
X-Received: by 2002:a17:903:120e:b0:1cc:ebe:5547 with SMTP id l14-20020a170903120e00b001cc0ebe5547mr5043356plh.0.1699524813768;
        Thu, 09 Nov 2023 02:13:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMYccyPUYXdRLbiWAt/Rrr2lff8DkVfjHrlmnPr9rVOEThxcSXfzeRdAMTZ0+vEY8CCgW5xw==
X-Received: by 2002:a17:903:120e:b0:1cc:ebe:5547 with SMTP id l14-20020a170903120e00b001cc0ebe5547mr5043330plh.0.1699524813447;
        Thu, 09 Nov 2023 02:13:33 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001c60a2b5c61sm3165370plf.134.2023.11.09.02.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:13:33 -0800 (PST)
Message-ID: <6341a77d-ba42-3f3a-4a2a-b598fb5c0e20@redhat.com>
Date: Thu, 9 Nov 2023 18:13:26 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 07/22] drivers: base: Allow parts of
 GENERIC_CPU_DEVICES to be overridden
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLG-00CTx8-CG@rmk-PC.armlinux.org.uk>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLG-00CTx8-CG@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/23 18:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Architectures often have extra per-cpu work that needs doing
> before a CPU is registered, often to determine if a CPU is
> hotpluggable.
> 
> To allow the ACPI architectures to use GENERIC_CPU_DEVICES, move
> the cpu_register() call into arch_register_cpu(), which is made __weak
> so architectures with extra work can override it.
> This aligns with the way x86, ia64 and loongarch register hotplug CPUs
> when they become present.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> Changes since RFC:
>   * Dropped __init from x86/ia64 arch_register_cpu()
> Changes since RFC v2:
>   * Dropped unnecessary Loongarch asm/cpu.h changes
> ---
>   drivers/base/cpu.c  | 14 ++++++++++----
>   include/linux/cpu.h |  4 ++++
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 34b48f660b6b..579064fda97b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -525,19 +525,25 @@ bool cpu_is_hotpluggable(unsigned int cpu)
>   EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
>   
>   #ifdef CONFIG_GENERIC_CPU_DEVICES
> -static DEFINE_PER_CPU(struct cpu, cpu_devices);
> +DEFINE_PER_CPU(struct cpu, cpu_devices);
> +
> +int __weak arch_register_cpu(int cpu)
> +{
> +	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
> +}
>   #endif
>   
>   static void __init cpu_dev_register_generic(void)
>   {
> -#ifdef CONFIG_GENERIC_CPU_DEVICES
>   	int i;
>   
> +	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> +		return;
> +
>   	for_each_present_cpu(i) {
> -		if (register_cpu(&per_cpu(cpu_devices, i), i))
> +		if (arch_register_cpu(i))
>   			panic("Failed to register CPU device");
>   	}
> -#endif
>   }
>   
>   #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index fc8094419084..1e982d63eae8 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -88,6 +88,10 @@ extern ssize_t arch_cpu_probe(const char *, size_t);
>   extern ssize_t arch_cpu_release(const char *, size_t);
>   #endif
>   
> +#ifdef CONFIG_GENERIC_CPU_DEVICES
> +DECLARE_PER_CPU(struct cpu, cpu_devices);
> +#endif
> +
>   /*
>    * These states are not related to the core CPU hotplug mechanism. They are
>    * used by various (sub)architectures to track internal state

-- 
Shaoqin


