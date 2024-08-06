Return-Path: <linux-arch+bounces-6029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A90494885F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 06:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50179281D1C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 04:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14451BA86F;
	Tue,  6 Aug 2024 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGhO6/vv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D227EADC;
	Tue,  6 Aug 2024 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722918531; cv=none; b=pC2CNMSHFdyPh5KVopy8UgIfmeRNeKCVSvfy+gVqGW/uVlDCbZZTh4v5uywPsPsGWneUdZGUHUIGc9zqmA3umuYNL+QU8Nsre9cUfQjwkfsC7rjMC6jIBYL6QSrzuQvMx5UHDC+KldAMyCg0i6gY+qSALbEAQCBd52aXMBBILME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722918531; c=relaxed/simple;
	bh=AS5b7+g/FCzcqVl/UqG+V9yJdrUatcHdi5X20U3QBrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1PsoWtNKsLxaQSFbNnjOKtch5OYxjKMNbFNSjuB1+TCf9lHbvWLVSYTgVmvh+wjCCxpVOAd10/J0mCkTAvbZZBBdYg9ISltgsTlvn72unnHqC6wEjEK+1BulL9mbEanGb9BXhL1RPHYA998ZBBC6Hh1n+rbD4WL7RF24f0IXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGhO6/vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1043C32786;
	Tue,  6 Aug 2024 04:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722918530;
	bh=AS5b7+g/FCzcqVl/UqG+V9yJdrUatcHdi5X20U3QBrU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PGhO6/vvMcJa5Zx8uYR3jw9Vh5ZDVX9Jmk2h/KhP+dzS92DHwzkMJVduz4BXKK3Sy
	 fB1j4GtGvQIzveoGmFL4Rq0sxXCVIi2pISQTfqy5uyX4qeFKo98zKCsj4yYVHb5JKp
	 W1Tb+7lSwbRw5aWJeVgbXhGS7YVwHs5Mmg94JzUtX+xrTg9YJdk90PIqOKybHFuF1G
	 cg6ewpMFIsYk8T+rDcpRPHj9Qr+wVYz5uj8Hzog6gJZ6Is+DDPeKNgZukJ80CLWpmW
	 CQmSiX+cayY7Ej45Zg8bIr8daPIb9Hjiel21IBVp+sjfHJ4myeovJw+7jRlSGbPby7
	 Gd/PlwrAdYxPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 790D6CE10CC; Mon,  5 Aug 2024 21:28:49 -0700 (PDT)
Date: Mon, 5 Aug 2024 21:28:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vineet Gupta <vgupta@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, torvalds@linux-foundation.org, arnd@arndb.de,
	geert@linux-m68k.org, palmer@rivosinc.com, mhiramat@kernel.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: [PATCH cmpxchg 2/3] ARC: Emulate one-byte cmpxchg
Message-ID: <3353ac4f-97ed-471b-bd19-96e0dbc41612@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
 <20240805192119.56816-2-paulmck@kernel.org>
 <eacb9a3c-0d76-47d2-8b80-59d6a58fe4b4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eacb9a3c-0d76-47d2-8b80-59d6a58fe4b4@kernel.org>

On Mon, Aug 05, 2024 at 06:27:57PM -0700, Vineet Gupta wrote:
> Hi Paul,
> 
> On 8/5/24 12:21, Paul E. McKenney wrote:
> > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on arc.
> >
> > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> > [ paulmck: Apply feedback from Naresh Kamboju. ]
> > [ paulmck: Apply kernel test robot feedback. ]
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Vineet Gupta <vgupta@kernel.org>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > Cc: <linux-snps-arc@lists.infradead.org>
> > ---
> >  arch/arc/Kconfig               |  1 +
> >  arch/arc/include/asm/cmpxchg.h | 33 ++++++++++++++++++++++++---------
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> > index fd0b0a0d4686a..163608fd49d18 100644
> > --- a/arch/arc/Kconfig
> > +++ b/arch/arc/Kconfig
> > @@ -13,6 +13,7 @@ config ARC
> >  	select ARCH_HAS_SETUP_DMA_OPS
> >  	select ARCH_HAS_SYNC_DMA_FOR_CPU
> >  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> > +	select ARCH_NEED_CMPXCHG_1_EMU
> >  	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
> >  	select ARCH_32BIT_OFF_T
> >  	select BUILDTIME_TABLE_SORT
> > diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> > index e138fde067dea..2102ce076f28b 100644
> > --- a/arch/arc/include/asm/cmpxchg.h
> > +++ b/arch/arc/include/asm/cmpxchg.h
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/build_bug.h>
> >  #include <linux/types.h>
> > +#include <linux/cmpxchg-emu.h>
> >  
> >  #include <asm/barrier.h>
> >  #include <asm/smp.h>
> > @@ -46,6 +47,9 @@
> >  	__typeof__(*(ptr)) _prev_;					\
> >  									\
> >  	switch(sizeof((_p_))) {						\
> > +	case 1:								\
> > +		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> > +		break;							\
> >  	case 4:								\
> >  		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
> >  		break;							\
> > @@ -65,16 +69,27 @@
> >  	__typeof__(*(ptr)) _prev_;					\
> >  	unsigned long __flags;						\
> >  									\
> > -	BUILD_BUG_ON(sizeof(_p_) != 4);					\
> 
> Is this alone not sufficient: i.e. for !LLSC let the atomic op happen
> under a spin-lock for non 4 byte quantities as well.

Now that you mention it, that would be a lot simpler.

> > +	switch(sizeof((_p_))) {						\
> > +	case 1:								\
> > +		__flags = cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> > +		_prev_ = (__typeof__(*(ptr)))__flags;			\
> > +		break;							\
> > +		break;							\
> 
> FWIW, the 2nd break seems extraneous.

And to your earlier point, the first break as well.  ;-)

How does the updated patch below look?  Or did I miss your point?

							Thanx, Paul

------------------------------------------------------------------------

commit 96c1107797ca329fe203818cdfda2fe5f5a9a82e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Mar 18 01:27:35 2024 -0700

    ARC: Emulate one-byte cmpxchg
    
    Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on arc.
    
    [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
    [ paulmck: Apply feedback from Naresh Kamboju. ]
    [ paulmck: Apply kernel test robot feedback. ]
    [ paulmck: Apply feedback from Vineet Gupta. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Vineet Gupta <vgupta@kernel.org>
    Cc: Andi Shyti <andi.shyti@linux.intel.com>
    Cc: Andrzej Hajda <andrzej.hajda@intel.com>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Palmer Dabbelt <palmer@rivosinc.com>
    Cc: <linux-snps-arc@lists.infradead.org>

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index fd0b0a0d4686a..163608fd49d18 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -13,6 +13,7 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067dea..58045c8983404 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -8,6 +8,7 @@
 
 #include <linux/build_bug.h>
 #include <linux/types.h>
+#include <linux/cmpxchg-emu.h>
 
 #include <asm/barrier.h>
 #include <asm/smp.h>
@@ -46,6 +47,9 @@
 	__typeof__(*(ptr)) _prev_;					\
 									\
 	switch(sizeof((_p_))) {						\
+	case 1:								\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
 		break;							\
@@ -65,8 +69,6 @@
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
-	BUILD_BUG_ON(sizeof(_p_) != 4);					\
-									\
 	/*								\
 	 * spin lock/unlock provide the needed smp_mb() before/after	\
 	 */								\

