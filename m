Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8A1913CE
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 16:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCXPCd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 11:02:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgCXPCd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Mar 2020 11:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wFYim2QYkMQiybbppEhpuH5sqX3Z/8A63mEmIPHre14=; b=JKNo1aucxJAp9DOxiyfngvdx4z
        FiVtVyxTPHVQiB1L3KLRccnN+VGj5h5+wWfubMPSjtEvkQJXeVlhWxvg1EbJCAxokEYrDfuisCznr
        zYgkL0WFgzHIkty3g78gt3dn+EcRIR8HJFVRypK0JUp8d/YcfSxs3CK/l5fnXRktLQWooeDPQLjHq
        mmrWKXgkBHm5QEGMFjM0VThvKSCEJuDxteUX3+EvefFfai0UgAw5/s5+zCO3fG/B+wF4RtNhd3t/I
        8xfThPBn7bcvR4mPGrraasbnI+0NcqTwEzd0NwmAWIyAllta1lGqcHw/Y1Ty/RWZwl9jafDacemUG
        9TjAdbFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGl44-0001kh-1W; Tue, 24 Mar 2020 15:02:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B539300096;
        Tue, 24 Mar 2020 16:01:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F491286C138B; Tue, 24 Mar 2020 16:01:55 +0100 (CET)
Date:   Tue, 24 Mar 2020 16:01:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
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
Message-ID: <20200324150155.GH20713@hirez.programming.kicks-ass.net>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324134534.1570-1-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 24, 2020 at 09:45:28PM +0800, Zhenyu Ye wrote:
> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> feature allows TLBs to be issued with a level allowing for quicker
> invalidation.  This series provide support for this feature. 
> 
> Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
> which detect the TTL feature and add __tlbi_level interface.

I realy hate how it makes vma->vm_flags more important for tlbi.
