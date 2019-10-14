Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E890D6B5D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2019 23:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfJNVsH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Oct 2019 17:48:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbfJNVsG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 17:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r8+y9y2pf6LTBiDmD8ROJU1496EBIFF0Ze6tIupxL2U=; b=K9uVe0jEoGlpWh2+YYpxbI82j
        94gnr5sqHxIwpTw7qYu9rgfRaZl4hH99mdv01m0cP3vrveXCqWMbu3ZOxIuicu0opBhchEnfJ754+
        tqq82Ow5YhOUV3NxjE1w6it9c9Krox4SATn0EGSDqWlB070ssRUW72rEoyS5vPMhkhK6bO9r39fUQ
        FyJOYdNh26zruSPPtzvxp98VsxBG+n53UoAE2i2rLN7R9BE4HdAvOOwK5krbXZwIc2olcX2J0hg/F
        UzZcIMDRc+R+PXNRxkRmwOsdkhXd35e8h+NXhKfbEA3rXf4TKvIAuoMdw4ANTP2TMXgFDJdI4WTJq
        YnL7y66EQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK8CA-0001s1-5B; Mon, 14 Oct 2019 21:48:02 +0000
Date:   Mon, 14 Oct 2019 14:48:02 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vineet Gupta <vineetg76@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if
 __PAGETABLE_PMD_FOLDED
Message-ID: <20191014214802.GA32665@bombadil.infradead.org>
References: <20191011121951.nxna6hruuskvdxod@box>
 <20191011223818.7238-1-vgupta@synopsys.com>
 <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
 <c0979d98-7236-b7c8-bd40-173ee2e87385@gmail.com>
 <CAHk-=wi3WXpKJkcpgHkUMgLiX9UdXnXhSFzBd8vTWkKgFpz0+Q@mail.gmail.com>
 <8bfd023b-5c00-8355-fd0f-3b4377951e6c@gmail.com>
 <CAHk-=wgUxgA-s4ZvxpcKDFfyoEmvcDr9Ydgo5W4s2hvrLHhP+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUxgA-s4ZvxpcKDFfyoEmvcDr9Ydgo5W4s2hvrLHhP+g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 14, 2019 at 01:38:34PM -0700, Linus Torvalds wrote:
> And now I've said pgd/pud/p4d/pmd so many times that I've confused
> myself and think I'm wrong again, and I think that historically -
> originally - we always had a pgd, and then the pmd didn't exist
> because it was folded into it. That makes sense from a x86 naming
> standpoint. Then x86 _did_ get a pmd, and then we added more levels in
> between, and other architectures did things differently.

Oh my goodness.  Thank you for writing all this out and finally getting
to this point.  I was reading the whole thing thinking "This is different
from what I remember" and then you got here.  This explains so much about
how our MM does/doesn't work, and it's not just me that's confused ;-)
