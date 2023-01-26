Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7218A67C7D8
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 10:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjAZJ5b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 04:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbjAZJ52 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 04:57:28 -0500
Received: from fx303.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01831EFCC
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 01:57:25 -0800 (PST)
Received: from localhost (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 159C630F7D0
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 10:57:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674727044;
        bh=uO7MCO8H75KotDHIyR6heNsXJ56/BH7BOfcV5EHmMEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=4YNoRhcr0vybNM+PSAQBurpnOdCztzxH+iMpLbZRkwaOFBCUhxO6eaicTA9Tgpxiw
         yyi5tk9BOYgQgv5G1xx/sGwlEQlAzTDotmiQCdl4pirN7a56hiuQg+ut19xnPRBIUL
         m9dEzRbdZRU2U54/uh0pmQDG+FGknzhTneAV6w/E=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 47B0330F6E2; Thu, 26 Jan
 2023 10:57:23 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 600CC30EF2D; Thu, 26 Jan
 2023 10:57:22 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 1EF2427E0493; Thu, 26 Jan 2023
 10:57:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id F0A6127E0491; Thu, 26 Jan 2023 10:57:21 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 JRZseFWEf3ef; Thu, 26 Jan 2023 10:57:21 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 9A5BE27E048E; Thu, 26 Jan 2023
 10:57:21 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <12187.63d24e82.597fe.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu F0A6127E0491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674727042;
 bh=y0pU6bUB9NtRwjLHJtgOZpwuFzZAZbLkd/6NSd04WhM=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=X7BuUXlibp43NQwoW2XoKczIL4vzGNFTCj5F8yW370vweqIXc9XTSGMKEFeNuiA5e
 bkUAd/wPpBSOBVN1KkeOkTfHQXjfCuCp1M/EQOs9zosEydOfE9WuKyG1Bj/44r3wGZ
 mysuu23qG+bNP9s2Himt9ysP+5Wj3jljQFPyrv34=
Date:   Thu, 26 Jan 2023 10:57:20 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
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
Message-ID: <20230126095720.GF5952@tellis.lin.mbt.kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-12-ysionneau@kalray.eu> <Y8qw2MaCJZzu3Ows@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8qw2MaCJZzu3Ows@FVFF77S0Q05N>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mark,

On Fri, Jan 20, 2023 at 03:18:48PM +0000, Mark Rutland wrote:
> On Fri, Jan 20, 2023 at 03:09:42PM +0100, Yann Sionneau wrote:
> > Add common headers (atomic, bitops, barrier and locking) for basic
> > kvx support.
> > 
> > Co-developed-by: Clement Leger <clement@clement-leger.fr>
> > Signed-off-by: Clement Leger <clement@clement-leger.fr>
> > Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> > Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> > Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> > Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> > Co-developed-by: Julien Villette <jvillette@kalray.eu>
> > Signed-off-by: Julien Villette <jvillette@kalray.eu>
> > Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> > Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> > ---
> > 
> > Notes:
> >     V1 -> V2:
> >      - use {READ,WRITE}_ONCE for arch_atomic64_{read,set}
> >      - use asm-generic/bitops/atomic.h instead of __test_and_*_bit
> >      - removed duplicated includes
> >      - rewrite xchg and cmpxchg in C using builtins for acswap insn
> 
> Thanks for those changes. I see one issue below (instantiated a few times), but
> other than that this looks good to me.
> 
> [...]
> 
> > +#define ATOMIC64_RETURN_OP(op, c_op)					\
> > +static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
> > +{									\
> > +	long new, old, ret;						\
> > +									\
> > +	do {								\
> > +		old = v->counter;					\
> 
> This should be arch_atomic64_read(v), in order to avoid the potential for the
> compiler to replay the access and introduce ABA races and other such problems.
Thanks for the suggestion, this will be into v3.

> For details, see:
> 
>   https://lore.kernel.org/lkml/Y70SWXHDmOc3RhMd@osiris/
>   https://lore.kernel.org/lkml/Y71LoCIl+IFdy9D8@FVFF77S0Q05N/
> 
> I see that the generic 32-bit atomic code suffers from that issue, and we
> should fix it.
I took a look at the generic 32-bit atomic, but I am unsure if this
needs to be done for both the SMP and non-SMP implementations. But I
can send a first patch and we can discuss from there.

> > +		new = old c_op i;					\
> > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > +	} while (ret != old);						\
> > +									\
> > +	return new;							\
> > +}
> > +
> > +#define ATOMIC64_OP(op, c_op)						\
> > +static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
> > +{									\
> > +	long new, old, ret;						\
> > +									\
> > +	do {								\
> > +		old = v->counter;					\
> 
> Likewise, arch_atomic64_read(v) here.
ack

> > +		new = old c_op i;					\
> > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > +	} while (ret != old);						\
> > +}
> > +
> > +#define ATOMIC64_FETCH_OP(op, c_op)					\
> > +static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
> > +{									\
> > +	long new, old, ret;						\
> > +									\
> > +	do {								\
> > +		old = v->counter;					\
> 
> Likewise, arch_atomic64_read(v) here.
ack

> > +		new = old c_op i;					\
> > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > +	} while (ret != old);						\
> > +									\
> > +	return old;							\
> > +}
> > +
> > +#define ATOMIC64_OPS(op, c_op)						\
> > +	ATOMIC64_OP(op, c_op)						\
> > +	ATOMIC64_RETURN_OP(op, c_op)					\
> > +	ATOMIC64_FETCH_OP(op, c_op)
> > +
> > +ATOMIC64_OPS(and, &)
> > +ATOMIC64_OPS(or, |)
> > +ATOMIC64_OPS(xor, ^)
> > +ATOMIC64_OPS(add, +)
> > +ATOMIC64_OPS(sub, -)
> > +
> > +#undef ATOMIC64_OPS
> > +#undef ATOMIC64_FETCH_OP
> > +#undef ATOMIC64_OP
> > +
> > +static inline int arch_atomic_add_return(int i, atomic_t *v)
> > +{
> > +	int new, old, ret;
> > +
> > +	do {
> > +		old = v->counter;
> 
> Likewise, arch_atomic64_read(v) here.
ack, this will bt arch_atomic_read(v) here since this is not atomic64_t
here.


Thanks
-- Jules





