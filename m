Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABCD4DC92
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 23:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFTVbD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 17:31:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTVbD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 17:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=enjs7CHak9fTSsrtrkc6AsjIa820JWzWgsah7wbOA1Y=; b=Yaq67oiPAUNb6kpFKiMcxMNSy
        1sLwhxmWqDoRJyxjUTMtjT+tgwEMyPQ7OWvj0YfFsdbO96kUZn/ZBK92ypjpaU0Y14XwzerZidJ5Z
        SSvz3jycgMDfYkK85HcblRrkUsIb3x56ebJ3WO/aipaP0V2x/Qg10m2k6iLndl/6x5BFkR+STNfEn
        8AAhHI7ViErnWYtrKnVCFt14Df4Ke9+LnoC1bnKVphgIAQwfPAKJVENgxztxSt6hW7U5pbahOWkTg
        WSwc/nv9yW0L6FQaxSlXBwbspYOy+K9bglgMNdvEiJzWkIQ022GXEFYotyNySuPSA2zm/OaXipTHw
        nsTM/tvVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he4e2-0000U4-Uc; Thu, 20 Jun 2019 21:30:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B1F82021E585; Thu, 20 Jun 2019 23:30:57 +0200 (CEST)
Date:   Thu, 20 Jun 2019 23:30:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190620213057.GD3436@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620070120.GU3402@hirez.programming.kicks-ass.net>
 <a945de7d3b6f2da03c62c9e1043e125b4c4211aa.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a945de7d3b6f2da03c62c9e1043e125b4c4211aa.camel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 20, 2019 at 06:34:55PM +0000, Eugeniy Paltsev wrote:
> On Thu, 2019-06-20 at 09:01 +0200, Peter Zijlstra wrote:

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
> 
> Thanks for explanation. Now I understand how this x86 magic works.
> 
> However it looks like even more complex than ARM implementation.
> As I understand on ARM they do something like that:
> ---------------------------->8-------------------------
> on_each_cpu {
> 	write_instruction
> 	flush_data_cache_region
> 	invalidate_instruction_cache_region
> }
> ---------------------------->8-------------------------
> 
> https://elixir.bootlin.com/linux/v5.1/source/arch/arm/kernel/patch.c#L121
> 
> Yep, there is some overhead - as we don't need to do white and D$ flush on each cpu
> but that makes code simple and avoids additional checks.
> 
> And I don't understand in which cases x86 approach with trap is better.
> In this ARM implementation we do one machine wide IPI instead of three in x86 trap approach.
> 
> Probably there is some x86 specifics I don't get?

It's about variable instruction length; ARM (RISC in general) doesn't
have that, ARC does.

Your current proposal works by keeping the instruction inside of the
i-fetch window, but that then results in instruction padding (extra
NOPs). And that is fine, it really should work.

The x86 approach however allows you to get rid of that padding and
should work for unaligned variable length instructions (we have 1-15
byte instructions).

I just wanted to make sure you were aware of the possiblities such that
you made an informed decision, I'm not trying to force complexity on you
:-)
