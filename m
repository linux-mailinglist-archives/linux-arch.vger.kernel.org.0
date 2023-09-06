Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18606793E20
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjIFNzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbjIFNzq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 09:55:46 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6679E6B;
        Wed,  6 Sep 2023 06:55:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-792726d3aeeso158769739f.0;
        Wed, 06 Sep 2023 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694008542; x=1694613342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbyDWxJfqMgWVcylxBXfX+Os4k5+YTlBDL7fHB3febM=;
        b=PludQ3GfBvzhzjiMFCLhiQxmEicR/8X9KmHbmSL92kPOyt0xvJDfwX2XuAPYc4s6iT
         lgL/1gkubzwi9HDWgPRMcOg5MCcpIjl4Huo6DsI0KptTFYqEryJDUUaGPsvwzRgT7fvm
         LZR34QghIUPmqmaMO5Qxj1kvZDW3Hp9PfUKzkevjCbycfGdtsAJtU+uBSGDA/b+uJwZS
         Ar9ezC/tDbom86mEGkwOo7Gy8HhTueQ+UQyHE4+3uAOaXduHk+Y+sKnsoLP3W2tHiAI3
         mHXEu8xKDnNqyioTTzf3ciknzVSzlzjetLDmHn/SjmyxNXNJwFwWv3LI/+hf940wnkZn
         Wwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694008542; x=1694613342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbyDWxJfqMgWVcylxBXfX+Os4k5+YTlBDL7fHB3febM=;
        b=SxoW/C7yIMnz8WRwtAsHgbAxEK+um6HkEZkpcdBaQofNsjUqeSTz+rJ9m0QKSNrv6p
         U1iClQ3gUI+5UfClbwM6BbNaoJdV1i2wJhBNU6icWoxOU4fZ/QwEvDnHedL0ycWxtaQj
         DM1wE5x8r6uQ94hbkwZpR5QdE8aqo2p86eX8Da5A7DioLK+G/HCcD4D3/eGNiPVg5ruj
         4nmZ9/1pwxm+nTIbkS9tDHFsKLio0G2O/VFmupoM6+B+Aog5GaX404PLYi4KrML9uvgl
         g/DkjLv6BkG4URP/EN+n9tz2iWYkfyOYjZ/IJBj/DlLs2yVWkPqTElP2WBXnpuZPC2dK
         Tb/g==
X-Gm-Message-State: AOJu0YwKVQtb+qmVmJXZVk7mD9lNaGY+Vv4DoZV2/Wf5/S0SHVlcp8iB
        vqpDosgYHFfZDW72ZudaJcz1iCP7arD4Bx+yH6Q=
X-Google-Smtp-Source: AGHT+IEZ0jkfj5Uf6FsapgkFNw1rXiq5p1/+3jIz1mfjeACGaSCI2qPmHp4YWLahdQbag1gsTEFoO5T7XElRYHgHrNc=
X-Received: by 2002:a6b:d607:0:b0:794:d833:4a8a with SMTP id
 w7-20020a6bd607000000b00794d8334a8amr17885350ioa.0.1694008542041; Wed, 06 Sep
 2023 06:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
 <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com>
 <CAHVXubhLB9Pw51C1ed1Youp9k0qTJKrokUAqf=Xnr+m3BoN5=g@mail.gmail.com>
 <CA+V-a8s0i=VMSbMa6WvOiZpqe_idAhq4cZ0inSdCNy39-rQeAg@mail.gmail.com> <CAHVXubjgjAwMOi0J5zZJkuX8RKwgfKp-_=tVTLDvKN=tBBdxNQ@mail.gmail.com>
In-Reply-To: <CAHVXubjgjAwMOi0J5zZJkuX8RKwgfKp-_=tVTLDvKN=tBBdxNQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 6 Sep 2023 14:54:41 +0100
Message-ID: <CA+V-a8uxe=sT7oX4Dk4zppCbYzWdZgWt9Xh4m+pA2+3t8kfnjg@mail.gmail.com>
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

On Wed, Sep 6, 2023 at 1:43=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> On Wed, Sep 6, 2023 at 2:24=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Alexandre,
> >
> > On Wed, Sep 6, 2023 at 1:18=E2=80=AFPM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > >
> > > On Wed, Sep 6, 2023 at 2:09=E2=80=AFPM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > Hi Alexandre,
> > > >
> > > > On Wed, Sep 6, 2023 at 1:01=E2=80=AFPM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> > > > >
> > > > > Hi Prabhakar,
> > > > >
> > > > > On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > >
> > > > > > Hi Alexandre,
> > > > > >
> > > > > > On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <alexghi=
ti@rivosinc.com> wrote:
> > > > > > >
> > > > > > > This function used to simply flush the whole tlb of all harts=
, be more
> > > > > > > subtile and try to only flush the range.
> > > > > > >
> > > > > > > The problem is that we can only use PAGE_SIZE as stride since=
 we don't know
> > > > > > > the size of the underlying mapping and then this function wil=
l be improved
> > > > > > > only if the size of the region to flush is < threshold * PAGE=
_SIZE.
> > > > > > >
> > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > > > ---
> > > > > > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> > > > > > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++=
++--------
> > > > > > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > > > > > >
> > > > > > After applying this patch, I am seeing module load issues on RZ=
/Five
> > > > > > (complete log [0]). I am testing defconfig + [1] (rz/five relat=
ed
> > > > > > configs).
> > > > > >
> > > > > > Any pointers on what could be an issue here?
> > > > >
> > > > > Can you give me the exact version of the kernel you use? The trap
> > > > > addresses are vmalloc addresses, and a fix for those landed very =
late
> > > > > in the release cycle.
> > > > >
> > > > I am using next-20230906, Ive pushed a branch [1] for you to have a=
 look.
> > > >
> > > > [0] https://github.com/prabhakarlad/linux/tree/rzfive-debug
> > >
> > > Great, thanks, I had to get rid of this possibility :)
> > >
> > > As-is, I have no idea, can you try to "bisect" the problem? I mean
> > > which patch in the series leads to those traps?
> > >
> > Oops sorry for not mentioning earlier, this is the offending patch
> > which leads to the issues seen on rz/five.
>
> Ok, so at least I found the following problem, but I don't see how
> that could fix your issue: can you give a try anyway? I keep looking
> into this, thanks
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index df2a0838c3a1..b5692bc6c76a 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -239,7 +239,7 @@ void flush_tlb_range(struct vm_area_struct *vma,
> unsigned long start,
>
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -       __flush_tlb_range(NULL, start, end, PAGE_SIZE);
> +       __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
>  }
>
I am able to reproduce the issue with the above change too.

Cheers,
Prabhakar
