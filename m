Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21F64DC67
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 23:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfFTVXE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 17:23:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48588 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTVXE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 17:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lE+8ibHHDChXz68mwHUNlW1qTS9lEBvs+jAu/8RbEdA=; b=XQ/tXsRrj+CE+J2xvQNmTA8w1
        vCadQnJlkqIXhuRqw2dmSvimF/BdiwqY8rb4Wu1OM3EHzQeHDtlsqYMCOrITqAk50fWwzdNqB9kye
        s/j1ee7cBA/gVdMeQKFZTCrbSvNnbwGrsgkFecfVX7QeHKUPLNR89qIN/c91hIUHoR0SraxVUqwc2
        CyZuwpeanVIFIz+ly+XnS9c9vOXWvX3IvCYTcLAsNL/F1XCdA3W+Pxh9ufDqaI9zR/TAzNzzTOgBQ
        5RI3n3pf+zfyd7WDb1RAoA8NwR5t8v3CCnK3EJ8mbF1jqekU+xrWVI5lqeWNgXQGTk5kCDl1oVNTU
        CKy03++Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he4WH-0002qf-S0; Thu, 20 Jun 2019 21:22:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A08542021E585; Thu, 20 Jun 2019 23:22:56 +0200 (CEST)
Date:   Thu, 20 Jun 2019 23:22:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Jason Baron <jbaron@akamai.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190620212256.GC3436@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620070120.GU3402@hirez.programming.kicks-ass.net>
 <a0a1aa81-d46e-71db-ff7b-207bc468068d@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a1aa81-d46e-71db-ff7b-207bc468068d@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 20, 2019 at 11:48:17AM -0700, Vineet Gupta wrote:
> On 6/20/19 12:01 AM, Peter Zijlstra wrote:
> 
> > 
> > In particular we do not need the alignment.
> > 
> > So what the x86 code does is:
> > 
> >  - overwrite the first byte of the instruction with a single byte trap
> >    instruction
> > 
> >  - machine wide IPI which synchronizes I$
> > 
> > At this point, any CPU that encounters this instruction will trap; and
> > the trap handler will emulate the 'new' instruction -- typically a jump.
> > 
> >   - overwrite the tail of the instruction (if there is a tail)
> > 
> >   - machine wide IPI which syncrhonizes I$
> > 
> > At this point, nobody will execute the tail, because we'll still trap on
> > that first single byte instruction, but if they were to read the
> > instruction stream, the tail must be there.
> > 
> >   - overwrite the first byte of the instruction to now have a complete
> >     instruction.
> > 
> >   - machine wide IPI which syncrhonizes I$
> > 
> > At this point, any CPU will encounter the new instruction as a whole,
> > irrespective of alignment.
> > 
> > 
> > So the benefit of this scheme is that is works irrespective of the
> > instruction fetch window size and don't need the 'funny' alignment
> > stuff.
> > 
> > Now, I've no idea if something like this is feasible on ARC; for it to
> > work you need that 2 byte trap instruction -- since all instructions are
> > 2 byte aligned, you can always poke that without issue.
> 
> We do have a 2 byte TRAP_S u6 which is used for all/any trap'ing: syscalls,
> software breakpoint, kprobes etc. But using it like x86 seems a bit excessive for
> ARC. Given that x86 doesn't implement flush_icache_range() it must have I$
> snooping D$ and also this machine wide IPI sync I$ must be totally under the hood
> all hardware affair - unlike ARC which needs on_each_cpu( I$ line range).

I always forget the exact details, but we do have to execute what is
called a serializing instruction to flush CPU state and force it to
re-read the actual instructions -- see sync_core().

> Using TRAP_S would actually requires 2 passes (and 2 rounds of IPI) for code
> patching - the last one to undo the TRAP_S itself.

Correct -- we do 3, like detailed in the other email. But we figured the
actual poking of text is the slow path anyway.

> I do worry about the occasional alignment induced extra NOP_S instruction (2 byte)
> but there doesn't seem to be an easy solution. Heck if we could use the NOP_S /
> B_S in first place. While not a clean solution by any standards, could anything be
> done to reduce the code path of DO_ONCE() so that unlikely code is not too far off.

if one could somehow get the arch_static_branch*() things to
conditionally emit either the 2 or 4 byte jump, depending on the offset
(which is known there, since we stick it in the __jump_table), then we
can have arch_jump_label_transform() use that same condition to switch
between 2 and 4 bytes too.

I just don't know if it's possible :-/
