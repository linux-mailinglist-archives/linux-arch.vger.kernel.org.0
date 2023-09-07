Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1D797B3E
	for <lists+linux-arch@lfdr.de>; Thu,  7 Sep 2023 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjIGSKj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Sep 2023 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjIGSKi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Sep 2023 14:10:38 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361810F1;
        Thu,  7 Sep 2023 11:10:05 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-64c2e2572f7so7123506d6.1;
        Thu, 07 Sep 2023 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694110203; x=1694715003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brKbRdx1kpGoO2Y9NjS4SFjuuPU0IFk1738Z4hW7QPE=;
        b=rrd4PrDWVv2jjTdtd6O8xCq4EHwQOoFejM4fR38BvLRDotce54HnzQOhBRlumlmTuP
         n7vLi29D93/GGBcdbOJU/x6HrGn/bzAxY9voU+K4fpd3Zgk8XAya2AHATDw0YR4zPYUc
         3SkXsIWQJT6WqHlLL34Rm44pml0yAVJMqjj7T5gO/9GLAZVIO22u+ygTU+teFR86UR8U
         AGTAuUOIrV+0C7EFXEVJ2VE+FDiBe7VjOax6FEZcrv8HcFDr55yP2qPbJ0FbUrf+1mvq
         xboq46V8/txGqUym1lMqSodhg4pOtFaL7lcSnn+AUG8/bxgFxOVMkHXzRD3N/bS47M6F
         k8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110203; x=1694715003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brKbRdx1kpGoO2Y9NjS4SFjuuPU0IFk1738Z4hW7QPE=;
        b=pzDWyfssVPXQO+wTMLWBByj/y1zhxl+D1G1Lyo4Ng1qZfCyVAoWk/LC85XrNNfE5Up
         uyDLSWYRHjO2GmXDWL5bv3XPsvZG73T9JN9wfeoGvJgCIHzSNWS03vd0qdD0Pnyyzjgl
         KZ5ewjzdQDORvXWh6g73X8qZXawFAxBOn+uO3smo6XZresRBalkuZ9JPjOUV7uQlbxD6
         8sA8fJLS6PFy797dkz8Lc4pOvwMh+r4AmWeo12bSrC8bYXMZIg1tR2rK9VQ9Ap2Wsrc3
         fPgdUJJ/sdOwH7JxWoDVR/veVc4/IY9Sa4Z8fMw8YTlHRxIgfAX1Rs1EXLle/LX02h9Q
         dOpA==
X-Gm-Message-State: AOJu0YwTBDU3/MFGnztDAVE/vSjuXW3GLkBncxakSGWsdFW8wJrtuj99
        X7VY3bdU75R27Xo65gd9c+uDCPh/zM2VyV8pucDjiM4bkXE=
X-Google-Smtp-Source: AGHT+IEB2hO+TGGIAGO65G3+5LgFgJwUd0dqMX6Dw9arpoFxlY11pB1Z3e5xVZisoM3mAw7p9kKP6mypD/66ucf4p3s=
X-Received: by 2002:a6b:d315:0:b0:787:ff98:c38c with SMTP id
 s21-20020a6bd315000000b00787ff98c38cmr21570759iob.10.1694083805330; Thu, 07
 Sep 2023 03:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
 <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com>
 <CAHVXubhLB9Pw51C1ed1Youp9k0qTJKrokUAqf=Xnr+m3BoN5=g@mail.gmail.com>
 <CA+V-a8s0i=VMSbMa6WvOiZpqe_idAhq4cZ0inSdCNy39-rQeAg@mail.gmail.com>
 <CAHVXubjgjAwMOi0J5zZJkuX8RKwgfKp-_=tVTLDvKN=tBBdxNQ@mail.gmail.com>
 <CA+V-a8uxe=sT7oX4Dk4zppCbYzWdZgWt9Xh4m+pA2+3t8kfnjg@mail.gmail.com> <CAHVXubitpk9RxMPc9+ss0y=ZmpOrfv0ocP+UDQktR=TM+gy=KQ@mail.gmail.com>
In-Reply-To: <CAHVXubitpk9RxMPc9+ss0y=ZmpOrfv0ocP+UDQktR=TM+gy=KQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 Sep 2023 11:49:03 +0100
Message-ID: <CA+V-a8tGGR8q1Wv=dJJKLkbAsfmH8p8Fn9Ycns7+1LCSzxvpZA@mail.gmail.com>
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
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexandre,

