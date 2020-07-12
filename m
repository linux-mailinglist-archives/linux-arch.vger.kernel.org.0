Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC69C21C935
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jul 2020 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgGLMDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jul 2020 08:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgGLMDm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 12 Jul 2020 08:03:42 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 336B1206E2;
        Sun, 12 Jul 2020 12:03:39 +0000 (UTC)
Date:   Sun, 12 Jul 2020 13:03:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org,
        steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Message-ID: <20200712120335.GA30896@gaia>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
 <20200710183158.GE11839@gaia>
 <b34e3d42-faaa-73ba-9b54-8e4017514ee0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34e3d42-faaa-73ba-9b54-8e4017514ee0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 11, 2020 at 02:50:46PM +0800, Zhenyu Ye wrote:
> On 2020/7/11 2:31, Catalin Marinas wrote:
> > On Fri, Jul 10, 2020 at 05:44:20PM +0800, Zhenyu Ye wrote:
> >> -	if ((end - start) >= (MAX_TLBI_OPS * stride)) {
> >> +	if ((!cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
> >> +	    (end - start) >= (MAX_TLBI_OPS * stride)) ||
> >> +	    pages >= MAX_TLBI_RANGE_PAGES) {
> >>  		flush_tlb_mm(vma->vm_mm);
> >>  		return;
> >>  	}
> > 
> > I think we can use strictly greater here rather than greater or equal.
> > MAX_TLBI_RANGE_PAGES can be encoded as num 31, scale 3.
> 
> Sorry, we can't.
> For a boundary value (such as 2^6), we have two way to express it
> in TLBI RANGE operations:
> 1. scale = 0, num = 31.
> 2. scale = 1, num = 0.
> 
> I used the second way in following implementation.  However, for the
> MAX_TLBI_RANGE_PAGES, we can only use scale = 3, num = 31.
> So if use strictly greater here, ERROR will happen when range pages
> equal to MAX_TLBI_RANGE_PAGES.

You are right, I got confused by the __TLBI_RANGE_NUM() macro which
doesn't return the actual 'num' for the TLBI argument as it would go
from 0 to 31. After subtracting 1, num end sup from -1 to 30, so we
never get the maximum range. I think for scale 3 and num 31, this would
be 8GB with 4K pages, so the maximum we'd cover 8GB - 64K * 4K.

> There are two ways to avoid this bug:
> 1. Just keep 'greater or equal' here.  The ARM64 specification does
> not specify how we flush tlb entries in this case, flush_tlb_mm()
> is also a good choice for such a wide range of pages.

I'll go for this option, I don't think it would make much difference in
practice if we stop at 8GB - 256M range.

> 2. Add check in the loop, just like: (this may cause the codes a bit ugly)
> 
> 	num = __TLBI_RANGE_NUM(pages, scale) - 1;
> 
> 	/* scale = 4, num = 0 is equal to scale = 3, num = 31. */
> 	if (scale == 4 && num == 0) {
> 		scale = 3;
> 		num = 31;
> 	}
> 
> 	if (num >= 0) {
> 	...
> 
> Which one do you prefer and how do you want to fix this error? Just
> a fix patch again?

I'll fold the diff below and refresh the patch:

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 1eb0588718fb..0300e433ffe6 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -147,9 +147,13 @@ static inline unsigned long get_trans_granule(void)
 #define __TLBI_RANGE_PAGES(num, scale)	(((num) + 1) << (5 * (scale) + 1))
 #define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
 
+/*
+ * Generate 'num' values from -1 to 30 with -1 rejected by the
+ * __flush_tlb_range() loop below.
+ */
 #define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
 #define __TLBI_RANGE_NUM(range, scale)	\
-	(((range) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK)
+	((((range) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
 
 /*
  *	TLB Invalidation
@@ -285,8 +289,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	pages = (end - start) >> PAGE_SHIFT;
 
 	if ((!cpus_have_const_cap(ARM64_HAS_TLB_RANGE) &&
-	     (end - start) > (MAX_TLBI_OPS * stride)) ||
-	    pages > MAX_TLBI_RANGE_PAGES) {
+	     (end - start) >= (MAX_TLBI_OPS * stride)) ||
+	    pages >= MAX_TLBI_RANGE_PAGES) {
 		flush_tlb_mm(vma->vm_mm);
 		return;
 	}
@@ -306,6 +310,10 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	 *    Start from scale = 0, flush the corresponding number of pages
 	 *    ((num+1)*2^(5*scale+1) starting from 'addr'), then increase it
 	 *    until no pages left.
+	 *
+	 * Note that certain ranges can be represented by either num = 31 and
+	 * scale or num = 0 and scale + 1. The loop below favours the latter
+	 * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
 	 */
 	while (pages > 0) {
 		if (!cpus_have_const_cap(ARM64_HAS_TLB_RANGE) ||
@@ -323,7 +331,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 			continue;
 		}
 
-		num = __TLBI_RANGE_NUM(pages, scale) - 1;
+		num = __TLBI_RANGE_NUM(pages, scale);
 		if (num >= 0) {
 			addr = __TLBI_VADDR_RANGE(start, asid, scale,
 						  num, tlb_level);

> >> -	/* Convert the stride into units of 4k */
> >> -	stride >>= 12;
> >> +	dsb(ishst);
> >>  
> >> -	start = __TLBI_VADDR(start, asid);
> >> -	end = __TLBI_VADDR(end, asid);
> >> +	/*
> >> +	 * When cpu does not support TLBI RANGE feature, we flush the tlb
> >> +	 * entries one by one at the granularity of 'stride'.
> >> +	 * When cpu supports the TLBI RANGE feature, then:
> >> +	 * 1. If pages is odd, flush the first page through non-RANGE
> >> +	 *    instruction;
> >> +	 * 2. For remaining pages: The minimum range granularity is decided
> >> +	 *    by 'scale', so we can not flush all pages by one instruction
> >> +	 *    in some cases.
> >> +	 *    Here, we start from scale = 0, flush corresponding pages
> >> +	 *    (from 2^(5*scale + 1) to 2^(5*(scale + 1) + 1)), and increase
> >> +	 *    it until no pages left.
> >> +	 */
> >> +	while (pages > 0) {
> > 
> > I did some simple checks on ((end - start) % stride) and never
> > triggered. I had a slight worry that pages could become negative (and
> > we'd loop forever since it's unsigned long) for some mismatched stride
> > and flush size. It doesn't seem like.
> 
> The start and end are round_down/up in the function:
> 
> 	start = round_down(start, stride);
>  	end = round_up(end, stride);
> 
> So the flush size and stride will never mismatch.

Right.

To make sure we don't miss any corner cases, I'll try to through the
algorithm above at CBMC (model checker; hopefully next week if I find
some time).

-- 
Catalin
