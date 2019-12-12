Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C311D310
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 18:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfLLREf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 12:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729927AbfLLREf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 12:04:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4EB214AF;
        Thu, 12 Dec 2019 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576170274;
        bh=cStQM6dJAgiI/M8e5otdqNPehlU5HK8fnoGish0RYPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKrPjstBHwTbT220UQOtLkKeCMvT6WPqTLCez8mR+Lq7UVly0+SrA5HonfG1lMuyO
         Uy6bO0rwELdpe2xXOhR9JbKXRiq4xqT6Xsi+e/OTI+9prkABIh2bIOaZcKkaGFGW5p
         YqTrrN1JrVJnnP8s94OpHruGOkFIRCOQrvvW7fz8=
Date:   Thu, 12 Dec 2019 17:04:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@c-s.fr, linux-arch@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191212170427.GA16364@willie-the-truck>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212104610.GW2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 11:46:10AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 12, 2019 at 10:07:56AM +0000, Will Deacon wrote:
> 
> > > So your proposed change _should_ be fine. Will, I'm assuming you never
> > > saw this on your ARGH64 builds when you did this code ?
> > 
> > I did see it, but (a) looking at the code out-of-line makes it look a lot
> > worse than it actually is (so the ext4 example is really helpful -- thanks
> > Michael!) and (b) I chalked it up to a crappy compiler.
> > 
> > However, see this comment from Arnd on my READ_ONCE series from the other
> > day:
> > 
> > https://lore.kernel.org/lkml/CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com
> > 
> > In which case, I'm thinking that we should be doing better in READ_ONCE()
> > for non-buggy compilers which would also keep the KCSAN folks happy for this
> > code (and would help with [1] too).
> 
> So something like this then? Although I suppose that should be moved
> into compiler-gcc.h and then guarded by #ifndef READ_ONCE or so.

Ah wait, I think we've been looking at this wrong. The volatile pointer
argument is actually the problem here, not READ_ONCE()! The use of typeof()
means that the temporary variable to which __READ_ONCE_SIZE writes ends up
being a volatile store, so it can't be optimised away. This is why we get
a stack access and why stack protector then wrecks the codegen for us.

I'll cook a patch getting rid of those volatiles.

Will
