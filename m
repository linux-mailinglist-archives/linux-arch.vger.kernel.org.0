Return-Path: <linux-arch+bounces-12981-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1295B14FF8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jul 2025 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E1A16F3FA
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jul 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D411F956;
	Tue, 29 Jul 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BFtYeS5P"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5940634EC
	for <linux-arch@vger.kernel.org>; Tue, 29 Jul 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801646; cv=none; b=NJFPspf+Lp9D9wV1RWdqQCWi7gIS3n3esVplsTdNkg8SKldodCuMWIbJomkUDUWku2b0f1zT8Acg6ysy9wUbZdeJfbxoQiBKMY0xwQmRDdxcd5Ip1J5JEeUATkupqlQxaiGp3Bl047tlsBdplTphPT9ln9Pv2AEV9YZRK59J7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801646; c=relaxed/simple;
	bh=YDXXR35EceFagrwwTnFsD/vt2j0nAubAD//YT09OdbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MApzTrsmr9ZrbnQ1W1H3vW1Y7dANIcy92PbMmgEDxSawGX2i6zPsaGJFd+tD4LdQdEf/aX296w2DqNWNeMAU3Wc3EnEyEh2vhwWYdnKfevDtomyCmL1aNE0dwjYsqwe0DMlKyweqTeNs5i3VbYuy8M43HzmJeeyI8VUUS/vRsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BFtYeS5P; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753801641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTilVCpqvxH+4gYgNeiGBFREOhDOFzc+K7BZeKbL4sU=;
	b=BFtYeS5P+X9efbIIHY66JKozTTmsQlW+Cn6QSgRwiVAdET5Ex5Utw9SfrzGMHe0uvhr3jk
	zuTQOPV4ZRIAft3Lxmb1dl7uVVxDuZvW1FiQNyL2bA+V6M+KbfxejQoA0dKivmr2uvfBiD
	R4UTslYF3H5GpeKJAtj6UoIf7zHtOnk=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH 9/9] um: Add initial SMP support
Date: Tue, 29 Jul 2025 23:06:51 +0800
Message-Id: <20250729150651.1957466-1-tiwei.bie@linux.dev>
In-Reply-To: <1310a0eaf8c8e3a1e944ad3f4f289f02164702cf.camel@sipsolutions.net>
References: <1310a0eaf8c8e3a1e944ad3f4f289f02164702cf.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 28 Jul 2025 18:27:53 +0200, Johannes Berg wrote:
> On Tue, 2025-07-29 at 00:04 +0800, Tiwei Bie wrote:
> > > > +++ b/arch/um/include/asm/spinlock.h
> > > > @@ -0,0 +1,8 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef __ASM_UM_SPINLOCK_H
> > > > +#define __ASM_UM_SPINLOCK_H
> > > > +
> > > > +#include <asm/processor.h>
> > > > +#include <asm-generic/spinlock.h>
> > > > +
> > > > +#endif /* __ASM_UM_SPINLOCK_H */
> > > 
> > > Do we need this file? Maybe asm-generic should be including the right
> > > things it needs?
> > 
> > I added this file to include asm/processor.h; otherwise, there would be
> > a lot of compilation errors. Other architectures seem to do the same:
> > 
> > $ grep -r asm/processor.h arch/ | grep asm/spinlock.h
> > arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>
> 
> Except for loongarch they all do something else too though. Feels to me
> um (and loongarch) really shouldn't need that file.

Sorry for the confusion. My point is that since other architectures
also do this, it seems common practice to include asm/processor.h in
asm/spinlock.h when necessary.

The reason we need to include asm/processor.h in asm/spinlock.h on UML
is because:

ticket_spin_lock() (which is an inline function indirectly provided by
asm-generic/spinlock.h) relies on atomic_cond_read_acquire(), which
is defined as smp_cond_load_acquire().

On UML, smp_cond_load_acquire() is provided by asm-generic/barrier.h,
and it relies on smp_cond_load_relaxed(), which is also provided by
asm-generic/barrier.h on UML. And smp_cond_load_relaxed() is a macro
that relies on cpu_relax(), which is provided by asm/processor.h.

If we don't include asm/processor.h in asm/spinlock.h, ticket_spin_lock()
will fail to build:

./include/asm-generic/ticket_spinlock.h: In function ‘ticket_spin_lock’:
./include/asm-generic/barrier.h:253:17: error: implicit declaration of function ‘cpu_relax’ [-Werror=implicit-function-declaration]
  253 |                 cpu_relax();                                    \
      |                 ^~~~~~~~~
./include/asm-generic/barrier.h:270:16: note: in expansion of macro ‘smp_cond_load_relaxed’
  270 |         _val = smp_cond_load_relaxed(ptr, cond_expr);           \
      |                ^~~~~~~~~~~~~~~~~~~~~
./include/linux/atomic.h:28:40: note: in expansion of macro ‘smp_cond_load_acquire’
   28 | #define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
      |                                        ^~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/ticket_spinlock.h:49:9: note: in expansion of macro ‘atomic_cond_read_acquire’
   49 |         atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~

I can add a comment for it like this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/sparc/include/asm/spinlock_32.h?h=v6.16#n14

Regards,
Tiwei

