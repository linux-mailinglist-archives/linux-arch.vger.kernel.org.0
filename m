Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E137665E965
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 11:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjAEKzP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 05:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjAEKzG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 05:55:06 -0500
X-Greylist: delayed 881 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 02:55:04 PST
Received: from fx308.security-mail.net (smtpout30.security-mail.net [85.31.212.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEBE50174
        for <linux-arch@vger.kernel.org>; Thu,  5 Jan 2023 02:55:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx308.security-mail.net (Postfix) with ESMTP id 8894275B18D
        for <linux-arch@vger.kernel.org>; Thu,  5 Jan 2023 11:40:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672915221;
        bh=HozEVKpsnPTz1W+OmWAJHb2nflwGQpHJX/pPziyjbkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=z8nnqsOPLAZ31pVTrEaSU8Vi1jwkux3kRJ9jir01BPlgH3Vm0rvu0GKLTqA8QcOvp
         kLczG4JPQ06aIFlsEnPWzgHdo4KICmI9A0K7HrUsCBAfrXYX+XrUXZNvGHj/AcXF+p
         bTvO3vB+RrFhkrZgRrmVTSG9wbJg55lN4Wsmg9nc=
Received: from fx308 (localhost [127.0.0.1]) by fx308.security-mail.net
 (Postfix) with ESMTP id 6DB4A75AF9C; Thu,  5 Jan 2023 11:40:21 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx308.security-mail.net (Postfix) with ESMTPS id 0F44375AB2B; Thu,  5 Jan
 2023 11:40:21 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id D52FF27E0373; Thu,  5 Jan 2023
 11:40:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id B47A227E02E4; Thu,  5 Jan 2023 11:40:20 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 h9vZft-QceM0; Thu,  5 Jan 2023 11:40:20 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 5854D27E02AC; Thu,  5 Jan 2023
 11:40:20 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <141b8.63b6a915.e31d.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu B47A227E02E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672915220;
 bh=rBdSTEj4sEHV5aOdgiMVbZa0c1+4vHmKGKt/utxqTFU=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=pKs+CePZ3R3W41fZHlmw/owOk940TBb9jGKa8X1N/B6at/r5t/99lcM7BYNSm1sbm
 GgU4FIb/vUiDD0dGYY0QwPK6QJVEAcqdlcP4MzXTRQlqlJaTfeeQw469yNJ0IyFuvr
 H4nRIuARzCz4d0RA5Dr/HYW0RULCkMt83j3YDunc=
Date:   Thu, 5 Jan 2023 11:40:19 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, bpf@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        devicetree@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-audit@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Moore <paul@paul-moore.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, Alex Michon <amichon@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Jonathan Borne <jborne@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH 00/25] Upstream kvx Linux port
Message-ID: <20230105104019.GA7446@tellis.lin.mbt.kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <7c531595-e987-422b-bcf7-48ad0ba49ce6@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c531595-e987-422b-bcf7-48ad0ba49ce6@app.fastmail.com>
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

Hi,

On Wed, Jan 04, 2023 at 04:58:25PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 3, 2023, at 17:43, Yann Sionneau wrote:
> > This patch series adds support for the kv3-1 CPU architecture of the kvx family
> > found in the Coolidge (aka MPPA3-80) SoC of Kalray.
> >
> > This is an RFC, since kvx support is not yet upstreamed into gcc/binutils,
> > therefore this patch series cannot be merged into Linux for now.
> >
> > The goal is to have preliminary reviews and to fix problems early.
> >
> > The Kalray VLIW processor family (kvx) has the following features:
> > * 32/64 bits execution mode
> > * 6-issue VLIW architecture
> > * 64 x 64bits general purpose registers
> > * SIMD instructions
> > * little-endian
> > * deep learning co-processor
> 
> Thanks for posting these, I had been wondering about the
> state of the port. Overall this looks really nice, I can
> see that you and the team have looked at other ports
> and generally made the right decisions.

Thank you and all for the reviews. We are currently going
through every remarks and we are trying to do our best to
send a new patch series with everything addressed.

> I commented on the syscall patch directly, I think it's
> important to stop using the deprecated syscalls as soon
> as possible to avoid having dependencies in too many
> libc binaries. Almost everything else can be changed
> easily as you get closer to upstream inclusion.
> 
> I did not receive most of the other patches as I'm
> not subscribed to all the mainline lists. For future 
> submissions, can you add the linux-arch list to Cc for
> all patches?

We misused get_maintainers.pl, running it on each patch instead
of using it on the whole series. next time every one will be in
copy of every patch in the series and including linux-arch.

> Reading the rest of the series through lore.kernel.org,
> most of the comments I have are for improvements that
> you may find valuable rather than serious mistakes:
> 
> - the {copy_to,copy_from,clear}_user functions are
>   well worth optimizing better than the byte-at-a-time
>   version you have, even just a C version built around
>   your __get_user/__put_user inline asm should help, and
>   could be added to lib/usercopy.c.

right, we are using memcpy for {copy_to,copy_from}_user_page
which has a simple optimized version introduced in
(kvx: Add some library functions).
I wonder if it is possible to do the same for copy_*_user functions.

> - The __raw_{read,write}{b,w,l,q} helpers should
>   normally be defined as inline asm instead of
>   volatile pointer dereferences, I've seen cases where
>   the compiler ends up splitting the access or does
>   other things you may not want on MMIO areas.
>
> - I would recomment implementing HAVE_ARCH_VMAP_STACK
>   as well as IRQ stacks, both of these help to
>   avoid data corruption from stack overflow that you
>   will eventually run into.
> 
> - You use qspinlock as the only available spinlock
>   implementation, but only support running on a
>   single cluster of 16 cores. It may help to use
>   the generic ticket spinlock instead, or leave it
>   as a Kconfig option, in particular since you only
>   have the emulated xchg16() atomic for qspinlock.
> 
> - Your defconfig file enables CONFIG_EMBEDDED, which
>   in turn enables CONFIG_EXPERT. This is probably
>   not what you want, so better turn off both of these.
> 
> - The GENERIC_CALIBRATE_DELAY should not be necessary
>   since you have a get_cycles() based delay loop.
>   Just set loops_per_jiffy to the correct value based
>   on the frequency of the cycle counter, to save
>   a little time during boot and get a more accurate
>   delay loop.
>
Ack !

   Jules




