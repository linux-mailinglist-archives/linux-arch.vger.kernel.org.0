Return-Path: <linux-arch+bounces-12983-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1DEB15813
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jul 2025 06:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D209D17F0D6
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jul 2025 04:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010E1A08AF;
	Wed, 30 Jul 2025 04:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mXdQpiuE"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37118B0F
	for <linux-arch@vger.kernel.org>; Wed, 30 Jul 2025 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753849138; cv=none; b=DFPdDachOGCFepRZnaT0HBABNcIjSW6zlsSHhByZPU2Wgv/8pa4x2ju3VAeNafAb/zKHdGJDe6ssD7em0q8CTZdmx/sxBpGffPA4VPu0UKP9VUFGBNBkJkU4u1oe3XfGUWFLiuuDCxRkbBT8LjV1oj99mTAkC7eWspPm5dbj2vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753849138; c=relaxed/simple;
	bh=jmKPHLMbRnAKa8U4+ef2lfCmCQ8v83m8my5Ux5l2Lqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nyFJs/i7w5ljNQs5IDkpEPM0xTwqXN/D5wVy4hlgm9vVd5BQvEq5pToLXeoSwQCzGiFSroCRnVruI1dlCWmEgkTv9KYX4tNwyiQYKdZAv5IIgierQk2TgGDfjxsfyNJBKEMkoNkaPj8D3B25UgH2f+bUiSa4H63jtPE/Q/jJvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mXdQpiuE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753849133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJZ2Xdj7Q+MZcbLlvMM9U359yJ94gJvtKBItcmsRF+0=;
	b=mXdQpiuERJ/szZLSa+HIe1frE8Nh8q8KH3xJJ9ssfQNK3ieWrfGXR98n4kwZG4sHR5Yea0
	uzCfYbW59jAl8v45r4gzkUP2WL3uvtaPfxfDLSbpsxSSK0lvhT4SvB/FpWGMFXDbPT/2m+
	rkkbSBGWMY+MA5L1UFlXq52M3kTNaMc=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH 9/9] um: Add initial SMP support
Date: Wed, 30 Jul 2025 12:18:38 +0800
Message-Id: <20250730041838.1821401-1-tiwei.bie@linux.dev>
In-Reply-To: <8bfc7ba021d584d30ac25c06d142d06dd72f15d0.camel@sipsolutions.net>
References: <8bfc7ba021d584d30ac25c06d142d06dd72f15d0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 29 Jul 2025 17:37:24 +0200, Johannes Berg wrote:
> On Tue, 2025-07-29 at 23:06 +0800, Tiwei Bie wrote:
> > On Mon, 28 Jul 2025 18:27:53 +0200, Johannes Berg wrote:
> > > On Tue, 2025-07-29 at 00:04 +0800, Tiwei Bie wrote:
> > > > > > +++ b/arch/um/include/asm/spinlock.h
> > > > > > @@ -0,0 +1,8 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > +#ifndef __ASM_UM_SPINLOCK_H
> > > > > > +#define __ASM_UM_SPINLOCK_H
> > > > > > +
> > > > > > +#include <asm/processor.h>
> > > > > > +#include <asm-generic/spinlock.h>
> > > > > > +
> > > > > > +#endif /* __ASM_UM_SPINLOCK_H */
> > > > > 
> > > > > Do we need this file? Maybe asm-generic should be including the right
> > > > > things it needs?
> > > > 
> > > > I added this file to include asm/processor.h; otherwise, there would be
> > > > a lot of compilation errors. Other architectures seem to do the same:
> > > > 
> > > > $ grep -r asm/processor.h arch/ | grep asm/spinlock.h
> > > > arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>
> > > 
> > > Except for loongarch they all do something else too though. Feels to me
> > > um (and loongarch) really shouldn't need that file.
> > 
> > Sorry for the confusion. My point is that since other architectures
> > also do this, it seems common practice to include asm/processor.h in
> > asm/spinlock.h when necessary.
> 
> Yeah, I understand.
> 
> > 
> > The reason we need to include asm/processor.h in asm/spinlock.h on UML
> > is because:
> > 
> > ticket_spin_lock() (which is an inline function indirectly provided by
> > asm-generic/spinlock.h) relies on atomic_cond_read_acquire(), which
> > is defined as smp_cond_load_acquire().
> 
> Right, but that's not the architecture's "fault".
> 
> It seems to me that either spinlock.h should include asm/processor.h for
> it,

+1

> or (at least, but I think less appropriate) asm-generic/spinlock.h
> should be doing this.
> 
> > On UML, smp_cond_load_acquire() is provided by asm-generic/barrier.h,
> > and it relies on smp_cond_load_relaxed(), which is also provided by
> > asm-generic/barrier.h on UML. And smp_cond_load_relaxed() is a macro
> > that relies on cpu_relax(), which is provided by asm/processor.h.
> 
> In general though, there ought to be some definition of which header
> file(s) is/are expected to provide smp_cond_load_acquire() and/or
> atomic_cond_read_acquire(). And that header file/those header files
> should be included by the files that use the functions/macros.
> 
> 
> IOW, I think you've stumbled across an inconsistency in the generic
> files, and hence we should fix that, rather than having each
> architecture paper over it.

That does make sense. I will prepare a patch for that. Thanks!

Regards,
Tiwei

