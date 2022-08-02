Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4A58806A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbiHBQkb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiHBQka (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 12:40:30 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B65183
        for <linux-arch@vger.kernel.org>; Tue,  2 Aug 2022 09:40:29 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 123so24448291ybv.7
        for <linux-arch@vger.kernel.org>; Tue, 02 Aug 2022 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=TKCfFaRwxtnk/rQVtVgmwJGR+kFqLe+E3ZNMs5uStiU=;
        b=fQz6bCpBWDz1U2UNZ+ogvEaeGM0+TQSUCvJjHgOxzKyVR10AMWmDx2/OC2IM/oT8VK
         ZxZKOlmmxDys3j4TmR3QotmUtsWfi3fa0qHZP3uYqAmgwuTmmrhfF+Sb0Zi2pnIfXWuz
         xVyYZy+CCqbxXYfrjVFlsFK3a6SCD0iuq2Vvzf2fE3rT8ks85BnVKYRK3UP96wOVF4W4
         nWzU9CVw619B+vCINNCA4+USGc+0+cRit4d94xnRthJdJRHWZqSsunW56JDBHrs52Ysa
         DGmPhv4wPDr00SDCFO8E8sRLT6HcOQbyKFcaeyQ5Pz4kH0WGi6hfR/8Q+qWq1jGBCTtr
         eUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=TKCfFaRwxtnk/rQVtVgmwJGR+kFqLe+E3ZNMs5uStiU=;
        b=euXw/iPkKeLd90iced8Caqo5YhudoZYOsWpb+X0h+GAiU4dpAnI9osKfzOMITlNORb
         O/m2081cgiMbnqE+K7qsUT+cGQFTtHIMGlPE6QLGpEk9Lg5vBx9/pZwPK9CBlUdfix0G
         SZIrg3CxO/s5GaGDK/NQEkHnUbF0j9yX2GOJu07PdqL2oHKIUFUEAopQpAHscCxxIkuw
         bfODVHxZKrh2MW6Pfn1qut3lF2gyIj85SZwipKO5GB2nopYS36FGXUKUsYwHpwt1xHZk
         fOOmUJSQdoL+UzfA+CDb1fTrlXjpyoXz9Os2MhMeXrYjThOqWt+RuiFHfuN0DD+nDmnK
         DKiQ==
X-Gm-Message-State: ACgBeo1w8r08AAAlFYZUeCdrhwiq8GKyaMA7naOEnzaa/ue/MSKm1+e+
        r6qGZKvzE72lbYTsBot66w1X9b9+nfNySHN20XYYeA==
X-Google-Smtp-Source: AA6agR5Gr6ZR3RM0aH8kASevKllDwtedqw0828kHHV1gmi+nYLK8FHDGmtXNVJqNcM1yQPB8Q5uxXbQyYEibGICYWso=
X-Received: by 2002:a25:bc3:0:b0:673:bc78:c095 with SMTP id
 186-20020a250bc3000000b00673bc78c095mr15523307ybl.376.1659458427960; Tue, 02
 Aug 2022 09:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-14-glider@google.com>
 <CANpmjNN1KVteEi4HPTqa_V78iQ1e2iNZ=rguLSE6aqyca7w_zA@mail.gmail.com>
In-Reply-To: <CANpmjNN1KVteEi4HPTqa_V78iQ1e2iNZ=rguLSE6aqyca7w_zA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Aug 2022 18:39:51 +0200
Message-ID: <CAG_fn=WDr1HnQG+Np9Q4waurnJgiS=3Z-ww2M1oW0To=1LivZg@mail.gmail.com>
Subject: Re: [PATCH v4 13/45] MAINTAINERS: add entry for KMSAN
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> >
> > +KMSAN
> > +M:     Alexander Potapenko <glider@google.com>
> > +R:     Marco Elver <elver@google.com>
> > +R:     Dmitry Vyukov <dvyukov@google.com>
> > +L:     kasan-dev@googlegroups.com
> > +S:     Maintained
> > +F:     Documentation/dev-tools/kmsan.rst
> > +F:     include/linux/kmsan*.h
> > +F:     lib/Kconfig.kmsan
> > +F:     mm/kmsan/
> > +F:     scripts/Makefile.kmsan
> > +
>
> It's missing:
>
>   arch/*/include/asm/kmsan.h

Done

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
