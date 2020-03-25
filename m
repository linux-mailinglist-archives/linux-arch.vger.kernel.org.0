Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7C1929B9
	for <lists+linux-arch@lfdr.de>; Wed, 25 Mar 2020 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCYNch (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 09:32:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCYNch (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2020 09:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V0U0l1QbT2uhoDe8FDDYfkVx/+fP0Sx7wifS90pP1dw=; b=lRUi8P8kwB3Nt2mEpi3N3rDSXJ
        kYOvThxmnePFXfhSh6CtMCUaRlb934Jm3r9+HQJe/asp2yUeYCHAK/ATOJ2CO9BDON34Xu6adoctK
        pqzXtZc448Pchn1xdR6lNvRpddgcmcKHKQJloDTcuc6Ra7hXS2NBe6DPWNNAGTwA1OwVnYIgc+P4W
        q1+LcViu+rlIAEzrjZAdIwxxgYRUSdPhyolyIoAMJVNzHPp0rBwNvRNsV/FH7Dk7taeH5AoiXx0iI
        VUNLdQbEoxW+IrM0VYXnfCT/aTJZqlQcwBR3N6dA+RFUZkhCG6IXJMXgpthpyydgWRJuOBDIMwSKK
        9A3riRGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH68b-0007Ze-25; Wed, 25 Mar 2020 13:32:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACE3C3023D1;
        Wed, 25 Mar 2020 14:32:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 712FA20C0D797; Wed, 25 Mar 2020 14:32:01 +0100 (CET)
Date:   Wed, 25 Mar 2020 14:32:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, linux-mm@kvack.org,
        guohanjun@huawei.com, will@kernel.org, linux-arch@vger.kernel.org,
        yuzhao@google.com, maz@kernel.org, steven.price@arm.com,
        arm@kernel.org, Dave.Martin@arm.com, arnd@arndb.de,
        suzuki.poulose@arm.com, npiggin@gmail.com,
        zhangshaokun@hisilicon.com, broonie@kernel.org,
        rostedt@goodmis.org, prime.zeng@hisilicon.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, xiexiangyou@huawei.com,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org
Subject: Re: Re: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
Message-ID: <20200325133201.GI20713@hirez.programming.kicks-ass.net>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <20200324150155.GH20713@hirez.programming.kicks-ass.net>
 <fb06ba92-a3ce-6925-e914-167a85837f27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb06ba92-a3ce-6925-e914-167a85837f27@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 25, 2020 at 12:49:45PM +0800, Zhenyu Ye wrote:
> Hi Peter,
> 
> On 2020/3/24 23:01, Peter Zijlstra wrote:
> > On Tue, Mar 24, 2020 at 09:45:28PM +0800, Zhenyu Ye wrote:
> >> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> >> feature allows TLBs to be issued with a level allowing for quicker
> >> invalidation.  This series provide support for this feature. 
> >>
> >> Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
> >> which detect the TTL feature and add __tlbi_level interface.
> > 
> > I realy hate how it makes vma->vm_flags more important for tlbi.
> > 
> 
> Thanks for your review.
> 
> The tlbi interfaces only have two parameters: vma and addr. If we
> try to not use vma->vm_flags, we may should have to add a parameter
> to some of these interfaces(such as flush_tlb_range), which are
> common to all architectures.
> 
> I'm not sure if this is feasible, because this feature is only
> supported by ARM64 currently.

Power (p9-radix) also has level dependent invalidation instructions, so
at the very least you can hook them up as well.
