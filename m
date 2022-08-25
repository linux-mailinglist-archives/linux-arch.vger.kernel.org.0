Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AACB5A15EF
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbiHYPkE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiHYPkD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 11:40:03 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F102A15A09
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 08:40:01 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31f445bd486so551222107b3.13
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fEQ1d/PiEHzLrmSBXGQT2W8YpNnPcaA3hRqhgrIy1b8=;
        b=F6xZURA7pUQy2v+UOwJV2SRBjGEut5CjaZ/xUi6FcIumRsvYr32tRVL6VK+/rlWoHx
         UKx7ihhTtIGPsJeDPQVAQEqpER/3I2NT7tZlDZC4342uPPCsBBM1YcMyvgFJt6lwqFlg
         XN1YHVnBy2JZYsszV+IWYwr61w2KwdeOfaIX6yxyLJ1JC7QX1BLYGCe4hxspikhXhs72
         LlOib55bwcEUaEKQmiCFgRQGvJCMgcZvugoncnNXcdNedyHR/+G7DB7ZUsduO3p+lKEL
         GVa8yILjJVx66GDhOZPVLdOghZ5Desu4mTb7XjFYxcPVXMxvEn3d9VGqQtRRWIFhkS+C
         5nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fEQ1d/PiEHzLrmSBXGQT2W8YpNnPcaA3hRqhgrIy1b8=;
        b=JJqWy0gM9eadixTtRm4L/TMLCs4C11cE6+7OgIwaxtsx+8DM0iiCR3YXFdlT1aP3B+
         NWKLXOXfyfpjr171ofF+O7SS1FBRFGtcM4ASFhgJQXPp28w2NwB+gJZ2+6D4fzGNyiLb
         y+Ao0MXYaNJn2StAlCvWJZJAFbCxDPZ9xr7Odrfc99QIn/6dOOMvvaTosxosXGRZKhb0
         g/Vy+02LRXAhP+ac7+7i50CBhVcnJMbKnezYFRLsoZQRWXJwdEMASIbS967xNN/FHmXn
         5w492ORmEQCFp/70SzaH9ob6pKPRjKu47rUWrsUsC76fCT2lx7iNwd9se4edZ8U7UQtA
         FfSg==
X-Gm-Message-State: ACgBeo1T5niVk6WYvNFW8DejC3CvDPUjZOp1kS5OO0s1rUFIXYwTpOID
        TRk5aQEz+NVc1uTsUirPJ83efgMusT43Z/OCfalWqA==
X-Google-Smtp-Source: AA6agR55v+DLet0yiWWCE94xVChePy5VsoHxFJfjQTURDicCdiaaIP6NeIPTzH3NruHqxBu+qCXcRybcS1En38eDdqc=
X-Received: by 2002:a25:bc3:0:b0:673:bc78:c095 with SMTP id
 186-20020a250bc3000000b00673bc78c095mr3870021ybl.376.1661442001024; Thu, 25
 Aug 2022 08:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-45-glider@google.com>
 <YsNIjwTw41y0Ij0n@casper.infradead.org>
In-Reply-To: <YsNIjwTw41y0Ij0n@casper.infradead.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 25 Aug 2022 17:39:24 +0200
Message-ID: <CAG_fn=VbvbYVPfdKXrYRTq7HwmvXPQUeUDWZjwe8x8W=ttq6KA@mail.gmail.com>
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
To:     Matthew Wilcox <willy@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 4, 2022 at 10:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 01, 2022 at 04:23:09PM +0200, Alexander Potapenko wrote:
> > Functions implementing the a_ops->write_end() interface accept the
> > `void *fsdata` parameter that is supposed to be initialized by the
> > corresponding a_ops->write_begin() (which accepts `void **fsdata`).
> >
> > However not all a_ops->write_begin() implementations initialize `fsdata`
> > unconditionally, so it may get passed uninitialized to a_ops->write_end(),
> > resulting in undefined behavior.
>
> ... wait, passing an uninitialised variable to a function *which doesn't
> actually use it* is now UB?  What genius came up with that rule?  What
> purpose does it serve?
>

Hi Matthew,

There is a discussion at [1], with Segher pointing out a reason for
this rule [2] and Linus requesting that we should be warning about the
cases where uninitialized variables are passed by value.

Right now there are only a handful cases in the kernel where such
passing is performed (we just need one more patch in addition to this
one for KMSAN to boot cleanly). So we are in a good position to start
enforcing this rule, unless there's a reason not to.

I am not sure standard compliance alone is a convincing argument, but
from KMSAN standpoint, performing parameter check at callsites
noticeably eases handling of values passed between instrumented and
non-instrumented code. This lets us avoid some low-level hacks around
instrumentation_begin()/instrumentation_end() (some context available
at [4]).

Let me know what you think,
Alex

[1] - https://lore.kernel.org/lkml/CAFKCwrjBjHMquj-adTf0_1QLYq3Et=gJ0rq6HS-qrAEmVA7Ujw@mail.gmail.com/T/
[2] - https://lore.kernel.org/lkml/20220615164655.GC25951@gate.crashing.org/
[3] - https://lore.kernel.org/lkml/CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com/
[4] https://lore.kernel.org/lkml/20220426164315.625149-29-glider@google.com/
