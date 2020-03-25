Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E01192E76
	for <lists+linux-arch@lfdr.de>; Wed, 25 Mar 2020 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgCYQmS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 12:42:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgCYQmQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2020 12:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mRHWpcrmchRbU0owKTcqFGIDS9+Dwj9bNBh2URMrFd8=; b=mgZzgtbyEo8KJZgK8cuoRLaS3F
        80P9siBMVb+J7I87vgTBr0msEZJWoQrRxICZd2DgP/r7wAk9LA6mVCRmcznNentWYNbzUndA/nEvY
        CidVPrN8hF6oFANViKQraeI8RhulIBtzVr4a9uCYc9hLZW5ak3KEYxRSuW8gaJjtKGe8/9bvE2vjY
        WS0nCwbe+8zOexAYCy1Z9L4ymiknO5OI5gBa49Q2AiYELwqgzKGsaxGuFe8LCKk4bkz13+LMzbNTe
        OVo60W2gGGnSx4vqxqt1b7v1bR9JFJYyLV6taQrAAmRwOrw7ItfWOMSv5NuFXSfhekYfHQgMFyes7
        nmRODt0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH96B-0004TC-6K; Wed, 25 Mar 2020 16:41:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 813823010CF;
        Wed, 25 Mar 2020 17:41:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 665E829A7FACF; Wed, 25 Mar 2020 17:41:44 +0100 (CET)
Date:   Wed, 25 Mar 2020 17:41:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Morse <james.morse@arm.com>
Cc:     Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com
Subject: Re: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
Message-ID: <20200325164144.GB20696@hirez.programming.kicks-ass.net>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <aaf017a8-3658-fe4d-c0cf-2f45656020af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf017a8-3658-fe4d-c0cf-2f45656020af@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 25, 2020 at 04:15:58PM +0000, James Morse wrote:
> Hi Zhenyu,
> 
> On 3/24/20 1:45 PM, Zhenyu Ye wrote:
> > In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> > feature allows TLBs to be issued with a level allowing for quicker
> > invalidation.  This series provide support for this feature. 
> > 
> > Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
> > which detect the TTL feature and add __tlbi_level interface.
> 
> How does this interact with THP?
> (I don't see anything on that in the series.)
> 
> With THP, there is no one answer to the size of mapping in a VMA.
> This is a problem because the arm-arm has in "Translation table level
> hints" in D5.10.2 of DDI0487E.a:
> | If an incorrect value for the entry being invalidated by the
> | instruction is specified in the TTL field, then no entries are
> | required by the architecture to be invalidated from the TLB.
> 
> If we get it wrong, not TLB maintenance occurs!
> 
> Unless THP leaves its fingerprints on the vma, I think you can only do
> this for VMA types that THP can't mess with. (see
> transparent_hugepage_enabled())

The convention way to deal with that is to issue the TBLI for all
possible sizes.

Power9 has all this, please look there.
