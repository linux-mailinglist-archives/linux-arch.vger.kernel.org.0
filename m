Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1530A3C
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaIZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:25:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfEaIZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LnyF2LiZJO/YFVndv0fY0DHSYQjvYUj7yzeqlwI/hZM=; b=SBouILP5p618snw6vbevL7rJP
        C0snIepbF1Kj2DLmCjDkr6qZC7kcT34RTDx3ZZth1zEc8Hcf2phdU2qt7TC5qevd0jE7an8ZhiUoC
        X3DoXlcbf5EDwSrJzgb1DH422y/m7Tv+tPseUPQ2DLHU4UnixqrsiWFEiftZKevWqdOsca6MIamTd
        4ZHq+feZuztfhqd8ifQC6SjY4N3lDc0KgOWKX0GDcOhKyn7RLoFa31J/Ykgs0WI7i5EB+hWdUXWAu
        5Pr7r5VrEfP2p2k2e8eO/IEHSIWU0jXfUa1syUqifJrLt34hE8+m/bCnk81VIigz3EVhoTMi/XlT6
        Iqg7sK63g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWcqw-0002TO-5U; Fri, 31 May 2019 08:25:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A75DD201B8CFE; Fri, 31 May 2019 10:25:28 +0200 (CEST)
Date:   Fri, 31 May 2019 10:25:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Message-ID: <20190531082528.GJ2623@hirez.programming.kicks-ass.net>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190530185358.GG28207@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530185358.GG28207@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 11:53:58AM -0700, Paul E. McKenney wrote:
> On Thu, May 30, 2019 at 11:22:42AM -0700, Vineet Gupta wrote:
> > Hi Peter,
> > 
> > Had an interesting lunch time discussion with our hardware architects pertinent to
> > "minimal guarantees expected of a CPU" section of memory-barriers.txt
> > 
> > 
> > |  (*) These guarantees apply only to properly aligned and sized scalar
> > |     variables.  "Properly sized" currently means variables that are
> > |     the same size as "char", "short", "int" and "long".  "Properly
> > |     aligned" means the natural alignment, thus no constraints for
> > |     "char", two-byte alignment for "short", four-byte alignment for
> > |     "int", and either four-byte or eight-byte alignment for "long",
> > |     on 32-bit and 64-bit systems, respectively.
> > 
> > 
> > I'm not sure how to interpret "natural alignment" for the case of double
> > load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> > alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> > 
> > I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
> > be atomic unless 8-byte aligned
> 
> I would not expect 8-byte accesses to be atomic on 32-bit systems unless
> some special instruction was in use.  But that usually means special
> intrinsics or assembly code.

If the GCC of said platform defaults to the double-word instructions for
long long, then I would very much expect natural alignment on it too.

If the feature is only available through inline asm or intrinsics, then
we can be a little more lenient perhaps.
