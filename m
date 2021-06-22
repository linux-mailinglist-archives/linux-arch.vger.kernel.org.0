Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45D3AFA71
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 03:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFVBKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 21:10:10 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:19559 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhFVBKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 21:10:10 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15M17rOU036029
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 04:07:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1624324068; x=1626916068;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q+eQRJ20he4Y2U54oc/fPHuAWqGk0e4b8CGa0ma1wzs=;
        b=XSqG8GUt1WyotyIfHlNwbGteMjQzpf8PXDQ2RFocwrKD3CtIlhCrWm8GANr33+sZ
        yjVxt3o7QDYNwx+qwfophoWurLsqJRgHzSmZpR1XfBicwqE2fIkxkATp5znfnF7K
        Oo/l9JLUr5wS2L7TaUEJglcSYQlidlZh/BMLJQ01r6hYT8RgHbqVbmsHin1oGRvF
        rrSkd/KKqEUyM0tZhVz+3xeOQBw4l8Q4kZJHutBv3FIUbHJrmLTR++S1iQhk58mj
        2QT+5dd5IqXSn1d5R9Kp7JbS6VrKisJscyKq6LZRtoAVMc6+BYw5H0RqpYaZyA7r
        JSayz6ILynmyQ1ykwEDO1A==;
X-AuditID: 8b5b014d-96ef2700000067b6-6d-60d137e4120b
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 0E.60.26550.4E731D06; Tue, 22 Jun 2021 04:07:48 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 22 Jun 2021 04:07:47 +0300
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
Subject: Re: [PATCH v3 3/3] riscv: optimized memset
Organization: FORTH
In-Reply-To: <20210617152754.17960-4-mcroce@linux.microsoft.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-4-mcroce@linux.microsoft.com>
Message-ID: <17cd289430f08f2b75b7f04242c646f6@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXSHT1dWfeJ+cUEg1+bFC22vbvKYrH19yx2
        i0UrvrNYTO2Jt9ixdDOTxb0Vy9gtXuxtZLF4smYmo0XHrq8sFpd3zWGz2Pa5hc3i4q/5jBYv
        L/cwW7TN4nfg8+ifPYXN493vZYweb16+ZPE43PGF3aOj7x+Lx85Zd9k9Nq3qZPP4tf0ok8fm
        JfUel5qvs3t83iTn0X6gmymAJ4rLJiU1J7MstUjfLoErY8P7xewFn3gqWo+lNTC+4exi5OSQ
        EDCReLd8N3sXIxeHkMBRRom/vy4wQiRMJWbv7QSzeQUEJU7OfMICYjMLWEhMvbKfEcKWl2je
        OpsZxGYRUJXY8fUIO4jNJqApMf/SQbB6EQFdiYsfDoMtYBaYziLxq3c3G0hCWMBYYsHylUwg
        Nr+AsMSnuxdZQWxOAQeJo8fXgdlCAqUSq08cYYU4wkXizIqpzBDHqUh8+P0AaCgHhyiQvXmu
        0gRGwVlITp2F5NRZSE5dwMi8ilEgscxYLzO5WC8tv6gkQy+9aBMjOO4YfXcw3t78Vu8QIxMH
        4yFGCQ5mJRHemykXEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz8upNiBcSSE8sSc1OTS1ILYLJ
        MnFwSjUwNTmumb1hzpHkX257uzV+znTdMInr1NPYsL2aOUzVVcL9XQqySf3u5mW+Ciu/Vm8t
        uHhZvmBN906xfnfXqj8yN4Tib97tW/mN857FcZblbCKWc+wY/vr8nmQixiUss+gL1/X5Se93
        uHYd+ydy8u/Bo1qmb11CQiZPfVGc38+0vPQzj4TU1zi7V0rnapdZer85l7an3zbMb4Xbh+Ml
        Og1ic9bJ3Ei+tP6t68cKjmfONhvcjX6t6ftvsf2r7sErS5UNvBJO69lvNa+ZPX1Rq6/MR6da
        rt+TODsWTgwN6rhoM+n//5UBxTd/pJetttjlVilyIs1kxYHd/9Tt1JIuhGzlUta+bx//N4Pl
        duVON7sTSizFGYmGWsxFxYkAJG208yoDAAA=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-06-17 18:27, Matteo Croce έγραψε:
> +
> +void *__memset(void *s, int c, size_t count)
> +{
> +	union types dest = { .u8 = s };
> +
> +	if (count >= MIN_THRESHOLD) {
> +		const int bytes_long = BITS_PER_LONG / 8;

You could make 'const int bytes_long = BITS_PER_LONG / 8;' and 'const 
int mask = bytes_long - 1;' from your memcpy patch visible to memset as 
well (static const...) and use them here (mask would make more sense to 
be named as word_mask).

> +		unsigned long cu = (unsigned long)c;
> +
> +		/* Compose an ulong with 'c' repeated 4/8 times */
> +		cu |= cu << 8;
> +		cu |= cu << 16;
> +#if BITS_PER_LONG == 64
> +		cu |= cu << 32;
> +#endif
> +

You don't have to create cu here, you'll fill dest buffer with 'c' 
anyway so after filling up enough 'c's to be able to grab an aligned 
word full of them from dest, you can just grab that word and keep 
filling up dest with it.

> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +		/* Fill the buffer one byte at time until the destination
> +		 * is aligned on a 32/64 bit boundary.
> +		 */
> +		for (; count && dest.uptr % bytes_long; count--)

You could reuse & mask here instead of % bytes_long.

> +			*dest.u8++ = c;
> +#endif

I noticed you also used CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on your 
memcpy patch, is it worth it here ? To begin with riscv doesn't set it 
and even if it did we are talking about a loop that will run just a few 
times to reach the alignment boundary (worst case scenario it'll run 7 
times), I don't think we gain much here, even for archs that have 
efficient unaligned access.
