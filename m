Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D6367BF5C
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 22:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjAYV4w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 16:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbjAYVz0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 16:55:26 -0500
Received: from fx403.security-mail.net (smtpout140.security-mail.net [85.31.212.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565A3A83
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 13:55:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id 6E28C57978C
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 22:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674683722;
        bh=WtoB9JtlKwd4Y8mogATd1m73eAkNffWMtzkgdcOdrFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jpK3fSfJCzy3ZANEGkjKa68WlzWKHAnxNIOUyHjrFerEyLWvdC7JV4+9BbvbaYOVc
         zG/WmhbgVQcAC7cuLJSoEk6kP3iplqZGTody8prkX2fh/DSCpiNkfhrN11Nmfvh2q9
         5rHYkMRf2BwOr/BqbGtWV8yBWOizstOkO2UnIhWc=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 0F1A55794C5; Wed, 25 Jan 2023 22:55:22 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx403.security-mail.net (Postfix) with ESMTPS id 194FF578B2C; Wed, 25 Jan
 2023 22:55:21 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id D2EB627E0493; Wed, 25 Jan 2023
 22:55:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id AEC3727E0491; Wed, 25 Jan 2023 22:55:20 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 si6Lv1AzzjtE; Wed, 25 Jan 2023 22:55:20 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 4AA5127E0461; Wed, 25 Jan 2023
 22:55:20 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <13e79.63d1a549.170d1.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu AEC3727E0491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674683720;
 bh=OP2H0clmfjMlntXGEQUOupSQETmz7iibW86xdOXdO/c=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=FiSVH+wqDIs88qUIullcsu5BFjd2D7z2E5u8DrTYSpKgGNXgRV/wZx6pLf0jEnjj1
 nq174SqV22wtEYt+DC4eOS10NI0yUL2JmwTj2bfQCvZEO4mxAawGM/7zjbG/MQC8HR
 kpFf4zpnPjbRuo+I0TP0j3cj6aN2Vd984BCzoL6c=
Date:   Wed, 25 Jan 2023 22:55:19 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [RFC PATCH v2 12/31] kvx: Add other common headers
Message-ID: <20230125215519.GE5952@tellis.lin.mbt.kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-13-ysionneau@kalray.eu> <Y8qlOpYgDefMPqWH@zx2c4.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8qlOpYgDefMPqWH@zx2c4.com>
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

Hi Jason,

On Fri, Jan 20, 2023 at 03:29:14PM +0100, Jason A. Donenfeld wrote:
> Hi Yann,
> 
> On Fri, Jan 20, 2023 at 03:09:43PM +0100, Yann Sionneau wrote:
> > +#include <linux/random.h>
> > +#include <linux/version.h>
> > +
> > +extern unsigned long __stack_chk_guard;
> > +
> > +/*
> > + * Initialize the stackprotector canary value.
> > + *
> > + * NOTE: this must only be called from functions that never return,
> > + * and it must always be inlined.
> > + */
> > +static __always_inline void boot_init_stack_canary(void)
> > +{
> > +	unsigned long canary;
> > +
> > +	/* Try to get a semi random initial value. */
> > +	get_random_bytes(&canary, sizeof(canary));
> > +	canary ^= LINUX_VERSION_CODE;
> > +	canary &= CANARY_MASK;
> > +
> > +	current->stack_canary = canary;
> > +	__stack_chk_guard = current->stack_canary;
> > +}
> 
> 
> You should rewrite this as:
> 
>     current->stack_canary = get_random_canary();
>     __stack_chk_guard = current->stack_canary;
> 
> which is what the other archs all now do. (They didn't used to, and this
> looks like it's simply based on older code.)
Thanks for the suggestion, this will be into v3

> > +#define get_cycles get_cycles
> > +
> > +#include <asm/sfr.h>
> > +#include <asm-generic/timex.h>
> > +
> > +static inline cycles_t get_cycles(void)
> > +{
> > +	return kvx_sfr_get(PM0);
> > +}
> 
> Glad to see this CPU has a cycle counter. Out of curiosity, what is
> its resolution?
This cpu has 4 performance monitor (PM), the first one is reserved to
count cycles, and it is cycle accurate.

> Also, related, does this CPU happen to have a "RDRAND"-like instruction?
I didn't knew about the RDRAND insruction, but no this CPU do not have
an instruction like that.

> (I don't know anything about kvx or even what it is.)
It's a VLIW core, a bit like Itanium, there are currently not publicly
available documentation.  We have started a discussion internally at
Kalray to share more information regarding this CPU and its ABI.

A very crude instruction listing can be found in our fork of
gdb-binutils: https://raw.githubusercontent.com/kalray/binutils/binutils-2_35_2/coolidge/opcodes/kv3-opc.c

Best regards,
-- Jules





