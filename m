Return-Path: <linux-arch+bounces-15081-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE67C88C64
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 09:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4459A3B7F53
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A531AF3F;
	Wed, 26 Nov 2025 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="AzWGxEIN"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender3-of-o54.zoho.com (sender3-of-o54.zoho.com [136.143.184.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38631A808;
	Wed, 26 Nov 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147154; cv=pass; b=pTHBZKc57OgZmgn8anKkH5rqsCEdAg5cumt3VG4VH/Llv71IljzkF9VViiecAwlHwqPxc3AhzWvlyjOGrMpiqBZuQ3mdjfVBL/E4/k+NkL3lYP66oMokroT4fi53aTne7c3M226LlfhQqD/lyaOqiBSECONoKZlyGTPCVM8PByo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147154; c=relaxed/simple;
	bh=7bqK9leSbZJO6WeM9sl8N4am2gpal5/ZjQs4k51+4GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlmnaHE2GIkv4Wf/lnfu2k7ceJ9MkH3zNptE+yKIDG3BgrMgzPTcZTJJu+m8aW6wc7v4AE4RXGi5cmVnyHreQemC7pc+3TY1xSPgnOphP2U3KzaN7swsyPPhxIF/ZASro3TNIbZwOhklS6v+JqJH0cNvJlJA22EXSmI4+YkwFGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=AzWGxEIN; arc=pass smtp.client-ip=136.143.184.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764147129; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EozE+DQrrfnCJQj1hNrK39Qej1ArM2OEIOAdUb9dYdn4ekF/mV6GCULrPHmc+HXFeUDf91WkI1WLUk5M+antVsx8OhxVU97UOIWlE9JXQJvTPv+g7O4CTRFWcGE32iBNLOaLQ1SXZqXVFyhG+GOIYjD0XEhgpCJKy6UgxD+0gf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764147129; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4kMxEju5M/nKc9DOThZPJgB81pFJ1BBy6AQBjiH7yQ8=; 
	b=XO/k7zRjvg5DJES+Z7O4fBVDcXkr495nzZ2gZiefk84q4eMNybbNzMS1+a5fk4/gVJVmbBLAChWpiq9pG+X3VuyikUTiwHT+JP4jsCcWjkXr/oqE5um5IzX3X6eko3IZj8wTSXFxZXBTMwVmyZ9eNMol2L9Un8zIxvZKuldfur0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764147128;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=4kMxEju5M/nKc9DOThZPJgB81pFJ1BBy6AQBjiH7yQ8=;
	b=AzWGxEINhyaf9Qe+BWKH+NZJVrxv8NBMjcNINDPYzYvRpgYVKYnnKEYrqYkUdDtv
	z7qjNz41mKXNNgDt3cgB04f4MvxZhrGhjZZoDuxIvmjrITReaIHHMPsZkjYXkxd7ZAF
	15eQYl9dVfhiZaVJGab8YnaExsH59ZlBynzqldzQ=
Received: by mx.zohomail.com with SMTPS id 1764147125272486.14699736135515;
	Wed, 26 Nov 2025 00:52:05 -0800 (PST)
Date: Wed, 26 Nov 2025 08:51:59 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, Arnd Bergmann <arnd@arndb.de>,
	akpm@linux-foundation.org, agordeev@linux.ibm.com,
	guoweikang.kernel@gmail.com, osandov@fb.com, bsz@amazon.de,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/3] irqchip/gic-v3: allocate one SGI for MSHV
Message-ID: <aSa_rxG80LDXDlhr@anirudh-surface.localdomain>
References: <20251125170124.2443340-1-anirudh@anirudhrb.com>
 <20251125170124.2443340-3-anirudh@anirudhrb.com>
 <86bjkqq9dp.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjkqq9dp.wl-maz@kernel.org>
X-ZohoMailClient: External

On Tue, Nov 25, 2025 at 06:01:38PM +0000, Marc Zyngier wrote:
> On Tue, 25 Nov 2025 17:01:23 +0000,
> Anirudh Raybharam <anirudh@anirudhrb.com> wrote:
> > 
> > From: Anirudh Rayabharam <anirudh@anirudhrb.com>
> > 
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > Currently SGIs are allocated only for the smp subsystem. The MSHV
> > (Microsoft Hypervisor aka Hyper-V) code also needs an SGI that can be
> > programmed into the SYNIC to receive intercepts from the hypervisor. The
> > hypervisor would then assert this SGI whenever there is a guest
> > VMEXIT.
> > 
> > Allocate one SGI for MSHV use in addition to the SGIs allocated for
> > IPIs. When running under MSHV, the full SGI range can be used i.e. no
> > need to reserve SGIs 8-15 for the secure firmware.
> > 
> > Since this SGI is needed only when running as a parent partition (i.e.
> > we can create guest partitions), check for it before allocating an SGI.
> 
> Sorry, but that's not an acceptable situation.
> 
> SGIs are for Linux to use, nobody else, and that allocation must be

Why does this restriction exist? In the code SGIs 8-15 are left for
secure firmware. So, things other than Linux can use SGIs. Why not MSHV
then?

> the same irrespective of whether Linux runs virtualised or not. This
> also won't work with GICv5 (there are no SGIs at all), so this is
> doomed from the very start, and would immediately create technical
> debt.

Hyper-V always presents a GICv3 so we don't need to worry about GICv5.

> 
> If you want to signal an interrupt to Linux, expose a device with an
> interrupt in a firmware table (i.e. not an SGI), and use that in your
> driver.

You mean in the ACPI tables? That would require us to modify the
firmware to expose this virtual device right?

Anirudh.

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

