Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2A1B2DE7
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 19:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgDUROI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbgDUROI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 13:14:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C2BC061A41;
        Tue, 21 Apr 2020 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3EA/7AX0rs6Qrm0teDF6eZhE7fl32yQxAMP+T/YL9Sw=; b=Csk3w3AHYtgx9dLWAi0Bj9GaeL
        WpiA954DmaP/cDXi6zis6Aam9NyQbc4tg9pxRzn1edkjdFlJJyK8nwWCjoyNUdidoT1EDjCqQ+GYb
        Id0FU0OIDG2DDOgNZ8UDtJV52HENyPo1p/jzO9SPKBiU9qeF1ykcBsXygc2ZmR/T8xV0z8fp0TD7b
        V61hxkEtiLkqECyfm5YBCPG5VtCQF4cLaWDDoFK/aXJe0b2lXsihiiScLqkQ/GBgYfwLTdJJnV20R
        +9ofQjYiXnRQiBLd2g6tVmZAHmvoRiWx+/CJjxXg8qBkTnJvPFofn5NAG9QXDI5G73bhOamfJ4cma
        slCS5ehQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQwSj-0003Ot-Rh; Tue, 21 Apr 2020 17:13:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C6FC30275A;
        Tue, 21 Apr 2020 19:13:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAF202BAF0F4F; Tue, 21 Apr 2020 19:13:28 +0200 (CEST)
Date:   Tue, 21 Apr 2020 19:13:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Zhenyu Ye <yezhenyu2@huawei.com>, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiexiangyou@huawei.com, zhangshaokun@hisilicon.com,
        linux-mm@kvack.org, arm@kernel.org, prime.zeng@hisilicon.com,
        kuhn.chenqun@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/6] arm64: Detect the ARMv8.4 TTL feature
Message-ID: <20200421171328.GW20730@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-2-yezhenyu2@huawei.com>
 <20200421165346.GA11171@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421165346.GA11171@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 09:53:46AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 03, 2020 at 05:00:43PM +0800, Zhenyu Ye wrote:
> > From: Marc Zyngier <maz@kernel.org>
> > 
> > In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> > feature allows TLBs to be issued with a level allowing for quicker
> > invalidation.
> 
> What does "issued with a level" mean?

What I understood it to be is page-size based on page-table hierarchy.
Just like we have on x86, 4k, 2m, 1g etc..

So where x86 INVLPG will tear down any sized page for the address given,
you can now day, kill me the PMD level translation for @addr.

Power9 radix also has things like this.
