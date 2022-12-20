Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B85651E71
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 11:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiLTKJt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 05:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiLTKJs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 05:09:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58B195;
        Tue, 20 Dec 2022 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mQoXx7ooWzXAgLu3DbAl3UCLnz1vvc6S+1s5Rvnq/UI=; b=mifUTTsP8pp/47e91n+1G5oAGl
        Sytj5m/XMsUymJR6hl/wNCZLxJsqkWKZXV+2zQ9MuvryuM7nKDKoAqAQ47XIXHOwTkmCnuAIWfLzy
        kvCyAKW+BmJSyHpcIlgvM9T9OjzbLtAmUKFjsenj43QJM2fi5Xma65xF7N16RYVY+HIBbMM/xNj8m
        NKKtjqtohqpqRmTU/UMIe6VUfhSD3zdYZD+48z3UOu2A8I28cV3h4WcSCrs4PMqs35w3gh9dWKGpE
        lNnqsH4LvQIcWKg375a/JZouT1oGuIk24Gb0pp6Tk1QK1kw2Is+yw2SAYC4ayabXxOXP9bj1K0vvl
        6nEPcutQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7ZYt-001gUJ-QB; Tue, 20 Dec 2022 10:09:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 237DC300023;
        Tue, 20 Dec 2022 11:09:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF1E6200AB1CE; Tue, 20 Dec 2022 11:09:16 +0100 (CET)
Date:   Tue, 20 Dec 2022 11:09:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: x86/ghash - add comment and fix broken link
Message-ID: <Y6GJzD9PLKj+Ocr2@hirez.programming.kicks-ass.net>
References: <20221220054042.188537-1-ebiggers@kernel.org>
 <20221220054042.188537-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220054042.188537-4-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 09:40:42PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a comment that explains what ghash_setkey() is doing, as it's hard
> to understand otherwise.  Also fix a broken hyperlink.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/x86/crypto/ghash-clmulni-intel_asm.S  |  2 +-
>  arch/x86/crypto/ghash-clmulni-intel_glue.c | 27 ++++++++++++++++++----
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
> index 9dfeb4d31b92..257ed9446f3e 100644
> --- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
> +++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
> @@ -4,7 +4,7 @@
>   * instructions. This file contains accelerated part of ghash
>   * implementation. More information about PCLMULQDQ can be found at:
>   *
> - * http://software.intel.com/en-us/articles/carry-less-multiplication-and-its-usage-for-computing-the-gcm-mode/
> + * https://www.intel.com/content/dam/develop/external/us/en/documents/clmul-wp-rev-2-02-2014-04-20.pdf

Since these things have a habbit if changing, we tend to prefer to host
a copy on kernel.org somewhere (used to be bugzilla, but perhaps there's
a better places these days).

>   *
>   * Copyright (c) 2009 Intel Corp.
>   *   Author: Huang Ying <ying.huang@intel.com>
> diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
> index 9453b094bb3b..700ecaee9a08 100644
> --- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
> +++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
> @@ -60,16 +60,35 @@ static int ghash_setkey(struct crypto_shash *tfm,
>  	if (keylen != GHASH_BLOCK_SIZE)
>  		return -EINVAL;
>  
> -	/* perform multiplication by 'x' in GF(2^128) */
> +	/*
> +	 * GHASH maps bits to polynomial coefficients backwards, which makes it
> +	 * hard to implement.  But it can be shown that the GHASH multiplication
> +	 *
> +	 *	D * K (mod x^128 + x^7 + x^2 + x + 1)
> +	 *
> +	 * (where D is a data block and K is the key) is equivalent to:
> +	 *
> +	 *	bitreflect(D) * bitreflect(K) * x^(-127)
> +	 *		(mod x^128 + x^127 + x^126 + x^121 + 1)
> +	 *
> +	 * So, the code below precomputes:
> +	 *
> +	 *	bitreflect(K) * x^(-127) (mod x^128 + x^127 + x^126 + x^121 + 1)
> +	 *
> +	 * ... but in Montgomery form (so that Montgomery multiplication can be
> +	 * used), i.e. with an extra x^128 factor, which means actually:
> +	 *
> +	 *	bitreflect(K) * x (mod x^128 + x^127 + x^126 + x^121 + 1)
> +	 *
> +	 * The within-a-byte part of bitreflect() cancels out GHASH's built-in
> +	 * reflection, and thus bitreflect() is actually a byteswap.
> +	 */

Whee, thanks, that was indeed entirely non-obvious.
