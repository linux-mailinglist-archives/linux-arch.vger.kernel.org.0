Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B766477365E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 04:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjHHCMe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 22:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjHHCMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 22:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE91711;
        Mon,  7 Aug 2023 19:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E3AC62377;
        Tue,  8 Aug 2023 02:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A6CC433C9;
        Tue,  8 Aug 2023 02:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691460748;
        bh=VRkYha2WcYiFCfW1jnh2VzYnyzSI0BELp4Vbm5rvuJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIDPQ2tkRoESMxlHw70sgk7jaT2faK4xi7GqlRBnpsnrfAGVWf56MAMy5koAx3fEu
         rc8orB5Jl57n/+LS4Q+M8wXPJlijTHZ/Mf+BbCq7fRz0uH9WVui1WSDJbW/sdv74h6
         hpcz6wB9Nf+Kae77HrB87LBryEUzWLuy8NCpFfX9qOy/CmCuFW+WeZJHruny88kTUU
         g+w7Yzys9y9TwUPJEJ4M+eT+sn+F/H3G+VIWsU/UsSfzSpmjECNB4p90XnDdXv0hcn
         A0ZPCj9ITwAzmSiKqhaCLUy9pW4lcrGn647Zu7X+t/8052h+2ejyG/w7z2f/x1Cre8
         vHXMHucz3xXmA==
Date:   Mon, 7 Aug 2023 22:12:15 -0400
From:   Guo Ren <guoren@kernel.org>
To:     Stefan O'Rear <sorear@fastmail.com>
Cc:     paul.walmsley@sifive.com, Anup Patel <anup@brainfault.org>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, paulmck@kernel.org,
        rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, Conor Dooley <conor.dooley@microchip.com>,
        xiaoguang.xing@sophgo.com,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        alexghiti@rivosinc.com, Kees Cook <keescook@chromium.org>,
        greentime.hu@sifive.com, Andrew Jones <ajones@ventanamicro.com>,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        guoren@kernel.org
Subject: Re: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce
 ERRATA_THEAD_QSPINLOCK
Message-ID: <ZNGkf88lhPt7fdhH@gmail.com>
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-8-guoren@kernel.org>
 <ae320af5-6cca-4689-aa66-9d0193713d40@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae320af5-6cca-4689-aa66-9d0193713d40@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07, 2023 at 01:23:34AM -0400, Stefan O'Rear wrote:
