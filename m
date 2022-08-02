Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C057F58804D
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiHBQcF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiHBQcC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 12:32:02 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9F12AFB
        for <linux-arch@vger.kernel.org>; Tue,  2 Aug 2022 09:32:00 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p71so6108165yba.9
        for <linux-arch@vger.kernel.org>; Tue, 02 Aug 2022 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=jBLRsOY6b2BWFCEwUDOOLDtlfS4iNN5NSPXBB7OTTdA=;
        b=C4yceeMrnfpv45TrBL5GxEv4ZUizC3/Vr/jdh5+Zbi+KLMTBmkoAfxkD1EYYg12lXR
         pVh9AeV8yvh5TuY9NmlD5eP0jKvFj7RP4G22OnxoGm/N4AdkMtswGPXRhOT2BAXTVf+g
         FxUqNI0/HgsAV4zTTqe6XuZcWKi6X5wZ9M7NjSvOyx1jz7FGR6CrHM8rbpH9l0DxzWoe
         hf6GZ3KmxjshcXvib72rR5MKZV0MM1F8H1CRVx3BPyeg9Gw1DE8RZTD5fXM+LhoZ5DnJ
         bgOGwc3ofHcCsX0ffHzVQHWF/qTn8A1ekfgQvNGt/WK7yTeGQxrDPRF9ro3QNUjzbtCk
         zTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jBLRsOY6b2BWFCEwUDOOLDtlfS4iNN5NSPXBB7OTTdA=;
        b=pFFcsXR0YnGX7+IdhdcphAEnuTFBb0CMTz6tzmiRsIrg84u4CZirMXRVVnUa4T1rhb
         EZu+CABgIRxDJahwJlz/W/N7m/OLlJw6IliV9MNQSPrdjk4PBNI9NotjgYE8xTQyyUel
         SuCz4hzfCSkcidLNCJ+mEuiuuiMTUJ1K3FD3AYe9d7jMuH1S4dYJQARo+Uko2fKM/Xrr
         swJQFcZY+7JYvvZgL3Am3c4UuoeTvM7RtNjZq3OR6AB18E5gTyIUucnA+5C4oHJZh2Lr
         VD+GqtrJ+xTJxwsjFuXTTb+Z5mWUf/xJtMTRWsSdR5Gn8Cuma4rioHqtvwTdyMa1JEnN
         fpKQ==
X-Gm-Message-State: ACgBeo1w7/qgsrX5RlawEUXcNcYGWPKMGahwFA0tN4Fmn18Gfd79E0N/
        VlbPQdsClt8oPrrEOEefeD9dUFRcckR0cTZVhWfoXw==
X-Google-Smtp-Source: AA6agR4IP/yDKQLvxlaLVuFqguT0B75J5VxgY1hE7G7tnFEWCGuvYJ1oLYRqlboQgCEcZi6lhGNXNp7TZO+7bdc8488=
X-Received: by 2002:a25:b9d1:0:b0:671:49f9:4e01 with SMTP id
 y17-20020a25b9d1000000b0067149f94e01mr16899347ybj.398.1659457919894; Tue, 02
 Aug 2022 09:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-16-glider@google.com>
 <CANpmjNOJ-2xim3KM=9O=sfSgQXZi81R6PQj=antfHnejaOOogg@mail.gmail.com>
In-Reply-To: <CANpmjNOJ-2xim3KM=9O=sfSgQXZi81R6PQj=antfHnejaOOogg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Aug 2022 18:31:23 +0200
Message-ID: <CAG_fn=UBVs+QgdWDa_UB_zs0OUO=-zjcoH+8NY7obUm20rkBOQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/45] mm: kmsan: call KMSAN hooks from SLUB code
To:     Marco Elver <elver@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 12, 2022 at 3:14 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:23, 'Alexander Potapenko' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > In order to report uninitialized memory coming from heap allocations
> > KMSAN has to poison them unless they're created with __GFP_ZERO.
> >
> > It's handy that we need KMSAN hooks in the places where
> > init_on_alloc/init_on_free initialization is performed.
> >
> > In addition, we apply __no_kmsan_checks to get_freepointer_safe() to
> > suppress reports when accessing freelist pointers that reside in freed
> > objects.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> But see comment below.
>

>
> Remove unnecessary whitespace change.
Will do, thanks for catching!


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
