Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2837941EB3F
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353671AbhJAK5w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353638AbhJAK5v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 06:57:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A199C061775;
        Fri,  1 Oct 2021 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FttHKMTVGyyZPi4Jt0sv3xNaWOnGQdWbdqCHGfqQouQ=; b=TT+sxVM4XpJSscjBpvUdqUryAS
        03PJVNo8feago5dc2kzACRWXmvgpHivnweO8ab76ZWvv0LhgrDm0G6LTuavZQIiJXTMuVZhEMURNx
        kNwGy8ELbMEAleQr19XnVjZXzhNpm2pHVcaxFPl5n2VHgXVVHqUvDjnUZ+q9PEL2QEt/FsIgyYJJy
        m5/bC4Asrz/y6p4KIXMLy5nS/+tm4Aa/BIDe2lbuOEF7GbvxtLND2rbxW2kWF4qDUD3AuWLzRxWEe
        EdW4hftCDlzP4JVt5x8swVwmdyitw+mUVxkoWpbJsD/bLw7tQrlqyvvx+ODFI+SJMaYqHpGwVv0TB
        9UyLHgcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWG9s-00Dmoc-A5; Fri, 01 Oct 2021 10:53:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C94D7300299;
        Fri,  1 Oct 2021 12:52:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6ACD626717AC6; Fri,  1 Oct 2021 12:52:49 +0200 (CEST)
