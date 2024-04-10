Return-Path: <linux-arch+bounces-3533-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3D89F283
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 14:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A8AB244B5
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CB015AAAE;
	Wed, 10 Apr 2024 12:43:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237412EBEF;
	Wed, 10 Apr 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753007; cv=none; b=Z5HSWlGl97YtCfHtJCmYRzyFaWcqDt58uurGSJFN+F1W3aKtjAlISuRgzjZy6958PcsrLFsoGUoEvt3xIwVKkOLyTxi/gm9t06jDgz37oB6xJV6Zz5Qs57dAXcndPqghLV1UiyZjx3vmuTv72uhP2lc0Q0f8clXaTLpBaFzMaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753007; c=relaxed/simple;
	bh=oNXkmJLZw0UUlzScvUERB+oZiwnYTzIkRhGzopuv6w0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLcJmoohYh4zMuEfFMNApVZR8SGv9dkwP1SUPucNozgW4cC4qrPBKcAyFQ3eDuyjUj2oUuZtFdIw9Lydc7UcZSjtIVqVFUPtyJldlL7G1wuZX82OsEMgW5JqsPePevzbLjo2fA8yXumyFdvwCQMBMcPwzUoWUCJu2UYnCL9NoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF2Wn6z5Vz6K6Cs;
	Wed, 10 Apr 2024 20:41:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AB478140DD4;
	Wed, 10 Apr 2024 20:43:19 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 13:43:19 +0100
Date: Wed, 10 Apr 2024 13:43:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, <linux-csky@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, <jianyong.wu@arm.com>,
	<justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <20240410134318.0000193c@huawei.com>
In-Reply-To: <20240322185327.00002416@Huawei.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
	<20240322185327.00002416@Huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> >   
> > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > index 47de0f140ba6..13d052bf13f4 100644
> > > --- a/drivers/base/cpu.c
> > > +++ b/drivers/base/cpu.c
> > > @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
> > >  {
> > >         int i, ret;
> > >
> > > -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> > > +       /*
> > > +        * When ACPI is enabled, CPUs are registered via
> > > +        * acpi_processor_get_info().
> > > +        */
> > > +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
> > >                 return;    
> > 
> > Honestly, this looks like a quick hack to me and it absolutely
> > requires an ACK from the x86 maintainers to go anywhere.  
> Will address this separately.
> 

So do people prefer this hack, or something along lines of the following?

static int __init cpu_dev_register_generic(void)
{
        int i, ret = 0;

        for_each_online_cpu(i) {
                if (!get_cpu_device(i)) {
                        ret = arch_register_cpu(i);
                        if (ret)
                                pr_warn("register_cpu %d failed (%d)\n", i, ret);
                }
        }
	//Probably just eat the error.
        return 0;
}
subsys_initcall_sync(cpu_dev_register_generic);

Which may look familiar at it's effectively patch 3 from v3 which was dealing
with CPUs missing from DSDT (something we think doesn't happen).

It might be possible to elide the arch_register_cpu() in
make_present() but that will mean we use different flows in this patch set
for the hotplug and initially present cases which is a bit messy.

I've tested this lightly on arm64 and x86 ACPI + DT booting and it "seems" fine.

Jonathan

> >   
> > >
> > >         for_each_present_cpu(i) {
> > > --    
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


