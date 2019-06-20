Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4277A4C8AD
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 09:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfFTHwa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 03:52:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfFTHwa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 03:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z9K4JaOfCly2PGAOEjcdrFWJOAtSuxbb4GvB+cSG2jg=; b=DIsQphDQ16khJezTqsw/oNAiR
        5sjLrKDs+Rngi0tKkBKh1rYK17HMeexsoBlVFQPTmmF/gFKgXehYIYRYdsC/E14t8+Ay0Gzl9Bvyo
        gnby4u0dNTmHjAE6Hmyo9Jtah0SG1RUKaXfhv3AfBlkmw/dG5rSIjPYOol+cLPbU00S21gyCiS6rH
        F2Gw2SDPp0N7iae6G7o9J5omXNRknXeGYLs2RpMDxuDpKoPyk5r12Exk87b8nc4yy1waOTIwkW4UM
        tXVt56CiOBmYi+ee/3Gyb/MDDzmFtGmnk8KhtDfDFudtAaXYjZW6WOb7MJlYTlFqRG1xkcBRM38eI
        0ILa6qk7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdrru-0008Ll-8o; Thu, 20 Jun 2019 07:52:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73A8120098587; Thu, 20 Jun 2019 09:52:24 +0200 (CEST)
Date:   Thu, 20 Jun 2019 09:52:24 +0200
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
Message-ID: <20190620075224.GT3419@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 19, 2019 at 11:55:41PM +0000, Vineet Gupta wrote:
> On 6/19/19 1:12 AM, Peter Zijlstra wrote:

> >>> +static inline u32 arc_gen_nop(void)
> >>> +{
> >>> +	/* 1x 32bit NOP in middle endian */
> > I dare not ask...
> 
> :-) The public PRM is being worked on for *real* so this will be remedied in a few
> months at best.
> 
> Short answer is it specifies how instruction stream is laid out in code memory for
> efficient next PC decoding given that ARC can freely intermix 2, 4, 6, 8 byte
> instruction fragments w/o any restrictions.
> 
> Consier SWI insn encoding: per PRM is
> 
> 31                                     0
> --------------------------------------------------------------
> 00100    010    01    101111    0    000    000000    111111
> --------------------------------------------------------------
> 
> In regular little endian notation, in memory it would have looked as
> 
> 31                  0
>  0x22    0x6F    0x00    0x3F 
>   b3     b2      b1      b0
> 
> However in middle endian format, the 2 short words are flipped
> 
> 31                   0
> 0x00    0x3F   0x22     0x6F   
>   b1     b0      b3       b2

I'm probably missing something here. I understand the I-fetch likes 2
byte chunks, but I'm not sure I understand how you end up with middle
endian.

With everything little endian, everything seems just fine. If you load
the first 2 byte at offset 0, you get the first 2 bytes of the
instruction.

If OTOH your arch big endian, and you were to load the first two bytes
at offset 0, you get the top two.

So this middle endian scheme, only seems to make sense if you're
otherwise big endian. But AFAICT ARC is bi-endian and the jump-label
patch under condsideration is explicitly !CPU_ENDIAN_BE32 -- which
suggests the instruction stream is sensitive to the endian selection.

Anyway, I was just 'surprised' at seeing middle endian mentioned,
curiosity killed the cat and all that :-)

