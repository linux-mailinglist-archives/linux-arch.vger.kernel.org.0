Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873B6663E32
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 11:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjAJK3R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 05:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjAJK3P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 05:29:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD235933;
        Tue, 10 Jan 2023 02:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/xtL8wvIQ8lp3BC23umGDk+I9OXyKwohSrU+Z23LYik=; b=o5SrilMrWER24rePTbd37D5rR3
        03Af0s4hy0SvanC8/eRAv5X/6uAN5F/D37kGqZ1sHdmfojYayBcomClwwtQiIFFdCCrLv2yPw1dXa
        Fm4BcZIyoq4yqYyBsk6HX5F0QzoDAo3BN9pwxePmb9sUznFBGXraNlt6dS/GRvQMhW93msvZiysCK
        AmxX+mYNLhKneNh3AvUn/71mZlQILHCKKAGsnTeeoD8/LqzD8wXbzyIqwmRbOO9qHL22LAPgnIhSV
        ML3sHXLLe+KBW8dBXmM/b18gTjpNlwd+/D7x+QBPyC+JYSzLsANSUHofmbbP0vuBtoYuXo3yjMRMd
        i5JOjQnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFBrQ-0035qA-1F;
        Tue, 10 Jan 2023 10:28:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9BAF3001F7;
        Tue, 10 Jan 2023 11:28:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75EEE2C539CAD; Tue, 10 Jan 2023 11:28:07 +0100 (CET)
Date:   Tue, 10 Jan 2023 11:28:07 +0100
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
Message-ID: <Y709txFG5QjW2qrg@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.550996611@infradead.org>
 <Y7Ri+Uij1GFkI/LB@osiris>
 <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
 <Y7xAsELYo4srs/z/@hirez.programming.kicks-ass.net>
 <CAHk-=whm+u8YoUaE9PKugYBxujhDL5twz6HqzqLP8OTXjKuT4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whm+u8YoUaE9PKugYBxujhDL5twz6HqzqLP8OTXjKuT4g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 09, 2023 at 04:02:33PM -0600, Linus Torvalds wrote:
> On Mon, Jan 9, 2023 at 10:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > I ran into a ton of casting trouble when compiling kernel/fork.c which
> > uses this_cpu_cmpxchg() on a pointer type and the compiler hates casting
> > pointers to an integer that is not the exact same size.
> 
> Ahh. Yeah - not because that code needs or wants the 128-bit case, but
> because the macro expands to all sizes in a switch statement, so the
> compiler sees all the cases even if only one is then statically
> picked.
> 
> So the silly casts are for all the cases that never matter.
> 
> Annoying.

Yes, very.

This seems to compile (and boot). Let me go update the others and push
it out for the robots to have a go.

#define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
({									\
	union {								\
		typeof(_var) full;					\
		struct {						\
			u64 low, high;					\
		};							\
	} old__, new__;							\
									\
	old__.full = _oval;						\
	new__.full = _nval;						\
									\
	asm qual ("cmpxchg16b " __percpu_arg([var])			\
		  : [var] "+m" (_var),					\
		    "+a" (old__.low),					\
		    "+d" (old__.high)					\
		  : "b" (new__.low),					\
		    "c" (new__.high)					\
		  : "memory");						\
									\
	old__.full;							\
})
