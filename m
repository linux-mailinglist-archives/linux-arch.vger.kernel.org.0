Return-Path: <linux-arch+bounces-1446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A5D839144
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7491289C04
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC65FB80;
	Tue, 23 Jan 2024 14:22:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937905F858;
	Tue, 23 Jan 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019752; cv=none; b=m7/BydWuTHrVneUKBjPcL5nFTAk3I4M8vpt7x5Yqsn3GobVHNTqwufDTcrtTNS2zzTLbsXAcp9HwPBLE4vJ7Ha3dAo0m7BipBq5QpOnNrjgswyMF6wxjUJR9nZqPhu6EpurUW0zjlhtFEGx+iDHGOUKs3IEfIdUVZPc1Oa1sTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019752; c=relaxed/simple;
	bh=6UOC/IhmsB3mO8ORCE3KruE97dPphECfRSplYvUL/d0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fl8rJzEwq3t3+0wDys111k8hFTxLs1Y87mzZzVbqtPtRC3RIGkP7g6qPHZOwuVIKjFHm768pWQg2JH3v1onqXV1OCBl9CCvT+lfI2TrlH4ce7E7BlqAEP9epiXx4cyoikZQeHS3QF/m1MZj/Q6RpMKrj8UFCFr7VhPwzTzxoAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TK8P10Qfbz6K64n;
	Tue, 23 Jan 2024 22:19:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CC42140AB8;
	Tue, 23 Jan 2024 22:22:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 14:22:19 +0000
Date: Tue, 23 Jan 2024 14:22:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 17/21] ACPI: add support to register CPUs based
 on the _STA enabled bit
Message-ID: <20240123142218.00001a7b@Huawei.com>
In-Reply-To: <Za+61Jikkxh2BinY@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOhC-00DvlI-Pp@rmk-PC.armlinux.org.uk>
	<ZYBDJG1g7SH7AiM1@shell.armlinux.org.uk>
	<20240102145320.000062f9@Huawei.com>
	<20240123102603.00004244@Huawei.com>
	<Za+61Jikkxh2BinY@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Jan 2024 13:10:44 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Jan 23, 2024 at 10:26:03AM +0000, Jonathan Cameron wrote:
