Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F23AEB38
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 16:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFUO3Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhFUO3W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 10:29:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22462C061574;
        Mon, 21 Jun 2021 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MMc2KGdoutHfZtgfbYoRfjF4kYXtJrSnb/pfXowYFuM=; b=a7IMFKTTLtH6QzE9oeMOnqWREB
        k74qpt9XqgIAsd8S9v9Ne2UShz2hSFYEGNbPUZtSwlg+cIk8tvrsOyP3mi08RLF+ZMj62OG1F9+Pw
        gaZfMY5/ziFDUMvDSiNQbxCElDxzlJ2zoObDofYFLCNtlPs+d2JeEYWboNKhJBP0sw3nMOecTf5sN
        qBJ3hi+T4QI/DgkLXEzsg5FZspWeU9g1Vh6c3WyJCA0rin+yrt/aImCiv373zIVGxKTlNTLV2eS4w
        vF3yy0w1zUvMUi8wRFYqbH8xoYyX6W3wpoTGoKnu9clF8lCNq0Yo86bQOCpOhXV75gOxYMj2R5CT7
        3I3pdb6g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvKsh-00DB4u-Dk; Mon, 21 Jun 2021 14:26:38 +0000
Date:   Mon, 21 Jun 2021 15:26:31 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 1/3] riscv: optimized memcpy
Message-ID: <YNChl0tkofSGzvIX@infradead.org>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617152754.17960-2-mcroce@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 17, 2021 at 05:27:52PM +0200, Matteo Croce wrote:
> +extern void *memcpy(void *dest, const void *src, size_t count);
> +extern void *__memcpy(void *dest, const void *src, size_t count);

No need for externs.

> +++ b/arch/riscv/lib/string.c

Nothing in her looks RISC-V specific.  Why doesn't this go into lib/ so
that other architectures can use it as well.

> +#include <linux/module.h>

I think you only need export.h.

> +void *__memcpy(void *dest, const void *src, size_t count)
> +{
> +	const int bytes_long = BITS_PER_LONG / 8;
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	const int mask = bytes_long - 1;
> +	const int distance = (src - dest) & mask;
> +#endif
> +	union const_types s = { .u8 = src };
> +	union types d = { .u8 = dest };
> +
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	if (count < MIN_THRESHOLD)

Using IS_ENABLED we can avoid a lot of the mess in this
function.

	int distance = 0;

	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
		if (count < MIN_THRESHOLD)
			goto copy_remainder;

		/* copy a byte at time until destination is aligned */
		for (; count && d.uptr & mask; count--)
			*d.u8++ = *s.u8++;
		distance = (src - dest) & mask;
	}

	if (distance) {
		...

> +		/* 32/64 bit wide copy from s to d.
> +		 * d is aligned now but s is not, so read s alignment wise,
> +		 * and do proper shift to get the right value.
> +		 * Works only on Little Endian machines.
> +		 */

Normal kernel comment style always start with a:

		/*


> +		for (next = s.ulong[0]; count >= bytes_long + mask; count -= bytes_long) {

Please avoid the pointlessly overlong line.  And (just as a matter of
personal preference) I find for loop that don't actually use a single
iterator rather confusing.  Wjy not simply:

		next = s.ulong[0];
		while (count >= bytes_long + mask) {
			...
			count -= bytes_long;
		}
