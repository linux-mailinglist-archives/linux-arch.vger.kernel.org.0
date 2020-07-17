Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06B4223A0F
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgGQLOf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQLOf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677EC061755;
        Fri, 17 Jul 2020 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jcoWM7ruH7eRB3PvnOjpOP2zq5Lo72OqQAXdvnfygY4=; b=CVu1uSlrWcaqMdSONPZ0wh2J+m
        9XU1Nm+rdNYESJYcv5gA6OgeeydBg6oKgG4NWLLnbt/BpUc7+futNOAtyi9tD0JhoyXaGKHnjBlmy
        Ckg87kJx7AebIIuKkRlkHis3qytr55CA10v6X9caZ5FjMrxcHF3XVbQCpXGRvaSsWZAFp+cHUrsRB
        mEUTllpu1D0t0z1LNuJ0qdu3yjauQPG7I45Ku09dNCKr08eYQJ3jxYbEI2eFsoU9IMuLRUp1YrgOV
        MNoNkpIfT0v9KMf3T2nGxsVjkveem+tlXoeroXQuzLM80lZH2RHTWPAaKLa/uxnKEv6BMPnmhymOn
        jzZv19iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJb-0001dZ-1F; Fri, 17 Jul 2020 11:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F2D8304D58;
        Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6840203D408F; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111005.024867618@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/11] Fixup page directory freeing
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

While fixing a silly bug on SH (patch #1), I realized that even with the
trivial patch to restore prior behaviour, page directory freeing was still
broken.

The thing is, on anything SMP, freeing page directories should observe the
exact same order as normal page freeing:

 1) unhook page/directory
 2) TLB invalidate
 3) free page/directory

Without this any concurrent page-table walk could end up with a Use-after-Free.
This is esp. trivial for anything that has software page-table walkers
(HAVE_FAST_GUP / software TLB fill) or the hardware caches partial page-walks
(ie. caches page directories).

Even on UP this might give issues, since mmu_gather is preemptible these days.
An interrupt or preempted task accessing user pages might stumble into the free
page if the hardware caches page directories.

So I've converted everything to always observe the above order, simply so we
don't have to worry about it.

If however I've been over zealous and your arch/mmu really doesn't need this
and you're offended by this potentially superfluous code, please let me know
and I'll replace the patch with one that adds a comment describing your
rationale for why it is not needed.


v1: https://lkml.kernel.org/r/20191211120713.360281197@infradead.org


