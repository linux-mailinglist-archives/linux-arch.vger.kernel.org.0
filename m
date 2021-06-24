Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECD3B2A5B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jun 2021 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhFXIb4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 04:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231826AbhFXIb4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Jun 2021 04:31:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCBD9613FE;
        Thu, 24 Jun 2021 08:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624523361;
        bh=n3+DR4PNcPYqodN80wD10aoRGrdopEbb0CZAydTJS6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GhCuIF8SdQXKtGcQFyVKTQQvSkJyQi9K1zNRkqZIHg4UwcQZtgUAAh+edYMVuULI6
         bxQ3Sodekl6HeI89qyqMxH9NFYfVnqq2JlDk+iuGJNvL59/zOPP9GWpAlU7PBWbqXm
         1bTznd7jv6/ldLkNpoOK5ZPxRkZsc/3nDk6Rm3IfBlk5rXsnBEPgnxxO3okcWVaI+J
         jPD3vnQp5tqchLbeg+qv/Lx8YPIaamn2OdsuKU4ur/5wrjXf+obTpttl8+bpmTGXrh
         LBe7erXtMqDhmlmtp1Y0ojqc/jKIN/YTUomM2h6Cq6hwK0bpYQEP6oQuYrh0ctzE5M
         B2JD/TYmRG1fw==
Date:   Thu, 24 Jun 2021 09:29:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        aneesh.kumar@linux.ibm.com, Marc Zyngier <maz@kernel.org>,
        steven.price@arm.com, Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Xiexiangyou <xiexiangyou@huawei.com>, liushixin2@huawei.com,
        huyaqin <huyaqin1@huawei.com>, zhurui3@huawei.com
Subject: Re: [PATCH v1] arm64: tlb: fix the TTL value of tlb_get_level
Message-ID: <20210624082914.GA1194@willie-the-truck>
References: <b80ead47-1f88-3a00-18e1-cacc22f54cc4@huawei.com>
 <20210623110412.GA32177@willie-the-truck>
 <800c06ad-1491-c5ba-c650-c78384bf50c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800c06ad-1491-c5ba-c650-c78384bf50c9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 24, 2021 at 09:55:53AM +0800, Zhenyu Ye wrote:
> On 2021/6/23 19:04, Will Deacon wrote:
> > On Wed, Jun 23, 2021 at 03:05:22PM +0800, Zhenyu Ye wrote:
> >> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> >> index 61c97d3b58c7..c995d1f4594f 100644
> >> --- a/arch/arm64/include/asm/tlb.h
> >> +++ b/arch/arm64/include/asm/tlb.h
> >> @@ -28,6 +28,10 @@ static void tlb_flush(struct mmu_gather *tlb);
> >>   */
> >>  static inline int tlb_get_level(struct mmu_gather *tlb)
> >>  {
> >> +	/* The TTL field is only valid for the leaf entry. */
> >> +	if (tlb->freed_tables)
> >> +		return 0;
> >> +
> >>  	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
> >>  				   tlb->cleared_puds ||
> >>  				   tlb->cleared_p4ds))
> > 
> > Thanks. I can't see a better way around this, so I'll queue the patch.
> > The stage-2 page-table code looks ok afaict, but please can you check it
> > too?
> 
> The stage-2 page-table codes seem to be correct to me.

Thanks for having a look.

Will
