Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657AF607141
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJUHiF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Oct 2022 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJUHiE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2022 03:38:04 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C48239200
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2022 00:38:03 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y72so2344025yby.13
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2022 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YqCI81aYTBUvq0AjF/BYw/CwZWDfTatRIRM86fy8mzM=;
        b=hdGApCLDmq0zk1404naN816WsPf7cus4RecqB5gWNPeMIwXuVT2JpTqOAePyNFo0Q+
         +A7vMQhDqeCFfi6RbOgeeW1dRh4oUJvWP0hZnDs/KK+Nv7HoCDL7+y5jUnB24RrIxW1V
         l9Grn4St0VsHs99MbtHIi8V8+4PhGRywmpkMY5QpBoXmPWTZOrPflcxxw9Cddy0OkLXA
         1H83ZHNUriu0YQIACgBzfbWOrYIhJ4nYjCzGVKWq6lY+RHeOyNcAEqr07B+mZpQ06BZz
         JUWPvoaYDWVI28Wb9OBW92L2zM729XBkw1zK4NjdriUn0h0Tp9lUzd5pmxDXhdbubX15
         x9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqCI81aYTBUvq0AjF/BYw/CwZWDfTatRIRM86fy8mzM=;
        b=HxnOHnYiDA2UZZIz/y/qYUyTjApEEc9cSeENDMxWryywutM1jBmLvoFcl+Ss+mMA40
         8B2yeWZ5m2F5FU01Az8TCsIATmu0UKR+OpgqjzE0wDjesZhsD/S5UfgmByM6b4kKj6hs
         emb8bJrfWZ4ctVeEOSYEF2tDYFgzSQl/J94j2UIii6KVGw5YCt1VHtWmf25kDHTyPKRr
         CtMBSfIilX9VuHEufXZBRre1htDxD8VNXYtMVAjUwaPlVe7px7+cbUh3cf6iwsxWRwAP
         fB/HQ1z3hH/I04NJiVH5aF4xB32tcVk9/vda5CDvQhbwW18rtXo5iAj5Yp5QVggpcPds
         n3Kg==
X-Gm-Message-State: ACrzQf1fQ42XcFzOZ6jA8rTN7nDzl60ijonMkkBxr3ZFumGhw1jxV8zQ
        yJ5XXBZh6p0sLsfNIuSjaQVS8NCnv9wjhgLqrasbng==
X-Google-Smtp-Source: AMsMyM62GSx0NWUinN6ObtQibLc5Ih1zlGVGyMCuv7Iu8ly2udUc3uKngmrdcVX2ldvl3SdCr2LW4qra3FYqJuzBJNY=
X-Received: by 2002:a25:7b42:0:b0:6ca:1d03:2254 with SMTP id
 w63-20020a257b42000000b006ca1d032254mr8096145ybc.584.1666337882424; Fri, 21
 Oct 2022 00:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
 <Y1BXQlu+JOoJi6Yk@elver.google.com> <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
 <Y1Bt+Ia93mVV/lT3@elver.google.com> <CAG_fn=WLRN=C1rKrpq4=d=AO9dBaGxoa6YsG7+KrqAck5Bty0Q@mail.gmail.com>
 <CAOzgRdb+W3_FuOB+P_HkeinDiJdgpQSsXMC4GArOSixL9K5avg@mail.gmail.com>
 <CANpmjNMUCsRm9qmi5eydHUHP2f5Y+Bt_thA97j8ZrEa5PN3sQg@mail.gmail.com> <CAOzgRdZsNWRHOUUksiOhGfC7XDc+Qs2TNKtXQyzm2xj4to+Y=Q@mail.gmail.com>
In-Reply-To: <CAOzgRdZsNWRHOUUksiOhGfC7XDc+Qs2TNKtXQyzm2xj4to+Y=Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 21 Oct 2022 00:37:26 -0700
Message-ID: <CANpmjNPUqVwHLVg5weN3+m7RJ7pCfDjBqJ2fBKueeMzKn=R=jA@mail.gmail.com>
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
To:     youling 257 <youling257@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 20 Oct 2022 at 23:39, youling 257 <youling257@gmail.com> wrote:
>
> PerfTop:    8253 irqs/sec  kernel:75.3%  exact: 100.0% lost: 0/0 drop:
> 0/17899 [4000Hz cycles],  (all, 8 CPUs)
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>
>     14.87%  [kernel]              [k] 0xffffffff941d1f37
>      6.71%  [kernel]              [k] 0xffffffff942016cf
>
> what is 0xffffffff941d1f37?

You need to build with debug symbols:
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y

Then it'll show function names.

> 2022-10-21 14:16 GMT+08:00, Marco Elver <elver@google.com>:
> > On Thu, 20 Oct 2022 at 22:55, youling 257 <youling257@gmail.com> wrote:
> >>
> >> How to use perf tool?
> >
> > The simplest would be to try just "perf top" - and see which kernel
> > functions consume most CPU cycles. I would suggest you compare both
> > kernels, and see if you can spot a function which uses more cycles% in
> > the problematic kernel.
> >
