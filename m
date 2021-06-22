Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7145E3AFA1B
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 02:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFVARX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 20:17:23 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:47499 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFVARW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 20:17:22 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15M0F5Pm034282
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 03:15:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1624320900; x=1626912900;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GN1BQE4IVzgLNDLmDfQi5g0v7raY1rltDK6TrpB/hoI=;
        b=T/ZTBp8WMcCd45upwLsTymuB+aLQ+c12zHFJBTI35VhEPx+IZF8cU592K5Q6lU4y
        JOEh36S04/Chc1i9W+rCJzgjW2dkmuohksu3wVfH0g7i+mtQ8e3gMwjR3GkNMKJ2
        Sr7XfzXapO8TZwkXXOjsIYW0Tds4NDG5ocRrSud864F3ELbgLQF/cmw1EmHPYOUx
        wY5tF8CuGXsh1c/TxCH9e7jMT2TPuRbAsyCsIqMc1OKuPU60ieyd4zrqplRjTuc2
        PhV/DsLutYjbogmLeTCzaupUPtqvQ+tef5ExK0zl/ZR9PiKHTwHoYJJYz+ub3ezh
        dZsUgSOjZ/1ELNBSGrYWsA==;
X-AuditID: 8b5b014d-962f1700000067b6-93-60d12b833daa
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 45.10.26550.38B21D06; Tue, 22 Jun 2021 03:14:59 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 22 Jun 2021 03:14:59 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
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
Organization: FORTH
In-Reply-To: <20210617152754.17960-2-mcroce@linux.microsoft.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-2-mcroce@linux.microsoft.com>
Message-ID: <87f2cf0e98c5c5560cfb591b4f4b29c8@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXSHT1dWbdZ+2KCwaXdNhbb3l1lsdj6exa7
        xaIV31kspvbEW+xYupnJ4t6KZewWL/Y2slg8WTOT0aJj11cWi8u75rBZbPvcwmZx8dd8RouX
        l3uYLdpm8TvwefTPnsLm8e73MkaPNy9fsngc7vjC7tHR94/FY+esu+wem1Z1snn82n6UyWPz
        knqPS83X2T0+b5LzaD/QzRTAE8Vlk5Kak1mWWqRvl8CVce/OR/aCC7IVG2beY25gPC7WxcjJ
        ISFgInHi8DXGLkYuDiGBo4wSze/2MEIkTCVm7+0Es3kFBCVOznzCAmIzC1hITL2ynxHClpdo
        3jqbGcRmEVCVODn1PVgNm4CmxPxLB8FsEQFdiYsfDrODLGAWmM4i8at3NxtIQljAWOL8pUaw
        QfwCwhKf7l5kBbE5BRwkNrRvYwexhQRKJS5+/soKcYSLxJLLr6GOU5H48PsBUA0HhyiQvXmu
        0gRGwVlITp2F5NRZSE5dwMi8ilEgscxYLzO5WC8tv6gkQy+9aBMjOPIYfXcw3t78Vu8QIxMH
        4yFGCQ5mJRHemykXEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz8upNiBcSSE8sSc1OTS1ILYLJ
        MnFwSjUwyb0KStn05UR79cQfi5kXWjprbTyxRzpm8vebs07Xn+SUVDF8XH3epObHf73YLWnT
        4jnNi49fubJ0Xg43/8xmba4TftdXbFDTWlu854PTTpaXm8QsJ1noy7NMVD41pT7VMCwpfU7e
        nceTXq6RyfrxOeroD5WzGeeCZz+a315Z9yLo0bEVnOeqtdntfu2rZ44pSfRJCf2x5cLK5rsH
        t0+fmxnl4K8dk5mk2jvH3PFJjquF/i1Of/1a3gVPzirfVzfQqJ1j4Wg49WL0rUtl/Ddkg/yk
        d7J5sxxfqFe+N3j9m4121r45PLJHH9kuvJjwVu/CG0POG0d/Kc5u3BqzXKLu7pO5Oybq3W76
        zshtkjmhQomlOCPRUIu5qDgRAN1SIgwrAwAA
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Matteo and thanks for the patch,

