Return-Path: <linux-arch+bounces-13678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA4B8580D
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 17:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFCB585C90
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B030BB98;
	Thu, 18 Sep 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hibaoA14"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6C22069A;
	Thu, 18 Sep 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208232; cv=none; b=SobZAdcaPXyrVuOPBpXSbg0obIgNxBxD0e8VUsBWokm9HA6g+etA7o6fmAXtSv5ggP/2zOeXNn8XUhBLpFCLJXL+xV/CKRea/CySZGGUHkO7rEcNR/d57aZjkgYH5p6b98gN5ipzOPmoUogLMnl3JqAeIiJ678IdcyU041T31kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208232; c=relaxed/simple;
	bh=a3ZVmh84djhx3jeizXkRVYFaZvVcG2pRhnJxsbOUgoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoNzpU36gJRuPgCGYgX1BSvZGAzOa8EkxbtkQ1RA0LR1pqtJapbsAqWaguGCnUhVya6Oh2WyUgm5kSi3jgO6+DKQw8ct1tL3d/yXazjRJ9Ownr83ivAeDPNDDepD1d484VIjQ/isD9OcXxEkOeJ+XbIr5LTCeRGFlxr+j+yLYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hibaoA14; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8915840E01CD;
	Thu, 18 Sep 2025 15:10:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dN5j7FxrsJ7P; Thu, 18 Sep 2025 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758208223; bh=Q+idQ3nKVvpk9eg3xZJCm0TLtHDXWL7Dv3vErDkn45M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hibaoA14815BNUHRP4KBL2Yu66Bw8D89Mez6cc03SM6yxkVYCdtn3UCoo61BjllXd
	 PMvKyKEs4kUjvBCAPszJ0NhoF+R4UlZuZGGiQMMoca0LaPeGINtoiFgwTNUkeq9jeL
	 llxF6c7BiR3kRj7s7JAF7hQXvkEnma294vX86fmjLG30R9Rlbptdv5ypQDbiYHWSXl
	 BvjiJQ3b97TkZGZp+JcsYHhCiINFT6g/VqRKqeQKSuh0ccNufMze4h+RTUfEdO0PkV
	 1n7sxvFQbmOhra4yuJTaYmQ9aWMBZNZz64p3onXElN0T27UFa/PaZiwvFBbkpRHR2V
	 xgOmYzYprjHvsJt5dQwxClehK1bnli414MWFhcI5AQ2mwO/X2Y3RtI8TFeKE758RSP
	 DpoyxewHJ1qMEwdFSHrF7GRyOgWu6qhOy6FDhuGLTa+cBzhdvVsf401wf8e3k3goNB
	 nOjkgAlDnYe+l6dCd35mcqB6kzg+3dGfxiM/AzG9Rcymq12gk3V+ZVxuYrSJWkxXkd
	 7/z14J5ExuDLX/h2ePVUsn94jglqvB85Pl9P3UJIA9g3XWhDDmDvQ9fR0Qprl4UvnF
	 59HmMYEaI8DokWHSUrQUAS5GfR6jEUnc+nRnScZYAvr7TpXLQi3f3NqC7NXMjnbEGk
	 D4YqCMNHCOomD7KEaIaPRB8A=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7AC6140E01C9;
	Thu, 18 Sep 2025 15:10:05 +0000 (UTC)
Date: Thu, 18 Sep 2025 17:09:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de, Neeraj.Upadhyay@amd.com, tiala@microsoft.com,
	kvijayab@amd.com, romank@linux.microsoft.com,
	linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] x86/Hyper-V: Add Hyper-V specific hvcall to set
 backing page
Message-ID: <20250918150959.GEaMwgx78CGCxjGce8@fat_crate.local>
References: <20250918150023.474021-1-tiala@microsoft.com>
 <20250918150023.474021-6-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250918150023.474021-6-tiala@microsoft.com>

On Thu, Sep 18, 2025 at 11:00:23AM -0400, Tianyu Lan wrote:
> Secure AVIC hardware provides APIC backing page
> to aid the guest in limiting which interrupt
> vectors can be injected into the guest. Hyper-V
> introduces a new register HV_X64_REGISTER_SEV_GPA_PAGE
> to notify hypervisor with APIC backing page and call
> it in Secure AVIC driver.

Why does hyperv needs special handling again and cannot simply adhere to the
secure AVIC spec?

None of that text explains *why* it is absolutely necessary to do something
hyperv-special...

> @@ -361,7 +364,11 @@ static void savic_setup(void)
>  	 * VMRUN, the hypervisor makes use of this information to make sure
>  	 * the APIC backing page is mapped in NPT.
>  	 */
> -	res = savic_register_gpa(gpa);
> +	if (hv_isolation_type_snp())
> +		res = hv_set_savic_backing_page(gfn);
> +	else
> +		res = savic_register_gpa(gpa);
> +

This is ugly and doesn't belong here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

