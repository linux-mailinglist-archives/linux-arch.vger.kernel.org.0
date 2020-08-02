Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7D23599D
	for <lists+linux-arch@lfdr.de>; Sun,  2 Aug 2020 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgHBSC2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Aug 2020 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBSC2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Aug 2020 14:02:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C94C06174A;
        Sun,  2 Aug 2020 11:02:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c15so16010048edj.3;
        Sun, 02 Aug 2020 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hIidJgHuEfm+QUxSjJcyWhB4lu2Xjl7LW3yKbJJeIh0=;
        b=uIs7/vU9Kx/pklkEtgD7hBiuHs6a0R+dGlNTjUGRPw721sRkbKusjxGi7PfHcXOJ+P
         EjAE8Vd54opYw74GdBkeR4XNF5IP2MPUk9fmgk6V6Ahfe99oRVQ2eTOjx4V/HNnjxo1p
         8JTL4om9ZC3cnlFf7IvLus1+6HB/iVpPvgkNBuxCV3vkFTVqsYvmHOwMCmyNnjJul9R4
         NyUbZELRb/+vAfU647duOFbumJn5NHcHvq2jBsmvofhPXlaOdyNnECGIYrfm3l1GH6Kt
         lYQels7sHnZLCY218xDI/G+/wAKH/pz8dPVH6DrvKapbnVTrwoCPcuTqLRUxp8GcwS18
         4m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hIidJgHuEfm+QUxSjJcyWhB4lu2Xjl7LW3yKbJJeIh0=;
        b=JP5m+gLpa0w+fNX6l3aEOLFr8Ii/uIV3PUZ4/5bKR3YeO7pwsyfBmeViSDCok/+kG1
         xm97vjhdI+V0/negVVfjxZuYq1c8879Xb2VeBpR+hrCCTvNeH6O9782XtDfeGiUAIPIK
         0v7cukw3uu3SgstdDD+mWwglE455DQYF0VtjoaK07wSvp6V+AVl0SVYMwPx5uS9WweUi
         cn5fA1u4pmuC4rlnttzEZlceYNHPKimkLXeVm3JYg/EkZGighzhVpej+mBSQbUFdY6ph
         hZG9hfk4d9mUwB/VrOdVpCBPjqAUMl6J40phkoUKwXkAwCbOTh4brJZFBinYrgcnR1qz
         SXZQ==
X-Gm-Message-State: AOAM532fVmUo+auDPMb5/10Y7gnxzH/iAxO7yYRvAMRNgSwUvDnyMlp5
        8LITHijlxIkRW0ozROc+yVw=
X-Google-Smtp-Source: ABdhPJxqUvJyL87Stg26v1+JoHbkpad0yhpL8P6CjttoB9bwnL2tuiWl2R60zFRBWtP21v7K7J2UFg==
X-Received: by 2002:aa7:cb15:: with SMTP id s21mr12929126edt.175.1596391346876;
        Sun, 02 Aug 2020 11:02:26 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id j21sm14090092edq.20.2020.08.02.11.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 11:02:26 -0700 (PDT)
Date:   Sun, 2 Aug 2020 20:02:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: Re: [PATCH v2 14/17] x86/setup: simplify reserve_crashkernel()
Message-ID: <20200802180223.GB86614@gmail.com>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-15-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-15-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> * Replace magic numbers with defines
> * Replace memblock_find_in_range() + memblock_reserve() with
>   memblock_phys_alloc_range()
> * Stop checking for low memory size in reserve_crashkernel_low(). The
>   allocation from limited range will anyway fail if there is no enough
>   memory, so there is no need for extra traversal of memblock.memory
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Assuming that this got or will get tested with a crash kernel:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
