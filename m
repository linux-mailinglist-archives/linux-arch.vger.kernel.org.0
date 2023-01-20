Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1DB675859
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjATPTL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 10:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjATPTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 10:19:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8A2FDB79A;
        Fri, 20 Jan 2023 07:19:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B62521515;
        Fri, 20 Jan 2023 07:19:46 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 175CD3F67D;
        Fri, 20 Jan 2023 07:18:55 -0800 (PST)
Date:   Fri, 20 Jan 2023 15:18:48 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?B?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/31] kvx: Add atomic/locking headers
Message-ID: <Y8qw2MaCJZzu3Ows@FVFF77S0Q05N>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-12-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120141002.2442-12-ysionneau@kalray.eu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 20, 2023 at 03:09:42PM +0100, Yann Sionneau wrote:
> Add common headers (atomic, bitops, barrier and locking) for basic
> kvx support.
> 
> Co-developed-by: Clement Leger <clement@clement-leger.fr>
> Signed-off-by: Clement Leger <clement@clement-leger.fr>
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> Co-developed-by: Julien Villette <jvillette@kalray.eu>
> Signed-off-by: Julien Villette <jvillette@kalray.eu>
> Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
> 
> Notes:
>     V1 -> V2:
>      - use {READ,WRITE}_ONCE for arch_atomic64_{read,set}
>      - use asm-generic/bitops/atomic.h instead of __test_and_*_bit
>      - removed duplicated includes
>      - rewrite xchg and cmpxchg in C using builtins for acswap insn

Thanks for those changes. I see one issue below (instantiated a few times), but
other than that this looks good to me.

[...]

> +#define ATOMIC64_RETURN_OP(op, c_op)					\
> +static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
> +{									\
> +	long new, old, ret;						\
> +									\
> +	do {								\
> +		old = v->counter;					\

This should be arch_atomic64_read(v), in order to avoid the potential for the
compiler to replay the access and introduce ABA races and other such problems.

For details, see:

  https://lore.kernel.org/lkml/Y70SWXHDmOc3RhMd@osiris/
  https://lore.kernel.org/lkml/Y71LoCIl+IFdy9D8@FVFF77S0Q05N/

I see that the generic 32-bit atomic code suffers from that issue, and we
should fix it.

> +		new = old c_op i;					\
> +		ret = arch_cmpxchg(&v->counter, old, new);		\
> +	} while (ret != old);						\
> +									\
> +	return new;							\
> +}
> +
> +#define ATOMIC64_OP(op, c_op)						\
> +static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
> +{									\
> +	long new, old, ret;						\
> +									\
> +	do {								\
> +		old = v->counter;					\

Likewise, arch_atomic64_read(v) here.

> +		new = old c_op i;					\
> +		ret = arch_cmpxchg(&v->counter, old, new);		\
> +	} while (ret != old);						\
> +}
> +
> +#define ATOMIC64_FETCH_OP(op, c_op)					\
> +static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
> +{									\
> +	long new, old, ret;						\
> +									\
> +	do {								\
> +		old = v->counter;					\

Likewise, arch_atomic64_read(v) here.

> +		new = old c_op i;					\
> +		ret = arch_cmpxchg(&v->counter, old, new);		\
> +	} while (ret != old);						\
> +									\
> +	return old;							\
> +}
> +
> +#define ATOMIC64_OPS(op, c_op)						\
> +	ATOMIC64_OP(op, c_op)						\
> +	ATOMIC64_RETURN_OP(op, c_op)					\
> +	ATOMIC64_FETCH_OP(op, c_op)
> +
> +ATOMIC64_OPS(and, &)
> +ATOMIC64_OPS(or, |)
> +ATOMIC64_OPS(xor, ^)
> +ATOMIC64_OPS(add, +)
> +ATOMIC64_OPS(sub, -)
> +
> +#undef ATOMIC64_OPS
> +#undef ATOMIC64_FETCH_OP
> +#undef ATOMIC64_OP
> +
> +static inline int arch_atomic_add_return(int i, atomic_t *v)
> +{
> +	int new, old, ret;
> +
> +	do {
> +		old = v->counter;

Likewise, arch_atomic64_read(v) here.

> +		new = old + i;
> +		ret = arch_cmpxchg(&v->counter, old, new);
> +	} while (ret != old);
> +
> +	return new;
> +}
> +
> +static inline int arch_atomic_sub_return(int i, atomic_t *v)
> +{
> +	return arch_atomic_add_return(-i, v);
> +}
> +
> +#include <asm-generic/atomic.h>
> +
> +#endif	/* _ASM_KVX_ATOMIC_H */

Otherwise, the atomics look good to me.

Thanks,
Mark.
