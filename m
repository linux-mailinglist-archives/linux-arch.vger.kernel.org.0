Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8472C5466
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 14:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbgKZNCf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 08:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389814AbgKZNCe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 08:02:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DABCC0613D4;
        Thu, 26 Nov 2020 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hLIHvPXWJN2+QMWWENMIdOYVjlW+boeIBinzicswIpY=; b=HkGfyJk1ztoJSLeBDC3iOhNo3N
        Sx5j5ga/YCWb+wo++NMG/gnhL8S2WoKL/BA8uMnAuRL6+dGgEPsPmFaB1YkumjBwT+RDRlmVqZUHy
        RrN2ZEOhU1S9r4u59aZNXKHMJQfwAW/EyK9+ZKrekfqn5zmI4zD5HBdsgoTCvfeh13ksse0O1j2+H
        qWwdpILV07vgJNJZRnMBCJqLkt/baSIDzvSERP32q4SxBNxOQR1NKSujVynxGfsd78xtlRS64oEZl
        lkALVz+fg1yw7AmFKOVjH/jjOV6RImvn9mbICf1Vnd+Q5qqdr2W/tCYxTDF9n6OcUeRuCB44hnOKs
        VgfZEgPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGuS-0007ck-Am; Thu, 26 Nov 2020 13:02:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D49C9305CC3;
        Thu, 26 Nov 2020 14:02:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDD89201E6BBD; Thu, 26 Nov 2020 14:02:02 +0100 (CET)
Date:   Thu, 26 Nov 2020 14:02:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 1/6] mm/gup: Provide gup_get_pte() more generic
Message-ID: <20201126130202.GH2414@hirez.programming.kicks-ass.net>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.036370527@infradead.org>
 <20201126124300.GP4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126124300.GP4327@casper.infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 26, 2020 at 12:43:00PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 01:01:15PM +0100, Peter Zijlstra wrote:
> > +#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
> > +/*
> > + * WARNING: only to be used in the get_user_pages_fast() implementation.
> > + * With get_user_pages_fast(), we walk down the pagetables without taking any
> > + * locks.  For this we would like to load the pointers atomically, but sometimes
> > + * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
> > + * we do have is the guarantee that a PTE will only either go from not present
> > + * to present, or present to not present or both -- it will not switch to a
> > + * completely different present page without a TLB flush in between; something
> > + * that we are blocking by holding interrupts off.
> 
> I feel like this comment needs some love.  How about:
> 
>  * For walking the pagetables without holding any locks.  Some architectures
>  * (eg x86-32 PAE) cannot load the entries atomically without using
>  * expensive instructions.  We are guaranteed that a PTE will only either go
>  * from not present to present, or present to not present -- it will not
>  * switch to a completely different present page without a TLB flush
>  * inbetween; which we are blocking by holding interrupts off.
> 
> And it would be nice to have an assertion that interrupts are disabled
> in the code.  Because comments are nice, but nobody reads them.

Quite agreed, I'll stick a separate patch on with the updated comment
and a lockdep_assert_irqs_disabled() in. I'm afraid that latter will make
for header soup though :/

We'll see, let the robots have it.
