Return-Path: <linux-arch+bounces-109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7F47E7810
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 04:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B64F1C20C87
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 03:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F3715B3;
	Fri, 10 Nov 2023 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFdj44xq"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E27C15B9
	for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2023 03:35:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672334682
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 19:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699587350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WQrDz3BrUoKfY/uV/CbjAH9j1WTdOdEvBMB5Ml9tk=;
	b=OFdj44xqUo5zv+73SqGjbHOMu1b1K3H8FyC6puIbWDHsm4CvChgrdqO7JOijDpUoekpjU8
	EsxADa76GP+2mkITBbLeSe2JWj31fG1F7HiQWtukjcCR1ZEyDZnCOERsuUBZpnog8UzT+b
	nxLPEPs7z0lcx3qtfifJyPpi7rakuPE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-0o7KHpfYMcim6W4UkNHMCA-1; Thu, 09 Nov 2023 22:35:48 -0500
X-MC-Unique: 0o7KHpfYMcim6W4UkNHMCA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ce29f5dc6cso41733a34.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2023 19:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699587348; x=1700192148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8WQrDz3BrUoKfY/uV/CbjAH9j1WTdOdEvBMB5Ml9tk=;
        b=Aff56xkNJEzrRIhUHekDyCQCvEkOyplhSwnZ9k0d45ngrNYS4tJi/o7ZBeEzz3Veur
         76pQq0XLG/R928zNxC0yCLzSahR4HhJTzze0gdog+8aKHoob1x+2UyHHT9xh6GOmBZMA
         SbdG59KiGatO/ezAzX1ueLglFdbu3qGGH5a6eC80Ee8t9sHTDL6eb/SqGKX+mjN5I89j
         yXcYK0+Vohgh90zLTZwQjahGBOrkz3u9L2ghTH+1Vx+5EG/uO7aTXMxjFlG0z2zrK6vr
         kgCoa7lyXZsDNIs5X6/R+nfnT8xg3WwW/7JV98IDxjka4/8ZZ0g5dVQ03nvJnahHBUKu
         DWYA==
X-Gm-Message-State: AOJu0Yy2/IXuPZxFwCDGvumvMVwkXs+zEWr/iFsLw+eUpxlNz/c8AUhC
	uPsXO0eW9X13t5cY3sQWnDymBVlijxczDjpkntPBQceiyxwv8Pq9DUbocFID1RyEABHMjX6m7gV
	flZo94fgJ3vbaJWP8q6bFsw==
X-Received: by 2002:a05:6870:468d:b0:1d6:4c63:7ba9 with SMTP id a13-20020a056870468d00b001d64c637ba9mr8173660oap.3.1699587348163;
        Thu, 09 Nov 2023 19:35:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0g1U5gqarx8cH0olNuMl9/UtKi0J1uyvc150ksgK2KoqY7BLV3KVCaBNiaCGerDe5ChRrSA==
X-Received: by 2002:a05:6870:468d:b0:1d6:4c63:7ba9 with SMTP id a13-20020a056870468d00b001d64c637ba9mr8173626oap.3.1699587347881;
        Thu, 09 Nov 2023 19:35:47 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gu6-20020a056a004e4600b0068fe7e07190sm11450826pfb.3.2023.11.09.19.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 19:35:47 -0800 (PST)
Message-ID: <534c2679-6a2b-455f-d60c-2f80207ef118@redhat.com>
Date: Fri, 10 Nov 2023 11:35:40 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 12/22] drivers: base: Print a warning instead of
 panic() when register_cpu() fails
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
 <E1r0JLg-00CTxd-31@rmk-PC.armlinux.org.uk>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLg-00CTxd-31@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/23 18:30, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> loongarch, mips, parisc, riscv and sh all print a warning if
> register_cpu() returns an error. Architectures that use
> GENERIC_CPU_DEVICES call panic() instead.
> 
> Errors in this path indicate something is wrong with the firmware
> description of the platform, but the kernel is able to keep running.
> 
> Downgrade this to a warning to make it easier to debug this issue.
> 
> This will allow architectures that switching over to GENERIC_CPU_DEVICES
> to drop their warning, but keep the existing behaviour.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   drivers/base/cpu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 221ffbeb1c9b..82b6a76125f5 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -551,14 +551,15 @@ void __weak arch_unregister_cpu(int num)
>   
>   static void __init cpu_dev_register_generic(void)
>   {
> -	int i;
> +	int i, ret;
>   
>   	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
>   		return;
>   
>   	for_each_present_cpu(i) {
> -		if (arch_register_cpu(i))
> -			panic("Failed to register CPU device");
> +		ret = arch_register_cpu(i);
> +		if (ret)
> +			pr_warn("register_cpu %d failed (%d)\n", i, ret);
>   	}
>   }
>   

-- 
Shaoqin


