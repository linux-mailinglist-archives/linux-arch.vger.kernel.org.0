Return-Path: <linux-arch+bounces-1441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5ED838BB5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5581F2277A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66A85A780;
	Tue, 23 Jan 2024 10:26:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599658126;
	Tue, 23 Jan 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005570; cv=none; b=N/KEeD1T3nNmM0MshVjj4QFKtyCXGOGNo8bvvVj/Q1J4B2CyO9h5K0F//TYyqHsvG7RBgsDfl5dNxhb5KAtr3FsPI2vixaETbXSTZ5fSmwLaMXv4wwiPgAtwr9sTmAaS5Dh+CvOynkJpdWeKbjNFEXBwUTjaTcK3j7G6IBkQP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005570; c=relaxed/simple;
	bh=FUcwLqqqNQfLITWpcgPePxChaMrTvzUqpYt/KMz8MZs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CX95qIGem2bFjX7CMCUVbQavCMvtvNoSNWyFMAnqARnDlSLdvSr1LvfB9TCug+PiKvI/nPXBwh65dsMy5/a2t4+VVWqGNhrtjItfNIpEuWnWo4uyvoZZy/Duv7VLHuexJG1vJnCeMhfEjFjb/VhwDft0AYdQkdCxMOXFNE1WvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TK37w3nrBz6JB35;
	Tue, 23 Jan 2024 18:23:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 56FC3140A86;
	Tue, 23 Jan 2024 18:26:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:26:04 +0000
Date: Tue, 23 Jan 2024 10:26:03 +0000
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
Message-ID: <20240123102603.00004244@Huawei.com>
In-Reply-To: <20240102145320.000062f9@Huawei.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOhC-00DvlI-Pp@rmk-PC.armlinux.org.uk>
	<ZYBDJG1g7SH7AiM1@shell.armlinux.org.uk>
	<20240102145320.000062f9@Huawei.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 2 Jan 2024 14:53:20 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 18 Dec 2023 13:03:32 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Dec 13, 2023 at 12:50:38PM +0000, Russell King wrote:  
> > > From: James Morse <james.morse@arm.com>
> > > 
> > > acpi_processor_get_info() registers all present CPUs. Registering a
> > > CPU is what creates the sysfs entries and triggers the udev
> > > notifications.
> > > 
> > > arm64 virtual machines that support 'virtual cpu hotplug' use the
> > > enabled bit to indicate whether the CPU can be brought online, as
> > > the existing ACPI tables require all hardware to be described and
> > > present.
> > > 
> > > If firmware describes a CPU as present, but disabled, skip the
> > > registration. Such CPUs are present, but can't be brought online for
> > > whatever reason. (e.g. firmware/hypervisor policy).
> > > 
> > > Once firmware sets the enabled bit, the CPU can be registered and
> > > brought online by user-space. Online CPUs, or CPUs that are missing
> > > an _STA method must always be registered.    
> > 
> > ...
> >   
> > > @@ -526,6 +552,9 @@ static void acpi_processor_post_eject(struct acpi_device *device)
> > >  		acpi_processor_make_not_present(device);
> > >  		return;
> > >  	}
> > > +
> > > +	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_ENABLED))
> > > +		arch_unregister_cpu(pr->id);    
> > 
> > This change isn't described in the commit log, but seems to be the cause
> > of the build error identified by the kernel build bot that is fixed
> > later in this series. I'm wondering whether this should be in a
> > different patch, maybe "ACPI: Check _STA present bit before making CPUs
> > not present" ?  
> 
> Would seem a bit odd to call arch_unregister_cpu() way before the code
> is added to call the matching arch_registers_cpu()
> 
> Mind you this eject doesn't just apply to those CPUs that are registered
> later I think, but instead to all.  So we run into the spec hole that
> there is no way to identify initially 'enabled' CPUs that might be disabled
> later.
> 
> > 
> > Or maybe my brain isn't working properly (due to being Covid positive.)
> > Any thoughts, Jonathan?  
> 
> I'll go with a resounding 'not sure' on where this change belongs.
> I blame my non existent start of the year hangover.
> Hope you have recovered!

Looking again, I think you were right, move it to that earlier patch.

J
> 
> Jonathan
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


