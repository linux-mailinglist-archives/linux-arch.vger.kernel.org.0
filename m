Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB621EE15
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNKgg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 06:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgGNKgg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 06:36:36 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8C0222202;
        Tue, 14 Jul 2020 10:36:32 +0000 (UTC)
Date:   Tue, 14 Jul 2020 11:36:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org,
        steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Message-ID: <20200714103629.GA18793@gaia>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710094420.517-3-yezhenyu2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 05:44:20PM +0800, Zhenyu Ye wrote:
> +#define __TLBI_RANGE_PAGES(num, scale)	(((num) + 1) << (5 * (scale) + 1))
> +#define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
> +
> +#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
> +#define __TLBI_RANGE_NUM(range, scale)	\
> +	(((range) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK)
[...]
> +	int num = 0;
> +	int scale = 0;
[...]
> +			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
[...]

Since num is an int, __TLBI_RANGE_PAGES is still an int. Shifting it by
PAGE_SHIFT can overflow as the maximum would be 8GB for 4K pages (or
128GB for 64K pages). I think we probably get away with this because of
some implicit type conversion but I'd rather make __TLBI_RANGE_PAGES an
explicit unsigned long:

#define __TLBI_RANGE_PAGES(num, scale)	((unsigned long)((num) + 1) << (5 * (scale) + 1))

Without this change, the CBMC check fails (see below for the test). In
the kernel, we don't have this problem as we encode the address via
__TLBI_VADDR_RANGE and it doesn't overflow.

The good part is that CBMC reckons the algorithm is correct ;).

---------------8<------tlbinval.c---------------------------
// SPDX-License-Identifier: GPL-2.0-only
/*
 * Check with:
 *   cbmc --unwind 6 tlbinval.c
 */

#define PAGE_SHIFT	(12)
#define PAGE_SIZE	(1 << PAGE_SHIFT)
#define VA_RANGE	(1UL << 48)

#define __round_mask(x, y) ((__typeof__(x))((y)-1))
#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
#define round_down(x, y) ((x) & ~__round_mask(x, y))

#define __TLBI_RANGE_PAGES(num, scale)	((unsigned long)((num) + 1) << (5 * (scale) + 1))
#define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)

#define TLBI_RANGE_MASK			0x1fUL
#define __TLBI_RANGE_NUM(pages, scale)	\
	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)

static unsigned long inval_start;
static unsigned long inval_end;

static void tlbi(unsigned long start, unsigned long size)
{
	unsigned long end = start + size;

	if (inval_end == 0) {
		inval_start = start;
		inval_end = end;
		return;
	}

	/* contiguous ranges in ascending order only */
	__CPROVER_assert(start == inval_end, "Contiguous TLBI ranges");

	inval_end = end;
}

static void __flush_tlb_range(unsigned long start, unsigned long end,
			      unsigned long stride)
{
	int num = 0;
	int scale = 0;
	unsigned long pages;

	start = round_down(start, stride);
	end = round_up(end, stride);
	pages = (end - start) >> PAGE_SHIFT;

	if (pages >= MAX_TLBI_RANGE_PAGES) {
		tlbi(0, VA_RANGE);
		return;
	}

	while (pages > 0) {
		__CPROVER_assert(scale <= 3, "Scale in range");
		if (pages % 2 == 1) {
			tlbi(start, stride);
			start += stride;
			pages -= stride >> PAGE_SHIFT;
			continue;
		}

		num = __TLBI_RANGE_NUM(pages, scale);
		__CPROVER_assert(num <= 30, "Num in range");
		if (num >= 0) {
			tlbi(start, __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT);
			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
			pages -= __TLBI_RANGE_PAGES(num, scale);
		}
		scale++;
	}
}

static unsigned long nondet_ulong(void);

int main(void)
{
	unsigned long stride = nondet_ulong();
	unsigned long start = round_down(nondet_ulong(), stride);
	unsigned long end = round_up(nondet_ulong(), stride);

	__CPROVER_assume(stride == PAGE_SIZE ||
			 stride == PAGE_SIZE << (PAGE_SHIFT - 3) ||
			 stride == PAGE_SIZE << (2 * (PAGE_SHIFT - 3)));
	__CPROVER_assume(start < end);
	__CPROVER_assume(end <= VA_RANGE);

	__flush_tlb_range(start, end, stride);

	__CPROVER_assert((inval_start == 0 && inval_end == VA_RANGE) ||
			 (inval_start == start && inval_end == end),
			 "Correct invalidation");

	return 0;
}
