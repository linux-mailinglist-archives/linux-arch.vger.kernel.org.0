Return-Path: <linux-arch+bounces-3991-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06C8B34A7
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 11:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884E7283FE0
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0D14039A;
	Fri, 26 Apr 2024 09:57:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCF140388;
	Fri, 26 Apr 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125472; cv=none; b=ZnsOooNSBcOwuNhMOBQUPlgSiu7A11gOVCVfxfXp9PMl8V7CHEqh8htrW0M257dg/XhKRuWhicGtVxyMJC3gagvn+76zVy6k7+ea/iFkgVOZY5aZ/pJAXJ9Ym5i7jgAfHmn22QoTkJBesV+ZeRy15FnVXA45VgYKj1DwlKO/a8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125472; c=relaxed/simple;
	bh=YnunoMN8nkdnM17N5BzTnP4Rk0EAfSVEPkyuNjEpSow=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z10pMqm01N9HqLmtQ1Eb+SQaMDIgcMxtpyjy/w0fDWWiKtq7IBZl7M6asXHyvSHqw9rERmZv4mN+CEiy6AYtomJoXRQrH5Jn5wmi54ws3Za2ssnx7LSUwED0rydUgzbECVUyA71B0h29rWdGRZyv7y61X3ruSPySIDzYHTLT9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQp4K2HcZz6K6tS;
	Fri, 26 Apr 2024 17:55:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 82256140B2A;
	Fri, 26 Apr 2024 17:57:41 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 10:57:40 +0100
Date: Fri, 26 Apr 2024 10:57:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gavin Shan <gshan@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linuxarm@huawei.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 12/16] arm64: psci: Ignore DENIED CPUs
Message-ID: <20240426105739.00007879@huawei.com>
In-Reply-To: <e4628e32-8e76-4db4-9c85-b1246186f3be@redhat.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-13-Jonathan.Cameron@huawei.com>
	<e4628e32-8e76-4db4-9c85-b1246186f3be@redhat.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Apr 2024 19:36:10 +1000
Gavin Shan <gshan@redhat.com> wrote:

> On 4/18/24 23:54, Jonathan Cameron wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When a CPU is marked as disabled, but online capable in the MADT, PSCI
> > applies some firmware policy to control when it can be brought online.
> > PSCI returns DENIED to a CPU_ON request if this is not currently
> > permitted. The OS can learn the current policy from the _STA enabled bit.
> > 
> > Handle the PSCI DENIED return code gracefully instead of printing an
> > error.
> > 
> > See https://developer.arm.com/documentation/den0022/f/?lang=en page 58.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > [ morse: Rewrote commit message ]
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v7: No change
> > ---
> >   arch/arm64/kernel/psci.c | 2 +-
> >   arch/arm64/kernel/smp.c  | 3 ++-
> >   2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> > index 29a8e444db83..fabd732d0a2d 100644
> > --- a/arch/arm64/kernel/psci.c
> > +++ b/arch/arm64/kernel/psci.c
> > @@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
> >   {
> >   	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
> >   	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
> > -	if (err)
> > +	if (err && err != -EPERM)
> >   		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
> >   
> >   	return err;
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 4ced34f62dab..dc0e0b3ec2d4 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -132,7 +132,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
> >   	/* Now bring the CPU into our world */
> >   	ret = boot_secondary(cpu, idle);
> >   	if (ret) {
> > -		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
> > +		if (ret != -EPERM)
> > +			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
> >   		return ret;
> >   	}
> >     
> 
> The changes in smp.c are based the assumption that PSCI is the only backend, which
> isn't true. So we probably need move this error message to specific backend, which
> could be PSCI, ACPI parking protocol, or smp_spin_table.

Do we? I'll check but I doubt other options ever return -EPERM so this change should
not impact those at all.  If they do add support in future for rejecting on the basis
of not having permission then this is fine anyway.

Jonathan


> 
> Thanks,
> Gavin
> 


