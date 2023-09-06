Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2582793C93
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjIFMZD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 08:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjIFMZD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 08:25:03 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2008171D;
        Wed,  6 Sep 2023 05:24:58 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34f3264a283so1908135ab.1;
        Wed, 06 Sep 2023 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694003098; x=1694607898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fLhsTfYTqZdZr8z56hbpmg5XtICWKziyrzDfh2mv1o=;
        b=FDPiZDhj1vp/HRrT/t+i6BmK90W7n/TxRhN9NNhkMYBKP0om78a9z59nD4YR5T3ksl
         yyGiZkQdTDkAYctetrIJJHnksysY+wfiZdcX8Nyyq4YPHqy8pE4T3urSeXvO8CSH2UEO
         HhyBEm6TVbvJYgxo7XCfxj6ykpGxVd1ogTUpi0h4174vOAxFvTRZlNJF96pVvBLLjQJ7
         HL6mqOUtErmLkPjY9V5e6zha06ffzLEEViTfWM08v3toq1P5BGkvNmHsRn1E6tovLbja
         qhqR4jkRcZiwZTb+vkVuH7KmYYRKWHGZPwbAfPRtoq8XnXWv0Bf91W4eo9nn+4Sy6BEr
         GYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003098; x=1694607898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fLhsTfYTqZdZr8z56hbpmg5XtICWKziyrzDfh2mv1o=;
        b=R04AqIm2IRohhCk2HRtbt692Dtt0EhtY/avzKfC8Q0zCrIf4Mr4ySDPX9FInBHPxh2
         UxVg5Yz7ZGPos256pB5S15Y0JuiblaCsEw3eXfdNn65V1A187wPKZgXpBNK39y5cZS3X
         FCdN2dVjylBAc7k2at6MBPEL5+5z8PGqxiy4ElShfF2tco3qtWbFzySkwiraqMOcJnEx
         9jsO/nn0J9i+HQ+6nK45IhVmuy4rT1vWnk4VKJa4VHEW44qBwEozhIxoLjZWjt6E8cz2
         1oYhP8FtqHYk/l1WEgHM2ojPXBEVG6MfflhLSA2hpU5DOjAp7x/srw4R6b3R866Rwv2b
         gjAg==
X-Gm-Message-State: AOJu0YyO6rk8zOURtEwWt+d48DJUqo/3Z7o1hZf5vCajnG0SZiYegfop
        B/F1utHaf+rlRq/I9OvPq5L7LI0ZO5TwY70bw1w=
X-Google-Smtp-Source: AGHT+IFXuzhnrvDWBwLUAAVx6AQhArl0lv3tw42IPTTuVjcH7zGUQNDliDj5Ts43x4pPls6rz9VqRxSdtcA8m3KZ8rM=
X-Received: by 2002:a05:6e02:19c5:b0:34a:95f9:650c with SMTP id
 r5-20020a056e0219c500b0034a95f9650cmr18133885ill.10.1694003098249; Wed, 06
 Sep 2023 05:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
 <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com> <CAHVXubhLB9Pw51C1ed1Youp9k0qTJKrokUAqf=Xnr+m3BoN5=g@mail.gmail.com>
In-Reply-To: <CAHVXubhLB9Pw51C1ed1Youp9k0qTJKrokUAqf=Xnr+m3BoN5=g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 6 Sep 2023 13:23:57 +0100
Message-ID: <CA+V-a8s0i=VMSbMa6WvOiZpqe_idAhq4cZ0inSdCNy39-rQeAg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexandre,

On Wed, Sep 6, 2023 at 1:18=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> On Wed, Sep 6, 2023 at 2:09=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Alexandre,
> >
> > On Wed, Sep 6, 2023 at 1:01=E2=80=AFPM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > Hi Alexandre,
> > > >
> > > > On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> > > > >
> > > > > This function used to simply flush the whole tlb of all harts, be=
 more
> > > > > subtile and try to only flush the range.
> > > > >
> > > > > The problem is that we can only use PAGE_SIZE as stride since we =
don't know
> > > > > the size of the underlying mapping and then this function will be=
 improved
> > > > > only if the size of the region to flush is < threshold * PAGE_SIZ=
E.
> > > > >
> > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> > > > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++--=
------
> > > > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > > > >
> > > > After applying this patch, I am seeing module load issues on RZ/Fiv=
e
> > > > (complete log [0]). I am testing defconfig + [1] (rz/five related
> > > > configs).
> > > >
> > > > Any pointers on what could be an issue here?
> > >
> > > Can you give me the exact version of the kernel you use? The trap
> > > addresses are vmalloc addresses, and a fix for those landed very late
> > > in the release cycle.
> > >
> > I am using next-20230906, Ive pushed a branch [1] for you to have a loo=
k.
> >
> > [0] https://github.com/prabhakarlad/linux/tree/rzfive-debug
>
> Great, thanks, I had to get rid of this possibility :)
>
> As-is, I have no idea, can you try to "bisect" the problem? I mean
> which patch in the series leads to those traps?
>
Oops sorry for not mentioning earlier, this is the offending patch
which leads to the issues seen on rz/five.

Cheers,
Prabhakar
