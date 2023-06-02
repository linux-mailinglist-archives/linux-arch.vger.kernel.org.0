Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA42720724
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjFBQLL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 12:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbjFBQK4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 12:10:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A610D9
        for <linux-arch@vger.kernel.org>; Fri,  2 Jun 2023 09:10:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so2564678e87.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Jun 2023 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685722189; x=1688314189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeFT72TXfXAwhYRh1W0GvqbmonxTxhIBsAfBN2yDsw0=;
        b=RTvspkHEUsSuNPDqJToga/D9ksuhPWw2CQKitisED6WLmRQIOFQAE36LbEBLA3ru/5
         PJaVdbxblp/DhG5XSh/cIh4cCXLdK2RBCol4ghYD8ryW5np9H/RxNs7NiX1M+4siepQU
         9jFNTjB9dX6Udb1vS1HyTdFCulGwzv3BJcPkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722189; x=1688314189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeFT72TXfXAwhYRh1W0GvqbmonxTxhIBsAfBN2yDsw0=;
        b=MC/ndiXyfFEUAte+a8ejGMZ1+VQFSwM67CVfDlWCejhk02mQ2spNynI8VMA6xxrq23
         VZ8Z2SdJ4frYW2y4iHCwuxKJN+Xfwffvc+eojruLcXlYYeWZ5T8ODXBfXaNOy4b/UZc4
         7aO1wLtBjOESUpjYPqKluTvKzwOoDlgkWqhSOP8sNTLvxdoE70BM7D/fin8x346jYNK3
         GQnpcBg/rYVXAlVD+ETPIcg9e19d2JwDjGTMT1tB3qoGa6U0HvYlHAB9z2ir3eAQyX/S
         0gX3BiaiVGu3Qm9IvwooZQrpEAVxFd/vD7xv+2xoa42CRA94ptTreLXxAECEoawrqpgP
         OwDA==
X-Gm-Message-State: AC+VfDym5TdDT4IU305APbUX+TIrXkd+flHtzl0Dx2f5WDX4ulw0vtJT
        fBLUD0TBIPuR4Ro8D6rK+sI/cT8CtZh0C/AwMYygi2dc
X-Google-Smtp-Source: ACHHUZ5rpMEhVJPXGGLmMXRHswpOff7LFkaPFimtt1JMTgqDSb/fb0CabboyjMzkxuiu839ZuFh+ug==
X-Received: by 2002:a2e:870f:0:b0:2ac:81c3:55eb with SMTP id m15-20020a2e870f000000b002ac81c355ebmr281581lji.28.1685722189568;
        Fri, 02 Jun 2023 09:09:49 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e25-20020a2e8199000000b002adbf24212esm271159ljg.49.2023.06.02.09.09.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:09:49 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4eed764a10cso2992268e87.0
        for <linux-arch@vger.kernel.org>; Fri, 02 Jun 2023 09:09:49 -0700 (PDT)
X-Received: by 2002:ac2:5d6c:0:b0:4f2:509b:87ba with SMTP id
 h12-20020ac25d6c000000b004f2509b87bamr2034590lft.50.1685722168361; Fri, 02
 Jun 2023 09:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
 <20230602143912.GI620383@hirez.programming.kicks-ass.net>
In-Reply-To: <20230602143912.GI620383@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 12:09:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj7K3Q9WbBtQHiOXKc04SRjeOF+TRopkwVoQh_CFU+kvg@mail.gmail.com>
Message-ID: <CAHk-=wj7K3Q9WbBtQHiOXKc04SRjeOF+TRopkwVoQh_CFU+kvg@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Helge Deller <deller@gmx.de>,
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
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Jun 2, 2023 at 10:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Something like so then?

Ack. I think it would be much cleaner if we would have it as part of
the Kconfig file and architectures could just override some
GCC_MIN_VERSION value, but that's not the universe we currently have,
so your patch looks like the best thing to do.

              Linus
