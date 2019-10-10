Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD3D21DC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 09:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfJJHiJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 03:38:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbfJJHaD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 03:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QTes5uVMa4eRN7/pRExYXKy8BKWgKlpRk+TdXzCx6uI=; b=F80s6XONsFkDHOWtuPkAqDhun
        X3HJ6WTlwiovblYOdAZpBV8A094i2afoRO/0cM05O+DpZ/f9khv+FHdhR0ZuJIIsvcdyJLCY+K9n9
        t2WKCAb/UfmX7uX3o5RVmeRw5D8OMkSYTk3dLZzOROWX/GBvWUxLtmdtDoD4yDIw3Etr7Ga6c6JWk
        wRUs3YE2VvSSURLyImW9O6ScBn5jyruoHH4ABpQrXIGB7ZEFvYvBzh+lEziWAkALd9OY57xSIkaug
        FcyVQK7VuHnwfqInTr3dAHpo+cQIW2zcqMB1pQTX3Srj5aUvxOPJZ2sYQrnlUZVbcrbuZL5W4n3mM
        Wy48VqKOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIStX-000162-12; Thu, 10 Oct 2019 07:29:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A95D3013A4;
        Thu, 10 Oct 2019 09:29:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BBE5202F4F4F; Thu, 10 Oct 2019 09:29:52 +0200 (CEST)
Date:   Thu, 10 Oct 2019 09:29:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
Message-ID: <20191010072952.GM2311@hirez.programming.kicks-ass.net>
References: <20191009222658.961-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009222658.961-1-vgupta@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 09, 2019 at 03:26:55PM -0700, Vineet Gupta wrote:
> Hi,
> 
> This series elides extraneous generate code for folded p4d/pud.
> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
> The code saving are not a while lot, but still worthwhile IMHO.
> 
> bloat-o-meter2 vmlinux-A-baseline vmlinux-E-elide-p?d_clear_bad
> add/remove: 0/2 grow/shrink: 0/1 up/down: 0/-146 (-146)
> function                                     old     new   delta
> p4d_clear_bad                                  2       -      -2
> pud_clear_bad                                 20       -     -20
> free_pgd_range                               546     422    -124
> Total: Before=4137148, After=4137002, chg -1.000000%
> 

Works for me, thanks!