> > On Tue, 2 Jan 2024 14:53:20 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Mon, 18 Dec 2023 13:03:32 +0000
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >   
> > > > On Wed, Dec 13, 2023 at 12:50:38PM +0000, Russell King wrote:    
> > > > > From: James Morse <james.morse@arm.com>
> > > > > 
> > > > > acpi_processor_get_info() registers all present CPUs. Registering a
> > > > > CPU is what creates the sysfs entries and triggers the udev
> > > > > notifications.
> > > > > 
> > > > > arm64 virtual machines that support 'virtual cpu hotplug' use the
> > > > > enabled bit to indicate whether the CPU can be brought online, as
> > > > > the existing ACPI tables require all hardware to be described and
> > > > > present.
> > > > > 
> > > > > If firmware describes a CPU as present, but disabled, skip the
> > > > > registration. Such CPUs are present, but can't be brought online for
> > > > > whatever reason. (e.g. firmware/hypervisor policy).
> > > > > 
> > > > > Once firmware sets the enabled bit, the CPU can be registered and
> > > > > brought online by user-space. Online CPUs, or CPUs that are missing
> > > > > an _STA method must always be registered.      
> > > > 
> > > > ...
> > > >     
> > > > > @@ -526,6 +552,9 @@ static void acpi_processor_post_eject(struct acpi_device *device)
> > > > >  		acpi_processor_make_not_present(device);
> > > > >  		return;
> > > > >  	}
> > > > > +
> > > > > +	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_ENABLED))
> > > > > +		arch_unregister_cpu(pr->id);      
> > > > 
> > > > This change isn't described in the commit log, but seems to be the cause
> > > > of the build error identified by the kernel build bot that is fixed
> > > > later in this series. I'm wondering whether this should be in a
> > > > different patch, maybe "ACPI: Check _STA present bit before making CPUs
> > > > not present" ?    
> > > 
> > > Would seem a bit odd to call arch_unregister_cpu() way before the code
> > > is added to call the matching arch_registers_cpu()
> > > 
> > > Mind you this eject doesn't just apply to those CPUs that are registered
> > > later I think, but instead to all.  So we run into the spec hole that
> > > there is no way to identify initially 'enabled' CPUs that might be disabled
> > > later.
> > >   
> > > > 
> > > > Or maybe my brain isn't working properly (due to being Covid positive.)
> > > > Any thoughts, Jonathan?    
> > > 
> > > I'll go with a resounding 'not sure' on where this change belongs.
> > > I blame my non existent start of the year hangover.
> > > Hope you have recovered!  
> > 
> > Looking again, I think you were right, move it to that earlier patch.  
> 
> I'm having second thoughts - because this patch introduces the
> arch_register_cpu() into the acpi_processor_add() path (via
> acpi_processor_get_info() and acpi_processor_make_enabled(), so isn't
> it also correct to add arch_unregister_cpu() to the detach/post_eject
> path as well? If we add one without the other, doesn't stuff become
> a bit asymetric?
> 
> Looking more deeply at these changes, I'm finding it isn't easy to
> keep track of everything that's going on here.

I can sympathize.

> 
> We had attach()/detach() callbacks that were nice and symetrical.
> How we have this post_eject() callback that makes things asymetrical.
> 
> We have the attach() method that registers the CPU, but no detach
> method, instead having the post_eject() method. On the face of it,
> arch_unregister_cpu() doesn't look symetric unless one goes digging
> more in the code - by that, I mean arch_register_cpu() only gets
> called of present=1 _and_ enabled=1. However, arch_unregister_cpu()
> gets called buried in acpi_processor_make_not_present(), called when
> present=0, and then we have this new one to handle the case where
> enabled=0. It is not obvious that arch_unregister_cpu() is the reverse
> of what happens with arch_register_cpu() here.

One option would be to pull the arch_unregister_cpu() out so it
happens in one place in both the present = 0 and enabled = 0 cases but
I'm not sure if it's safe to reorder the contents of 
acpi_processor_not_present() as it's followed by a bunch of things.

Would looks something like

if (cpu_present(pr->id)) {
	if (!(sta & ACPI_STA_DEVICE_PRESENT)) {
		acpi_processor_make_not_present(device); /* Remove arch_cpu_unregister() */
	} else if (!(sta & ACPI_STA_DEVICE_ENABLED)) {
		/* Nothing to do in this case */
	} else {
		return; /* Firmware did something silly - probably racing */
	}
	arch_unregister_cpu(pr->id);

	return;
}

> 
> Then we have the add() method allocating pr->throttling.shared_cpu_map,
> and acpi_processor_make_not_present() freeing it. From what I read in
> ACPI v6.5, enabled is not allowed to be set without present. So, if
> _STA reports that a CPU that had present=1 enabled=1, but then is
> later reported to be enabled=0 (which we handle by calling only
> arch_unregister_cpu()) then what happens when _STA changes to
> enabled=1 later? Does add() get called? 

yes it does (I poked it to see) which indeed isn't good (unless I've
broken my setup in some obscure way).

Seems we need a few more things than arch_unregister_cpu() pulled out
in the above code.


> If it does, this would cause
> a new acpi_processor structure to be allocated and the old one to be
> leaked... I hope I'm wrong about add() being called - but if it isn't,
> how does enabled going from 0->1 get handled... and if we are handling
> its 1->0 transition separately from present, then surely we should be
> handling that.
> 
> Maybe I'm just getting confused, but I've spent much of this morning
> trying to unravel all this... and I'm of the opinion that this isn't a
> sign of a good approach.

It's all annoyingly messy at the root of things, but indeed you've found
some issues in current implementation.  Feels like just ripping out
a bunch of stuff from acpi_processor_make_not_present() and calling it
for both paths will probably work, but I've not tested that yet.

Jonathan
> 


