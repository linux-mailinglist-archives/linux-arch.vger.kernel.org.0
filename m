Return-Path: <linux-arch+bounces-5951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315AF9466BD
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 03:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638F81C2101B
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 01:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71BFE556;
	Sat,  3 Aug 2024 01:22:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDEF9EB;
	Sat,  3 Aug 2024 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722648127; cv=none; b=gdGKUCTHAYhJod7SWCXji9pSk7utUK90jLhh61rEMtHVngQoJBMcIYZJKdGhdq3XKfd/uLRIyBxKFrbQw188t9oKpGk8v90IYew3I19+iyswgbb0JuW8PFaBPW7Vs5oYcroM8a69dVxlivonKvzrvWv5NEwxsYy4yNqK6/XSmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722648127; c=relaxed/simple;
	bh=QlCsaxkmkBO+k1bZHDH4/wNRZHvnphdyZIE2BlUfQE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esJvtFqF+9xWuawM2JCH9qy4/5K9IjVUUFqnAeNFdQA+nl3QHPRpIxRiHdOWWTTXu2UqcoBq+bkwHGLxRB514HMEAMFXkqzY54P9PjWvYIFTQtyoOcxY6OwGYSMcDVSyHr4JOMkaR80jOhcUQwcp6EUSoqCozix86D+yRu19Z60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc4fcbb131so76093015ad.3;
        Fri, 02 Aug 2024 18:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722648125; x=1723252925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBd1wMelZARBCVInJl3VCnspXuIwi7xicjkRlzE9arc=;
        b=uCBruZ4slQxTNJpnvDkKbGVW4X0SE8Lfkp9LulvogbA6+qvim04ngCBx/B4kHxk65u
         1qIQvbgYzON+94leSbvCEUqEZxflAV9p/1QhuM1THxjYlN4QNzZHFg1LYJt5dWyKD77n
         KsJUhgi9XEcpTyFozPIKqGRRS/gXcAYVy6jkG+47SW1dSQAcP7D0ORfIowebenWcZBSB
         AuBSq9gf+HXzj7Oz5mS65UAyBn1fYwxWWx+bsJxNMGTvm/Ls5j1W/rn+0o40+lUyJ3yZ
         G373oa80VvjY9DAKpgfl/2xXWeoqBug11gxnIhoCAadlf61dgSnMGdB+NWo0VvhQH2Gu
         VIUw==
X-Forwarded-Encrypted: i=1; AJvYcCWOzDAFVKoaga7o1IAgWziDzezmqGavqJaKrus1adftzfKbOVlTgIK5W4yV3Ki6Dl5Voc3yZlE2mqPmioAJ5y/bCb9pK+66VhU5oq/faLvbKT2+H3KmHKOD2MPq2fO9Yc4VBHUMicTLij84HIdOZ7eC1a5d9rWc9X9d6uubJD5nQmSFcf3jixrpgumpD7QWd04amzSbBwz1yEuxxn40+fvgVB4JgBC0lfs2L1KJ3LIhpI0IEhCvdwu+Wewf/sE=
X-Gm-Message-State: AOJu0YxwZybdp/7yTfau7iOxhlQuMhnti/W9ZD3aggR0MRWfse8sc5hf
	MToQgQJuxG6s54w5D9hcpnkFLuCH2Qdl3cVFynDTL8dAChOt79oZ
X-Google-Smtp-Source: AGHT+IEh3GRCAvALzlvd4U+F1tShJABMMoDoWNowR82KjXH9xwxziEaiwqMzhpgj6M2OlmS1YgXMiA==
X-Received: by 2002:a17:902:ecc5:b0:1fd:8f66:b070 with SMTP id d9443c01a7336-1ff57464d40mr74676445ad.57.1722648125527;
        Fri, 02 Aug 2024 18:22:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f6093fsm23731485ad.114.2024.08.02.18.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 18:22:05 -0700 (PDT)
Date: Sat, 3 Aug 2024 01:22:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kw@linux.com, kys@microsoft.com, lenb@kernel.org,
	lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 4/7] arm64: hyperv: Boot in a Virtual Trust Level
Message-ID: <Zq2GOzYAC8WdaUTk@liuwe-devbox-debian-v2>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-5-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726225910.1912537-5-romank@linux.microsoft.com>

On Fri, Jul 26, 2024 at 03:59:07PM -0700, Roman Kisel wrote:
> To run in the VTL mode, Hyper-V drivers have to know what
> VTL the system boots in, and the arm64/hyperv code does not
> update the variable that stores the value.
> 
> Update the variable to enable the Hyper-V drivers to boot
> in the VTL mode and print the VTL the code runs in.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/Makefile        |  1 +
>  arch/arm64/hyperv/hv_vtl.c        | 13 +++++++++++++
>  arch/arm64/hyperv/mshyperv.c      |  4 ++++
>  arch/arm64/include/asm/mshyperv.h |  7 +++++++
>  4 files changed, 25 insertions(+)
>  create mode 100644 arch/arm64/hyperv/hv_vtl.c
> 
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> index 87c31c001da9..9701a837a6e1 100644
> --- a/arch/arm64/hyperv/Makefile
> +++ b/arch/arm64/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y		:= hv_core.o mshyperv.o
> +obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
> new file mode 100644
> index 000000000000..38642b7b6be0
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_vtl.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024, Microsoft, Inc.
> + *
> + * Author : Roman Kisel <romank@linux.microsoft.com>
> + */
> +
> +#include <asm/mshyperv.h>
> +
> +void __init hv_vtl_init_platform(void)
> +{
> +	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> +}
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 341f98312667..8fd04d6e4800 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -98,6 +98,10 @@ static int __init hyperv_init(void)
>  		return ret;
>  	}
>  
> +	/* Find the VTL */
> +	ms_hyperv.vtl = get_vtl();
> +	hv_vtl_init_platform();

It doesn't make sense to me because this function unconditionally prints
Linux runs in Hyper-V Virtual Trust Level.

Thanks,
Wei.

> +
>  	ms_hyperv_late_init();
>  
>  	hyperv_initialized = true;
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> index a7a3586f7cb1..63d6bb6998fc 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -49,6 +49,13 @@ static inline u64 hv_get_msr(unsigned int reg)
>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>  				HV_SMCCC_FUNC_NUMBER)
>  
> +#ifdef CONFIG_HYPERV_VTL_MODE
> +void __init hv_vtl_init_platform(void);
> +int __init hv_vtl_early_init(void);
> +#else
> +static inline void __init hv_vtl_init_platform(void) {}
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
>  
>  #define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
> -- 
> 2.34.1
> 

