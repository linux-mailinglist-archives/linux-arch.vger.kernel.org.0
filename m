Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3252A666FF5
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjALKn1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 05:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjALKmh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 05:42:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD0838AFB;
        Thu, 12 Jan 2023 02:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FbD0IxWuAX/Y8WsFg6u3/hujf5Ic00N3x5hHmUPVo3k=; b=JJN8SRR0AcR1WfdCZaFcyHSia9
        //YI6UN0uXhh2PkY8RGhTr4Lygk+YYq63ibUzQ5iZpz+1D0m/a8hjCg24QcmYFH50XRKasTBj7cQJ
        rK31jXqyB4CIu1NKgIwZxoU11LJaKDLCg8rpBXGUQlCdhovZLYEzlHXi2Myu20rx0lcCY7yKgdq6C
        FjLhRA3FtITaih04d9/a29ZLOgYnFMRs7ej45UE5i53cOYM7CPQ/HL0O5laaUvjvsgY64jtnnNt4Q
        dCpFpDnoCkjV1Iih8lxPHE00Y25SCaI3EnkOu30Po1hfzB5iIuEgP3nCwt6o3Bano83Cx8LO/bq2B
        UxGw7UJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFuwT-004zNt-8i; Thu, 12 Jan 2023 10:36:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F8DC30084B;
        Thu, 12 Jan 2023 11:35:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B0E12CC6D735; Thu, 12 Jan 2023 11:35:59 +0100 (CET)
Date:   Thu, 12 Jan 2023 11:35:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
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
Subject: Re: [RFC][PATCH 05/12] arch: Introduce
 arch_{,try_}_cmpxchg128{,_local}()
Message-ID: <Y7/ijxXMGqYCqSRe@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
 <Y7xh8Orb2/E2sM7J@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xh8Orb2/E2sM7J@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 09, 2023 at 06:50:24PM +0000, Mark Rutland wrote:

> Similarly, I'd suggest:
> 
> | #define __CMPXCHG128(name, mb, cl...)                                   \
> | static __always_inline u128                                             \
> | __lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)         \
> | {                                                                       \
> |         asm volatile(                                                   \
> |         __LSE_PREAMBLE                                                  \
> |         "       casp" #mb "\t%[old], %H[old], %[new], %H[new], %[v]\n"  \
> |         : [old] "+&r" (old),                                            \
> |           [v] "+Q" (*(u128 *)ptr)                                       \
> |         : [new] "r" (new)                                               \
> |         : cl);                                                          \
> |                                                                         \
> |         return old;                                                     \
> | }
> | 
> | __CMPXCHG128(   ,   )   
> | __CMPXCHG128(_mb, al, "memory")
> | 
> | #undef __CMPXCHG128

clang-16 seems to hate on this like:

arch/arm64/include/asm/atomic_lse.h:342:1: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
arch/arm64/include/asm/atomic_lse.h:334:17: note: expanded from macro '__CMPXCHG128'
	: [old] "+&r" (old),                                            \
		       ^

(much the same for the ll_sc version; if you want the full build thing,
holler and I'll bounce you the robot mail).
