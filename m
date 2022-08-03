Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCFB5891B4
	for <lists+linux-arch@lfdr.de>; Wed,  3 Aug 2022 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiHCRqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 13:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiHCRqc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 13:46:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4B65E6
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 10:46:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g5so5122405ybg.11
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=kVM/3uyhal6qaeACSB8divgbMh2p6Q9rmvW6JHSngAY=;
        b=ECfvFXHNoWfUFidh9Eguf3fa6Bq7Cr+ZBwO3g+v5R26inMZJ+PprF07thBS/iAUDOv
         KoHKoNk3p1CD7oA+XYhLMGnLx1UM64+m/oZTxYGBm1ui3mSKNDJXkbXHNHZNWwYMPM25
         no6Xk74r5H+HlvFMAu7VhmjjTkqjGEorYK/E1NNrmLycAfwGb5T8CDwMPzi10MsKfcDt
         CXm/wIg4qaq6nACUNqANSQ4Cc+ljRsHsBpUSMvB1FXN+xTv+VW9BrlbK48uMvV02e1hS
         ZJi1UEudP/SKw5sBgAoFnA38ohuro2kf26ubLWtfiJ2mUlp6waOtZ04l1TvBymZ8hC+a
         h9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=kVM/3uyhal6qaeACSB8divgbMh2p6Q9rmvW6JHSngAY=;
        b=MLJ/toVJrW1M462Zut+dZIJEqY9dBKEzOEJxPCj7BeDOXLcqvs5d/LAqR1XF9pYidu
         8Ma9nwKQkTjlXscPnWjgguGWFol27Cwu3AkVOkRTL4CuF6z9xzk+7rHJwkB4r2soWEL1
         ToddP3vOqP9wDvV7K/bM7FWQEqWMmjwraHYkN9f+r+A74Nc/FHWQdImO4CBxEt7rUPCN
         yrIEZui+W0xuLSMYNPdy9hWeYhaUyiVqNrfeQhhrBIc1mW1ZaDA29r+B/eDIXHvL4hTe
         hucmc7Rs466M77wHezEcRX4w3IrWOKviQq3DuxLGYfkRbk7zUJZkLuvo6sQ2bCTRBId3
         Y4Xw==
X-Gm-Message-State: ACgBeo0ZZr+WLD6Ra0Eazxo7wd3RXtvLBVMKUV02wUlsvbLAA+STyzXB
        625k6N1kdtYI/hWZI6IOI2o+u4CqJ5TNiashmTRCZA==
X-Google-Smtp-Source: AA6agR4g1FyYUH5thYLF9ivxcDKGh7mHOG7nULxadr/VqkcQq6xewq/huMh2sMi+U779TLv1Uc8ZMhJh1Xgb5KuhJ1U=
X-Received: by 2002:a25:b9d1:0:b0:671:49f9:4e01 with SMTP id
 y17-20020a25b9d1000000b0067149f94e01mr22124946ybj.398.1659548790205; Wed, 03
 Aug 2022 10:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-12-glider@google.com>
 <Ys6YvvARDX6pWmWv@elver.google.com>
In-Reply-To: <Ys6YvvARDX6pWmWv@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Aug 2022 19:45:53 +0200
Message-ID: <CAG_fn=ViyCu8uGy5YQ_FdPmsMWzX5UpozfLXiotF_bDu5P70Lw@mail.gmail.com>
Subject: Re: [PATCH v4 11/45] kmsan: add KMSAN runtime core
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

On Wed, Jul 13, 2022 at 12:04 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, Jul 01, 2022 at 04:22PM +0200, 'Alexander Potapenko' via kasan-de=
v wrote:
> [...]
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2e24db4bff192..59819e6fa5865 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -963,6 +963,7 @@ config DEBUG_STACKOVERFLOW
> >
> >  source "lib/Kconfig.kasan"
> >  source "lib/Kconfig.kfence"
> > +source "lib/Kconfig.kmsan"
> >
> >  endmenu # "Memory Debugging"
> >
> > diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> > new file mode 100644
> > index 0000000000000..8f768d4034e3c
> > --- /dev/null
> > +++ b/lib/Kconfig.kmsan
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config HAVE_ARCH_KMSAN
> > +     bool
> > +
> > +config HAVE_KMSAN_COMPILER
> > +     # Clang versions <14.0.0 also support -fsanitize=3Dkernel-memory,=
 but not
> > +     # all the features necessary to build the kernel with KMSAN.
> > +     depends on CC_IS_CLANG && CLANG_VERSION >=3D 140000
> > +     def_bool $(cc-option,-fsanitize=3Dkernel-memory -mllvm -msan-disa=
ble-checks=3D1)
> > +
> > +config HAVE_KMSAN_PARAM_RETVAL
> > +     # Separate check for -fsanitize-memory-param-retval support.
>
> This comment doesn't add much value, maybe instead say that "Supported
> only by Clang >=3D 15."
Fixed.

> > +     depends on CC_IS_CLANG && CLANG_VERSION >=3D 140000
>
> Why not just "depends on HAVE_KMSAN_COMPILER"? (All
> fsanitize-memory-param-retval supporting compilers must also be KMSAN
> compilers.)
Good idea, will do.

> > +     def_bool $(cc-option,-fsanitize=3Dkernel-memory -fsanitize-memory=
-param-retval)
> > +
> > +
>
> HAVE_KMSAN_PARAM_RETVAL should be moved under "if KMSAN" so that this
> isn't unnecessarily evaluated in every kernel build (saving 1 shelling
> out to clang in most builds).
Ack.

> > +config KMSAN
> > +     bool "KMSAN: detector of uninitialized values use"
> > +     depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> > +     depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> > +     select STACKDEPOT
> > +     select STACKDEPOT_ALWAYS_INIT
> > +     help
> > +       KernelMemorySanitizer (KMSAN) is a dynamic detector of uses of
> > +       uninitialized values in the kernel. It is based on compiler
> > +       instrumentation provided by Clang and thus requires Clang to bu=
ild.
> > +
> > +       An important note is that KMSAN is not intended for production =
use,
> > +       because it drastically increases kernel memory footprint and sl=
ows
> > +       the whole system down.
> > +
> > +       See <file:Documentation/dev-tools/kmsan.rst> for more details.
> > +
> > +if KMSAN
> > +
> > +config KMSAN_CHECK_PARAM_RETVAL
> > +     bool "Check for uninitialized values passed to and returned from =
functions"
> > +     default HAVE_KMSAN_PARAM_RETVAL
>
> This can be enabled even if !HAVE_KMSAN_PARAM_RETVAL. Should this be:
>
>         default y
>         depends on HAVE_KMSAN_PARAM_RETVAL
>
> instead?
>
Ack

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
