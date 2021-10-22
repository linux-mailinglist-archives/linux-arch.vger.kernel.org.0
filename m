Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58C7437B07
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhJVQjX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 12:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhJVQjW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 12:39:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004B7C061764;
        Fri, 22 Oct 2021 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6hZiNIyGel125n1o6XdKTYMm3OC5SbnDoqr+z05nKn0=; b=q0fwcOQlUM6NaSxVygxGQBVH+k
        Nbmv/cffL7Ma7C5Z7DbhzBFkJR0pJeFGwNT8uyiR9f4pFBERq9ApuzBMYVkORpuDuf1li+AboB3j+
        4sI8WboczIxCp0NQObqRiq6HNpzQmFKXBhNJrN0Yate1Cl6KMXn00MwunEVYJ/Pz8h/tDxxz4R7IY
        RdUH/E69AMQqWEak6tlPfUpqR2pDi18q0Opfyi82blrIhRzMCMIBWNvUg6PTQWmFBLNHm9/xKsryO
        PFsRE9rZaBw+w70C2+Oc64aCmNioTdL1xavEEXpKugYXfmPj5Nu79TlHMlVsDzGze8UolPZM9D+gq
        HhIriVMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdxWX-00Bc57-Ld; Fri, 22 Oct 2021 16:36:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B220986249; Fri, 22 Oct 2021 18:36:04 +0200 (CEST)
Date:   Fri, 22 Oct 2021 18:36:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 4/7] arch: Make ARCH_STACKWALK independent of STACKTRACE
Message-ID: <20211022163604.GD174703@worktop.programming.kicks-ass.net>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.356586621@infradead.org>
 <202110220917.AACE11A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110220917.AACE11A@keescook>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 09:18:05AM -0700, Kees Cook wrote:
> On Fri, Oct 22, 2021 at 05:09:37PM +0200, Peter Zijlstra wrote:
> > Make arch_stack_walk() available for ARCH_STACKWALK architectures
> > without it being entangled in STACKTRACE.
> 
> Which CONFIG/arch combos did you build test with this? It looks good,
> but I always expect things like this to end up landing in corner cases.
> :)

I had this one through 0day last night. That's no guarantees, but at
least it's had a handfull of builds done on it.
