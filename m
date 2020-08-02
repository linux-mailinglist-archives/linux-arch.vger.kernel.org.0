Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B522359B2
	for <lists+linux-arch@lfdr.de>; Sun,  2 Aug 2020 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHBSDL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Aug 2020 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBSDK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Aug 2020 14:03:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D827FC06174A;
        Sun,  2 Aug 2020 11:03:09 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so9776333ejb.0;
        Sun, 02 Aug 2020 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fQZKbY0rONiHjM83HibQy63AEJaxpKeGQhQtY04gDSU=;
        b=NClt20d7Ft+K6FkgUCUu4JaE3tIZQCut3LntjJUJhXUsmJc9/hAN8f1uhRfdf1xDS4
         v+mVxDX9o4kozVR+Ah8Xum0mBupoLJJ8sGRFuq+zGUPap92vHCw3QWRVbrRdpExOLg1f
         PfYSYoa+08lkV+ejUHsbzm11vb6ZXDx9wG5OH/PIC6kGD+/IwmcMBK0f+S9Q47Ilfp0r
         CnDK0w5UJZcBtyEbi0uelKFQBUpbqi9svF4nCggxxWbCeGrL/RSClOw7dY42O+RKurT4
         SeQmDc1qACQRwd/qkF4Bl6+EBF1g484NpzCeNGAZebTMM88+MrzhcW/7+ogo+dclYvqf
         xJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fQZKbY0rONiHjM83HibQy63AEJaxpKeGQhQtY04gDSU=;
        b=J9bfHA8A/41k+4z40K5dbRSczRTSYHZP8ZoibcIi2PXvAxiaaeAmJp6DZE/v8M0BOe
         +QYeM8sVKSd0L60ZkDl/QPn8RuUfORZWZeVbXco++sid8s3oCHuNO/rzDH9/vZf9WRpU
         pA3rfwxFjT1bkLIOmsfckW6sE7x/c1yX0vFqSjxtrHQ2S9fOxBSTn26MUdEqZYntKtLR
         rUrndwmo0gDqQT/e8/7ua3It6PWAzCKsewbzvpQ0sWlkfUQIjtnjTCmACoGAxE9YU6+c
         LyWgHOLDlmBe6/plUiXUyUsPzoBfXbCe8EW7ShjPkd63cyNJqlAYogmzOAq2OPWunHI7
         Ejng==
X-Gm-Message-State: AOAM533GptcbZRwGUbnFs+LWlYZQkw7CO/XrElRuad6u7ky210BMVb5o
        G2J19gMCX4Dj5/wG4dcaJ/iJ2Cl1
X-Google-Smtp-Source: ABdhPJwRVVa9oTHFz53Gep6kufj7aL7kFTxC9FLC9t+X6tOc6fXoy+b82cv+AC/Z1BhRkxvbjIG1Og==
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr12944760ejc.351.1596391388538;
        Sun, 02 Aug 2020 11:03:08 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x1sm13599477ejc.119.2020.08.02.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 11:03:07 -0700 (PDT)
Date:   Sun, 2 Aug 2020 20:03:04 +0200
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
Subject: Re: [PATCH v2 17/17] memblock: use separate iterators for memory and
 reserved regions
Message-ID: <20200802180304.GC86614@gmail.com>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-18-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-18-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> for_each_memblock() is used to iterate over memblock.memory in
> a few places that use data from memblock_region rather than the memory
> ranges.
> 
> Introduce separate for_each_mem_region() and for_each_reserved_mem_region()
> to improve encapsulation of memblock internals from its users.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .clang-format                  |  3 ++-
>  arch/arm64/kernel/setup.c      |  2 +-
>  arch/arm64/mm/numa.c           |  2 +-
>  arch/mips/netlogic/xlp/setup.c |  2 +-
>  arch/x86/mm/numa.c             |  2 +-
>  include/linux/memblock.h       | 19 ++++++++++++++++---
>  mm/memblock.c                  |  4 ++--
>  mm/page_alloc.c                |  8 ++++----
>  8 files changed, 28 insertions(+), 14 deletions(-)

The x86 part:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
