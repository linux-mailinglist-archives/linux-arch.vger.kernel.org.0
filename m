Return-Path: <linux-arch+bounces-15085-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270BC8963C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 11:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB53B94B1
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4377731E0E6;
	Wed, 26 Nov 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="GjLHrdFl"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender3-of-o54.zoho.com (sender3-of-o54.zoho.com [136.143.184.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25D3242D7;
	Wed, 26 Nov 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154026; cv=pass; b=dreBZjZGgFYDb4HzKlAm9iVu3bikBlN7pzQ9zDSPRH60K1jW7nR4W0gv4jpgMJBdk+RZvoY8wUYijmAPIoBJZCDrrwWYDL7hqqmSFrp38JSYm2ObAdyG3Y2I15q3p8FvhGWrtHLsbPfqTlunprcwdvxaGAlz+NReVdqcP+ZYOmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154026; c=relaxed/simple;
	bh=M+zjAZsrQYDnMsG5FXD7DZiUF/GmcJWIUWpKOgYUwvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMpP3HbUC8hQbavF4gQlRZaE/yoNpp4vKjYb2Rn6AXiJigqh5OORg52CuTslz9IPpaFCI01/MIR6b72ZFD+9xVa2h5ZtVA7qsBWpxgA3z8/13iGHbd40V9J0gFZ8o2S6qotl8eSKY5outQalnkUvV1v7cJQ3JcvmVNxCGsPHY7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=GjLHrdFl; arc=pass smtp.client-ip=136.143.184.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764153999; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SUtnv6J7VsnEM7W/tPWaAY59MO76NcqiqWLy59E4stpw0Oy/UoQu/9x5KWlWm6p+XmkPpbVbaRwEVfqvVSo8MPTkQGjtP96pRr2cEfN1amil6n/gpsbQ5x5L5/MGEFiHgyaqZgeoi6qGxlz3vs7bbQfI2pilJ5iDZMNdg8MDUAw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764153999; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JQa7pr2d2LWfMGLERrFlEKDeH19thDdsNOy8z01FBYg=; 
	b=RGG3sMdrXFgh+ACK59yNKbWfUlgf3Xw8ab1jH2jy1YZcunteDjaeLXR6tBuN/KK9yxgcGroPLEGVhQvDenfKjYN8u5foLnS4MkYL0hmsdWFr9WbudSL7izeledchIbfm+PcCf4mYJI96Oaosa5OfrwLjA/zVf3T4vzR16tFwN7s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764153999;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=JQa7pr2d2LWfMGLERrFlEKDeH19thDdsNOy8z01FBYg=;
	b=GjLHrdFlCRbKQosUewtLukpsHWYOb1Q/Zw4/NlQxgEGfHGJiVw4DAm6MhlPCBDB0
	80W0hYhphDDhtGxj4WlqgsDBPLev+nRAmE1NUKmIduuP57b4WfPRbw1mJ8QcfQKosMR
	uycMbEuEGlqVDGsxpHB0wrEeYYRpaG0guYCZU/g4=
Received: by mx.zohomail.com with SMTPS id 1764153997500477.0715187596991;
	Wed, 26 Nov 2025 02:46:37 -0800 (PST)
Date: Wed, 26 Nov 2025 10:46:31 +0000
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
Message-ID: <aSbahzqu_3GN-PPJ@anirudh-surface.localdomain>
References: <20251125170124.2443340-1-anirudh@anirudhrb.com>
 <20251125170124.2443340-3-anirudh@anirudhrb.com>
 <86bjkqq9dp.wl-maz@kernel.org>
 <aSa_rxG80LDXDlhr@anirudh-surface.localdomain>
 <86a509qi8p.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a509qi8p.wl-maz@kernel.org>
X-ZohoMailClient: External

On Wed, Nov 26, 2025 at 09:02:30AM +0000, Marc Zyngier wrote:
> On Wed, 26 Nov 2025 08:51:59 +0000,
> Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> > 
> > On Tue, Nov 25, 2025 at 06:01:38PM +0000, Marc Zyngier wrote:
> > > On Tue, 25 Nov 2025 17:01:23 +0000,
> > > Anirudh Raybharam <anirudh@anirudhrb.com> wrote:
> > > > 
> > > > From: Anirudh Rayabharam <anirudh@anirudhrb.com>
> > > > 
> > > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > > 
> > > > Currently SGIs are allocated only for the smp subsystem. The MSHV
> > > > (Microsoft Hypervisor aka Hyper-V) code also needs an SGI that can be
> > > > programmed into the SYNIC to receive intercepts from the hypervisor. The
> > > > hypervisor would then assert this SGI whenever there is a guest
> > > > VMEXIT.
> > > > 
> > > > Allocate one SGI for MSHV use in addition to the SGIs allocated for
> > > > IPIs. When running under MSHV, the full SGI range can be used i.e. no
> > > > need to reserve SGIs 8-15 for the secure firmware.
> > > > 
> > > > Since this SGI is needed only when running as a parent partition (i.e.
> > > > we can create guest partitions), check for it before allocating an SGI.
> > > 
> > > Sorry, but that's not an acceptable situation.
> > > 
> > > SGIs are for Linux to use, nobody else, and that allocation must be
> > 
> > Why does this restriction exist? In the code SGIs 8-15 are left for
> > secure firmware. So, things other than Linux can use SGIs. Why not MSHV
> > then?
> 
> Because SGIs are for *internal* usage. Not usage from another random
> piece of SW. The ACPI tables explicitly don't describe SGIs. DT
> explicitly don't describe SGIs. Do you get the clue?

The name Software Generated Interrupts suggests that it is supposed to be
used by pieces of SW.

Yes, ACPI/DT don't describe SGIs because they're not supposed to be used
by devices. SW has full control over SGIs and it is up to the SW to
assign meaning to them, isn't it?

> 
> > > the same irrespective of whether Linux runs virtualised or not. This
> > > also won't work with GICv5 (there are no SGIs at all), so this is
> > > doomed from the very start, and would immediately create technical
> > > debt.
> > 
> > Hyper-V always presents a GICv3 so we don't need to worry about GICv5.
> 
> Well, that's pretty short sighted of you, and eventually you'll have
> to support it, or just die. So do the right thing from the beginning.

Well, we don't when or if that will happen. But if it does happen, we
can solve it in a way that makes sense for GICv5. If there are no SGIs
at all, great, maybe we'll have a nicer solution then.

> 
> > >
> > > If you want to signal an interrupt to Linux, expose a device with an
> > > interrupt in a firmware table (i.e. not an SGI), and use that in your
> > > driver.
> > 
> > You mean in the ACPI tables? That would require us to modify the
> > firmware to expose this virtual device right?
> 
> Yes. How is that surprising?

It's not ideal that we would need some custom firmware to run Linux on
MSHV (as a parent). Do you think there could be some other possible solution
for handling this in the kernel? Maybe by thinking of it as a platform specific
quirk or something?

Thanks,
Anirudh.

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

