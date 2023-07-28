Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC4766E7E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjG1Nfr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 09:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjG1Nfp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 09:35:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1D4227
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2023 06:35:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bccc9ec02so308472366b.2
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2023 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690551313; x=1691156113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjWxYuMkYyCYydGZYyJb4wLVfHb9S4Js5IwnnFB0XSM=;
        b=mrIibh3Dlr65plPmb3Z5x+BK8DLfVVHVgMxww4xnQSb3VTUTBAhXWOncfguFuNeGNX
         MGsDK3J+A8xpOpSJrr/dv0TihJRHPUB9q9atC/ZgxkMr2lAponsucCOMIlt9Sd1oyHI0
         pNBr5+KNFgBYRwp/e1r5nwpJaAtvBmzFYiAetPlrGdBs0m+Gp9YL81CyIkqTZuu1PmDM
         T2cXP6wX/WgEj32CGATYB59Tz8DEYlqb7yCYpb0rxCi6wiXXxTMA/eFZGlgkmeEXKEqt
         aN3bg3giPBpxEgAdV+QB9qygbyiPBv7i5ufllQpPlE/w4NmqPtSt1iX//pWE8MIo+cUn
         NfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690551313; x=1691156113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjWxYuMkYyCYydGZYyJb4wLVfHb9S4Js5IwnnFB0XSM=;
        b=amZPj3xkeieouvUHVLlNkGaqpNHVBv8UplQYIq9rdkoZyZ2V1sQTKAs7/S10hiLu/r
         VJLZbfAl8yTMUj3aJA5Qpejs85dk918hyfRkC8mo6CSezr0Lt9UubkXxloDqKa7VVk1N
         ugaRp4XK9Yza4ozxw31w5hJcOdHxUA48uv/pj4fj+6f0xuydq2WYi+Gyw1kXJBzMRpim
         ii8TYvFivaQcsFLCvtUiDnmmh8ZSFTYJpm5F5iTSu8Wwevz1xx3vUASZOVLzGNjo/bmb
         8VKakcn1vvh03vLqSq/McDqOnotYCogQmCdd328b5LRX1/AE7sNNMFlwYu0Vu7mr/9GA
         ObjA==
X-Gm-Message-State: ABy/qLayN88JxXOVJshvC8WEzfWuMyyZ4o3WeLbfq8to0Fjy6X9Cv9GA
        mIcTMxqFA9TFESgaNF+W+2Lw8A==
X-Google-Smtp-Source: APBJJlHKH1RVaeJ+IQWiZC6RQ/5l8Tw7cw+9QG6eDnuSTly70i49Mrj/0IX7qZ9HnNDqHSo9f1w0pQ==
X-Received: by 2002:a17:906:2202:b0:99b:d1ef:520b with SMTP id s2-20020a170906220200b0099bd1ef520bmr2223467ejs.31.1690551312875;
        Fri, 28 Jul 2023 06:35:12 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090607ca00b009931a3adf64sm2111178ejc.17.2023.07.28.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:35:12 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:35:11 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Will Deacon <will@kernel.org>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] riscv: Improve flush_tlb()
Message-ID: <20230728-d89388540f7ad14318ad768e@orel>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
 <20230727185553.980262-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727185553.980262-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 08:55:50PM +0200, Alexandre Ghiti wrote:
> For now, flush_tlb() simply calls flush_tlb_mm() which results in a
> flush of the whole TLB. So let's use mmu_gather fields to provide a more
> fine-grained flush of the TLB.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/tlb.h      | 8 +++++++-
>  arch/riscv/include/asm/tlbflush.h | 3 +++
>  arch/riscv/mm/tlbflush.c          | 7 +++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
