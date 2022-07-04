Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B77565E66
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiGDUZU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 16:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGDUZT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 16:25:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793FB5FAA
        for <linux-arch@vger.kernel.org>; Mon,  4 Jul 2022 13:25:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j21so17408050lfe.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NHXRzMNJPY/okJiN7rxUFnMFdO+6UnOx+ybcPBWQtw=;
        b=QhD7FvbczvS7ySqve4lgmGKe6XQqf2tkErpFbk227PNJlSK9nINruRTNggBVzaq6hn
         Vm06wsisRqXUdJvpIFNLX7oFVacVFtCt6NbzXypYAbFcxemoyYNqmZPiyTxlGlD7Sr1U
         /8FS/9iTlnawFf71gWUa5iOfR8gUphFcHgYu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NHXRzMNJPY/okJiN7rxUFnMFdO+6UnOx+ybcPBWQtw=;
        b=Ao5anbpdij61QpO6A62aH/PVK3Sm1m3abKIwL6gRzmStnA/GEzZWms6zuhWfKSKGSS
         LojaHmv0MbVON/LrYfGVvPvE65sm9FSCPcq2ShRy6lSzZxjaCM8zVELSuXJln7C/7a6I
         4+tuLSuFrI7rboXNyqUDKrnALHQnOOjnK9BomeUNVL2ueuT/DoQo6JqOg00ZJYGq4a9F
         APe6gCoaYaS8o6FSgew//sPsEgdyinQGPf5mcuLQ71rwSGvUKfFTdb+/w4eW1WFZkPxR
         D8eZ6mDTEN5ogYTNwrYmmTiV089OSgavc8NGln88uQyDfWMIPJoSu38WOlybXWlsxyn4
         bt8w==
X-Gm-Message-State: AJIora8APa7/kUO0QyvINedjTQGGDJmz36AWgCivrQfHWBHIqbbXcDeJ
        s76IpbbpboH8QizsxYwvahdrfEcg5UWaXgsUcfA=
X-Google-Smtp-Source: AGRyM1tHTKNm4Q9OBVoAtHDAiJMzFBWpkjTJ9bX3pwAdMN8idvDJHuv0yjvr2abbm6mDHCWg67hNkA==
X-Received: by 2002:a05:6512:4013:b0:47f:705e:379e with SMTP id br19-20020a056512401300b0047f705e379emr20716805lfb.457.1656966316332;
        Mon, 04 Jul 2022 13:25:16 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b0047f933622c8sm5300694lfc.163.2022.07.04.13.25.15
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 13:25:15 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id a11so12209896ljb.5
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 13:25:15 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:21b:ad72:5401 with SMTP id
 g7-20020a5d64e7000000b0021bad725401mr27424083wri.442.1656966304591; Mon, 04
 Jul 2022 13:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV> <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
 <YsM5XHy4RZUDF8cR@ZenIV> <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
 <YsNFoH0+N+KCt5kg@ZenIV>
In-Reply-To: <YsNFoH0+N+KCt5kg@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jul 2022 13:24:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
Message-ID: <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
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

On Mon, Jul 4, 2022 at 12:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> You are checking the wrong thing here.  It's really about mount_lock -
> ->d_seq is *not* bumped when we or attach in some namespace.

I think we're talking past each other.

Yes, we need to check the mount sequence lock too, because we're doing
that mount traversal.

But I think we *also* need to check the dentry sequence count, because
the dentry itself could have been moved to another parent.

The two are entirely independent, aren't they?

And the dentry sequence point check should go along with the "we're
now updating the sequence point from the old dentry to the new".

The mount point check should go around the "check dentry mount point",
but it's a separate issue from the whole "we are now jumping to a
different dentry, we should check that the previous dentry hasn't
changed".

                    Linus
