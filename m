Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107EC793D81
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbjIFNQR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjIFNQQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 09:16:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A91CE9
        for <linux-arch@vger.kernel.org>; Wed,  6 Sep 2023 06:16:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0db66af1bso19936285ad.2
        for <linux-arch@vger.kernel.org>; Wed, 06 Sep 2023 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1694006172; x=1694610972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uld++PB00AvttIUabIU7xcqVSkPz344JqFl8ppv134=;
        b=VZcNZXWJ5o647XY3ZFBM8Dck33z/hii5Mpv4JnMEdcpQO2BXSko5L0DJwEOZ5hgW0/
         VcDCNxKWKO69DifeDrrZ+cTP6tvik68l7bKvfISnOudpShXwTbwTXEt42XqQLj7+uz9R
         Ibh7AFOIMp73qNxDFr7AWcOqCKGATb8geI/A9lhIGIxwAf+qG+rl+QtS/HNpeqjEEpcJ
         IqPYfId3cfPBQI/ZX9TPZE2+jZjVGS5WCd26oyM4StOCcyPGUWIwbN4h6QA2+ioyKvCL
         OrOqJ0EJZOgkffRKFZoZ+ZPv7omgF1iIJFTyGUxSQfMJDIKBN89DqjyVSCYgbYc6jL4D
         tMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694006172; x=1694610972;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uld++PB00AvttIUabIU7xcqVSkPz344JqFl8ppv134=;
        b=eJja6xddxF0hop7iVzIjKyr2TtDOuJkngecBmztKR1XrPspPPdjVpuu6t+iL/P8HYH
         xEL/RbpHqJJVt2HPgPQE6LdUCjvcd0dzgP35X2OQoInX5HEAZjQCWqDAv/J6PxbT/p0i
         oNVpo4AFw0GJssCy+sH3XuL6Ax2JwlT9QOmdnve9Hx172LcxcBJl9lk86GUu3diSBRIa
         osrk5MMprlu0ORCaI1M5I1ykFRypZb93/tysvcyYu7mduDpdIYisB7jcyUUuicODVlpn
         MjUC11BLCbfS4y4YcyTzeP702aX+1UkKCHUwzUF4DKSGTD49OBzi/En2SbD2BRD+Fha4
         yj6w==
X-Gm-Message-State: AOJu0Yxm4rbVBCmSyxBgakyBeNGVbw20Z90oY4b74utcCqHrW2JyJpaU
        6jl5FJAIrs6DQl8WVD0q4CH98Q==
X-Google-Smtp-Source: AGHT+IE490DJ0B8HsJUKc5YGg+iZZKcgEd0HmXU6tZkHPl3GceN2Bm3rAS+0TX+wSHA1qhJxq3bR3A==
X-Received: by 2002:a17:90b:4c50:b0:271:7a79:ecbb with SMTP id np16-20020a17090b4c5000b002717a79ecbbmr13634747pjb.28.1694006171898;
        Wed, 06 Sep 2023 06:16:11 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id gm15-20020a17090b100f00b002681bda127esm10986823pjb.35.2023.09.06.06.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:16:10 -0700 (PDT)
Date:   Wed, 06 Sep 2023 06:16:10 -0700 (PDT)
X-Google-Original-Date: Wed, 06 Sep 2023 06:16:08 PDT (-0700)
Subject:     Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
In-Reply-To: <CAHVXubjgjAwMOi0J5zZJkuX8RKwgfKp-_=tVTLDvKN=tBBdxNQ@mail.gmail.com>
CC:     prabhakar.csengg@gmail.com, geert+renesas@glider.be,
        Will Deacon <will@kernel.org>, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org,
        mchitale@ventanamicro.com, vincent.chen@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ajones@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-bed35427-44cd-4d85-9589-df2483346d32@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 06 Sep 2023 05:43:46 PDT (-0700), alexghiti@rivosinc.com wrote:
> On Wed, Sep 6, 2023 at 2:24 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
>>
>> Hi Alexandre,
>>
>> On Wed, Sep 6, 2023 at 1:18 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> >
>> > On Wed, Sep 6, 2023 at 2:09 PM Lad, Prabhakar
>> > <prabhakar.csengg@gmail.com> wrote:
>> > >
>> > > Hi Alexandre,
>> > >
>> > > On Wed, Sep 6, 2023 at 1:01 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> > > >
>> > > > Hi Prabhakar,
>> > > >
>> > > > On Wed, Sep 6, 2023 at 1:49 PM Lad, Prabhakar
>> > > > <prabhakar.csengg@gmail.com> wrote:
>> > > > >
>> > > > > Hi Alexandre,
>> > > > >
>> > > > > On Tue, Aug 1, 2023 at 9:58 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> > > > > >
>> > > > > > This function used to simply flush the whole tlb of all harts, be more
>> > > > > > subtile and try to only flush the range.
>> > > > > >
>> > > > > > The problem is that we can only use PAGE_SIZE as stride since we don't know
>> > > > > > the size of the underlying mapping and then this function will be improved
>> > > > > > only if the size of the region to flush is < threshold * PAGE_SIZE.
>> > > > > >
>> > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> > > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> > > > > > ---
>> > > > > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
>> > > > > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++--------
>> > > > > >  2 files changed, 31 insertions(+), 14 deletions(-)
>> > > > > >
>> > > > > After applying this patch, I am seeing module load issues on RZ/Five
>> > > > > (complete log [0]). I am testing defconfig + [1] (rz/five related
>> > > > > configs).
>> > > > >
>> > > > > Any pointers on what could be an issue here?
>> > > >
>> > > > Can you give me the exact version of the kernel you use? The trap
>> > > > addresses are vmalloc addresses, and a fix for those landed very late
>> > > > in the release cycle.
>> > > >
>> > > I am using next-20230906, Ive pushed a branch [1] for you to have a look.
>> > >
>> > > [0] https://github.com/prabhakarlad/linux/tree/rzfive-debug
>> >
>> > Great, thanks, I had to get rid of this possibility :)
>> >
>> > As-is, I have no idea, can you try to "bisect" the problem? I mean
>> > which patch in the series leads to those traps?
>> >
>> Oops sorry for not mentioning earlier, this is the offending patch
>> which leads to the issues seen on rz/five.
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
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE

Alex and I were talking a bit.  I'm OK just dropping the TLB flush 
series for this release, that way we can get to the bottom of what's 
wrong.

>
>>
>> Cheers,
>> Prabhakar
