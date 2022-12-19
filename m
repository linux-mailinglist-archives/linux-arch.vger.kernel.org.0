Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F728650F91
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 16:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiLSP6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 10:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiLSP5p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 10:57:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451BAFAFB;
        Mon, 19 Dec 2022 07:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01156B80EDA;
        Mon, 19 Dec 2022 15:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A4CC433F0;
        Mon, 19 Dec 2022 15:56:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QAL5Ft+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671465399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81vP/WZfkabtKBEFH0+IkYNddzD7C35Ot4O6pKjKCUI=;
        b=QAL5Ft+CRVjgFazjSaWQke+om0MPkMazc/xZcVmBYAxpw5EucxYhwoG/jqyorloH07JPIh
        2Co8/IsFgaYX3B26tsS1uLsDb+oqNgS2m4jTopzXzp2LXtEDmXqpF16eNAmTppVsKLepWa
        UX8TRJrd/Jvnf1V6FSWgDbH69/XNoow=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4929dc98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Dec 2022 15:56:39 +0000 (UTC)
Date:   Mon, 19 Dec 2022 16:56:33 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
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
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 01/12] crypto: Remove u128 usage
Message-ID: <Y6CJsWBhcbKatZNg@zx2c4.com>
References: <20221219153525.632521981@infradead.org>
 <20221219154118.889543494@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219154118.889543494@infradead.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:26PM +0100, Peter Zijlstra wrote:
> As seems to be the common (majority) usage in crypto, use __uint128_t
> instead of u128.
> 
> This frees up u128 for definition in linux/types.h.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  lib/crypto/curve25519-hacl64.c |  142 ++++++++++++++++++++---------------------
>  lib/crypto/poly1305-donna64.c  |   22 ++----
>  2 files changed, 80 insertions(+), 84 deletions(-)
> 
> --- a/lib/crypto/curve25519-hacl64.c
> +++ b/lib/crypto/curve25519-hacl64.c
> @@ -14,8 +14,6 @@
>  #include <crypto/curve25519.h>
>  #include <linux/string.h>
>  
> -typedef __uint128_t u128;
> -
>  static __always_inline u64 u64_eq_mask(u64 a, u64 b)
>  {
>  	u64 x = a ^ b;
> @@ -50,77 +48,77 @@ static __always_inline void modulo_carry
>  	b[0] = b0_;
>  }
>  
> -static __always_inline void fproduct_copy_from_wide_(u64 *output, u128 *input)
> +static __always_inline void fproduct_copy_from_wide_(u64 *output, __uint128_t *input)
>  {
>  	{
> -		u128 xi = input[0];
> +		__uint128_t xi = input[0];

Why not just use `u128` from types.h in this file?

Jason
