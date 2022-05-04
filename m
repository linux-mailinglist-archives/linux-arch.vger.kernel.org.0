Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C095519ECC
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349241AbiEDMFx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 08:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiEDMFw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 08:05:52 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE7A1E3FF;
        Wed,  4 May 2022 05:02:13 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nmDhh-0001Pn-7R; Wed, 04 May 2022 14:02:01 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v4 2/7] asm-generic: qspinlock: Indicate the use of mixed-size atomics
Date:   Wed, 04 May 2022 14:02:00 +0200
Message-ID: <7375410.EvYhyI6sBW@diego>
In-Reply-To: <20220430153626.30660-3-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com> <20220430153626.30660-3-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am Samstag, 30. April 2022, 17:36:21 CEST schrieb Palmer Dabbelt:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> The qspinlock implementation depends on having well behaved mixed-size
> atomics.  This is true on the more widely-used platforms, but these
> requirements are somewhat subtle and may not be satisfied by all the
> platforms that qspinlock is used on.
> 
> Document these requirements, so ports that use qspinlock can more easily
> determine if they meet these requirements.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  include/asm-generic/qspinlock.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index d74b13825501..95be3f3c28b5 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -2,6 +2,37 @@
>  /*
>   * Queued spinlock
>   *
> + * A 'generic' spinlock implementation that is based on MCS locks. An

_For_ an architecture that's ... ?

> + * architecture that's looking for a 'generic' spinlock, please first consider
> + * ticket-lock.h and only come looking here when you've considered all the
> + * constraints below and can show your hardware does actually perform better
> + * with qspinlock.
> + *
> + *

double empty line is probably not necessary

> + * It relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no weaker
> + * than RCtso if you're power), where regular code only expects atomic_t to be
> + * RCpc.
> + *
> + * It relies on a far greater (compared to asm-generic/spinlock.h) set of
> + * atomic operations to behave well together, please audit them carefully to
> + * ensure they all have forward progress. Many atomic operations may default to
> + * cmpxchg() loops which will not have good forward progress properties on
> + * LL/SC architectures.
> + *
> + * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
> + * do. Carefully read the patches that introduced
> + * queued_fetch_set_pending_acquire().
> + *
> + * It also heavily relies on mixed size atomic operations, in specific it
> + * requires architectures to have xchg16; something which many LL/SC
> + * architectures need to implement as a 32bit and+or in order to satisfy the
> + * forward progress guarantees mentioned above.
> + *
> + * Further reading on mixed size atomics that might be relevant:
> + *
> + *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
> + *
> + *
>   * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
>   * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
>   *
> 




