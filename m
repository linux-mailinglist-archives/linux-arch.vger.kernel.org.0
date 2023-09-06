Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC09793C56
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjIFMJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjIFMJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 08:09:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF23E6A;
        Wed,  6 Sep 2023 05:09:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7927f241772so147963239f.1;
        Wed, 06 Sep 2023 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694002187; x=1694606987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Va2nW+Usqp8ZrfnRefu/KyBtk1DZM9iZcObEbx3C5o=;
        b=hsR0IY6+JLGpTya8fvR/yj8S5gYLahTbUQxzKvaEnnzJcjhcXu6jDQZccd2EKGTngq
         K/gT1rbB2MunvnLNHqFvBk9K3stfAa7dThWML5aMizu3E+7x3591WbmkKW4nRrFWSNM7
         X1+TFHEhcCYPXBpyxH7vWUav9DLXXp/R7cuqmBpi9qd6xDsYv2NQWhrZNT8zxMkMbdTU
         ixO0YJW5ZubmrfCzG3N3se3Jj4vuDlPOM2PhYSGfoBRuqJ3qXS/sb3b3E5uLZ/5HrMfJ
         +y4FelU7HeSykhZyF/ebRbVD5eu8rWOJ5BrUrjQRuOgP17YAQP1waW7o7hk6GTwfkSOT
         ZtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694002187; x=1694606987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Va2nW+Usqp8ZrfnRefu/KyBtk1DZM9iZcObEbx3C5o=;
        b=AG//PSM9T1ftq2ia/1m5X/qj3Wzdrqa4TWVhbDBa9ECawaoCBS2TKX5yTzAwrIYGsx
         ZWHMiYpIsYXHdPP55PAtrAroCO7jn9XdsD6Zez/ykms0Rye1JFAuypfWRsO+m0+mJLKl
         xj15EHcD0Gsq55K+TfSONQNtW/ef85LpLl9Dgd4r6wG6UBKehX7yHruckfMMGPa99/nV
         fw7UApD+KU6duWUImxnjj4WbjWr8GFSxIbb0PtQkxxuiGXzT2ujqsqv9j10p0/75KCv9
         5TZWx8FYMEUeaMDt38Df5aaGJ4ImAHK99tfgGf2og9qbHJS1JHiFwAUiN1wn8cHpMTXn
         +OaQ==
X-Gm-Message-State: AOJu0Yzp52kawxgTHs8AnXSbHy7GZ0yLMeB5WpJIL4YHkjT08Nq2xHPE
        0BDLbhStUupAKC5mpvMKfGy+c59E13riP3Rq2gM=
X-Google-Smtp-Source: AGHT+IGWtERQu1uvVBVvppCTlAc4PSePNP4mqkpS/y84Zw6WXafaYObIR3DZxO29+98HddvyRnwByAxFYYmURZplQcI=
X-Received: by 2002:a5e:9e41:0:b0:792:9ace:f7ba with SMTP id
 j1-20020a5e9e41000000b007929acef7bamr14897870ioq.11.1694002186899; Wed, 06
 Sep 2023 05:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
In-Reply-To: <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 6 Sep 2023 13:08:46 +0100
Message-ID: <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexandre,

On Wed, Sep 6, 2023 at 1:01=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Hi Prabhakar,
>
> On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Alexandre,
> >
> > On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > >
> > > This function used to simply flush the whole tlb of all harts, be mor=
e
> > > subtile and try to only flush the range.
> > >
> > > The problem is that we can only use PAGE_SIZE as stride since we don'=
t know
> > > the size of the underlying mapping and then this function will be imp=
roved
> > > only if the size of the region to flush is < threshold * PAGE_SIZE.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++------=
--
> > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > >
> > After applying this patch, I am seeing module load issues on RZ/Five
> > (complete log [0]). I am testing defconfig + [1] (rz/five related
> > configs).
> >
> > Any pointers on what could be an issue here?
>
> Can you give me the exact version of the kernel you use? The trap
> addresses are vmalloc addresses, and a fix for those landed very late
> in the release cycle.
>
I am using next-20230906, Ive pushed a branch [1] for you to have a look.

[0] https://github.com/prabhakarlad/linux/tree/rzfive-debug

Cheers,
Prabhakar
