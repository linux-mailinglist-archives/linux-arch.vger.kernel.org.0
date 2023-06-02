Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5924E720A10
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 21:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjFBT6I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 15:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjFBT6H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 15:58:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8BE40
        for <linux-arch@vger.kernel.org>; Fri,  2 Jun 2023 12:58:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso3349533e87.0
        for <linux-arch@vger.kernel.org>; Fri, 02 Jun 2023 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685735884; x=1688327884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pqo3OfJjzReA0YZCNQePZ3Xh5QPxALpix/U4edhgSI=;
        b=W4f2bvHY/MqtlWgFoJcA+8vxb7C0987DVZj2B5PB2quJ4KQUQHF9e6SIGOPIRiGTIh
         Wz8b90W6/fBSD0skzOT6YNt6xHi9cR+ErM1v7lJrBVG99YNrQ+i9Jzkwok5SGQnCx5Pw
         YpwwJLJB55uJxOm0scv6/RripMi+2ltE/pnSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685735884; x=1688327884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pqo3OfJjzReA0YZCNQePZ3Xh5QPxALpix/U4edhgSI=;
        b=Qxfs+2Fztb4MBkWrimKln/uRLI2RnBK4xGlZwri4v0bdMAlXSoGg1TRrfupFqCNZz5
         pcS7QMOf6VXnlxB4uJBW5sDAQtKwtfTnOvRIzZYE1D0KnSIFXmNKUwdhPScpvnSCKoN3
         JhS/hhm1XDDtHOb3z5+OmCh/LsgQEP6mOiGi2liHYtnLwpgWEwDxu+EOPVZwUdWriyIX
         +BpUKU4XdTnh5Auvo3vGw4vvA0y9GS6UOLYpiuMXZZ41lGKjcZFB6J20A8E5lykiPCuc
         xH2KJ03r7AkL3QpE0FrNXYEA8m/or1Bt2gVIIv49JCb5B49LkiKB2HVX3Sj5vAyO94f0
         CRRQ==
X-Gm-Message-State: AC+VfDy/1NYiaHX7Pm9jlxrJK6q38N8axd4HPFtqR5bmnfwMiPbZXmic
        lML6xYzqfQiQ7jky6hgvG+Sg8Q8P1ziCbhpRBTtUhk/7
X-Google-Smtp-Source: ACHHUZ4195k5TSqdrufXYBApiHxaLYenl5RIdl0d2FNh6q4wvpz3+RMcJ38aAfuPAvc00/rP+A6YHA==
X-Received: by 2002:ac2:5602:0:b0:4f3:aa74:2faf with SMTP id v2-20020ac25602000000b004f3aa742fafmr2359865lfd.6.1685735884172;
        Fri, 02 Jun 2023 12:58:04 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id d21-20020a056402517500b0050bc6c04a66sm1011110ede.40.2023.06.02.12.58.02
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 12:58:03 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so3591497a12.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Jun 2023 12:58:02 -0700 (PDT)
X-Received: by 2002:a05:6402:b10:b0:514:9b60:ea65 with SMTP id
 bm16-20020a0564020b1000b005149b60ea65mr2665357edb.16.1685735862382; Fri, 02
 Jun 2023 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
 <20230602143912.GI620383@hirez.programming.kicks-ass.net> <E333E35E-5F9C-441C-B75A-082F19D37978@zytor.com>
 <20230602191014.GA695361@hirez.programming.kicks-ass.net> <B432FCD8-2ED7-42B1-BC3B-34F277A1CD9F@zytor.com>
 <20230602194021.GB695361@hirez.programming.kicks-ass.net>
In-Reply-To: <20230602194021.GB695361@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 15:57:25 -0400
X-Gmail-Original-Message-ID: <CAHk-=wi4q=_+vQkOM0LRY7SfsH+D1-9DOSBABAzXrZwWxmJR+g@mail.gmail.com>
Message-ID: <CAHk-=wi4q=_+vQkOM0LRY7SfsH+D1-9DOSBABAzXrZwWxmJR+g@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, suravee.suthikulpanit@amd.com,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 2, 2023 at 3:40=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> "With 64bit builds depending on __SIZEOF_INT128__ to detect the
> presence of __int128 raise the parisc minimum compiler version to
> gcc-11.0.0."
>
> better?

I'd just say "64-bit targets need the __int128 type, which for pa-risc
means raising the minimum gcc version to 11".

The __SIZEOF_INT128__ part isn't the important part. That's just the sympto=
m.

               Linus
