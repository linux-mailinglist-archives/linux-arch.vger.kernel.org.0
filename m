Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B102ECE98
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 12:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhAGLUY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 06:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbhAGLUY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 06:20:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969B8C0612F4;
        Thu,  7 Jan 2021 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OaPgUI5aCCYZQI5vszvvf5IbsCgMfnpkhzevE0JkHCg=; b=IqMv68P+0jpey0fzZ2N7VF5J0c
        +L6n+CHvNdfG/kIP9nSZwYPxAJ8845r1RWz+LYvGkHdRK4gsZOa8Kdduzx3/MzGNN9F/cmC3hY9Xh
        H/k0ui/EotgpzaVCqeDsSVJDevd+hbrEf1roXh7bNuatFoRaR1XUFHsUfuJMtJBMEKL0SZ1RwD3tC
        +FvDUxIKEkVBUystdkRrTilwb3iJcNGpE2v1lP108klPNUzFh12n0aQG1W14x/rZDgTXhJ6BHr5CZ
        t4lp82RVBz6/Qw1NrnFqHYha8VShHtXEsgcY61ub/lWvzEFFk4yCrrnp80NGV8SI1M41GYbKaiQzk
        QGBk9MuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxTJr-003JrH-MO; Thu, 07 Jan 2021 11:19:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 996513060AE;
        Thu,  7 Jan 2021 12:19:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F47220164737; Thu,  7 Jan 2021 12:19:04 +0100 (CET)
Date:   Thu, 7 Jan 2021 12:19:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/5] csky: Remove custom asm/atomic.h implementation
Message-ID: <X/buKPr5OCH3C32J@hirez.programming.kicks-ass.net>
References: <1608478763-60148-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608478763-60148-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Dec 20, 2020 at 03:39:19PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Use generic atomic implementation based on cmpxchg. So remove csky
> asm/atomic.h.

Clarification would be good. Typically cmpxchg() loops perform
sub-optimal on LL/SC architectures, due to the double loop construction.
