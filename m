Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223A8311CE
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEaP5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 11:57:41 -0400
Received: from foss.arm.com ([217.140.101.70]:53658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEaP5l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 May 2019 11:57:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3324A341;
        Fri, 31 May 2019 08:57:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DB213F59C;
        Fri, 31 May 2019 08:57:37 -0700 (PDT)
Date:   Fri, 31 May 2019 16:57:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, hpa@zytor.com,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 1/3] lib/test_kasan: Add bitops tests
Message-ID: <20190531155730.GA2646@lakrids.cambridge.arm.com>
References: <20190531150828.157832-1-elver@google.com>
 <20190531150828.157832-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531150828.157832-2-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 31, 2019 at 05:08:29PM +0200, Marco Elver wrote:
> This adds bitops tests to the test_kasan module. In a follow-up patch,
> support for bitops instrumentation will be added.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Changes in v3:
> * Use kzalloc instead of kmalloc.
> * Use sizeof(*bits).

Thatnks for cleaning these up! FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Changes in v2:
> * Use BITS_PER_LONG.
> * Use heap allocated memory for test, as newer compilers (correctly)
>   warn on OOB stack access.
> ---
>  lib/test_kasan.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 7de2702621dc..1ef9702327d2 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -11,16 +11,17 @@
>  
>  #define pr_fmt(fmt) "kasan test: %s " fmt, __func__
>  
> +#include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/kasan.h>
>  #include <linux/kernel.h>
> -#include <linux/mman.h>
>  #include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/module.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> -#include <linux/module.h>
> -#include <linux/kasan.h>
>  
>  /*
>   * Note: test functions are marked noinline so that their names appear in
> @@ -623,6 +624,73 @@ static noinline void __init kasan_strings(void)
>  	strnlen(ptr, 1);
>  }
>  
> +static noinline void __init kasan_bitops(void)
> +{
> +	long *bits = kzalloc(sizeof(*bits), GFP_KERNEL);
> +	if (!bits)
> +		return;
> +
> +	pr_info("within-bounds in set_bit");
> +	set_bit(0, bits);
> +
> +	pr_info("within-bounds in set_bit");
> +	set_bit(BITS_PER_LONG - 1, bits);
> +
> +	pr_info("out-of-bounds in set_bit\n");
> +	set_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in __set_bit\n");
> +	__set_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in clear_bit\n");
> +	clear_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in __clear_bit\n");
> +	__clear_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in clear_bit_unlock\n");
> +	clear_bit_unlock(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in __clear_bit_unlock\n");
> +	__clear_bit_unlock(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in change_bit\n");
> +	change_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in __change_bit\n");
> +	__change_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in test_and_set_bit\n");
> +	test_and_set_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in __test_and_set_bit\n");
> +	__test_and_set_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in test_and_set_bit_lock\n");
> +	test_and_set_bit_lock(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in test_and_clear_bit\n");
> +	test_and_clear_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in __test_and_clear_bit\n");
> +	__test_and_clear_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in test_and_change_bit\n");
> +	test_and_change_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in __test_and_change_bit\n");
> +	__test_and_change_bit(BITS_PER_LONG, bits);
> +
> +	pr_info("out-of-bounds in test_bit\n");
> +	(void)test_bit(BITS_PER_LONG, bits);
> +
> +#if defined(clear_bit_unlock_is_negative_byte)
> +	pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
> +	clear_bit_unlock_is_negative_byte(BITS_PER_LONG, bits);
> +#endif
> +	kfree(bits);
> +}
> +
>  static int __init kmalloc_tests_init(void)
>  {
>  	/*
> @@ -664,6 +732,7 @@ static int __init kmalloc_tests_init(void)
>  	kasan_memchr();
>  	kasan_memcmp();
>  	kasan_strings();
> +	kasan_bitops();
>  
>  	kasan_restore_multi_shot(multishot);
>  
> -- 
> 2.22.0.rc1.257.g3120a18244-goog
> 
