Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12A71DEC66
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgEVPti (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 11:49:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbgEVPth (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 11:49:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5181C55D;
        Fri, 22 May 2020 08:49:37 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F41F3F305;
        Fri, 22 May 2020 08:49:32 -0700 (PDT)
Date:   Fri, 22 May 2020 16:49:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     peterz@infradead.org, mark.rutland@arm.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 3/6] arm64: Add tlbi_user_level TLB invalidation helper
Message-ID: <20200522154925.GE26492@gaia>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-4-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423135656.2712-4-yezhenyu2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 23, 2020 at 09:56:53PM +0800, Zhenyu Ye wrote:
> @@ -190,8 +196,8 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>  
>  	dsb(ishst);
> -	__tlbi(vale1is, addr);
> -	__tlbi_user(vale1is, addr);
> +	__tlbi_level(vale1is, addr, 0);
> +	__tlbi_user_level(vale1is, addr, 0);
>  }

This one remains with a level 0 throughout the series. Is this
intentional? If we can't guarantee the level here, better to use the
non-level __tlbi().

-- 
Catalin
