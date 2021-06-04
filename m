Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD2939BBB1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhFDPYA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 11:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFDPYA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 11:24:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C4C061766;
        Fri,  4 Jun 2021 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2LwCsyQ99O1W5o2DTS6nj/TbRvVmizYYRU42AaeV1hk=; b=Wzws8ckunLbKdFT/Z3/l8RsCrh
        uERJi4yoIbZabhENn+J66DkGGXRRZOe/TE3MGnrS5AqBir2EG0DwXZ20ANilRaFE83+LeBzWMrlKP
        aeT1mrtrjX0OIfahs4o2D2rfqVffho9XiAGegD+RvTi1y2Z8spnqKvn9o08F+WUFhhfGQvGs5Iy8v
        /KoqCfwUCCSKXxiw4tsujT6v7+3v7zhAXqAwNTH0x0ThJ5YpRlRfWHL/N7yqq/KphS2sEDrAClvQe
        TUzowjYRzkF3VM0oQga3SSnZK87k8qmujW+F37gvpx/sgTpbl8HFVTArqDoS4ZuNZr7o+1EWIvJ2z
        Cfo3mMjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpBe2-003TEs-F3; Fri, 04 Jun 2021 15:22:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D480300299;
        Fri,  4 Jun 2021 17:22:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46F332CCC5C2F; Fri,  4 Jun 2021 17:22:04 +0200 (CEST)
Date:   Fri, 4 Jun 2021 17:22:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
 <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck>
 <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604151356.GC2793@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 04:13:57PM +0100, Will Deacon wrote:

> In fact, maybe it's actually necessary to bundle the load and branch
> together. I looked at some of the examples of compilers breaking control
> dependencies from memory-barriers.txt and the "boolean short-circuit"
> example seems to defeat volatile_if:
> 
> void foo(int *x, int *y)
> {
>         volatile_if (READ_ONCE(*x) || 1 > 0)
>                 WRITE_ONCE(*y, 42);
> }  

Yeah, I'm not too bothered about this. Broken is broken.

If this were a compiler feature, the above would be a compile error. But
alas, we're not there yet :/ and the best we get to say at this point
is: don't do that then.
