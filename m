Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF6797B09
	for <lists+linux-arch@lfdr.de>; Thu,  7 Sep 2023 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjIGSAd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Sep 2023 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245155AbjIGSAd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Sep 2023 14:00:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2EE43
        for <linux-arch@vger.kernel.org>; Thu,  7 Sep 2023 11:00:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401ec23be82so14205255e9.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Sep 2023 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694109601; x=1694714401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwR4d+5UoVgi3hAZhhlc3KZ970LG1A0zS/bDs+8zFKk=;
        b=sks+u4Qzh3dqg4i8Rw+Y7F608+7vubOXvDH8NEFQ32TciTjIpdtcPzxzVROEyrLJJW
         69pdGUBnhI7MJ6K1Zic08jSj/6n6wVeqA8IMH8RnRfavnOdnNGtLizxPkP41Ad1XHr4g
         3B+aRmrVWktS2sN6m3nstII5uju0u/hf9lAtWmb5YKTfnSxFwArHlWqSH9bdFkhF5pTa
         S7lffWKFobdN7IF3EkWZrlBfwiYrrvFLm/aCnLeyXLcVIfSOBuwtNVecsX2w0+SEXq0P
         Df6vjuh+FHAsHEVeQJTK3dMo9eWIEwHzgSNr0zBOGtgbdyPpSQMTw/dD35jFitHvK2U1
         aLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109601; x=1694714401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwR4d+5UoVgi3hAZhhlc3KZ970LG1A0zS/bDs+8zFKk=;
        b=lp7z436r23VW4Y7kvrPoBMJkOV15EPbGRy7Rofx6hm99ndu/WtAWXsgt5C9EWnwV04
         /dplX6zh55rnOWJWhkXP1ZMxUdqkaNB0Kv9vx3einYU49qCRKV3PE4cykH5FY8oFszv8
         JP168YUeZ5u7LuMYIiVz77nbkVsAcVbaaI+gIbmmLd/Lugv95Y1Wit4rsIgMgJ8etShP
         rjhrmptyuL4hIq6QQm2+zHQpDjeK1MdpjPUo7pYKvLByd21hUnJt+UeER0sh0bEjgqk8
         oRbGfOIwBhohqjw5z3niTnFMO5h3IfvIBwHYDS2f91Yr3wYeFZLvR13Ltvb5WUiEonYT
         dtVA==
X-Gm-Message-State: AOJu0YwlgX9iuiHZvjFuLoRNa/Gf3EDqXGoCLgwAQkzfvWFZfC57Cdz6
        fGtaYy2UA+KtB4nx0XuuHDh5KHRGBSUtHsSmG8/wzJi4N9N+SvOkVr0=
X-Google-Smtp-Source: AGHT+IFJTavyxjhxdaZZ701qmmj1qQoYaTn/kfRbKFSawpT28Zk2UYqvQGaxKIpZhSb6/hBu/iAUJVkTBPu3r6ZOQ5U=
X-Received: by 2002:a2e:b013:0:b0:2bc:b29e:8ff7 with SMTP id
 y19-20020a2eb013000000b002bcb29e8ff7mr4344328ljk.20.1694077571114; Thu, 07
 Sep 2023 02:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
 <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com>
 <CAHVXubhLB9Pw51C1ed1Youp9k0qTJKrokUAqf=Xnr+m3BoN5=g@mail.gmail.com>
 <CA+V-a8s0i=VMSbMa6WvOiZpqe_idAhq4cZ0inSdCNy39-rQeAg@mail.gmail.com>
 <CAHVXubjgjAwMOi0J5zZJkuX8RKwgfKp-_=tVTLDvKN=tBBdxNQ@mail.gmail.com> <CA+V-a8uxe=sT7oX4Dk4zppCbYzWdZgWt9Xh4m+pA2+3t8kfnjg@mail.gmail.com>
In-Reply-To: <CA+V-a8uxe=sT7oX4Dk4zppCbYzWdZgWt9Xh4m+pA2+3t8kfnjg@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 7 Sep 2023 11:05:59 +0200
Message-ID: <CAHVXubitpk9RxMPc9+ss0y=ZmpOrfv0ocP+UDQktR=TM+gy=KQ@mail.gmail.com>
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
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Prabhakar,

