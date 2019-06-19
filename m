Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86B4B3B6
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2019 10:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfFSIMd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jun 2019 04:12:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfFSIMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jun 2019 04:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DFDmIe4RHPAZL+qQ9KFPuggzK78PR57GX9gLSjen+80=; b=At3JbsRS7oZLpVhfSse6JdB+E
        pyzG235bIhVrraEKC2+7FUyrGtImw2zubb59+UYWjJpC2HI/Nbtr0lsuO+mckK/gwEAFndBMvCo2R
        g4AKi6Q6smS2bbWKNanKx2u8rpzoQtWA+ywqsOpbOBvIFGXtauZ1PlMB3r0DgrrW7KW5j8Jbouzuu
        9cD0uSl7mNwIkxKTYCQhv4Fmja9atFHGPiuREM0Dr8XZyxRnr/X0PWgYLBM4KoPaNXLV8pirXhb5r
        FGhecwrFSq9e+fWItzZSLfnWXh5FKcDIa87qOWT0b8D2HQ4KJSE4YaKFA8c9Izi8n16n03DSjQjy8
        6hMUNp4HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdVhl-0006TM-LX; Wed, 19 Jun 2019 08:12:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0051120A4E0A0; Wed, 19 Jun 2019 10:12:27 +0200 (CEST)
Date:   Wed, 19 Jun 2019 10:12:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Jason Baron <jbaron@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190619081227.GL3419@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 18, 2019 at 04:16:20PM +0000, Vineet Gupta wrote:

> > +/*
> > + * To make atomic update of patched instruction available we need to guarantee
> > + * that this instruction doesn't cross L1 cache line boundary.
> > + *

Oh urgh. Is that the only way ARC can do text patching? We've actually
considered something like this on x86 at some point, but there we have
the 'fun' detail that the i-fetch window does not in fact align with L1
size on all uarchs, so that got complicated real fast.

I'm assuming you've looked at what x86 currently does and found
something like that doesn't work for ARC?

> > +/* Halt system on fatal error to make debug easier */
> > +#define arc_jl_fatal(format...)						\
> > +({									\
> > +	pr_err(JUMPLABEL_ERR format);					\
> > +	BUG();								\
> 
> Does it make sense to bring down the whole system vs. failing and returning.
> I see there is no error propagation to core code, but still.

It is what x86 does. And I've been fairly adamant about doing so. When
the kernel text is compromised, do you really want to continue running
it?

> > +})
> > +
> > +static inline u32 arc_gen_nop(void)
> > +{
> > +	/* 1x 32bit NOP in middle endian */

I dare not ask...

> > +	return 0x7000264a;
> > +}
> > +

> > +	/*
> > +	 * All instructions are aligned by 2 bytes so we should never get offset
> > +	 * here which is not 2 bytes aligned.
> > +	 */

> > +	WRITE_ONCE(*instr_addr, instr);
> > +	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);

So do you have a 2 byte opcode that traps unconditionally? In that case
I'm thinking you could do something like x86 does. And it would avoid
that NOP padding you do to get the alignment.

