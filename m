Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00565A7059
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 00:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiH3WF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiH3WFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 18:05:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6513963F26;
        Tue, 30 Aug 2022 15:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C3E4B81E28;
        Tue, 30 Aug 2022 22:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82260C433C1;
        Tue, 30 Aug 2022 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661897151;
        bh=WOPgq+Z/r2IfhVRD2klqGuqRjEDudKtBpcud8vKpYyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zdXxZEBCZRcSQbBODbQg04Xw1/vZ3ciEnmFehxiWEF9sP0bmdQi+HvP5hDPG6qpEG
         Aciuz/LdL6sL1fVQF+PrbGmgBwvb4MeIaVKdSjmfxM0J8XNXZtEjXvXATt6jdJvOmb
         gZvO0kFonCFekXOatC4xxsTJqBFa894ckXQui73o=
Date:   Tue, 30 Aug 2022 15:05:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>,
        Yu Zhao <yuzhao@google.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-Id: <20220830150549.afa67340c2f5eb33ff9615f4@linux-foundation.org>
In-Reply-To: <CAG_fn=X6eZ6Cdrv5pivcROHi3D8uymdgh+EbnFasBap2a=0LQQ@mail.gmail.com>
References: <20220826150807.723137-1-glider@google.com>
        <20220826150807.723137-5-glider@google.com>
        <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
        <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com>
        <20220829122452.cce41f2754c4e063f3ae8b75@linux-foundation.org>
        <CAG_fn=X6eZ6Cdrv5pivcROHi3D8uymdgh+EbnFasBap2a=0LQQ@mail.gmail.com>
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

On Tue, 30 Aug 2022 16:23:44 +0200 Alexander Potapenko <glider@google.com> wrote:

> >                  from init/do_mounts.c:2:
> > ./include/linux/page-flags.h: In function ‘page_fixed_fake_head’:
> > ./include/linux/page-flags.h:226:36: error: invalid use of undefined type ‘const struct page’
> >   226 |             test_bit(PG_head, &page->flags)) {
> >       |                                    ^~
> > ./include/linux/bitops.h:50:44: note: in definition of macro ‘bitop’
> >    50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
> >       |                                            ^~~~
> > ./include/linux/page-flags.h:226:13: note: in expansion of macro ‘test_bit’
> >   226 |             test_bit(PG_head, &page->flags)) {
> >       |             ^~~~~~~~
> > ...
> 
> Gotcha, this is a circular dependency: mm_types.h -> sched.h ->
> kmsan.h -> gfp.h -> mmzone.h -> page-flags.h -> mm_types.h, where the
> inclusion of sched.h into mm_types.h was only introduced in "mm:
> multi-gen LRU: support page table walks" - that's why the problem was
> missing in other trees.

Ah, thanks for digging that out.

Yu, that inclusion is regrettable.  I don't think mm_types.h is an
appropriate site for implementing lru_gen_use_mm() anyway.  Adding a
new header is always the right fix for these things.  I'd suggest
adding a new mglru.h (or whatever) and putting most/all of the mglru
material in there.

Also, the addition to kernel/sched/core.c wasn't clearly changelogged,
is uncommented and I doubt if the sched developers know about it, let
alone reviewed it.  Please give them a heads-up.

The addition looks fairly benign, but core context_switch() is the
sort of thing which people get rather defensive about and putting
mm-specific stuff in there might be challenged.  Some quantitative
justification of this optimization would be appropriate.

> In fact sched.h only needs the definitions of `struct
> kmsan_context_state` and `struct kmsan_ctx` from kmsan.h, so I am
> splitting them off into kmsan_types.h to break this circle.
> Doing so also helped catch a couple of missing/incorrect inclusions of
> KMSAN headers in subsystems.

