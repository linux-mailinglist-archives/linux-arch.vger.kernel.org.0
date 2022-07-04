Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2348565EA9
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 22:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGDUvt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiGDUvs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 16:51:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D8A44D
        for <linux-arch@vger.kernel.org>; Mon,  4 Jul 2022 13:51:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so18383922ejj.12
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+7oxHi4Udb60oAybVQkpA6ge9KpdkDRHq2SyT5frGM=;
        b=WC8Na+ue7lqvNzcIq0d+w4TYUijqbI+F8XNMIDa46PZ8jUKAKSXH250R7Z1JnCea/0
         dN2Yngk7PGEZtY/pHthqQmcylYXw5XH9Y6By6BDUbTg0gRZli/Lf9QMiBR2msDqWBWIe
         3EDQ3hn2ffEhmMkzBdbguSGtcze3oKMYFRvO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+7oxHi4Udb60oAybVQkpA6ge9KpdkDRHq2SyT5frGM=;
        b=0GiH6EZ4wcVNfoa+Bzy3If+bj6K0W1EEMMGiXKXzGCfxU7LsjcWI/j/GxoHwscVwhX
         WugA6Zn0yyPXEyYCcD26EfhI7vN3/yKcU++RUtMoXMwjAJpnQMNCQRjAMOWLxFhlhZnv
         bcxFvSEtE6SsVMIJlK9GB0sCqTg+O6yW3ur4MYHhOZWDc72FsRzhI1/oIN79yJnzVyse
         B2wdyAw1Y1EOPbJts421A9P09ueOJ4MQGBb1/NaOx5MTaVz/e+wMZf4/ZI4lfAqyhChB
         ysg3yoXh4N2JQZcnVGua6w0rT0uBf7tlwZ8AcjEeG5XEHpFF3XEW5D60kvwf6xqR8oAg
         fneQ==
X-Gm-Message-State: AJIora+0x6wkYcS9V5DhljmaBQubwE7226uYR1kGpgpjECPo1geYaU6L
        jwPwJ+BMTAzlPqh3gAomEfqjGqgXkes9Iikj3TI=
X-Google-Smtp-Source: AGRyM1tcyMqjPPkB6xU0hAog9WxhTlKmGhSWONSIAZuDYo6mS7OSQLsA+K1zRAdo/CDgHdAW6pdwyw==
X-Received: by 2002:a17:907:7292:b0:726:95e4:5a21 with SMTP id dt18-20020a170907729200b0072695e45a21mr31497150ejc.266.1656967905457;
        Mon, 04 Jul 2022 13:51:45 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7dc09000000b00437938c731fsm15453883edu.97.2022.07.04.13.51.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 13:51:44 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id c131-20020a1c3589000000b003a19b2bce36so3028288wma.4
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 13:51:43 -0700 (PDT)
X-Received: by 2002:a05:600c:354e:b0:3a1:9ddf:468d with SMTP id
 i14-20020a05600c354e00b003a19ddf468dmr9623331wmq.145.1656967892746; Mon, 04
 Jul 2022 13:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV> <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
 <YsM5XHy4RZUDF8cR@ZenIV> <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
 <YsNFoH0+N+KCt5kg@ZenIV> <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
 <YsNRsgOl04r/RCNe@ZenIV>
In-Reply-To: <YsNRsgOl04r/RCNe@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jul 2022 13:51:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih_JHVPvp1qyW4KNK0ctTc6e+bDj4wdTgNkyND6tuFoQ@mail.gmail.com>
Message-ID: <CAHk-=wih_JHVPvp1qyW4KNK0ctTc6e+bDj4wdTgNkyND6tuFoQ@mail.gmail.com>
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

On Mon, Jul 4, 2022 at 1:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Why is that a problem?  It could have been moved to another parent,
> but so it could after we'd crossed to the mounted and we wouldn't have
> noticed (or cared).

Yeah, see my other email.

I agree that it might be a "we don't actually care" situation, where
all we care about that the name was valid at one point (when we picked
up that sequence point). So maybe we don't care about closing it.

But even if so, I think it might warrant a comment, because I still
feel like we're basically "throwing away" our previous sequence point
information without ever checking it.

Maybe all we ever care about is basically "this sequence point
protects the dentry inode pointer for the next lookup", and when it
comes to mount points that ends up being immaterial.

             Linus
