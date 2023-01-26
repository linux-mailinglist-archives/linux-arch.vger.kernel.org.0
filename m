Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54C67C98C
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 12:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbjAZLPw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 06:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjAZLPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 06:15:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E6E410CD;
        Thu, 26 Jan 2023 03:15:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33988C14;
        Thu, 26 Jan 2023 03:16:31 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.10.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 402733F71E;
        Thu, 26 Jan 2023 03:15:40 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:15:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jules Maselbas <jmaselbas@kalray.eu>
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
Message-ID: <Y9Jg2QkbLUoYhimB@FVFF77S0Q05N>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-12-ysionneau@kalray.eu>
 <Y8qw2MaCJZzu3Ows@FVFF77S0Q05N>
 <20230126095720.GF5952@tellis.lin.mbt.kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126095720.GF5952@tellis.lin.mbt.kalray.eu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jules,

On Thu, Jan 26, 2023 at 10:57:20AM +0100, Jules Maselbas wrote:
> Hi Mark,
> 
> On Fri, Jan 20, 2023 at 03:18:48PM +0000, Mark Rutland wrote:
> > On Fri, Jan 20, 2023 at 03:09:42PM +0100, Yann Sionneau wrote:
> > > +#define ATOMIC64_RETURN_OP(op, c_op)					\
> > > +static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
> > > +{									\
> > > +	long new, old, ret;						\
> > > +									\
> > > +	do {								\
> > > +		old = v->counter;					\
> > 
> > This should be arch_atomic64_read(v), in order to avoid the potential for the
> > compiler to replay the access and introduce ABA races and other such problems.
> Thanks for the suggestion, this will be into v3.
> 
> > For details, see:
> > 
> >   https://lore.kernel.org/lkml/Y70SWXHDmOc3RhMd@osiris/
> >   https://lore.kernel.org/lkml/Y71LoCIl+IFdy9D8@FVFF77S0Q05N/
> > 
> > I see that the generic 32-bit atomic code suffers from that issue, and we
> > should fix it.
> I took a look at the generic 32-bit atomic, but I am unsure if this
> needs to be done for both the SMP and non-SMP implementations. But I
> can send a first patch and we can discuss from there.

Sounds good to me; thanks!

[...]

> > > +static inline int arch_atomic_add_return(int i, atomic_t *v)
> > > +{
> > > +	int new, old, ret;
> > > +
> > > +	do {
> > > +		old = v->counter;
> > 
> > Likewise, arch_atomic64_read(v) here.
> ack, this will bt arch_atomic_read(v) here since this is not atomic64_t
> here.

Ah, yes, my bad!

Thanks,
Mark.
