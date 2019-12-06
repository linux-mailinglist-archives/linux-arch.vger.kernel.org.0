Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797FF1150E7
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 14:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLFNRN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 08:17:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfLFNRN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Dec 2019 08:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c/BS0k8X+8NG/g3S4NAeJDxb7dNaLWprIW3ucB/d7FI=; b=Orv0ZhCRtyr6C280YO0QMvQZ2
        NLIRlOF2R1VcTi8UQ64A9l3gqUZ6zhu05V6kXJUgUQbXnPoilSWNKsCXK061mPrp7Fag5L5UudX2+
        Net8OnlcMe75RQ4Gqu2hRvMi0QyYkqu+kfdYyWIO8d9zKvcRl6f9LZLYdJgDX7SQgeYB/C0MDPrrP
        pl6607VUyQOCfcJKRkv2g8qs8rSVqJ6TT17NQyt8UYfmbuSbrwtpfMuGeBgbKJYDPNrqkJjnnuDfz
        rTxYDz1H4TRsmFIb26kiFXvwmG0zj9VOdfV7n2jsezpjOT+JQBbKKlzBWzXWmmaiqIt28oOPeQ7R2
        oEbok13BA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idDTY-0007Xj-Ha; Fri, 06 Dec 2019 13:16:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CC7930025A;
        Fri,  6 Dec 2019 14:15:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A750E2B275E62; Fri,  6 Dec 2019 14:16:50 +0100 (CET)
Date:   Fri, 6 Dec 2019 14:16:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        elver@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, kasan-dev@googlegroups.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag
 (topic/kasan-bitops)
Message-ID: <20191206131650.GM2827@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blslei5o.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 06, 2019 at 11:46:11PM +1100, Michael Ellerman wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Hi Linus,
> 
> Please pull another powerpc update for 5.5.
> 
> As you'll see from the diffstat this is mostly not powerpc code. In order to do
> KASAN instrumentation of bitops we needed to juggle some of the generic bitops
> headers.
> 
> Because those changes potentially affect several architectures I wasn't
> confident putting them directly into my tree, so I've had them sitting in a
> topic branch. That branch (topic/kasan-bitops) has been in linux-next for a
> month, and I've not had any feedback that it's caused any problems.
> 
> So I think this is good to merge, but it's a standalone pull so if anyone does
> object it's not a problem.

No objections, but here:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=topic/kasan-bitops&id=81d2c6f81996e01fbcd2b5aeefbb519e21c806e9

you write:

  "Currently bitops-instrumented.h assumes that the architecture provides
atomic, non-atomic and locking bitops (e.g. both set_bit and __set_bit).
This is true on x86 and s390, but is not always true: there is a
generic bitops/non-atomic.h header that provides generic non-atomic
operations, and also a generic bitops/lock.h for locking operations."

Is there any actual benefit for PPC to using their own atomic bitops
over bitops/lock.h ? I'm thinking that the generic code is fairly
optimal for most LL/SC architectures.

I've been meaning to audit the various architectures and move them over,
but alas, it's something I've not yet had time for...