On Thu, Sep 7, 2023 at 10:06=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Prabhakar,
>
> On Wed, Sep 6, 2023 at 3:55=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Alexandre,
> >
> > On Wed, Sep 6, 2023 at 1:43=E2=80=AFPM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > >
> > > On Wed, Sep 6, 2023 at 2:24=E2=80=AFPM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > Hi Alexandre,
> > > >
> > > > On Wed, Sep 6, 2023 at 1:18=E2=80=AFPM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> > > > >
> > > > > On Wed, Sep 6, 2023 at 2:09=E2=80=AFPM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > >
> > > > > > Hi Alexandre,
> > > > > >
> > > > > > On Wed, Sep 6, 2023 at 1:01=E2=80=AFPM Alexandre Ghiti <alexghi=
ti@rivosinc.com> wrote:
> > > > > > >
> > > > > > > Hi Prabhakar,
> > > > > > >
> > > > > > > On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
> > > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Alexandre,
> > > > > > > >
> > > > > > > > On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <ale=
xghiti@rivosinc.com> wrote:
> > > > > > > > >
> > > > > > > > > This function used to simply flush the whole tlb of all h=
arts, be more
> > > > > > > > > subtile and try to only flush the range.
> > > > > > > > >
> > > > > > > > > The problem is that we can only use PAGE_SIZE as stride s=
ince we don't know
> > > > > > > > > the size of the underlying mapping and then this function=
 will be improved
> > > > > > > > > only if the size of the region to flush is < threshold * =
PAGE_SIZE.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > > > > > ---
> > > > > > > > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> > > > > > > > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++=
++++++--------
> > > > > > > > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > > > > > > > >
> > > > > > > > After applying this patch, I am seeing module load issues o=
n RZ/Five
> > > > > > > > (complete log [0]). I am testing defconfig + [1] (rz/five r=
elated
> > > > > > > > configs).
> > > > > > > >
> > > > > > > > Any pointers on what could be an issue here?
> > > > > > >
> > > > > > > Can you give me the exact version of the kernel you use? The =
trap
> > > > > > > addresses are vmalloc addresses, and a fix for those landed v=
ery late
> > > > > > > in the release cycle.
> > > > > > >
> > > > > > I am using next-20230906, Ive pushed a branch [1] for you to ha=
ve a look.
> > > > > >
> > > > > > [0] https://github.com/prabhakarlad/linux/tree/rzfive-debug
> > > > >
> > > > > Great, thanks, I had to get rid of this possibility :)
> > > > >
> > > > > As-is, I have no idea, can you try to "bisect" the problem? I mea=
n
> > > > > which patch in the series leads to those traps?
> > > > >
> > > > Oops sorry for not mentioning earlier, this is the offending patch
> > > > which leads to the issues seen on rz/five.
> > >
> > > Ok, so at least I found the following problem, but I don't see how
> > > that could fix your issue: can you give a try anyway? I keep looking
> > > into this, thanks
> > >
> > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > > index df2a0838c3a1..b5692bc6c76a 100644
> > > --- a/arch/riscv/mm/tlbflush.c
> > > +++ b/arch/riscv/mm/tlbflush.c
> > > @@ -239,7 +239,7 @@ void flush_tlb_range(struct vm_area_struct *vma,
> > > unsigned long start,
> > >
> > >  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > >  {
> > > -       __flush_tlb_range(NULL, start, end, PAGE_SIZE);
> > > +       __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> > >  }
> > >
> > I am able to reproduce the issue with the above change too.
>
> I can't reproduce the problem on my Unmatched or Qemu, so it is not
> easy to debug. But I took another look at your traces and something is
> weird to me. In the following trace (and there is another one), the
> trap is taken at 0xffffffff015ca034, which is the beginning of
> rz_ssi_probe(): that's a page fault, so no translation was found (or
> an invalid one is cached).
>
> [   16.586527] Unable to handle kernel paging request at virtual
> address ffffffff015ca034
> [   16.594750] Oops [#3]
> ...
> [   16.622000] epc : rz_ssi_probe+0x0/0x52a [snd_soc_rz_ssi]
> ...
> [   16.708697] status: 0000000200000120 badaddr: ffffffff015ca034
> cause: 000000000000000c
> [   16.716580] [<ffffffff015ca034>] rz_ssi_probe+0x0/0x52a
> [snd_soc_rz_ssi]
> ...
>
> But then here we are able to read the code at this same address:
> [   16.821620] Code: 0109 6597 0000 8593 5f65 7097 7f34 80e7 7aa0 b7a9
> (7139) f822
>
> So that looks like a "transient" error. Do you know if you uarch
> caches invalid TLB entries? If you don't know, I have just written
> some piece of code to determine if it does, let me know.
>
No I dont, can you please share the details so that I can pass on the
information to you.

> Do those errors always happen?
>
Yes they do.

Cheers,
Prabhakar
