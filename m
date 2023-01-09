Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401CB662B38
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAIQ34 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjAIQ3b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 11:29:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784213F6B;
        Mon,  9 Jan 2023 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K4iLiuKEPTIMOSfy85ssWj3jx3GEEqdcGwlKwLODXMM=; b=JAy3f3pJzS7zKtbCVYppxBykTw
        GRrOsT8QXwJeRAVJnKjXkPNTTrYhLcKd6x7KX7Er5l5FnRJxlkrKavnOuiiKBcLrxI98sFeLSzlTi
        X/RCB/4g03Emt/oA33OuwJ7Lw67aPct5WDU5KbEI7+Ne1z3NJAUQI20zlsNXrvVUojTYfNprA1iXA
        qsasYrCJDKcBRXJrcZy+4PPXepvCbRYEFhzkYd8UwLYw3lJtlTLXRLSP1xUFW+luM9Gy2E3q3nme1
        1wLhOXUv6PRulcIOv6OJIpLIL5TyVk1QvInXtFnA+/iKh9bXbBkNptb3lVtD9eTuWxYl63jk0dz8i
        fH0nr+GQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pEv0g-002mMs-0C;
        Mon, 09 Jan 2023 16:28:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEE513001E5;
        Mon,  9 Jan 2023 17:28:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A07E20086EAB; Mon,  9 Jan 2023 17:28:32 +0100 (CET)
Date:   Mon, 9 Jan 2023 17:28:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>, corbet@lwn.net,
        will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
Message-ID: <Y7xAsELYo4srs/z/@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.550996611@infradead.org>
 <Y7Ri+Uij1GFkI/LB@osiris>
 <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 03, 2023 at 11:08:29AM -0800, Linus Torvalds wrote:

> But I *do* note that this patch seems to be the only one that depends
> on the new this_cpu_cmpxchg() updates to make it just automatically do
> the right thing for a 128-bit value. And I have to admit that all
> those games with __pcpu_cast_128() make no sense to me. Why isn't it
> just using "u128" everywhere without any odd _Generic() games?

I ran into a ton of casting trouble when compiling kernel/fork.c which
uses this_cpu_cmpxchg() on a pointer type and the compiler hates casting
pointers to an integer that is not the exact same size.