> On Wed, Aug 2, 2023, at 12:46 PM, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > According to qspinlock requirements, RISC-V gives out a weak LR/SC
> > forward progress guarantee which does not satisfy qspinlock. But
> > many vendors could produce stronger forward guarantee LR/SC to
> > ensure the xchg_tail could be finished in time on any kind of
> > hart. T-HEAD is the vendor which implements strong forward
> > guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
> > with errata help.
> >
> > T-HEAD early version of processors has the merge buffer delay
> > problem, so we need ERRATA_WRITEONCE to support qspinlock.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig.errata              | 13 +++++++++++++
> >  arch/riscv/errata/thead/errata.c       | 24 ++++++++++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h   | 20 ++++++++++++++++++++
> >  arch/riscv/include/asm/vendorid_list.h |  3 ++-
> >  arch/riscv/kernel/cpufeature.c         |  3 ++-
> >  5 files changed, 61 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index 4745a5c57e7c..eb43677b13cc 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -96,4 +96,17 @@ config ERRATA_THEAD_WRITE_ONCE
> > 
> >  	  If you don't know what to do here, say "Y".
> > 
> > +config ERRATA_THEAD_QSPINLOCK
> > +	bool "Apply T-Head queued spinlock errata"
> > +	depends on ERRATA_THEAD
> > +	default y
> > +	help
> > +	  The T-HEAD C9xx processors implement strong fwd guarantee LR/SC to
> > +	  match the xchg_tail requirement of qspinlock.
> > +
> > +	  This will apply the QSPINLOCK errata to handle the non-standard
> > +	  behavior via using qspinlock instead of ticket_lock.
> > +
> > +	  If you don't know what to do here, say "Y".
> 
> If this is to be applied, I would like to see a detailed explanation somewhere,
> preferably with citations, of:
> 
> (a) The memory model requirements for qspinlock
These were written in commit: a8ad07e5240 ("asm-generic: qspinlock: Indicate the use of
mixed-size atomics"). For riscv, the most controversial point is xchg_tail()
implementation for native queued spinlock.

> (b) Why, with arguments, RISC-V does not architecturally meet (a)
In the spec "Eventual Success of Store-Conditional Instructions":
"By contrast, if other harts or devices continue to write to that reservation set, it is
not guaranteed that any hart will exit its LR/SC loop."

1. The arch_spinlock_t is 32-bit width, and it contains LOCK_PENDING
   part and IDX_TAIL part.
    - LOCK:     lock holder
    - PENDING:  next waiter (Only once per contended situation)
    - IDX:      nested context (normal, hwirq, softirq, nmi)
    - TAIL:     last contended cpu
   The xchg_tail operate on IDX_TAIL part, so there is no guarantee on "NO"
   "other harts or devices continue to write to that reservation set".

2. When you do lock torture test, you may see a long contended ring queue:
                                                                xchg_tail
                                                                    +-----> CPU4 (big core)
                                                                    |
   CPU3 (lock holder) -> CPU1 (mcs queued) -> CPU2 (mcs queued) ----+-----> CPU0 (little core)
    |                                                               |
    |                                                               +-----> CPU5 (big core)
    |                                                               |
    +--locktorture release lock (spin_unlock) and spin_lock again --+-----> CPU3 (big core)

    If CPU0 doesn't have a strong fwd guarantee, xhg_tail is consistently failed.

> (c) Why, with arguments, T-HEAD C9xx meets (a)
> (d) Why at least one other architecture which defines ARCH_USE_QUEUED_SPINLOCKS
>     meets (a)
I can't give the C9xx microarch implementation detail. But many
open-source riscv cores have provided strong forward progress guarantee
LR/SC implementation [1] [2]. But I would say these implementations are
too rude, which makes LR send a cacheline unique interconnect request.
It satisfies xchg_tail but not cmpxchg & cond_load. CPU vendors should
carefully consider your LR/SC fwd guarantee implementation.

[1]: https://github.com/riscv-boom/riscv-boom/blob/v3.0.0/src/main/scala/lsu/dcache.scala#L650
[2]: https://github.com/OpenXiangShan/XiangShan/blob/v1.0/src/main/scala/xiangshan/cache/MainPipe.scala#L470

> 
> As far as I can tell, the RISC-V guarantees concerning constrained LR/SC loops
> (livelock freedom but no starvation freedom) are exactly the same as those in
> Armv8 (as of 0487F.c) for equivalent loops, and xchg_tail compiles to a
> constrained LR/SC loop with guaranteed eventual success (with -O1).  Clearly you
> disagree; I would like to see your perspective.
For Armv8, I would use LSE for the lock-contended scenario. Ref this
commit 0ea366f5e1b6: ("arm64: atomics: prefetch the destination word for
write prior to stxr").

> 
> -s
> 
> > +
> >  endmenu # "CPU errata selection"
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index 881729746d2e..d560dc45c0e7 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -86,6 +86,27 @@ static bool errata_probe_write_once(unsigned int stage,
> >  	return false;
> >  }
> > 
> > +static bool errata_probe_qspinlock(unsigned int stage,
> > +				   unsigned long arch_id, unsigned long impid)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_QSPINLOCK))
> > +		return false;
> > +
> > +	/*
> > +	 * The queued_spinlock torture would get in livelock without
> > +	 * ERRATA_THEAD_WRITE_ONCE fixup for the early versions of T-HEAD
> > +	 * processors.
> > +	 */
> > +	if (arch_id == 0 && impid == 0 &&
> > +	    !IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> > +		return false;
> > +
> > +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static u32 thead_errata_probe(unsigned int stage,
> >  			      unsigned long archid, unsigned long impid)
> >  {
> > @@ -103,6 +124,9 @@ static u32 thead_errata_probe(unsigned int stage,
> >  	if (errata_probe_write_once(stage, archid, impid))
> >  		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
> > 
> > +	if (errata_probe_qspinlock(stage, archid, impid))
> > +		cpu_req_errata |= BIT(ERRATA_THEAD_QSPINLOCK);
> > +
> >  	return cpu_req_errata;
> >  }
> > 
> > diff --git a/arch/riscv/include/asm/errata_list.h 
> > b/arch/riscv/include/asm/errata_list.h
> > index fbb2b8d39321..a696d18d1b0d 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -141,6 +141,26 @@ asm volatile(ALTERNATIVE(						\
> >  	: "=r" (__ovl) :						\
> >  	: "memory")
> > 
> > +static __always_inline bool
> > +riscv_has_errata_thead_qspinlock(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		asm_volatile_goto(
> > +		ALTERNATIVE(
> > +		"j	%l[l_no]", "nop",
> > +		THEAD_VENDOR_ID,
> > +		ERRATA_THEAD_QSPINLOCK,
> > +		CONFIG_ERRATA_THEAD_QSPINLOCK)
> > +		: : : : l_no);
> > +	} else {
> > +		goto l_no;
> > +	}
> > +
> > +	return true;
> > +l_no:
> > +	return false;
> > +}
> > +
> >  #endif /* __ASSEMBLY__ */
> > 
> >  #endif
> > diff --git a/arch/riscv/include/asm/vendorid_list.h 
> > b/arch/riscv/include/asm/vendorid_list.h
> > index 73078cfe4029..1f1d03877f5f 100644
> > --- a/arch/riscv/include/asm/vendorid_list.h
> > +++ b/arch/riscv/include/asm/vendorid_list.h
> > @@ -19,7 +19,8 @@
> >  #define	ERRATA_THEAD_CMO 1
> >  #define	ERRATA_THEAD_PMU 2
> >  #define	ERRATA_THEAD_WRITE_ONCE 3
> > -#define	ERRATA_THEAD_NUMBER 4
> > +#define	ERRATA_THEAD_QSPINLOCK 4
> > +#define	ERRATA_THEAD_NUMBER 5
> >  #endif
> > 
> >  #endif
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index f8dbbe1bbd34..d9694fe40a9a 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
> >  		 * spinlock value, the only way is to change from queued_spinlock to
> >  		 * ticket_spinlock, but can not be vice.
> >  		 */
> > -		if (!force_qspinlock) {
> > +		if (!force_qspinlock &&
> > +		    !riscv_has_errata_thead_qspinlock()) {
> >  			set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
> >  		}
> >  #endif
> > -- 
> > 2.36.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
