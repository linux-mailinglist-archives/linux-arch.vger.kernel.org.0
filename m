Return-Path: <linux-arch+bounces-5199-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E6091C1A6
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 16:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0348B241E5
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE81C230E;
	Fri, 28 Jun 2024 14:49:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE21DDE9;
	Fri, 28 Jun 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586162; cv=none; b=jHB6N4jwplL5J2TfElEMKwpdFfqeqPbPZ7pzDgVnmDsQ3/pLBbB82oW8yto8GVCQf6lM01NhoxG8Qz2Xg52SpPzPP4BSS4klRaxjBWDpaK0hdAvp1Va1wsXfUfQjQZxQNSOV/P0WdCVHjEiE9gLxwtZMvGL0CTzsZmdjwbSCS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586162; c=relaxed/simple;
	bh=F8Z/G6QOk1hpF1CsAB/v8poGgbup+7UMAw5W0VYOVBg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxDbK1rYGAA41jDxZvKNp40ATh13PSt2xaMMzPIddSbWfXK6xk7ZDuq3RnopeTXyM2RUbHK3GjI5+XZ9I82XbkcorBZrjahefmK+ieyXUb/TuO/yscD5+ZSM8lQWXNpsei1HWQVKwDgEY2zP9EzU4KpKErYsU5n17sbvsshsQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W9dbz0KCcz6HJcq;
	Fri, 28 Jun 2024 22:48:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F8051400D3;
	Fri, 28 Jun 2024 22:49:11 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 28 Jun
 2024 15:49:10 +0100
Date: Fri, 28 Jun 2024 15:49:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Will Deacon <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>
CC: Marc Zyngier <maz@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	<loongarch@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Luis" <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, "Salil
 Mehta" <salil.mehta@huawei.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin Shan
	<gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>, Karl Heubaum
	<karl.heubaum@oracle.com>
Subject: Re: [PATCH v10 00/19] ACPI/arm64: add support for virtual cpu
 hotplug
Message-ID: <20240628154909.000044d9@Huawei.com>
In-Reply-To: <867celjfng.wl-maz@kernel.org>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
	<20240613112511.00006331@huawei.com>
	<867celjfng.wl-maz@kernel.org>
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

On Wed, 19 Jun 2024 13:11:47 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Thu, 13 Jun 2024 11:25:27 +0100,
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > On Wed, 29 May 2024 14:34:27 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > v10:
> > > - Make acpi_processor_set_per_cpu() return 0 / error rather than bool
> > >   to simplify error handling at the call sites.
> > >   (Thanks to both Rafael and Gavin who commented on this)
> > > - Gather tags.
> > > - Rebase on v6.10-rc1
> > > 
> > > The approach to the GICv3 changes stablized very late in the 6.10 cycle.
> > > Subject to Marc taking a final look at those, I think we are now
> > > in a good state wrt to those and the ACPI parts. The remaining code
> > > that hasn't received review tags from the relevant maintainers
> > > is the arm64 specific arch_register_cpu().  Given I think this will go
> > > through the arm64 tree, hopefully they have just been waiting for
> > > everything else to be ready.  
> > 
> > Marc, Will, Catalin,
> > 
> > Any comments on this series?  We definitely want to finally land this
> > in 6.11!
> > 
> > Marc, in practice I think you already gave feedback on the the GICv3
> > changes in here as part of the discussions in the earlier version threads,
> > but if you have time for a final glance through it would be much appreciated.
> > Thanks for all your earlier help on this btw.  
> 
> I've had a quick look and the GICv3 parts look OK to me (you should
> now have by tags for both patches).
> 
> Thanks,
> 
> 	M.

Thanks again for your help with this one Marc.

Will, Catalin? We are nearly at RC6 and this series has been unchanged all cycle.
Great to hear your opinions on this.  My assumption is that it will go through
your tree if you are happy with it.

Thanks,

Jonathan




