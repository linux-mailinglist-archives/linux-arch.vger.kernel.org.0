Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB00771971
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 07:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHGFYF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 01:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHGFYE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 01:24:04 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84363113;
        Sun,  6 Aug 2023 22:24:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 12A4A320090C;
        Mon,  7 Aug 2023 01:23:57 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Mon, 07 Aug 2023 01:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691385837; x=1691472237; bh=x5
        qNGeXXt3ERHXs7RLt7yAgmwQ1o1sx5LtjKah3J7y8=; b=MDiVnkj16mwLH6ukoz
        vMS5bOVlCaCqEFlHHvaym8PoDAwodNR3fkGUBFrr5zd2PC7YRHC3xE2IECdpxT3r
        ZmTzpB+xK8wD/Tq7WY/gLJUEovyz70AG58TtfulE/zdqDeNuAjhpnN0Ct++bVyoR
        M4I0aII+nbVFxfVCg/d8z8ttHZe3T8Vd4WEoZWDglyIssXySbFizDiQiWoJSkLhC
        hu5cyu+HA3+SFGL1DzrxW34MGBxy8YDTczMlWBiqmtHzi3FiiZA4nu0AjhTEE6tM
        GUraRMtCBnf6yPoaigs28r2+PhRJcig80qk99/TdDeULIJUcRPrgKOS+oCrdlqlK
        O33Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691385837; x=1691472237; bh=x5qNGeXXt3ERH
        Xs7RLt7yAgmwQ1o1sx5LtjKah3J7y8=; b=cFrk0/+YVO09szURCvFez9RcbRDkJ
        W1LdYGvBt0RHCTuQ8LAG+AcUbH2b4XDCUDOV4qVpMzavyWXMifXAvcMs/mmpT311
        XEQQIxTL0Bps5TS1hjXCAOZ16cvH6LBDGSWwHszmKU3nCNhj1jRlacxs4xDeusPY
        9k8jLM6CiQLMMI/0Az5Wi3fenpY8r0UI41arpEIrvYk/aNsFH9Dn/pCjUmlWfGSm
        o2Zgbd0pe8Wixfx5NJyO4mE+mInfLPrE0czOtO9g+jFCitxBD3+OsaYEZ0LzXpcI
        uDUG8UQbxFpZLsZ2eyFNKbg5hrovf6+1CH6webb5tCCtw2NtrpKg+CjuA==
X-ME-Sender: <xms:6n_QZBhIM_o7WJErxnO3ZgYA6c-WTYgLOn-kUqs-H5iRzp-DHhDf1g>
    <xme:6n_QZGBesSgwGOzTPzVD7PcCEJEkje3Ks9FyA9Q-c0LevH2jEPokojPLex354PD6V
    IPPnO4RBaB5hfquIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejueehgedtueetgefhheejjeeigffhieefjeehuddvueegtdfh
    heevgfeggfektdenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6n_QZBHHL-ZOlYctLzv3WollQNvKcNjfKZa_akHiW3mjXwNQhzUYEA>
    <xmx:6n_QZGR0wHWCHc1KuEDJpIx5R3iNXNReyB-pS7ahPvuXnCGY-gBzTA>
    <xmx:6n_QZOwq90uK7dj8SBKnjSST29F-FuwgeyW0_roJz17ZMe_whaM0HQ>
    <xmx:7X_QZGdWP5hvG2ufh70_oX0vRGWGHXdNHCwGDwPtsfM0cx2kQ5v2Tw>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9BE931700089; Mon,  7 Aug 2023 01:23:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <ae320af5-6cca-4689-aa66-9d0193713d40@app.fastmail.com>
In-Reply-To: <20230802164701.192791-8-guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-8-guoren@kernel.org>
Date:   Mon, 07 Aug 2023 01:23:34 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     guoren <guoren@kernel.org>, paul.walmsley@sifive.com,
        "Anup Patel" <anup@brainfault.org>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        "Palmer Dabbelt" <palmer@rivosinc.com>, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, paulmck@kernel.org,
        rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com,
        "Conor Dooley" <conor.dooley@microchip.com>,
        xiaoguang.xing@sophgo.com,
        =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        alexghiti@rivosinc.com, "Kees Cook" <keescook@chromium.org>,
        greentime.hu@sifive.com, "Andrew Jones" <ajones@ventanamicro.com>,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, "Guo Ren" <guoren@linux.alibaba.com>
