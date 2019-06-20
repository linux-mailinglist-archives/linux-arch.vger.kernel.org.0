Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38D4C80E
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFTHPX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 03:15:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTHPX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 03:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YLDOeKEFgKiCJoPhKcSOnanWSsPi7sudQNGrpls87Xk=; b=Hvh03hzeGqUCZ23Rsfw22JUI6
        D15b+sIQwzRdM/hYgY+rDpSs0Y6SrxJUs1LKWQc1JPVMhIbRJ7foMOn7NgSJFUeyWT0oOd7iLXL5i
        lmoAVhGfGkzu1UQFezcyyvhwJdSQZqMsy0XHAe8e0XH9ye0jNck0+IRfBvKsXGgTiSkq2Lf4C6q06
        T4evu9PuTMaF219uCJSDTfB8cfopDzHV/CRxLVEAOwjY5Lg56kGpWjzCQvVV/f8nKMmLFm+lnKJXA
        55LXQbPUwJMRgadEbITW4beOs0lC4tLVykc/xR7U+8T+ceazUUj5KLY6vWeU/d1HJJcaCZciT8s4e
        TBVAghfkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdrHw-0004Bw-4v; Thu, 20 Jun 2019 07:15:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E446F200B4CB3; Thu, 20 Jun 2019 09:15:14 +0200 (CEST)
Date:   Thu, 20 Jun 2019 09:15:14 +0200
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
Message-ID: <20190620071514.GR3419@hirez.programming.kicks-ass.net>
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

> FWIW I tried to avoid all of this by using the 2 byte NOP_S and B_S variants which
> ensures we can never straddle cache line so the alignment issue goes away. There's
> a nice code size reduction too - see [1] . But I get build link errors in
> networking code around DO_ONCE where the unlikely code is too much and offset
> can't be encoded in signed 10 bits which B_S is allowed.

Yeah, so on x86 we have a 2 byte and a 5 byte relative jump and have the
exact same issue. We're currently using 5 byte jumps unconditionally for
the same reason.

Getting it to use the 2 byte one where possible is a 'fun' project for
someone with spare time at some point.  It might need a GCC plugin to
pull off, I've not put too much tought into it.
