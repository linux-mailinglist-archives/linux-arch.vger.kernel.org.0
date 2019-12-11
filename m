Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7982A11AAF9
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLKMcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:32:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55136 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLKMcQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U00e+4tun2sB5OFJt+4Nz4j/tQMLxpbE5HmgeSygRhM=; b=JEbYtLe2QQvWJBZw3kBcMpX6n
        tBAowmpgFsrFe7dQcrlHu9enNYfiUdOacOl+zgv9Z7u5yxCQfPgW1KDmFDYKYNHo7wP8e8Gn/VD91
        P6W+j2nko7cfaiMzf7fa5+icEmAyPH+OeD48Q7Tb9a02oV2anaEO2ed4eWyaEpMJ2FRm/2WEdzU+e
        tpZ9QxwqHDedNrfp7E7sZDfYPfJgNwq+0RMZ6t8mmKvK42MJuIQIL+yEGI4vgC8qPuwOuFgOJalTm
        pcAgXmi3Erb2xhoErSz/fm84DLDPRynDbGbQ5pgdgXS53L2uhmgqym1lZ+mBWIaWTlTf8/zrj6IUL
        xNleP0tpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if190-0003sf-JO; Wed, 11 Dec 2019 12:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A6D8305E21;
        Wed, 11 Dec 2019 13:29:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 184BC2026E819; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211120713.360281197@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 00/17] Fixup page directory freeing
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

Also included are some patches that rename/document some of the mmu gather
options.