Subject: Re: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce
 ERRATA_THEAD_QSPINLOCK
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 2, 2023, at 12:46 PM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> According to qspinlock requirements, RISC-V gives out a weak LR/SC
> forward progress guarantee which does not satisfy qspinlock. But
> many vendors could produce stronger forward guarantee LR/SC to
> ensure the xchg_tail could be finished in time on any kind of
> hart. T-HEAD is the vendor which implements strong forward
> guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
> with errata help.
>
> T-HEAD early version of processors has the merge buffer delay
> problem, so we need ERRATA_WRITEONCE to support qspinlock.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig.errata              | 13 +++++++++++++
>  arch/riscv/errata/thead/errata.c       | 24 ++++++++++++++++++++++++
>  arch/riscv/include/asm/errata_list.h   | 20 ++++++++++++++++++++
>  arch/riscv/include/asm/vendorid_list.h |  3 ++-
>  arch/riscv/kernel/cpufeature.c         |  3 ++-
>  5 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 4745a5c57e7c..eb43677b13cc 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -96,4 +96,17 @@ config ERRATA_THEAD_WRITE_ONCE
> 
>  	  If you don't know what to do here, say "Y".
> 
> +config ERRATA_THEAD_QSPINLOCK
> +	bool "Apply T-Head queued spinlock errata"
> +	depends on ERRATA_THEAD
> +	default y
> +	help
> +	  The T-HEAD C9xx processors implement strong fwd guarantee LR/SC to
> +	  match the xchg_tail requirement of qspinlock.
> +
> +	  This will apply the QSPINLOCK errata to handle the non-standard
> +	  behavior via using qspinlock instead of ticket_lock.
> +
> +	  If you don't know what to do here, say "Y".

If this is to be applied, I would like to see a detailed explanation somewhere,
preferably with citations, of:

(a) The memory model requirements for qspinlock
(b) Why, with arguments, RISC-V does not architecturally meet (a)
(c) Why, with arguments, T-HEAD C9xx meets (a)
(d) Why at least one other architecture which defines ARCH_USE_QUEUED_SPINLOCKS
    meets (a)

As far as I can tell, the RISC-V guarantees concerning constrained LR/SC loops
(livelock freedom but no starvation freedom) are exactly the same as those in
Armv8 (as of 0487F.c) for equivalent loops, and xchg_tail compiles to a
constrained LR/SC loop with guaranteed eventual success (with -O1).  Clearly you
disagree; I would like to see your perspective.

-s

> +
>  endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 881729746d2e..d560dc45c0e7 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -86,6 +86,27 @@ static bool errata_probe_write_once(unsigned int stage,
>  	return false;
>  }
> 
> +static bool errata_probe_qspinlock(unsigned int stage,
> +				   unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_QSPINLOCK))
> +		return false;
> +
> +	/*
> +	 * The queued_spinlock torture would get in livelock without
> +	 * ERRATA_THEAD_WRITE_ONCE fixup for the early versions of T-HEAD
> +	 * processors.
> +	 */
> +	if (arch_id == 0 && impid == 0 &&
> +	    !IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> +		return false;
> +
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return true;
> +
> +	return false;
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>  			      unsigned long archid, unsigned long impid)
>  {
> @@ -103,6 +124,9 @@ static u32 thead_errata_probe(unsigned int stage,
>  	if (errata_probe_write_once(stage, archid, impid))
>  		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
> 
> +	if (errata_probe_qspinlock(stage, archid, impid))
> +		cpu_req_errata |= BIT(ERRATA_THEAD_QSPINLOCK);
> +
>  	return cpu_req_errata;
>  }
> 
> diff --git a/arch/riscv/include/asm/errata_list.h 
> b/arch/riscv/include/asm/errata_list.h
> index fbb2b8d39321..a696d18d1b0d 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -141,6 +141,26 @@ asm volatile(ALTERNATIVE(						\
>  	: "=r" (__ovl) :						\
>  	: "memory")
> 
> +static __always_inline bool
> +riscv_has_errata_thead_qspinlock(void)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		asm_volatile_goto(
> +		ALTERNATIVE(
> +		"j	%l[l_no]", "nop",
> +		THEAD_VENDOR_ID,
> +		ERRATA_THEAD_QSPINLOCK,
> +		CONFIG_ERRATA_THEAD_QSPINLOCK)
> +		: : : : l_no);
> +	} else {
> +		goto l_no;
> +	}
> +
> +	return true;
> +l_no:
> +	return false;
> +}
> +
>  #endif /* __ASSEMBLY__ */
> 
>  #endif
> diff --git a/arch/riscv/include/asm/vendorid_list.h 
> b/arch/riscv/include/asm/vendorid_list.h
> index 73078cfe4029..1f1d03877f5f 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -19,7 +19,8 @@
>  #define	ERRATA_THEAD_CMO 1
>  #define	ERRATA_THEAD_PMU 2
>  #define	ERRATA_THEAD_WRITE_ONCE 3
> -#define	ERRATA_THEAD_NUMBER 4
> +#define	ERRATA_THEAD_QSPINLOCK 4
> +#define	ERRATA_THEAD_NUMBER 5
>  #endif
> 
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index f8dbbe1bbd34..d9694fe40a9a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
>  		 * spinlock value, the only way is to change from queued_spinlock to
>  		 * ticket_spinlock, but can not be vice.
>  		 */
> -		if (!force_qspinlock) {
> +		if (!force_qspinlock &&
> +		    !riscv_has_errata_thead_qspinlock()) {
>  			set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
>  		}
>  #endif
> -- 
> 2.36.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
