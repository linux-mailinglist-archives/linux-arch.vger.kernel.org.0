Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE19565FFF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 02:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiGEAGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 20:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGEAGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 20:06:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5DB4A6
        for <linux-arch@vger.kernel.org>; Mon,  4 Jul 2022 17:06:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q8so174518ljj.10
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qmr+F6QyjrWZ2ZNhmVLeAUEKN7hzojbkjvHu88aEdVo=;
        b=DIX8InJ6+wbF8trPlzF4+I2SecOagwTWWWojE8MrUcdpyHa/pRG6jbX6znc3kN0wwY
         meZsX/cYHAia9UGV3E6pOMc+RLJkbdCCC5GHWJIC5ovXbkt+u1S6rePiMZINTfJyYWAf
         La2KI8ZnqJltrRgKiua/JxCOBBzGPIGfHCgC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qmr+F6QyjrWZ2ZNhmVLeAUEKN7hzojbkjvHu88aEdVo=;
        b=Z+uEVYzh+kcSQ7SVycKYufE9z0lyRONDUhMBVNZ4MmULc6nB23EejyghMd9anNaau8
         wSnQtI+DLU3/TqKGK82usSsYprA34REs3XoEPY/WmGCx9bZVK6ZIyD2AxDaIfnyxaBa/
         ufv9gIVr3zcZyfUfazsKEZ0bw5rlHmzzI2E3R961egaP/6ALq1nJhQf4vF0Al/TM/0nO
         0UtV5vJ45++be/9vvL7eOyMEpojq+M5CbCLOkNusBFetKQ9Ulk6YWfzS8CtXdPMLKKW1
         ANdYoTXBaBxzo7d6ts+8Ve9ibNs5GBbAEZkJcwyGpbBSYl+lucNYnIezVPpXCQWLaAWG
         RWsQ==
X-Gm-Message-State: AJIora8C33BbAu7UFH8w9vfWN6X66XTAwB4qbC6XudSSGmf9kiRJi5lB
        EJhh9xfBBAdFYV85yEocByUfmzqmjKWNZFQZT54=
X-Google-Smtp-Source: AGRyM1ubyzXDapbT3hKl+S+M7YsXB0uFA/Risi1XV/vHQ8lQNz/LjUTax+WCPs1ZOoXoxlrF0IK0Lw==
X-Received: by 2002:a05:651c:1246:b0:25a:9a7c:680c with SMTP id h6-20020a05651c124600b0025a9a7c680cmr18862779ljh.79.1656979605681;
        Mon, 04 Jul 2022 17:06:45 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id cf3-20020a056512280300b0047fa8ffe92csm5370823lfb.233.2022.07.04.17.06.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 17:06:45 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id l7so11878293ljj.4
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 17:06:44 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:21b:ad72:5401 with SMTP id
 g7-20020a5d64e7000000b0021bad725401mr27990729wri.442.1656979593298; Mon, 04
 Jul 2022 17:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <YsJWCREA5xMfmmqx@ZenIV> <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
 <YsM5XHy4RZUDF8cR@ZenIV> <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
 <YsNFoH0+N+KCt5kg@ZenIV> <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
 <YsNRsgOl04r/RCNe@ZenIV> <CAHk-=wih_JHVPvp1qyW4KNK0ctTc6e+bDj4wdTgNkyND6tuFoQ@mail.gmail.com>
 <YsNVyLxrNRFpufn8@ZenIV> <YsN0GURKuaAqXB/e@ZenIV> <YsN1kfBsfMdH+eiU@ZenIV>
In-Reply-To: <YsN1kfBsfMdH+eiU@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jul 2022 17:06:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmD7BgykuZYDOH-fmvfE3VMXm3qSoRjGShjKKdiiPDtA@mail.gmail.com>
Message-ID: <CAHk-=wjmD7BgykuZYDOH-fmvfE3VMXm3qSoRjGShjKKdiiPDtA@mail.gmail.com>
Subject: Re: [PATCH 1/7] __follow_mount_rcu(): verify that mount_lock remains unchanged
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Potapenko <glider@google.com>,
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
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 4, 2022 at 4:19 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -       unsigned        seq, m_seq, r_seq;
> +       unsigned        seq, next_seq, m_seq, r_seq;

So the main thing I react to here is how "next_seq" is in the "struct
nameidata", but then it always goes together with a "struct dentry"
that you end up having to pass separately (and that is *not* in that
"struct nameidata").

Now, saving the associated dentry (as "next_dentry") in the nd would
solve that, but ends up benign ugly since everything then wants to
look at the dentry anyway, so while it would solve the inconsistency,
it would be ugly.

I wonder if the solution might not be to create a new structure like

        struct rcu_dentry {
                struct dentry *dentry;
                unsigned seq;
        };

and in fact then we could make __d_lookup_rcu() return one of these
things (we already rely on that "returning a two-word structure is
efficient" elsewhere).

That would then make that "this dentry goes with this sequence number"
be a very clear thing, and I actually thjink that it would make
__d_lookup_rcu() have a cleaner calling convention too, ie we'd go
from

        dentry = __d_lookup_rcu(parent, &nd->last, &nd->next_seq);

rto

       dseq = __d_lookup_rcu(parent, &nd->last);

and it would even improve code generation because it now returns the
dentry and the sequence number in registers, instead of returning one
in a register and one in memory.

I did *not* look at how it would change some of the other places, but
I do like the notion of "keep the dentry and the sequence number that
goes with it together".

That "keep dentry as a local, keep the sequence number that goes with
it as a field in the 'nd'" really does seem an odd thing. So I'm
throwing the above out as a "maybe we could do this instead..".

Not a huge deal. That oddity or not, I think the patch series is an improvement.

I do have a minor gripe with this too:

> +       nd->seq = nd->next_seq = 0;

I'm not convinced "0" is a good value.

It's not supposed to match anything, but it *could* match a valid
sequence number. Wouldn't it be better to pick something that is
explicitly invalid and has the low bit set (ie 1 or -1).

We don't seem to have a SEQ_INVAL or anything like that, but it does
seem that if the intent is to make it clear it's not a real sequence
number any more at that point, then 0 isn't great.

But again, this is more of a stylistic detail thing than a real complaint.

             Linus