Στις 2021-06-17 18:27, Matteo Croce έγραψε:
> 
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * String functions optimized for hardware which doesn't
> + * handle unaligned memory accesses efficiently.
> + *
> + * Copyright (C) 2021 Matteo Croce
> + */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +
> +/* Minimum size for a word copy to be convenient */
> +#define MIN_THRESHOLD (BITS_PER_LONG / 8 * 2)
> +
> +/* convenience union to avoid cast between different pointer types */
> +union types {
> +	u8 *u8;

You are using a type as a name, I'd go with as_bytes/as_ulong/as_uptr 
which makes it easier for the reader to understand what you are trying 
to do.

> +	unsigned long *ulong;
> +	uintptr_t uptr;
> +};
> +
> +union const_types {
> +	const u8 *u8;
> +	unsigned long *ulong;
> +};
> +

I suggest you define those unions inside the function body, no one else 
is using them.

> +void *__memcpy(void *dest, const void *src, size_t count)
> +{
> +	const int bytes_long = BITS_PER_LONG / 8;
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	const int mask = bytes_long - 1;
> +	const int distance = (src - dest) & mask;

Why not unsigned ints ?

> +#endif
> +	union const_types s = { .u8 = src };
> +	union types d = { .u8 = dest };
> +
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

If you want to be compliant with memcpy you should check for overlapping 
regions here since "The memory areas must not overlap", and do nothing 
about it because according to POSIX this leads to undefined behavior. 
That's why recent libc implementations use memmove in any case (memcpy 
is an alias to memmove), which is the suggested approach.

> +	if (count < MIN_THRESHOLD)
> +		goto copy_remainder;
> +
> +	/* copy a byte at time until destination is aligned */
> +	for (; count && d.uptr & mask; count--)
> +		*d.u8++ = *s.u8++;
> +

You should check for !IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) here.

> +	if (distance) {
> +		unsigned long last, next;
> +
> +		/* move s backward to the previous alignment boundary */
> +		s.u8 -= distance;

It'd help here to explain that since s is distance bytes ahead relative 
to d, and d reached the alignment boundary above, s is now aligned but 
the data needs to be shifted to compensate for distance, in order to do 
word-by-word copy.

> +
> +		/* 32/64 bit wide copy from s to d.
> +		 * d is aligned now but s is not, so read s alignment wise,
> +		 * and do proper shift to get the right value.
> +		 * Works only on Little Endian machines.
> +		 */

This commend is misleading because s is aligned or else s.ulong[0]/[1] 
below would result an unaligned access.

> +		for (next = s.ulong[0]; count >= bytes_long + mask; count -= 
> bytes_long) {
> +			last = next;
> +			next = s.ulong[1];
> +
> +			d.ulong[0] = last >> (distance * 8) |
> +				     next << ((bytes_long - distance) * 8);
> +
> +			d.ulong++;
> +			s.ulong++;
> +		}
> +
> +		/* restore s with the original offset */
> +		s.u8 += distance;
> +	} else
> +#endif
> +	{
> +		/* if the source and dest lower bits are the same, do a simple
> +		 * 32/64 bit wide copy.
> +		 */

A while() loop would make more sense here.

> +		for (; count >= bytes_long; count -= bytes_long)
> +			*d.ulong++ = *s.ulong++;
> +	}
> +
> +	/* suppress warning when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y */
> +	goto copy_remainder;
> +
> +copy_remainder:
> +	while (count--)
> +		*d.u8++ = *s.u8++;
> +
> +	return dest;
> +}
> +EXPORT_SYMBOL(__memcpy);
> +
> +void *memcpy(void *dest, const void *src, size_t count) __weak
> __alias(__memcpy);
> +EXPORT_SYMBOL(memcpy);
