Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09637793CE5
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjIFMoD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjIFMoC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 08:44:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E911713
        for <linux-arch@vger.kernel.org>; Wed,  6 Sep 2023 05:43:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso5969505e9.0
        for <linux-arch@vger.kernel.org>; Wed, 06 Sep 2023 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694004237; x=1694609037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97T82DaWND1ic3tMqCxU8VDEgFQSQlyfp7fMNRtDH0U=;
        b=ZA30sYVDmR8bpKIysuffD17UzICwGniTcl++Mp8ZDHNf935kJiD54AnGUayUJCqkAC
         qIPkPlrqfJmorMDVVp8zuXXzqfkeMIhBf2gJPAntXQu4otQR1xM8Zdn5FMOG+W1CoUIg
         VGe119ms0GbeFqBpgT1vgkjee+n6Qns67kjwFyylL9VMvWCwBD+YMQukPWKbu3zdvsKa
         r4OFzr844o/HESAJGrhqTRvlMClq6K31xN5V+g52efpSuTxjDJ6s6grZ6LzqlzCkU87w
         EVDH6S1LSy0mdmmSFUirsDCMBlv528ro3ApzweglH6QrTXyElfEZG5DA22GytEJ5BeOg
         ZoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694004237; x=1694609037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97T82DaWND1ic3tMqCxU8VDEgFQSQlyfp7fMNRtDH0U=;
        b=IWeaP/8MfUXtkbsj7N4eiVhCfcymGF07njQew3041Xd7RBfYQ/ZOGO0+AJW/LExiJL
         Q7ygdLoJbr5CljKZk19yxxvuwG3E5NTkRUXK7YqY3TlBZecUyrfOGgyxosUpQPkVKKNI
         DAwLBU0NPtydOW5kAiy2MUqVxqn1O9xRhlJjlQL82MP5RVPa6XQ8h/EPZvzkxbRWemKD
         365dzrMQ7tE7BAVkKNd5Nwf31JSZPlU98AVBiuFIw7HUFWCHeoq96e2GQWtYOd9w8Os9
         47NBkG/812ASiIBhW/7Vq9BnggKQG39XFWWTyKgEzRbcjPlwVj+rcSj3DODVQJtF7Mo8
         KYQQ==
X-Gm-Message-State: AOJu0Yw+FEQtNyQnUl3HoOH1JT5ITaRm18l6bWxApvkacDsk9Jsd9wWZ
        ahjHE1aH52QyfNLT/MVlcmStAHWvey6US9ZX7tx68D1QKqkM9a1xb+Y=
X-Google-Smtp-Source: AGHT+IE5EzPlYpM04M+Q/aJihvrqk89xvt00ppxx1QLaRQWeDL07/bJeynyeRYAenM4+M4c30V7uH8C5wCvl72MrsjQ=
X-Received: by 2002:a05:6000:5c9:b0:30f:c1fa:7901 with SMTP id
 bh9-20020a05600005c900b0030fc1fa7901mr2582820wrb.5.1694004237054; Wed, 06 Sep
 2023 05:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
 <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com>
 <CAHVXubhLB9Pw51C1ed1Youp9k0qTJKrokUAqf=Xnr+m3BoN5=g@mail.gmail.com> <CA+V-a8s0i=VMSbMa6WvOiZpqe_idAhq4cZ0inSdCNy39-rQeAg@mail.gmail.com>
In-Reply-To: <CA+V-a8s0i=VMSbMa6WvOiZpqe_idAhq4cZ0inSdCNy39-rQeAg@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 6 Sep 2023 14:43:46 +0200
Message-ID: <CAHVXubjgjAwMOi0J5zZJkuX8RKwgfKp-_=tVTLDvKN=tBBdxNQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 6, 2023 at 2:24=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Alexandre,
>
> On Wed, Sep 6, 2023 at 1:18=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> >
> > On Wed, Sep 6, 2023 at 2:09=E2=80=AFPM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Alexandre,
> > >
> > > On Wed, Sep 6, 2023 at 1:01=E2=80=AFPM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> > > >
> > > > Hi Prabhakar,
> > > >
> > > > On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > >
> > > > > Hi Alexandre,
> > > > >
> > > > > On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <alexghiti=
@rivosinc.com> wrote:
> > > > > >
> > > > > > This function used to simply flush the whole tlb of all harts, =
be more
> > > > > > subtile and try to only flush the range.
> > > > > >
> > > > > > The problem is that we can only use PAGE_SIZE as stride since w=
e don't know
> > > > > > the size of the underlying mapping and then this function will =
be improved
> > > > > > only if the size of the region to flush is < threshold * PAGE_S=
IZE.
> > > > > >
> > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> > > > > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++=
--------
> > > > > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > > > > >
> > > > > After applying this patch, I am seeing module load issues on RZ/F=
ive
> > > > > (complete log [0]). I am testing defconfig + [1] (rz/five related
> > > > > configs).
> > > > >
> > > > > Any pointers on what could be an issue here?
> > > >
> > > > Can you give me the exact version of the kernel you use? The trap
> > > > addresses are vmalloc addresses, and a fix for those landed very la=
te
> > > > in the release cycle.
> > > >
> > > I am using next-20230906, Ive pushed a branch [1] for you to have a l=
ook.
> > >
> > > [0] https://github.com/prabhakarlad/linux/tree/rzfive-debug
> >
> > Great, thanks, I had to get rid of this possibility :)
> >
> > As-is, I have no idea, can you try to "bisect" the problem? I mean
> > which patch in the series leads to those traps?
> >
> Oops sorry for not mentioning earlier, this is the offending patch
> which leads to the issues seen on rz/five.

Ok, so at least I found the following problem, but I don't see how
that could fix your issue: can you give a try anyway? I keep looking
into this, thanks

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index df2a0838c3a1..b5692bc6c76a 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -239,7 +239,7 @@ void flush_tlb_range(struct vm_area_struct *vma,
unsigned long start,

 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-       __flush_tlb_range(NULL, start, end, PAGE_SIZE);
+       __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
 }

 #ifdef CONFIG_TRANSPARENT_HUGEPAGE

>
> Cheers,
> Prabhakar
