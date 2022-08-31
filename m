Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE15A7EF2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiHaNeg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 09:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiHaNeV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 09:34:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A2D4F5C
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 06:33:36 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j204so4165384ybj.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=0+LvJ7VjdJUJkQtLqFzy6A2FisDBtX4zU7WtR7vEfb0=;
        b=lZE1wqPcUFTWUx2edJyH4j/xIAjV6jv2Q2oGtrj5GUNtTwzHlWPP5s6DqeZqSl9h8Y
         5M2pjTrzgC3VMZR1TKgCMVNlFqzs6YpmNTPNQaRsVMonq17hQ26jD/H8Tz4E177fgg73
         NhpoSy/yJx6JeJJ3hdx3YKg/Vku4dz+HPU8DXoj1Lu6i1NLgUA423Pyw9B/ZdZTJshiC
         0mDh6vZsBBLCK+Ee0Us1bvDT2sG55h+CvEl+1b3evaLpTPUB/pNCbiPncvz2hXqSHBMG
         ix9J/RXr86EQDoPG2G1AYL+iXKf1Eu4GvNPauyG64Q5cElBD6rPco7a1Ku2nEJgjEUMv
         cDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=0+LvJ7VjdJUJkQtLqFzy6A2FisDBtX4zU7WtR7vEfb0=;
        b=HnYz27Fdobq10tguF88gPe3pS7eQdqYTmm69XLV1lvoZZQRkG4gRupVVENl+/Jy1sW
         tI3Q1PRMnMeh8S+ZrHveqsmp1zVAwEy4XVZPR17qU/50lEZUtvyYP1dXPPydvXQJHIbi
         YYBmDmD5R6uvGP4H1MT7tgsRMDNo/K98R/Ep7FI9fAr+V6iXhKv3QjCdJ+5ltIYnxLcs
         VL9MVuQMTSTFOy6h87DqdjchLjTPhyb79jBwTNp3p2ihCSa7GZxSpGe7eA16wyDYS72K
         t273qLDTsFZ95f4CiXJ48SNn5Q/NxlsKhpo/8oG5IQ+6kRGosBPxYEA3NURTDp+JlzWP
         tjCg==
X-Gm-Message-State: ACgBeo2DBLTJlBqgzex/JSc31oK68rRDmCL01bVm0XW3Oo/en2MEwWY0
        IAjUxAq029nANH1/Fj4LhFqLGjUWBbBvvPb/PJC8UA==
X-Google-Smtp-Source: AA6agR527s4sIJuqvAoe6R6bXgEbs7fsJxYB1PTbH3VZAYpcKPk/1e0D345H5OETRX62rrwgZpKJfp6B29lhrMk3Lhk=
X-Received: by 2002:a25:bc3:0:b0:673:bc78:c095 with SMTP id
 186-20020a250bc3000000b00673bc78c095mr15327415ybl.376.1661952810986; Wed, 31
 Aug 2022 06:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-45-glider@google.com>
 <YsNIjwTw41y0Ij0n@casper.infradead.org> <CAG_fn=VbvbYVPfdKXrYRTq7HwmvXPQUeUDWZjwe8x8W=ttq6KA@mail.gmail.com>
 <CAHk-=wg-LXL4ZDMveCf9M7gWWwCMDG1dHCjD7g1u_vUXsU6Bzw@mail.gmail.com>
 <20220825215754.GI25951@gate.crashing.org> <CAHk-=wj_nfiLk_bzjD8GWFFzm17syvOYqS=Y7BOarMSTkMiamQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj_nfiLk_bzjD8GWFFzm17syvOYqS=Y7BOarMSTkMiamQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 31 Aug 2022 15:32:54 +0200
Message-ID: <CAG_fn=UFbsbM1-cSvvc3aBMmFgasAWqeBrOXpzZ7_DjwU3wT6g@mail.gmail.com>
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 9:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 25, 2022 at 3:10 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > But UB is defined in terms of the abstract machine (like *all* of C),
> > not in terms of the generated machine code.  Typically things will work
> > fine if they "become invisible" by inlining, but this does not make the
> > program a correct program ever.  Sorry :-(
>
> Yeah, and the abstract machine model based on "abstract syntax" is
> just wrong, wrong, wrong.
>
> I really wish the C standard people had the guts to just fix it.  At
> some point, relying on tradition when the tradition is bad is not a
> great thing.
>
> It's the same problem that made all the memory ordering discussions
> completely untenable. The language to allow the whole data dependency
> was completely ridiculous, because it became about the C language
> syntax and theory, not about the actual code generation and actual
> *meaning* that the whole thing was *about*.
>
> Java may be a horrible language that a lot of people hate, but it
> avoided a lot of problems by just making things about an actual
> virtual machine and describing things within a more concrete model of
> a virtual machine.
>
> Then you can just say "this code sequence generates this set of
> operations, and the compiler can optimize it any which way it likes as
> long as the end result is equivalent".
>
> Oh well.
>
> I will repeat: a paper standard that doesn't take reality into account
> is less useful than toilet paper. It's scratchy and not very
> absorbent.
>
> And the kernel will continue to care more about reality than about a C
> standard that does bad things.
>
> Inlining makes the use of the argument go away at the call site and
> moves the code of the function into the body. That's how things
> *work*. That's literally the meaning of inlining.
>
> And inlining in C is so important because macros are weak, and other
> facilities like templates don't exist.
>
> But in the kernel, we also often use it because the actual semantics
> of "not a function call" in terms of code generation is also important
> (ie we have literal cases where "not generating the 'call'
> instruction" is a correctness issue).
>
> If the C standard thinks "undefined argument even for inlining use is
> UB", then it's a case of that paperwork that doesn't reflect reality,
> and we'll treat it with the deference it deserves - is less than
> toilet paper.

Just for posterity, in the case of KMSAN we are only dealing with
cases where the function call survived inlining and dead code
elimination.


> We have decades of history of doing that in the kernel. Sometimes the
> standards are just wrong, sometimes they are just too far removed from
> reality to be relevant, and then it's just not worth worrying about
> them.
>
>           Linus



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
