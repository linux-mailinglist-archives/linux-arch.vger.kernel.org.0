Return-Path: <linux-arch+bounces-14750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3116C5D2D5
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 13:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891063B5731
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E123B63C;
	Fri, 14 Nov 2025 12:50:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA723ABB0;
	Fri, 14 Nov 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763124614; cv=none; b=MohwjzgU3yLwztDuPWkpgMU0GUkrgKfKV4soHiIR1RDxrXzdAt13JgvpXLYym04+21/6HMj2njwcOlcDaZnLQxzj+CfqocpsllsIhzSO62NdN5Pybx5+gDC7X8/3sJFCX7LDJl4E6WC8nC+VLNXRfSSrDz436QhZoRirm2EX94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763124614; c=relaxed/simple;
	bh=ZX0qxQEA/qKn1+mqswPWH2DE8zp8xPlwYue0yLuqu6g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7aAE30e5aSOqReEX+qPq4mcITbZS9pCaSkfUnSN6ALZ/hn3zn5WgeBrqf5ANgrFMOP4eACtKYlLNtuUh0Nz1NtRLiECQH0BqKPaf2rXW6d8HSv1t0JgWPqTDoDUej70kno6OQGz2saSGZMbsM7qdDVfwWyWuoT3FwiFtT6Kifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d7H5d6tbYzJ46jg;
	Fri, 14 Nov 2025 20:49:25 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id AECB714033C;
	Fri, 14 Nov 2025 20:50:01 +0800 (CST)
Received: from localhost (10.126.173.232) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 14 Nov
 2025 12:50:00 +0000
Date: Fri, 14 Nov 2025 12:49:58 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, Dan Williams
	<dan.j.williams@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
	Drew Fustini <fustini@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, <james.morse@arm.com>, Will Deacon <will@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v5 0/6]  Cache coherency management subsystem
Message-ID: <20251114124958.00006a85@huawei.com>
In-Reply-To: <20251108-spearmint-contend-aa3dd8a0220e@spud>
References: <20251031111709.1783347-1-Jonathan.Cameron@huawei.com>
	<20251108-spearmint-contend-aa3dd8a0220e@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Sat, 8 Nov 2025 20:02:52 +0000
Conor Dooley <conor@kernel.org> wrote:

> Arnd,
> 
> On Fri, Oct 31, 2025 at 11:17:03AM +0000, Jonathan Cameron wrote:
> > Support system level interfaces for cache maintenance as found on some
> > ARM64 systems. It is expected that systems using other CPU architectures
> > (such as RiscV) that support CXL memory and allow for native OS flows
> > will also use this. This is needed for correct functionality during
> > various forms of memory hotplug (e.g. CXL). Typical hardware has MMIO
> > interface found via ACPI DSDT. A system will often contain multiple
> > hardware instances.
> > 
> > Includes parameter changes to cpu_cache_invalidate_memregion() but no
> > functional changes for architectures that already support this call.
> > 
> > How to merge?
> > - Current suggestion would be via Conor's drivers/cache tree which routes
> >   through the SoC tree.  
> 
> I was gonna put this in linux-next, but I'm not really sure that Arnd
> was satisfied with the discussion on the previous version about
> suitability of the directory: https://lore.kernel.org/all/20251028114348.000006ed@huawei.com/
> 
> Arnd, did that response satisfy you, or nah?

Seems Arnd is busy.  Conor, if you are happy doing so, maybe push it to a tree
linux-next picks up, but hold off on the pull request until Arnd has had a chance
to reply?

Jonathan

> 
> Cheers,
> Conor.
> 
> >   *  Andrew Morton has expressed he is fine with the MM related changes
> >      going via another appropriate tree.
> >   *  CXL maintainers expressed that they don't consider it appropriate
> >      to go through theit tree.
> >   *  The tiny touching of Arm specific code has an ack from Catalin.  
> 


