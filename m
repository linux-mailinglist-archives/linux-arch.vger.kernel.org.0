Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21945A547F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiH2TZA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 15:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2TY7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 15:24:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F091F2F1;
        Mon, 29 Aug 2022 12:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F17EB811E9;
        Mon, 29 Aug 2022 19:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E72C433D6;
        Mon, 29 Aug 2022 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661801094;
        bh=bvJk1oFFNYzt8e4h6wKH6kqiTtNdEy8t/HVURp2TtOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6GuB5/Z8vBgiihEDvt2dTWer1Mz4W1uoXySfQkHPdYVggcEMqrXENRWvhytKJ68N
         rOi3UokczdAHOoeSYIYDF+3pjSiCZjQZcIHCJEAM2IXlp4WL8aTnQ3QyeQD6GvYEeV
         LNm9hPATckMyEfH8R7ZRYofxbCOEfH2WK+fF02jo=
Date:   Mon, 29 Aug 2022 12:24:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user()
 and put_user()
Message-Id: <20220829122452.cce41f2754c4e063f3ae8b75@linux-foundation.org>
In-Reply-To: <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com>
References: <20220826150807.723137-1-glider@google.com>
        <20220826150807.723137-5-glider@google.com>
        <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
        <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 29 Aug 2022 16:57:31 +0200 Alexander Potapenko <glider@google.com> wrote:

> On Sat, Aug 27, 2022 at 6:17 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 26 Aug 2022 17:07:27 +0200 Alexander Potapenko <glider@google.com> wrote:
> >
> > > Use hooks from instrumented.h to notify bug detection tools about
> > > usercopy events in variations of get_user() and put_user().
> >
> > And this one blows up x86_64 allmodconfig builds.
> 
> How do I reproduce this?
> I tried running `make mrproper; make allmodconfig; make -j64` (or
> allyesconfig, allnoconfig) on both KMSAN tree
> (https://github.com/google/kmsan/commit/ac3859c02d7f40f59992737d63afcacda0a972ec,
> which is Linux v6.0-rc2 plus the 44 KMSAN patches) and
> linux-mm/mm-stable @ec6624452e36158d0813758d837f7a2263a4109d with
> KMSAN patches applied on top of it.
> All builds were successful.
> 
> I then tried to cherry-pick just the first 4 commits to mm-stable and
> see if allmodconfig works - it resulted in numerous "implicit
> declaration of function ‘instrument_get_user’" errors (quite silly of
> me), but nothing looking like the errors you posted.
> I'll try to build-test every patch in the series after fixing the
> missing declarations, but so far I don't see other problems.
> 
> Could you share the mmotm commit id which resulted in the failures?

I just pushed out a tree which exhibits this with gcc-12.1.1 and with
gcc-11.1.0.  Tag is mm-everything-2022-08-29-19-17.

The problem is introduced by d0d9a44d2210 ("kmsan: add KMSAN runtime core")

make mrproper
make allmodconfig
make init/do_mounts.o

In file included from ./include/linux/kernel.h:22,
                 from ./arch/x86/include/asm/percpu.h:27,
                 from ./arch/x86/include/asm/nospec-branch.h:14,
                 from ./arch/x86/include/asm/paravirt_types.h:40,
                 from ./arch/x86/include/asm/ptrace.h:97,
                 from ./arch/x86/include/asm/math_emu.h:5,
                 from ./arch/x86/include/asm/processor.h:13,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from init/do_mounts.c:2:
./include/linux/page-flags.h: In function ‘page_fixed_fake_head’:
./include/linux/page-flags.h:226:36: error: invalid use of undefined type ‘const struct page’
  226 |             test_bit(PG_head, &page->flags)) {
      |                                    ^~
./include/linux/bitops.h:50:44: note: in definition of macro ‘bitop’
   50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
      |                                            ^~~~
./include/linux/page-flags.h:226:13: note: in expansion of macro ‘test_bit’
  226 |             test_bit(PG_head, &page->flags)) {
      |             ^~~~~~~~
...
