Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80C651E62
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 11:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiLTKH1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 05:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiLTKH0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 05:07:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3B276;
        Tue, 20 Dec 2022 02:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TE8SK83hZpIrmXxIPF+PfTz1QNq7GDqavzb2gGRNmvI=; b=J857vVwjqN6ucvsNzm+LXgLq7s
        wFUYiU+fYrYffswKMGpflrOIzR9ZGuxwieRRRcVx0mvuF03UNNOrvKFYhZeoZKgUtGWWR6esuPQl8
        DurSv7nTGIraNcp8YeG9AE9XZO/iYzyq69J2yUYdpjvzP9bqFjdkxM6cfT1s1oEMZ0Pgesvq0X/3w
        SlJJWNijdd5I3tGrJAd4+RWqeu5MT2T6fItg2unxMbE6Lbft3dvOI94/N4/WGy37ZDv4t3vnL+r8G
        /GQCrGgh9xhojOZnvmP9UB5Sgk7qI2HWjK/PVlQyzgua36fMs2rZhxTlUXDMT4Pc8RIDZddyDUD0S
        UcZGslIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7ZWG-001gMe-DF; Tue, 20 Dec 2022 10:06:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F2FC3000DD;
        Tue, 20 Dec 2022 11:06:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F11A120A1ABA4; Tue, 20 Dec 2022 11:06:30 +0100 (CET)
Date:   Tue, 20 Dec 2022 11:06:30 +0100
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
Subject: Re: [PATCH 0/3] crypto: x86/ghash cleanups
Message-ID: <Y6GJJvUReMp6h2kk@hirez.programming.kicks-ass.net>
References: <20221220054042.188537-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220054042.188537-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 09:40:39PM -0800, Eric Biggers wrote:
> These patches are a replacement for Peter Zijlstra's patch
> "[RFC][PATCH 02/12] crypto/ghash-clmulni: Use (struct) be128"
> (https://lore.kernel.org/r/20221219154118.955831880@infradead.org).
> 
> Eric Biggers (3):
>   crypto: x86/ghash - fix unaligned access in ghash_setkey()
>   crypto: x86/ghash - use le128 instead of u128
>   crypto: x86/ghash - add comment and fix broken link
> 
>  arch/x86/crypto/ghash-clmulni-intel_asm.S  |  6 +--
>  arch/x86/crypto/ghash-clmulni-intel_glue.c | 45 +++++++++++++++-------
>  2 files changed, 35 insertions(+), 16 deletions(-)

Thanks! Lemme go rebase on top of this.
