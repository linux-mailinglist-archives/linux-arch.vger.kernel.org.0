Return-Path: <linux-arch+bounces-10412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB72A46F9B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB62188879A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23426E970;
	Wed, 26 Feb 2025 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ar/9C9wj"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577AD26E965;
	Wed, 26 Feb 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613394; cv=none; b=mN8r+GKj4W1P1R8LNxv7ZAvm9rg6zoxnW9aF5hj5fm/fXqIKIzG2PK7rxiw3MMl1fjF6Rdt6KxNZx2QACmbfd+KrlsGsM5uO/tocbsi5Fvr+vpAHCiF58B8p5geu6QA9ShabXF9XAxQWUNt29CpcGQ3bFen9yoE3TdYU1+4w25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613394; c=relaxed/simple;
	bh=yw3bajXoxmDmry067IRgYkao+gs6z0/DF6pY5sDZAF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGdAX5GIFkkhcdKPWUcAGTzTr5x5XOs7FcShRiJky1+3YlC/Oj8Rymp0aG8QKsrd+Z2HDMWC9wOJhLBadIZ6WC6m1FcPtjy2rxdpvadS6SZf9+9Mgc26hqtANWYMLYM3FTA52V5J20RYOmF2jOmiUCL4VaBYIBanxU/QVKOV1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ar/9C9wj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id A393E210EACA;
	Wed, 26 Feb 2025 15:43:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A393E210EACA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740613392;
	bh=jzMXL280br0vhbgA72KzbwPRmGz6jiYxkQdz6bCZM2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ar/9C9wjmLoKfaSfU4jE6OWNYEhLvO08kHxOvO1dxpVy28cVQhh0RP96Db9T5SWwU
	 j3V/uYXFAQY97/T/kAINpXql5Jj4zG/wIuxKyi2pjR1LPPnaXEGObKUM8vLqnHf2Mc
	 0EGXqC4phb3oOqEXIQmWqSTjHb1SfUFSUFK8Er3o=
Date: Wed, 26 Feb 2025 15:43:09 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org, vkuznets@redhat.com,
	prapal@linux.microsoft.com, muislam@microsoft.com,
	anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and
 setup function
Message-ID: <Z7-nDUe41XHyZ8RJ@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-9-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-9-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:08:02PM -0800, Nuno Das Neves wrote:
> This will handle SYNIC interrupts such as intercepts, doorbells, and
> scheduling messages intended for the mshv driver.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
>  drivers/hv/hv_common.c         | 5 +++++
>  include/asm-generic/mshyperv.h | 1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 0116d0e96ef9..616e9a5d77b4 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -107,6 +107,7 @@ void hv_set_msr(unsigned int reg, u64 value)
>  }
>  EXPORT_SYMBOL_GPL(hv_set_msr);
>  
> +static void (*mshv_handler)(void);
>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
> @@ -117,6 +118,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  
>  	inc_irq_stat(irq_hv_callback_count);
> +	if (mshv_handler)
> +		mshv_handler();

Can mshv_handler be defined as a weak symbol doing nothing instead
of defining it a null pointer?
This should allow to simplify this code and get rid of
hv_setup_mshv_handler, which looks redundant.

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> +
>  	if (vmbus_handler)
>  		vmbus_handler();
>  
> @@ -126,6 +130,11 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	set_irq_regs(old_regs);
>  }
>  
> +void hv_setup_mshv_handler(void (*handler)(void))
> +{
> +	mshv_handler = handler;
> +}
> +
>  void hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  	vmbus_handler = handler;
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 2763cb6d3678..f5a07fd9a03b 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -677,6 +677,11 @@ void __weak hv_remove_vmbus_handler(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
>  
> +void __weak hv_setup_mshv_handler(void (*handler)(void))
> +{
> +}
> +EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
> +
>  void __weak hv_setup_kexec_handler(void (*handler)(void))
>  {
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 1f46d19a16aa..a05f12e63ccd 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -208,6 +208,7 @@ void hv_setup_kexec_handler(void (*handler)(void));
>  void hv_remove_kexec_handler(void);
>  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
>  void hv_remove_crash_handler(void);
> +void hv_setup_mshv_handler(void (*handler)(void));
>  
>  extern int vmbus_interrupt;
>  extern int vmbus_irq;
> -- 
> 2.34.1
> 

