Return-Path: <linux-arch+bounces-12974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80329B13F8F
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB3017717E
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B9273D9A;
	Mon, 28 Jul 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iZL3rH/O"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEB274B41
	for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2025 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718713; cv=none; b=Ptk/8q8zOHR7ah9Ie05xvbY4ygFIzZt9ZwcqZHGC2r3PSeWk8lggs6gQzq1ohsbfm90T7DXX4U3ZAgrmQ9SsLc3s8f00FFlakH1xFVvLLn+M/IJuzu/J4fhLkPeLvIRgt/5evZcCll7sf0ucMV3qHrF6e6h1eiUtzK4PdeIFG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718713; c=relaxed/simple;
	bh=NbRPVnLVavH6LCrMGewbNUQnbG9vLo9tmDfFUwpFCSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIqmUJNUR+VYx3YkoQTEIMwyIB6IRT6vxSAMS5LEFcA+iBFAxIUPdhEpWbUMBMDZyLUqJtcBQs3+XzAKaeGun1jm8hPG5Sz2Gb1H4J77JYsZgoghBu4FKtubNnZgnj58wcSp0/kMEkecIy1nVTJnEjEq0JIVGVkzJ6+8UgxoEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iZL3rH/O; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753718707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVAGEmVQivoenw+PuhZbfG45bOVJetfwBov2q28tJeM=;
	b=iZL3rH/OA7FED0dzkOn8GdHFHfz4vGTSnPzD0TI9edaOwIGy3RvXl9RDKQE0MqbCZmP92q
	Mc72es2gf/APVHvmSDKjquilHwGZTGZTZ5wtsjTWc/CvdTh5C2OcAVtWKKn1kIOtCHaQU+
	A3kmfzGoMdHPTGa33baBWimBlRhYxoQ=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH 9/9] um: Add initial SMP support
Date: Tue, 29 Jul 2025 00:04:19 +0800
Message-Id: <20250728160419.3256752-1-tiwei.bie@linux.dev>
In-Reply-To: <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
References: <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 28 Jul 2025 12:47:08 +0200, Johannes Berg wrote:
> On Sun, 2025-07-27 at 14:29 +0800, Tiwei Bie wrote:
> > 
> > +++ b/arch/um/include/asm/smp.h
> > @@ -2,6 +2,27 @@
> >  #ifndef __UM_SMP_H
> >  #define __UM_SMP_H
> >  
> > -#define hard_smp_processor_id()		0
> > +#if IS_ENABLED(CONFIG_SMP)
> > +
> > +#include <linux/bitops.h>
> > +#include <asm/current.h>
> > +#include <linux/cpumask.h>
> > +#include <shared/smp.h>
> > +
> > +#define raw_smp_processor_id() uml_curr_cpu()
> > +
> > +void arch_smp_send_reschedule(int cpu);
> > +
> > +void arch_send_call_function_single_ipi(int cpu);
> > +
> > +void arch_send_call_function_ipi_mask(const struct cpumask *mask);
> > +
> > +static inline void smp_cpus_done(unsigned int maxcpus) { }
> > +
> > +#else /* !CONFIG_SMP */
> > +
> > +#define raw_smp_processor_id() 0
> 
> This seems a bit odd to me, linux/smp.h also defines
> raw_smp_processor_id() to 0 the same way, unconditionally.
> 
> It almost seems to me we should define raw_smp_processor_id() only for
> SMP? But then also __smp_processor_id()? Maybe not?

I think you're right. I should't define raw_smp_processor_id() for non-SMP.

> 
> linux-arch folks, do you have any comments?
> 
> > --- /dev/null
> > +++ b/arch/um/include/asm/spinlock.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_UM_SPINLOCK_H
> > +#define __ASM_UM_SPINLOCK_H
> > +
> > +#include <asm/processor.h>
> > +#include <asm-generic/spinlock.h>
> > +
> > +#endif /* __ASM_UM_SPINLOCK_H */
> 
> Do we need this file? Maybe asm-generic should be including the right
> things it needs?

I added this file to include asm/processor.h; otherwise, there would be
a lot of compilation errors. Other architectures seem to do the same:

$ grep -r asm/processor.h arch/ | grep asm/spinlock.h
arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>

> 
> > +void enter_turnstile(struct mm_id *mm_id);
> > +void exit_turnstile(struct mm_id *mm_id);
> 
> We could add __acquires(turnstile) and __releases(turnstile) or
> something, to have sparse check that it's locked/unlocked correctly, but
> not sure it's worth it.

Will do.

> 
> > +int disable_kmalloc[NR_CPUS] = { 0 };
> 
> nit: you can remove the "0".

Will fix all the nits in the next version.

> 
> > +int smp_sigio_handler(struct uml_pt_regs *regs)
> > +{
> > +	int cpu = raw_smp_processor_id();
> > +
> > +	IPI_handler(cpu, regs);
> > +	if (cpu != 0)
> > +		return 1;
> > +	return 0;
> 
> nit: "return cpu != 0;" perhaps
> 
> > +__uml_setup("ncpus=", uml_ncpus_setup,
> > +"ncpus=<# of desired CPUs>\n"
> > +"    This tells UML how many virtual processors to start. The maximum\n"
> > +"    number of supported virtual processors can be obtained by querying\n"
> > +"    the CONFIG_NR_CPUS option using --showconfig.\n\n"
> 
> 
> I feel like probably this should at least for now be mutually exclusive
> with time-travel= parameters, at least if it's not 1? Or perhaps only
> with time-travel=ext?

Currently, the UML_TIME_TRAVEL_SUPPORT option depends on !SMP:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/um/Kconfig?h=v6.16#n218

so they can't be enabled at the same time during build.

> 
> The timer code is in another patch, will look at that also. I guess
> until then it's more of a gut feeling on "how would this work" :)

Thanks for the review! :)

Regards,
Tiwei

