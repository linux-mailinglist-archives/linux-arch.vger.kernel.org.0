Return-Path: <linux-arch+bounces-13385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4EB4443B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08943B1177
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983BF223DFB;
	Thu,  4 Sep 2025 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="dQc40yqK"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE3EEAB;
	Thu,  4 Sep 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006575; cv=pass; b=GQ1L2suR83lXwccoAmjUhnY1+YiZmn5ijNkGGmJKB8W8dPM46lLDRqlhmUqyOtFXDKp/xMNb6lrnzBcGmgrpieySxEFAxajG2YavCS/UXtNSybU092jKgea+2Z68ubu4jTLjfh3mGHLU0oCpnQjEEMewSjC4H5AKsqVdXqzPjy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006575; c=relaxed/simple;
	bh=IXUhTyGSEq6cODsVKJKAvacHUbsTJvpdZAMsIzfQDnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9jtGJapkz4bWYltEOI95SOG57bRELDJszwOXmGh1bctvUyXFOab6lDXSggInI7sXHYVUUIn6BDzTUPnKJR6SnTWM13o34uFxdqUHvxKWIwlGiOjth2Ftf+nPwn/ptFKW4DDWQc5WvCS3PIPn8XwldGjGSN+zojupiBmR73JyDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=dQc40yqK; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1757006535; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JlrR3IwW1M98FTaE1uSA6CKsxK/BT2Y73sbxQIKPDKHPwvop5GvUZRvEiLqwB4N68QItpHNL3kcNjxgZuYXMGcfKMqsEmqAadKpKSRcUPGwOHTkVlakwHEvASxRTy+CUeM/L+dxjRirGl6AgsPEaSPSXc4I53YlY3EZjt1BYlNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757006535; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sug0CNElZw5SXr+EPiBghFae43QdyGzoVG7yd36m4G4=; 
	b=iFovEAps1XPIkxJG/BKOXKaPGqjndlWs8aNwfgAgCKnE7NNUluIBF3i7NbSwNrisz78dj1L+wHrTZYSuGh0X4LwUFO//o2yamHLoTgc3eYARaJF4iV0fp0ZO+BYXmOkMaZVw91tfUZi3j6FbAYazY9A5EYZcRSQsUkl7DWCPZnE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757006535;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=sug0CNElZw5SXr+EPiBghFae43QdyGzoVG7yd36m4G4=;
	b=dQc40yqKrM9Z19oaZ+ppv9wvwdTxm1vAq+brKm1We5WQ1tSbcygG9fnutFY6/6k6
	KE+xvXUqU1rsLqtFCTQtFi1PYpmuY+KT/ewHPvqztoz5DKGXgohZ+CYykFR2aI6I+iM
	SVGgun8PIfK19KX3mzkQB9e7JHutnzZCMBpaHEnM=
Received: by mx.zohomail.com with SMTPS id 175700653350928.19407257757507;
	Thu, 4 Sep 2025 10:22:13 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:22:04 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v0 1/6] x86/hyperv: Rename guest shutdown functions
Message-ID: <aLnKvGvTyowA_PMv@anirudh-surface.localdomain>
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
 <20250904021017.1628993-2-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904021017.1628993-2-mrathor@linux.microsoft.com>
X-ZohoMailClient: External

On Wed, Sep 03, 2025 at 07:10:12PM -0700, Mukesh Rathor wrote:
> This commit renames hv_machine_crash_shutdown to more appropriate

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Please describe your changes in imperative mood. For e.g.:

“make xyzzy do frotz” instead of “[This patch] makes xyzzy do frotz”

Please fix this for all the patches in this series.

Thanks,
Anirudh.

> hv_guest_crash_shutdown and makes it applicable to guests only. This
> in preparation for the subsequent hypervisor root/dom0 crash support
> patches.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index b8caf78c4336..f5d76d854d39 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -237,7 +237,7 @@ static void hv_machine_shutdown(void)
>  #endif /* CONFIG_KEXEC_CORE */
>  
>  #ifdef CONFIG_CRASH_DUMP
> -static void hv_machine_crash_shutdown(struct pt_regs *regs)
> +static void hv_guest_crash_shutdown(struct pt_regs *regs)
>  {
>  	if (hv_crash_handler)
>  		hv_crash_handler(regs);
> @@ -824,7 +824,8 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.shutdown = hv_machine_shutdown;
>  #endif
>  #if defined(CONFIG_CRASH_DUMP)
> -	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
> +	if (!hv_root_partition)
> +		machine_ops.crash_shutdown = hv_guest_crash_shutdown;
>  #endif
>  #endif
>  	/*
> -- 
> 2.36.1.vfs.0.0
> 

