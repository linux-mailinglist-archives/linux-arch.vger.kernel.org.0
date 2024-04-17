Return-Path: <linux-arch+bounces-3761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828318A8667
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A50B25538
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB14146A96;
	Wed, 17 Apr 2024 14:41:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C21428E2;
	Wed, 17 Apr 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364911; cv=none; b=JAjpmj7RZDI5erGzd7bmi3JPgXtTvcKOaV2riLzpK94kioJrND7A+xqB27cIGgzc4em80T7rEhKb0uQc2UdCI3dH2lUjlSI5zGLMarexQSBh87GI0RI52t0Yxz4Nltfv2xAgITD0K5TDl/xS+fZp044XGcZ0BCnK0I9YBijLaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364911; c=relaxed/simple;
	bh=2bBUJpkv4u0ce+Rp18oWAx6MoLI8B1peg59e65KozMI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSI3feGv2Uzm7JE2+YHO+EiquldKyfO/6WLV4nt+0VdqDf4scTsm7Y+Lr4RfjYbkhTflr1Ika/scSTN7djaFO8G3q/flELTfnaXJHjhHLhJ+06lRAFg2W+gXJz/q3RhiT39TlMqE1VGewgpUpFR6FEAXJImVqBWqH+7sP/8T6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKNlG239gz6D8ym;
	Wed, 17 Apr 2024 22:36:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 09442140B38;
	Wed, 17 Apr 2024 22:41:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 15:41:39 +0100
Date: Wed, 17 Apr 2024 15:41:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel Luis
	<miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linuxarm@huawei.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v6 02/16] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
Message-ID: <20240417154138.0000511b@Huawei.com>
In-Reply-To: <Zh/WPYMJYepLbST/@shell.armlinux.org.uk>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
	<20240417131909.7925-3-Jonathan.Cameron@huawei.com>
	<Zh/WPYMJYepLbST/@shell.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 17 Apr 2024 15:01:33 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 17, 2024 at 02:18:55PM +0100, Jonathan Cameron wrote:
> > For arm64 the CPU registration cannot complete until the ACPI
> > interpreter us up and running so in those cases the arch specific
> > arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> > registration will be attempted later.
> > 
> > Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > v6: tags
> > ---
> >  drivers/base/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 56fba44ba391..b9d0d14e5960 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -558,7 +558,7 @@ static void __init cpu_dev_register_generic(void)
> >  
> >  	for_each_present_cpu(i) {
> >  		ret = arch_register_cpu(i);
> > -		if (ret)
> > +		if (ret != -EPROBE_DEFER)
> >  			pr_warn("register_cpu %d failed (%d)\n", i, ret);  
> 
> This looks very broken to me.
> 
> 		if (ret && ret != -EPROBE_DEFER)
> 
> surely, because we don't want to print a warning if arch_register_cpu()
> was successful?

Gah.  Excellent point.

thanks,

Jonathan

> 


