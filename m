Return-Path: <linux-arch+bounces-5948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998299466AA
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 03:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C40282644
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08DA4C98;
	Sat,  3 Aug 2024 01:21:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE68567F;
	Sat,  3 Aug 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722648093; cv=none; b=bPW5tJ6odE7KPAF0TGO+6QFEJ9IgnlfimdMtK6dcSpjhkdIiBkunv1gtytjWn3Y1lE6L3uOR100Xe5xIQLDlaktyF8HcPt9yQWMWQuToVMAkmhQ0uEZGxCBQmdEq69BIkIftGTG5Mc03uEiWjhUx/rUir2HtK05HOCaR4dVr8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722648093; c=relaxed/simple;
	bh=1OwoZaHVI9aZupJdancQKHLKBgrbUxUBr1NA70J2Qjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPQpFMXgaDtGgXF45lTHmeE1fAHdncpiUleHIc5Z/q6L5MC9ztGpumcJIoPbrdlY6NssOpmNOqkTZE+HZ7MoTEDTW3LJKnVwRmqqugTJ7OixPovLQTJAFQSw/f4dxkmsDHAJiB7GAwrkP5cb7oLY8v+HDEJSPPS3rCddbHU8z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39b27935379so3252715ab.1;
        Fri, 02 Aug 2024 18:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722648091; x=1723252891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsnImiphK1NlwCVal/zOVFS53Curr6mQhhwK0Co5UYM=;
        b=IYDmfKsjFTN59qPGTdzZmkZPkvo6o9QQuey5FlbDylLx0WcuZdWF4zWnGjsIRgyic6
         zXxYv1YEe+pT7klqWJAnODpAjkpZquszWzNVlzrC6K4zSwJld0R1ZEvQUCCqtx0kpAhG
         Pc+K7WR6bGMnjFTJFTwUUr+Vlcor++IQCC4TrrqE3B1o35uU69B1/G42vY6Mmr7uQ456
         Kvkw8bOL8pSOVvFQ2JNLLnTYXI8W4503BKVWBTEoMHI2aQ9ZEY20ggDmMXoZRfHaQm4e
         8Tt17gno+npos584on1+U0Cygvs3FzDf9hpjnaGdVDa0soBmQa+0OHalSanXTHc3vFTF
         5CPg==
X-Forwarded-Encrypted: i=1; AJvYcCXd1gsrgc3WH90wXOvxXrDWpHczMlTCEU+SaE6/sIWhkhiJI5kL0c+wSZO8+dw2U89WIYYcFfbfa3dM96+q+q9KDmcU7wEHJk/S5cCzCbmYhG65zwz3zEHpFIdlKDYhRPRmLc7z3KP8GlPjqxtSIikZizhKt7fqeFL1ZOeNUs+NBf079olRO5oJR/4CKShxjSxM8e0y3HKuBRzi0rOxkbF77Ogi5r8pWTcuOQ7IUIGQyeQjAFX3N2u0u1kXuAk=
X-Gm-Message-State: AOJu0YwlrrCJ9IP5Z9HQ7TCnV4fXy6su1HM88cGdYSNjJO5h95qSDXS/
	c9ofFEsHZzbMoZwt2uW3l8ldduEXpqUo2kwKhkPj2UvKxK6acHke
X-Google-Smtp-Source: AGHT+IGtDKeBup1Q5S5nO+6X4pO7UjRMLDLx+BnkZfIeEqKtoBYna1Ag7k37iiRYXTS97jTK8aQYUQ==
X-Received: by 2002:a92:c64d:0:b0:381:fa54:fb33 with SMTP id e9e14a558f8ab-39b1fc1e182mr63205255ab.17.1722648091202;
        Fri, 02 Aug 2024 18:21:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59294515sm23572265ad.244.2024.08.02.18.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 18:21:30 -0700 (PDT)
Date: Sat, 3 Aug 2024 01:21:29 +0000
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
Subject: Re: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
Message-ID: <Zq2GGfsHjpoacdy_@liuwe-devbox-debian-v2>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726225910.1912537-2-romank@linux.microsoft.com>

On Fri, Jul 26, 2024 at 03:59:04PM -0700, Roman Kisel wrote:
> The arm64 Hyper-V startup path relies on ACPI to detect
> running under a Hyper-V compatible hypervisor. That
> doesn't work on non-ACPI systems.
> 
> Hoist the ACPI detection logic into a separate function,
> use the new SMC added recently to Hyper-V to use in the
> non-ACPI case.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

The change looks sensible.

Within one minor comment fixed below:

Acked-by: Wei Liu <wei.liu@kernel.org>

However I would also like to get an Acked-by or reivewed-by from someone
who works on the ARM64 side of things -- Saurabh, Boqun, Srivatsa, and
Jinank?

> ---
>  arch/arm64/hyperv/mshyperv.c      | 36 ++++++++++++++++++++++++++-----
>  arch/arm64/include/asm/mshyperv.h |  5 +++++
>  2 files changed, 36 insertions(+), 5 deletions(-)
> 
[...]
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> index a975e1a689dd..a7a3586f7cb1 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -51,4 +51,9 @@ static inline u64 hv_get_msr(unsigned int reg)
>  
>  #include <asm-generic/mshyperv.h>
>  
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0x56726570

Presumably these are ASCII codes for an identifier string, please 
provide comments to explain what they are.

> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0
> +
>  #endif
> -- 
> 2.34.1
> 

