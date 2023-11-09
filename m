Return-Path: <linux-arch+bounces-98-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5FB7E68CA
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B271C20443
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7E11198;
	Thu,  9 Nov 2023 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMokZfVx"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A0D2F0
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 10:51:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857EB26B1
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 02:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699527114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzXmFfn5zVQ8O2djRIzf4P/RBzxnLFE/MCnf13XN7x8=;
	b=BMokZfVxwLfSamvGK17HmKIHP+NAyAWAUiEi3VDiBXnUZMOtlekbjmxgYhO6AMsUN70XPr
	zNuK0ZSKc+zwMdNhSOSiBeRolZQS3vS3rBs0BSp+84tYO+64gmGoi5YgO4T2iRGmgy9D1Y
	pg5zFYcvQ2kj1zruKkykVi9XN8MwtrI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-jiBSy5pdP7qdmrxRQ4RwwA-1; Thu, 09 Nov 2023 05:51:53 -0500
X-MC-Unique: jiBSy5pdP7qdmrxRQ4RwwA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc47716c4eso1134935ad.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2023 02:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527112; x=1700131912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzXmFfn5zVQ8O2djRIzf4P/RBzxnLFE/MCnf13XN7x8=;
        b=JuwFQzUj2g+S3ae/N7/zMdpIu8C16qlu6f8SUfRPrXOK9cr8LcSzA3xA17jT2oABO2
         NIRylPonsAzEiwc/ew3eEqd934PxjohLv31J8Z18D7YviWc6u5TbgnG8fwozQMkAjT8B
         Au0nxz5CS/cK/AxfDtvRu3nBo57o6veasODtSeZz5BLFyQz/F86BsPLaAv0I6N0mnSWR
         NjTfY6P0lU9C5xwuuWXGnmSFnYkjhsnFdrIdM8R8daMmXwXgcsDZpQOy4WITujsQ0nIS
         k8nkQTlimxAIQfYRC39+Mk/7X5iF5Re3AV7DKgRxnleKuZiN4PeyCxe+0vGBHof7JQNJ
         LeXQ==
X-Gm-Message-State: AOJu0YzU+RA5fsgVTk2vI41hWjvYvSQbNYjxROgwxMG1rWDd8welxYuT
	KZB5K/EyWC0DT3FEWLGH3ARM8O3K5q+NSyK3SdSh6zkrowHTcddr025P3GE254nnCMgWRuJbJCM
	5bc4bAFEudoottbDhr2uS9g==
X-Received: by 2002:a17:902:e5c7:b0:1cc:27fa:1fb7 with SMTP id u7-20020a170902e5c700b001cc27fa1fb7mr4861877plf.5.1699527112442;
        Thu, 09 Nov 2023 02:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiDKE4c0Ju3XEU4qcUzBfLHE4odbtCyEmKR/OFqWPBbcxkvIL/TmgSbJ2a8W59JHM952t4Zg==
X-Received: by 2002:a17:902:e5c7:b0:1cc:27fa:1fb7 with SMTP id u7-20020a170902e5c700b001cc27fa1fb7mr4861848plf.5.1699527112117;
        Thu, 09 Nov 2023 02:51:52 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001b86dd825e7sm3245836plb.108.2023.11.09.02.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:51:51 -0800 (PST)
Message-ID: <17dd2b32-079a-101e-e5c1-0166d6dea3b9@redhat.com>
Date: Thu, 9 Nov 2023 18:51:44 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 08/22] drivers: base: Implement weak
 arch_unregister_cpu()
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
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLL-00CTxD-Gc@rmk-PC.armlinux.org.uk>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLL-00CTxD-Gc@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/23 18:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add arch_unregister_cpu() to allow the ACPI machinery to call
> unregister_cpu(). This is enough for arm64, riscv and loongarch, but
> needs to be overridden by x86 and ia64 who need to do more work.
> 
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> Changes since v1:
>   * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
> Changes since RFC v2:
>   * Move earlier in the series
> ---
>   drivers/base/cpu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 579064fda97b..58bb86091b34 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
>   {
>   	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
>   }
> -#endif
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +void __weak arch_unregister_cpu(int num)
> +{
> +	unregister_cpu(&per_cpu(cpu_devices, num));
> +}
> +#endif /* CONFIG_HOTPLUG_CPU */
> +#endif /* CONFIG_GENERIC_CPU_DEVICES */
>   
>   static void __init cpu_dev_register_generic(void)
>   {

-- 
Shaoqin


