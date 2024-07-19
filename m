Return-Path: <linux-arch+bounces-5510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1FF9371AB
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 02:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EC11C20BDE
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD510F1;
	Fri, 19 Jul 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sn2I95Uu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD71388
	for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350396; cv=none; b=n9wrAPFpxP7RT8bFe8dID4RSRsEKDhyolvxNjqneWGd10zi0wWDfA7ggtd837PxmMdscliLnt7IY2ejw4nhLOfCQzwOm5nvaXGUdijR+8OA+UoHkaz+McWRk/60dREc2zsXGMkpxw0XANiI59GWVaF2J1q7nfIvgs2gJc5Vfpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350396; c=relaxed/simple;
	bh=RnoOrTDqYMwqmgyBL997j2WfnbhFEDox1ALgKaUqHuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ORvNU4HANLpLD8XA+yHhhLKtxg4nlcLmAqDFaIme/54S/u0F5K+vbhqVb7usafGSgLx8906LOpUqGoxqT3cT/vEM5tDSFKKERj5YjhGFNUWVnMOaEeSr0f5OyqaQBVwJN7rYUeKu42nGL4aaCy2n8JNQpmaa4IaHmybINCAzxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Sn2I95Uu; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3856b7be480so5455025ab.0
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 17:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721350394; x=1721955194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNAPVnBxs50FSqQ39oQ/X0NdsaUWEkhbtljgwA0dK+M=;
        b=Sn2I95UuUc1Z1VLFwESxfN4bG9UYWvNIkgHVpubVF5jr8Ky/BGxrk07t2KU0KYRexx
         dIpoWbrb3NAAkQE/Znd9/p9td5WtnBHMEhZGURIzSuvmwsCJCWcDYVGKoH4gnaj6l0Qr
         e8CEo8qM52EHLIZpdg3YNiAJAWQ2kl9g3l+IPTyJMenKelo6vl6HachLbX7hAgiy7lne
         oIKVV/HRruWdu6GHlUfYTuLNEccpVnw1Eyi8mEwTBG5Lnv3Wnzu1xuyKX4Cj+WLarnnK
         s3ZcA+ANdDSbV9aWfJQkLq6jD5cNE/Uxo0St8qfBgOJsW6sEd33p7CiAnfb3z68NUbRK
         CzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350394; x=1721955194;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNAPVnBxs50FSqQ39oQ/X0NdsaUWEkhbtljgwA0dK+M=;
        b=lm006PNmv86pWqv1Yfco1gGtHOI7YcUu9vYgjWf4b7q1MBnFSYXdXDp6BG5mjeBdkm
         qFzxYeRFycjJIU2G7xVQUFI6rXihYpEkW0zNzocInQXi+l+MpJLHKFSNOmZYhCc9DcP7
         utGlI6EVKkDRUIMnwxUGG95W3ILci7kuilH+zPV7QGOLak8vTGCNBpc4LCbjodzRG3Yh
         FEpQhdyS8jZK/GK2I7uxd2n3jWDCwTvd6IirRxomEr5T9A0t+SDGoyP2WHLihpViL+FT
         RWP/wwCGLsqDrU4V3ZHSgWjpnC0NIOR2VkxBnd4O2KmQ+ee7wif2YNSR1mH+5THPtjef
         av+A==
X-Forwarded-Encrypted: i=1; AJvYcCUUQrFso6uwzy/RndqVYeOQ257+R9cLr8AXMaMPGPKIPewyxrk8zljwu9mnV5rX8LXt7WcMLKNeCN+IWBd4gbF+KYeEG7Qoyu77gw==
X-Gm-Message-State: AOJu0Yzy29I6HPoGOCwInRApnPR8Svxx2P/srk8c4K+ajM5s55piQ/ko
	n7bV1us00G2gHjWDbPHY6fewBtOTzhAZtdOEM1THrwWCApgx/Q6sD/jJBhzLvcQ=
X-Google-Smtp-Source: AGHT+IF5soNWoBfxIJAzPM7ulE2ztXx3R64HiLhLbDOWs9lCmTj3XqnA7S+bNE2jbslzIWMskkLVPA==
X-Received: by 2002:a05:6e02:b2d:b0:396:4314:2bcf with SMTP id e9e14a558f8ab-39643142de5mr67747935ab.19.1721350394158;
        Thu, 18 Jul 2024 17:53:14 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-397f60fc088sm897415ab.50.2024.07.18.17.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 17:53:13 -0700 (PDT)
Message-ID: <da5ba38a-8848-439e-b80a-3d6584111a78@sifive.com>
Date: Thu, 18 Jul 2024 19:53:11 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] riscv: Add ISA extension parsing for Ziccrse
To: Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-10-alexghiti@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org
In-Reply-To: <20240717061957.140712-10-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2024-07-17 1:19 AM, Alexandre Ghiti wrote:
> Add support to parse the Ziccrse string in the riscv,isa string.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index f71ddd2ca163..863b9b7d4a4f 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -82,6 +82,7 @@
>  #define RISCV_ISA_EXT_ZACAS		73
>  #define RISCV_ISA_EXT_XANDESPMU		74
>  #define RISCV_ISA_EXT_ZABHA		75
> +#define RISCV_ISA_EXT_ZICCRSE		76
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c125d82c894b..93d8cc7e232c 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -306,6 +306,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>  	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
> +	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),

Please sort this entry per the comment at the beginning of the array.

Regards,
Samuel

>  };
>  
>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);


