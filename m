Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D975A70D2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 00:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiH3W2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 18:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiH3W11 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 18:27:27 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352596FD6
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 15:26:03 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id d14so4800380ual.9
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=r2P9ypGVKmAeSRno/tnjXqx+dUVsN5K996xR9WW8XbA=;
        b=DZGo2BNvDlG7/zqfXW/QJuwqFO+SIOxNidK6H2ty1hFs/dLY5Eqn1UETUmlkSu0enV
         xDyl5CVvVebImnq5Thn9RArOrtrLqQX3fekaHzaHeVW+lIS8iJvvPw/5+z07o0RcvVPC
         P37KA8UbL/ispTj6OaeJhcgK4v7SmiUmj6ynT2QxqZCV10hUtaa+EK6K+79t4PGF/noQ
         9e24buA1qTJzQdQvBrsBpdCzA76jh3e8mtF06xH26lCG7Ta02lQOWsrgs9PT6JvynFE/
         //7MWylVSxXDVeYji4ooSry5grv9QKnnHoLMwpyWZSUuBEZtdBSjHTIRp1QWqIdIr38W
         hFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=r2P9ypGVKmAeSRno/tnjXqx+dUVsN5K996xR9WW8XbA=;
        b=jPBElz6Yq+eqtWTEy0zEHPDnHRD1TPrQTHT6BdQuG2eLj3ne+bB99TJ3UQJao/jI4Y
         eP1YfLZSF51tnlsop46tshvxVTZwiuzpD/3fIDWxUh5WH8CMPvczA+7a/HkDNqS+DIar
         fWlDmQJ9t2CswUH7Ce1dSugdB8cnA4xH+T1bdeo28iuqsdl3/z5AgTgNej1tDQrGq8iq
         BLVRCdE9xp6w2/6a5aeaBISch3FLRbgzyQsKqwjlULtqSIZlHB+vXho9Hfjf4XzJgrPR
         z0FIGIM+Hleb1mOPR73XdqSafO+izjA3BUaaoa756URC3qXs0e55u5zaPGQFGt/UEQCV
         3waA==
X-Gm-Message-State: ACgBeo32Z1t8KFS5clHOMXUjy7MrJS2UpbPk70yuUdq80Ei9Rq5hN8pJ
        8kfL0hpOkAtulyLNGM1Y4iLK89tLH6+nfZUQscTeQQ==
X-Google-Smtp-Source: AA6agR60+KV0yqyQq+iX5Bs1kEZbtaQBiCEn4gv6zHZYqemrhxaS5IB5T402nhD96NsktnfRhmWwTB/EIRtyUYdZwfQ=
X-Received: by 2002:ab0:1e0d:0:b0:39f:a187:b72e with SMTP id
 m13-20020ab01e0d000000b0039fa187b72emr3174662uak.70.1661898361104; Tue, 30
 Aug 2022 15:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220826150807.723137-1-glider@google.com> <20220826150807.723137-5-glider@google.com>
 <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
 <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com>
 <20220829122452.cce41f2754c4e063f3ae8b75@linux-foundation.org>
 <CAG_fn=X6eZ6Cdrv5pivcROHi3D8uymdgh+EbnFasBap2a=0LQQ@mail.gmail.com> <20220830150549.afa67340c2f5eb33ff9615f4@linux-foundation.org>
In-Reply-To: <20220830150549.afa67340c2f5eb33ff9615f4@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 30 Aug 2022 16:25:24 -0600
Message-ID: <CAOUHufZrb_gkxaWfCLuFodRtCwGGdYjo2wvFW7kTiTkRbg4XNQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and put_user()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 30, 2022 at 4:05 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Tue, 30 Aug 2022 16:23:44 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > >                  from init/do_mounts.c:2:
> > > ./include/linux/page-flags.h: In function =E2=80=98page_fixed_fake_he=
ad=E2=80=99:
> > > ./include/linux/page-flags.h:226:36: error: invalid use of undefined =
type =E2=80=98const struct page=E2=80=99
> > >   226 |             test_bit(PG_head, &page->flags)) {
> > >       |                                    ^~
> > > ./include/linux/bitops.h:50:44: note: in definition of macro =E2=80=
=98bitop=E2=80=99
> > >    50 |           __builtin_constant_p((uintptr_t)(addr) !=3D (uintpt=
r_t)NULL) && \
> > >       |                                            ^~~~
> > > ./include/linux/page-flags.h:226:13: note: in expansion of macro =E2=
=80=98test_bit=E2=80=99
> > >   226 |             test_bit(PG_head, &page->flags)) {
> > >       |             ^~~~~~~~
> > > ...
> >
> > Gotcha, this is a circular dependency: mm_types.h -> sched.h ->
> > kmsan.h -> gfp.h -> mmzone.h -> page-flags.h -> mm_types.h, where the
> > inclusion of sched.h into mm_types.h was only introduced in "mm:
> > multi-gen LRU: support page table walks" - that's why the problem was
> > missing in other trees.
>
> Ah, thanks for digging that out.
>
> Yu, that inclusion is regrettable.

Sorry for the trouble -- it's also superfluous because we don't call
lru_gen_use_mm() when switching to the kernel.

I've queued the following for now.

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -3,7 +3,6 @@
 #define _LINUX_MM_TYPES_H

 #include <linux/mm_types_task.h>
-#include <linux/sched.h>

 #include <linux/auxvec.h>
 #include <linux/kref.h>
@@ -742,8 +741,7 @@ static inline void lru_gen_init_mm(struct mm_struct *mm=
)

 static inline void lru_gen_use_mm(struct mm_struct *mm)
 {
-       if (!(current->flags & PF_KTHREAD))
-               WRITE_ONCE(mm->lru_gen.bitmap, -1);
+       WRITE_ONCE(mm->lru_gen.bitmap, -1);
 }

 #else /* !CONFIG_LRU_GEN */
