Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D993638FB67
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhEYHKf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 03:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEYHKf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 May 2021 03:10:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A942C061574;
        Tue, 25 May 2021 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dhjMzEWRpEYCggzzWYWrO4NWQua4Pzy2IDHhRpCzSjQ=; b=IsVkGtA5ZB8YFvH3U7Ozmpf981
        WwMu0lFeJ0raouKk6e2vDzvcl2Sa2JPGsHdv4CXl6cahCfQhnH3szKQVryfowloRe2sLxnCFuc00T
        NF04BRtlyh+n/DNNPXkDAr9Zx2akQSc/zh6DY+tSpGeQhIpPYNBmLk0nbE7VFQMfSxyb0+5Z/HqVA
        mevdbYvjKWgtCfdjIJY2rgKGpL3N3/mISgk/iyMgu2NDEQ/HsVmf+Og08XZQcqmvKv2dQmxApCidv
        gxqemhfZUkTrSaL1wxFiRDRc3zUVoFX9nY9kZupiRZdiSsIfgYXY3NX5oNb+ZUIJG2GSGADGA51aj
        a5+Kzp2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llRAr-003DRO-En; Tue, 25 May 2021 07:08:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11E803001E4;
        Tue, 25 May 2021 09:08:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0084731474567; Tue, 25 May 2021 09:08:20 +0200 (CEST)
Date:   Tue, 25 May 2021 09:08:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
Message-ID: <YKyiZBAGcbGMEjTc@hirez.programming.kicks-ass.net>
References: <20210524224150.8009-1-rdunlap@infradead.org>
 <3398848.TK9RqziN78@ubuntu-mate-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3398848.TK9RqziN78@ubuntu-mate-laptop>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 11:31:22PM -0400, Julian Braha wrote:
> Hi Randy,
> 
> It seems I introduced a new unmet dependency bug
> in my attempt to fix one :/
> 
> Anyway, I don't see why the dependency on FRAME_POINTER
> was necessary in the first place, so LGTM.

It might have been an attempt at ensuring sane backtraces; but I didn't
dig into the history of the thing. Either way around, it's fairly
out-dated if that was indeed the case.