Date:   Fri, 1 Oct 2021 12:52:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V4 07/22] LoongArch: Add atomic/locking headers
Message-ID: <YVbogd2gihouyWJd@hirez.programming.kicks-ass.net>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-8-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927064300.624279-8-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 27, 2021 at 02:42:44PM +0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/include/asm/bitops.h b/arch/loongarch/include/asm/bitops.h
> new file mode 100644
> index 000000000000..8b05d9683571
> --- /dev/null
> +++ b/arch/loongarch/include/asm/bitops.h
> @@ -0,0 +1,220 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_BITOPS_H
> +#define _ASM_BITOPS_H
> +
> +#ifndef _LINUX_BITOPS_H
> +#error only <linux/bitops.h> can be included directly
> +#endif
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <asm/barrier.h>
> +#include <asm/byteorder.h>
> +#include <asm/compiler.h>
> +#include <asm/cpu-features.h>
> +
> +#if _LOONGARCH_SZLONG == 32
> +#define __LL		"ll.w	"
> +#define __SC		"sc.w	"
> +#define __AMADD		"amadd.w	"
> +#define __AMAND_SYNC	"amand_db.w	"
> +#define __AMOR_SYNC	"amor_db.w	"
> +#define __AMXOR_SYNC	"amxor_db.w	"
> +#elif _LOONGARCH_SZLONG == 64
> +#define __LL		"ll.d	"
> +#define __SC		"sc.d	"
> +#define __AMADD		"amadd.d	"
> +#define __AMAND_SYNC	"amand_db.d	"
> +#define __AMOR_SYNC	"amor_db.d	"
> +#define __AMXOR_SYNC	"amxor_db.d	"
> +#endif
> +
> +/*
> + * set_bit - Atomically set a bit in memory
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + */
> +static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	int bit = nr % BITS_PER_LONG;
> +	volatile unsigned long *m = &addr[BIT_WORD(nr)];
> +
> +	__asm__ __volatile__(
> +	"   " __AMOR_SYNC "$zero, %1, %0        \n"
> +	: "+ZB" (*m)
> +	: "r" (1UL << bit)
> +	: "memory");
> +}
> +
> +/*
> + * clear_bit - Clears a bit in memory
> + * @nr: Bit to clear
> + * @addr: Address to start counting from
> + */
> +static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	int bit = nr % BITS_PER_LONG;
> +	volatile unsigned long *m = &addr[BIT_WORD(nr)];
> +
> +	__asm__ __volatile__(
> +	"   " __AMAND_SYNC "$zero, %1, %0       \n"
> +	: "+ZB" (*m)
> +	: "r" (~(1UL << bit))
> +	: "memory");
> +}
> +
> +/*
> + * clear_bit_unlock - Clears a bit in memory
> + * @nr: Bit to clear
> + * @addr: Address to start counting from
> + */
> +static inline void clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
> +{
> +	clear_bit(nr, addr);
> +}
> +
> +/*
> + * change_bit - Toggle a bit in memory
> + * @nr: Bit to change
> + * @addr: Address to start counting from
> + */
> +static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	int bit = nr % BITS_PER_LONG;
> +	volatile unsigned long *m = &addr[BIT_WORD(nr)];
> +
> +	__asm__ __volatile__(
> +	"   " __AMXOR_SYNC "$zero, %1, %0       \n"
> +	: "+ZB" (*m)
> +	: "r" (1UL << bit)
> +	: "memory");
> +}
> +
> +/*
> + * test_and_set_bit - Set a bit and return its old value
> + * @nr: Bit to set
> + * @addr: Address to count from
> + */
> +static inline int test_and_set_bit(unsigned long nr,
> +	volatile unsigned long *addr)
> +{
> +	int bit = nr % BITS_PER_LONG;
> +	unsigned long res;
> +	volatile unsigned long *m = &addr[BIT_WORD(nr)];
> +
> +	__asm__ __volatile__(
> +	"   " __AMOR_SYNC "%1, %2, %0       \n"
> +	: "+ZB" (*m), "=&r" (res)
> +	: "r" (1UL << bit)
> +	: "memory");
> +
> +	res = res & (1UL << bit);
> +
> +	return res != 0;
> +}
> +
> +/*
> + * test_and_set_bit_lock - Set a bit and return its old value
> + * @nr: Bit to set
> + * @addr: Address to count from
> + */
> +static inline int test_and_set_bit_lock(unsigned long nr,
> +	volatile unsigned long *addr)
> +{
> +	int bit = nr % BITS_PER_LONG;
> +	unsigned long res;
> +	volatile unsigned long *m = &addr[BIT_WORD(nr)];
> +
> +	__asm__ __volatile__(
> +	"   " __AMOR_SYNC "%1, %2, %0       \n"
> +	: "+ZB" (*m), "=&r" (res)
> +	: "r" (1UL << bit)
> +	: "memory");
> +
> +	res = res & (1UL << bit);
> +
> +	return res != 0;
> +}
> +/*
> + * test_and_clear_bit - Clear a bit and return its old value
> + * @nr: Bit to clear
> + * @addr: Address to count from
> + */
> +static inline int test_and_clear_bit(unsigned long nr,
> +	volatile unsigned long *addr)
> +{
> +	int bit = nr % BITS_PER_LONG;
> +	unsigned long res, temp;
> +	volatile unsigned long *m = &addr[BIT_WORD(nr)];
> +
> +	__asm__ __volatile__(
> +	"   " __AMAND_SYNC "%1, %2, %0      \n"
> +	: "+ZB" (*m), "=&r" (temp)
> +	: "r" (~(1UL << bit))
> +	: "memory");
> +
> +	res = temp & (1UL << bit);
> +
> +	return res != 0;
> +}
> +
> +/*
> + * test_and_change_bit - Change a bit and return its old value
> + * @nr: Bit to change
> + * @addr: Address to count from
> + */
> +static inline int test_and_change_bit(unsigned long nr,
> +	volatile unsigned long *addr)
> +{
> +	int bit = nr % BITS_PER_LONG;
> +	unsigned long res;
> +	volatile unsigned long *m = &addr[BIT_WORD(nr)];
> +
> +	__asm__ __volatile__(
> +	"   " __AMXOR_SYNC "%1, %2, %0      \n"
> +	: "+ZB" (*m), "=&r" (res)
> +	: "r" (1UL << bit)
> +	: "memory");
> +
> +	res = res & (1UL << bit);
> +
> +	return res != 0;
> +}

Why is asm-generic/bitops/atomic.h not working for you?

