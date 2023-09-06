Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0ED793C75
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjIFMSw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 08:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjIFMSw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 08:18:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87795F9
        for <linux-arch@vger.kernel.org>; Wed,  6 Sep 2023 05:18:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so35213425e9.2
        for <linux-arch@vger.kernel.org>; Wed, 06 Sep 2023 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694002727; x=1694607527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCatPaNtALkNNK4KsoXQ8WAXqz9RrcLBBDmwLPI3Vw0=;
        b=PgznwoWAQRlakNaKTmQOWC2X0RWDWcUTRXyWxFGIahQ0uUs3rP/iBmYJAYc1CnRfqW
         iQNz0afCqr4ozxkonWvMkXErZtWEwNYw/NO+7NDmASLjGLv27Uuk4vvaj17gSEog5Myw
         6DzoP3mrGralIeqL1wKwYhWCzIColc72oUfzjGqKnabfOpxpvglYL0mIvHknH7KRtuYC
         QQ+ux87miZkc3kzzBjROIV7NPGLz4+qMhwQIY+zxhr1bdhUBBpNcvTad25GWuQ3SHMOQ
         3EChiKHrbBZlyH1y2Z/7t6RYKaOFy0VSikAZ1FE6DcGvc/AKfs71g2mzq7kWw2v5rjH7
         INpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694002727; x=1694607527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCatPaNtALkNNK4KsoXQ8WAXqz9RrcLBBDmwLPI3Vw0=;
        b=jNO1b7jHxKTgZhu8AroixCHB7XXxEF6TdyMlxWkPbIj1UbY+34D3q9a1/UVRxTDMGe
         dgVs1pMzwmaq0lFiwb1zmYTJyi8OQXnU842TUfCPcLGWL8CCXf/DfsYgUhMHxvexqeN/
         hm1H+AlRNluDyCTXBC2Q2o7y73+IJf4pAIzdy9AN+Gma4iPniddUUI/4cTM4+fAoTbcL
         j/b7aWQDRRvIwvyY3sTMSHMDlQCY2rwy/fFNeQ+8dwzJkmnILOjZvSJ2yN+ttJZzST8k
         BukMvQet97O0pvgwirbt/hiIiXSR5kUOCyAfoqSFXuOMlwq83Hofyb/lN/bo2XZ5b7Y1
         DRrQ==
X-Gm-Message-State: AOJu0YzuazbKcjWYMpYG6wFTLDARkv8/ja130s8rI+ZDo58pDdOpi/Fk
        AMoLmP6fd58NgT7oMk7NWDX57Isp31ryksaP8AJXyA==
X-Google-Smtp-Source: AGHT+IHr5EDmAZjNEiPKlcvR7awkoi1CNbTcJGcicRFsNZbpcWizj4wm9k/5LZIJTpywY2sKGNbDzYOdptyCzoRBUHk=
X-Received: by 2002:adf:f011:0:b0:31c:8257:2c78 with SMTP id
 j17-20020adff011000000b0031c82572c78mr2105408wro.52.1694002726940; Wed, 06
 Sep 2023 05:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com> <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com>
In-Reply-To: <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 6 Sep 2023 14:18:35 +0200
Message-ID: <CAHVXubhLB9Pw51C1ed1Youp9k0qTJKrokUAqf=Xnr+m3BoN5=g@mail.gmail.com>
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

On Wed, Sep 6, 2023 at 2:09=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Alexandre,
>
> On Wed, Sep 6, 2023 at 1:01=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Alexandre,
> > >
> > > On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> > > >
> > > > This function used to simply flush the whole tlb of all harts, be m=
ore
> > > > subtile and try to only flush the range.
> > > >
> > > > The problem is that we can only use PAGE_SIZE as stride since we do=
n't know
> > > > the size of the underlying mapping and then this function will be i=
mproved
> > > > only if the size of the region to flush is < threshold * PAGE_SIZE.
> > > >
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> > > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++----=
----
> > > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > > >
> > > After applying this patch, I am seeing module load issues on RZ/Five
> > > (complete log [0]). I am testing defconfig + [1] (rz/five related
> > > configs).
> > >
> > > Any pointers on what could be an issue here?
> >
> > Can you give me the exact version of the kernel you use? The trap
> > addresses are vmalloc addresses, and a fix for those landed very late
> > in the release cycle.
> >
> I am using next-20230906, Ive pushed a branch [1] for you to have a look.
>
> [0] https://github.com/prabhakarlad/linux/tree/rzfive-debug

Great, thanks, I had to get rid of this possibility :)

As-is, I have no idea, can you try to "bisect" the problem? I mean
which patch in the series leads to those traps?

Thanks!

Alex

>
> Cheers,
> Prabhakar
