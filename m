Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD4255955
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 13:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgH1L1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgH1L0l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 07:26:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF4FC061235;
        Fri, 28 Aug 2020 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vIhwCesJTseG3yB623ZttocnuTn6e3tnM3q7J6zZ9Kg=; b=NfCCiLf0zc5PcQJaZCCJsN4tCi
        2CY6IwnecyFSbp6lPV8ze1xb1XBG8QfJS+RdwfRMOUnxfiJQ1RLugGon18Dym+KeLYaWPT07BXRSE
        XO3OCsaiEsU4YK1f0HeJgmcDRhF9/QLxNm5aElYdGB3PcitsmpLCjjjKr52xghLl4P+G/PFTnBQ7r
        udW0s+yDs+pLSFrhILeJk9e3uETXurfC2LOSwa0Mm1GfqkUhWVKKyC5Xbp5UdMyoPKKICHetVEZOw
        b/8Kg0HeUqMJYd8H5jqBgU7WA+lCIg4Lk8QjTLcmb1sz0tiB+mR9yOgygok6g+Yu1FPVY9EuHhfgq
        wE45mhiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBcLv-0003dw-E1; Fri, 28 Aug 2020 11:15:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81649300238;
        Fri, 28 Aug 2020 13:15:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 331F52C56DB14; Fri, 28 Aug 2020 13:15:25 +0200 (CEST)
Date:   Fri, 28 Aug 2020 13:15:25 +0200
From:   peterz@infradead.org
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] mm: fix exec activate_mm vs TLB shootdown and lazy
 tlb switching race
Message-ID: <20200828111525.GX1362448@hirez.programming.kicks-ass.net>
References: <20200828100022.1099682-1-npiggin@gmail.com>
 <20200828100022.1099682-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828100022.1099682-2-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 08:00:19PM +1000, Nicholas Piggin wrote:

> Closing this race only requires interrupts to be disabled while ->mm
> and ->active_mm are being switched, but the TLB problem requires also
> holding interrupts off over activate_mm. Unfortunately not all archs
> can do that yet, e.g., arm defers the switch if irqs are disabled and
> expects finish_arch_post_lock_switch() to be called to complete the
> flush; um takes a blocking lock in activate_mm().

ARM at least has activate_mm() := switch_mm(), so it could be made to
work.