On Wed, Sep 6, 2023 at 3:55=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Alexandre,
>
> On Wed, Sep 6, 2023 at 1:43=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> >
> > On Wed, Sep 6, 2023 at 2:24=E2=80=AFPM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Alexandre,
> > >
> > > On Wed, Sep 6, 2023 at 1:18=E2=80=AFPM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> > > >
> > > > On Wed, Sep 6, 2023 at 2:09=E2=80=AFPM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > >
> > > > > Hi Alexandre,
> > > > >
> > > > > On Wed, Sep 6, 2023 at 1:01=E2=80=AFPM Alexandre Ghiti <alexghiti=
@rivosinc.com> wrote:
> > > > > >
> > > > > > Hi Prabhakar,
> > > > > >
> > > > > > On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
> > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Alexandre,
> > > > > > >
> > > > > > > On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <alexg=
hiti@rivosinc.com> wrote:
> > > > > > > >
> > > > > > > > This function used to simply flush the whole tlb of all har=
ts, be more
> > > > > > > > subtile and try to only flush the range.
> > > > > > > >
> > > > > > > > The problem is that we can only use PAGE_SIZE as stride sin=
ce we don't know
> > > > > > > > the size of the underlying mapping and then this function w=
ill be improved
> > > > > > > > only if the size of the region to flush is < threshold * PA=
GE_SIZE.
> > > > > > > >
> > > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > > > > ---
> > > > > > > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> > > > > > > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++=
++++--------
> > > > > > > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > > > > > > >
> > > > > > > After applying this patch, I am seeing module load issues on =
RZ/Five
> > > > > > > (complete log [0]). I am testing defconfig + [1] (rz/five rel=
ated
> > > > > > > configs).
> > > > > > >
> > > > > > > Any pointers on what could be an issue here?
> > > > > >
> > > > > > Can you give me the exact version of the kernel you use? The tr=
ap
> > > > > > addresses are vmalloc addresses, and a fix for those landed ver=
y late
> > > > > > in the release cycle.
> > > > > >
> > > > > I am using next-20230906, Ive pushed a branch [1] for you to have=
 a look.
> > > > >
> > > > > [0] https://github.com/prabhakarlad/linux/tree/rzfive-debug
> > > >
> > > > Great, thanks, I had to get rid of this possibility :)
> > > >
> > > > As-is, I have no idea, can you try to "bisect" the problem? I mean
> > > > which patch in the series leads to those traps?
> > > >
> > > Oops sorry for not mentioning earlier, this is the offending patch
> > > which leads to the issues seen on rz/five.
> >
> > Ok, so at least I found the following problem, but I don't see how
> > that could fix your issue: can you give a try anyway? I keep looking
> > into this, thanks
> >
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index df2a0838c3a1..b5692bc6c76a 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -239,7 +239,7 @@ void flush_tlb_range(struct vm_area_struct *vma,
> > unsigned long start,
> >
> >  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> >  {
> > -       __flush_tlb_range(NULL, start, end, PAGE_SIZE);
> > +       __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> >  }
> >
> I am able to reproduce the issue with the above change too.

I can't reproduce the problem on my Unmatched or Qemu, so it is not
easy to debug. But I took another look at your traces and something is
weird to me. In the following trace (and there is another one), the
trap is taken at 0xffffffff015ca034, which is the beginning of
rz_ssi_probe(): that's a page fault, so no translation was found (or
an invalid one is cached).

[   16.586527] Unable to handle kernel paging request at virtual
address ffffffff015ca034
[   16.594750] Oops [#3]
...
[   16.622000] epc : rz_ssi_probe+0x0/0x52a [snd_soc_rz_ssi]
...
[   16.708697] status: 0000000200000120 badaddr: ffffffff015ca034
cause: 000000000000000c
[   16.716580] [<ffffffff015ca034>] rz_ssi_probe+0x0/0x52a
[snd_soc_rz_ssi]
...

But then here we are able to read the code at this same address:
[   16.821620] Code: 0109 6597 0000 8593 5f65 7097 7f34 80e7 7aa0 b7a9
(7139) f822

So that looks like a "transient" error. Do you know if you uarch
caches invalid TLB entries? If you don't know, I have just written
some piece of code to determine if it does, let me know.

Do those errors always happen?

>
> Cheers,
> Prabhakar
