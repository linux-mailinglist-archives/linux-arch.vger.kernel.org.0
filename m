Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3244F30A29
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfEaIX1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:23:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIX1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fdnlo9ztd5dJncnArgtMmEkp4hYI9oo/LawGnWmTfnY=; b=bttYdLG7ehBKlEgRpdcZXZcX9
        wgIMA+lbL3IUV0x+adFyIFnTALbEB2N47V0Lv/RBkw+BfeC51Ofsr8t2FDFSIO1UjLRzkTAG8dtf1
        NtVZMhBJr7W9XzVE1ko2ZYZRSdwhnylESKlpjhF6qLYntSSewu93jCQrTarfZJCv9PhsL2rDnDV/h
        tSq4mo7XocQr3dvAGv/Im9E5PJwyWVl36gw61QQC9KB11+LcahflJN23PnCTE1DW0tieof7dBnEsI
        n2c3099mPsvEcPT9vGkM8ZmI6pj1BRQ6prajI9T4WTzptLhCLnCKTzBLY8nfwn4/RhlNo/lMRGIzk
        rDurHpGVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWcou-00070v-B1; Fri, 31 May 2019 08:23:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9BA6201B8CFE; Fri, 31 May 2019 10:23:22 +0200 (CEST)
Date:   Fri, 31 May 2019 10:23:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Message-ID: <20190531082322.GI2623@hirez.programming.kicks-ass.net>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190530185358.GG28207@linux.ibm.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A2520D9C@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2520D9C@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 07:16:36PM +0000, Vineet Gupta wrote:
> On 5/30/19 11:55 AM, Paul E. McKenney wrote:
> >
> >> I'm not sure how to interpret "natural alignment" for the case of double
> >> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> >> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> >>
> >> I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
> >> be atomic unless 8-byte aligned
> > I would not expect 8-byte accesses to be atomic on 32-bit systems unless
> > some special instruction was in use.  But that usually means special
> > intrinsics or assembly code.
> 
> Thx for confirming.
> 
> In cases where we *do* expect the atomicity, it seems there's some existing type
> checking but isn't water tight.
> e.g.
> 
> #define __smp_load_acquire(p)                        \
> ({                                    \
>     typeof(*p) ___p1 = READ_ONCE(*p);                \
>     compiletime_assert_atomic_type(*p);                \
>     __smp_mb();                            \
>     ___p1;                                \
> })
> 
> #define compiletime_assert_atomic_type(t)                \
>     compiletime_assert(__native_word(t),                \
>         "Need native word sized stores/loads for atomicity.")
> 
> #define __native_word(t) \
>     (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
>      sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
> 
> 
> So it won't catch the usage of 4 byte aligned long long which gcc targets to
> single double load instruction.

Yes, we didn't do those because that would result in runtime overhead.

We assume natural alignment for any type the hardware can do.
