Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C52765237D
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 16:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiLTPKx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 10:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiLTPKt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 10:10:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C53A62EA;
        Tue, 20 Dec 2022 07:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FFNeZkVqnyoGozFMwV8suZuO15qmhw0RI08pyhsvplQ=; b=aj3xUuejuA9YH7oE/tMQbHxDrC
        5p9yKMxF2BMunnN+3aFfpuq4xvQtgL6Mtrf776Ph7v2oiGV9BjVApUkzIjk/WfaM1JFNiL/d3uNFt
        Cv73DfWGBBk8PaAlwJVSwfYr3hfq3P/tA8V8DL1kjpeeNx7zhonlT8kvfC88Q40rDC5AGMpqylyTa
        hPk5u9253JZPrw4gklKKy0rEjWbNLpr/vX9MLoGk1h4JsNN6FMYf6ULtZxxqymlZtiTpJmvNfyRE+
        Vda14xeiFfnUBjl0zdQiemuszxdTFOeh76ZedxboR2+ROwt3pEguOkI7xDP9FcJk8q2/NS7Axhz1z
        OnVJkmTA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7eFb-001u7k-I3; Tue, 20 Dec 2022 15:09:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BE3F300193;
        Tue, 20 Dec 2022 16:09:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0457E223694AF; Tue, 20 Dec 2022 16:09:37 +0100 (CET)
Date:   Tue, 20 Dec 2022 16:09:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
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
Message-ID: <Y6HQMVz041V7NruP@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux>
 <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
 <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 20, 2022 at 08:31:19AM -0600, Linus Torvalds wrote:
> On Tue, Dec 20, 2022 at 5:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Dec 19, 2022 at 12:07:25PM -0800, Boqun Feng wrote:
> > >
> > > I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
> > > long *) ptr)"? Because compilers may think only 64bit value pointed by
> > > "ptr" gets modified, and they are allowed to do "useful" optimization.
> >
> > In this I've copied the existing cmpxchg_double() code; I'll have to let
> > the arch folks speak here, I've no clue.
> 
> It does sound like the right thing to do. I doubt it ends up making a
> difference in practice, but yes, the asm doesn't have a memory
> clobber, so the input/output types should be the right ones for the
> compiler to not possibly do something odd and cache the part that it
> doesn't see as being accessed.

Right, and x86 does just *ptr, without trying to cast away the volatile
even.

I've pushed out a *(u128 *)ptr variant for arm64 and s390, then at least
we'll know if the compiler objects.
