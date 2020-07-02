Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C195B211EC7
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 10:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgGBI2v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 04:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGBI2v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 04:28:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BFDC08C5C1;
        Thu,  2 Jul 2020 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1j2DrlcbUugnfL/BNKwgbBGwdXe1p5YiDNDgH1lziiA=; b=Gw3bFkBiw7lSr8XB4zKQSY2gM3
        tJk/ji3zgpfflj/zaSGFhyr7KMwLj+Oe+0Sm+KHfgrWViOHfPxx7b/QpCRZnd7QyWyLqPOjt5u4M+
        VT2c7Tj/WbWZ13AD1/9R0UzoNtp4d+F1m8batuj5Xl7qdQTZYJNIcpd7a6z0ADN51FPDOud+x2inb
        vaWHcRWO38JcCO7v+Lm2XkFcXbg2GQMLv/ahw7WmAbTz34o8N8P/o1BFnXY9TMJge7Bqawg2gEdUW
        veyOYqGH2bZGaUNyWTxK59SurZc9DII4ezuMOTRrJmJ1ycOYDis9O0xqtG1x7WpxmweqV5UnoKy94
        H7QDMhfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jquaH-0000Gw-TV; Thu, 02 Jul 2020 08:28:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CDA230015A;
        Thu,  2 Jul 2020 10:28:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AA3620CC68A2; Thu,  2 Jul 2020 10:28:40 +0200 (CEST)
Date:   Thu, 2 Jul 2020 10:28:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/8] powerpc/pseries: use smp_rmb() in H_CONFER spin yield
Message-ID: <20200702082840.GC4781@hirez.programming.kicks-ass.net>
References: <20200702074839.1057733-1-npiggin@gmail.com>
 <20200702074839.1057733-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702074839.1057733-3-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 02, 2020 at 05:48:33PM +1000, Nicholas Piggin wrote:
> There is no need for rmb(), this allows faster lwsync here.

Since you determined this; I'm thinking you actually understand the
ordering here. How about recording this understanding in a comment?

Also, should the lock->slock load not use READ_ONCE() ?

