Return-Path: <linux-arch+bounces-15089-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D16C8CEB2
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 07:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68BAA34E06A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 06:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C5030F54D;
	Thu, 27 Nov 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="GOt4N6OM"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender3-of-o54.zoho.com (sender3-of-o54.zoho.com [136.143.184.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFD4A0C;
	Thu, 27 Nov 2025 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764224832; cv=pass; b=EX0ylAJ13wacX3p1wy7XtChQkwh7dcgOaXpoNLnBMvsVWiTFLa7MsaLX3TcJ4aVNxbMLUEXZDNk9QYvsTjXUdLezl5JQzD9+YAjPkagImp0TvEQOJltGqPYlirvi6pUoxdkl3RDwjVtNlhcxSKJzfSUh4C2oH5JZJXoMlwaSvmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764224832; c=relaxed/simple;
	bh=gdBinVxQsbFZOHfBQ40vtQyAZxxJI3gz5alE10yUZCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTy+C0BQlreG4Hg7GNP3zOznWQWxHg87aY4hmUgkQx4AUiDTdw8eUzvH+J+EnOi5T0FZ8Vi3hAVvTT8v7xtWArDiFq6KFayEzyMTpu+qzsovIIX3nch/rbYhmqNfDQygi2Npuvp8kdm2QWKwiIcSEWJoGSm2qxoMn3gOiHbJHRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=GOt4N6OM; arc=pass smtp.client-ip=136.143.184.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764224786; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dE3lq7tv3WQRQfECKsEi0hDF4pwVV163Ye3Z1xfhudGgqBuQM0UqaAprpuKtXfRpPKUJDz1Abug7/uXKgO+5U/7hEBsQiOjN2FGoapLQe0I7OfB00Ht8Q2f+cdVVcxH7RdyGXmAUhCFsn75OQX6gX/tBubpoqrQbUUEBikhDD6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764224786; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xO3M9bvoRJsOaEEeuSrleP65nQq5qE6zfFwVwcTwieI=; 
	b=ZBWfA8pCpGTm0dpkMRTefwIlntWw5EcPAVSUU/T9osBHUdFO8OaQjsNb5KpOKw566hGCTBZlrvbklJe7lDbP6QPSCW/8UctpE7O91NJOJNgBFksDrIPhYy3PSdNTkTB9wgswpVEFXdy2eq5+qLNSVSt5eUIglR1WsRRx+/GHOts=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764224786;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=xO3M9bvoRJsOaEEeuSrleP65nQq5qE6zfFwVwcTwieI=;
	b=GOt4N6OMOHfzkAK0kZCguNHuDlcLhKDVb7Q7QLg6N+VwKHJoIV9GoD9BnCn0H7uV
	uUBgeKT+epT9Kg4+V76ysHCTPFlcH/lOJaOJ3RjR4hClbcvbduvNervAYHcnqlwdVzy
	Y9Sj76CLyw2McOIzdviaWLHGUKW1VpH5icW2Cp+A=
Received: by mx.zohomail.com with SMTPS id 1764224784283849.3243083730232;
	Wed, 26 Nov 2025 22:26:24 -0800 (PST)
Date: Thu, 27 Nov 2025 06:26:16 +0000
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
Message-ID: <aSfvCBYySLGpyk1L@anirudh-surface.localdomain>
References: <20251125170124.2443340-1-anirudh@anirudhrb.com>
 <20251125170124.2443340-3-anirudh@anirudhrb.com>
 <86bjkqq9dp.wl-maz@kernel.org>
 <aSa_rxG80LDXDlhr@anirudh-surface.localdomain>
 <86a509qi8p.wl-maz@kernel.org>
 <aSbahzqu_3GN-PPJ@anirudh-surface.localdomain>
 <87bjkofpsc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjkofpsc.wl-maz@kernel.org>
X-ZohoMailClient: External

On Wed, Nov 26, 2025 at 09:27:15PM +0000, Marc Zyngier wrote:
> On Wed, 26 Nov 2025 10:46:31 +0000,
> Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> > 
> > On Wed, Nov 26, 2025 at 09:02:30AM +0000, Marc Zyngier wrote:
> > > On Wed, 26 Nov 2025 08:51:59 +0000,
> > > Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> > > > 
> > > > On Tue, Nov 25, 2025 at 06:01:38PM +0000, Marc Zyngier wrote:
> > > > > On Tue, 25 Nov 2025 17:01:23 +0000,
> > > > > Anirudh Raybharam <anirudh@anirudhrb.com> wrote:
> > > > > > 
> > > > > > From: Anirudh Rayabharam <anirudh@anirudhrb.com>
> > > > > > 
> > > > > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > > > > 
> > > > > > Currently SGIs are allocated only for the smp subsystem. The MSHV
> > > > > > (Microsoft Hypervisor aka Hyper-V) code also needs an SGI that can be
> > > > > > programmed into the SYNIC to receive intercepts from the hypervisor. The
> > > > > > hypervisor would then assert this SGI whenever there is a guest
> > > > > > VMEXIT.
> > > > > > 
> > > > > > Allocate one SGI for MSHV use in addition to the SGIs allocated for
> > > > > > IPIs. When running under MSHV, the full SGI range can be used i.e. no
> > > > > > need to reserve SGIs 8-15 for the secure firmware.
> > > > > > 
> > > > > > Since this SGI is needed only when running as a parent partition (i.e.
> > > > > > we can create guest partitions), check for it before allocating an SGI.
> > > > > 
> > > > > Sorry, but that's not an acceptable situation.
> > > > > 
> > > > > SGIs are for Linux to use, nobody else, and that allocation must be
> > > > 
> > > > Why does this restriction exist? In the code SGIs 8-15 are left for
> > > > secure firmware. So, things other than Linux can use SGIs. Why not MSHV
> > > > then?
> > > 
> > > Because SGIs are for *internal* usage. Not usage from another random
> > > piece of SW. The ACPI tables explicitly don't describe SGIs. DT
> > > explicitly don't describe SGIs. Do you get the clue?
> > 
> > The name Software Generated Interrupts suggests that it is supposed to be
> > used by pieces of SW.
> 
> I'm so glad you spell it out for me, I had no idea. I can't help but
> notice that it is not called SGIFRPOSIDKA (Software Generated
> Interrupt From Random Piece Of Software I Don't Know About).

Haha.

> 
> Linux owns the SGIs, full stop. If you want to generate interrupts
> from outside of Linux, use a standard interrupts. Not rocket science.
> 
> > Yes, ACPI/DT don't describe SGIs because they're not supposed to be used
> > by devices. SW has full control over SGIs and it is up to the SW to
> > assign meaning to them, isn't it?
> 
> No. It means that a single *consistent* software agent *owns* these
> interrupts and doesn't have to let *anyone* else use them from outer
> space.

Okay, got it.

> 
> > > > > the same irrespective of whether Linux runs virtualised or not. This
> > > > > also won't work with GICv5 (there are no SGIs at all), so this is
> > > > > doomed from the very start, and would immediately create technical
> > > > > debt.
> > > > 
> > > > Hyper-V always presents a GICv3 so we don't need to worry about GICv5.
> > > 
> > > Well, that's pretty short sighted of you, and eventually you'll have
> > > to support it, or just die. So do the right thing from the beginning.
> > 
> > Well, we don't when or if that will happen. But if it does happen, we
> > can solve it in a way that makes sense for GICv5. If there are no SGIs
> > at all, great, maybe we'll have a nicer solution then.
> 
> Great. See you then. In the meantime, I have no interest in this sort
> of sorry hacks polluting the stuff I maintain.
> 
> > > > > If you want to signal an interrupt to Linux, expose a device with an
> > > > > interrupt in a firmware table (i.e. not an SGI), and use that in your
> > > > > driver.
> > > > 
> > > > You mean in the ACPI tables? That would require us to modify the
> > > > firmware to expose this virtual device right?
> > > 
> > > Yes. How is that surprising?
> > 
> > It's not ideal that we would need some custom firmware to run Linux on
> > MSHV (as a parent). Do you think there could be some other possible solution
> > for handling this in the kernel? Maybe by thinking of it as a platform specific
> > quirk or something?
> 
> You either do it the *correct* way, by exposing a virtual device, with
> an edge-triggered PPI, just like other hypervisors have done, or you
> keep your toy to yourself.  It is that simple. We don't have to accept
> ugly crap in Linux just for the sake of you not having to do the right
> thing in your firmware.
> 
> Feel free to post a new series once you have something that matches
> the above expectations.

Okay got it, I'll come up with a series that reads PPIs from ACPI.

Thanks for your feedback!

Anirudh.

> 
> 	M.
> 
> -- 
> Jazz isn't dead. It just smells funny.

