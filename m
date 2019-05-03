Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95F71310F
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfECPTT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 11:19:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECPTT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 11:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wBcs/GPdYlZGvq1t4SvrIDHfNZxY4cOY/VusREli/MY=; b=gfQANTdrHNW5l6B5vDi2+yPJn
        zx0Tt2OIg7XKWWRb2JhOCiSxvrLuOEHiPTkzP5AKuPlhrM8RNQAmqctsTp8600c9KoBEnrnAY6Gyr
        IvKi/GUHjKTCfhBFbSTm8sMJDmEqVe3fI04Dad0NlXyDuFKvkYZ/9TZS2YCKNyLGdIu46Kg+RGsO4
        hME5IV3Vz+bJSP2TWL2lwvI6v9XI4udZikrHffj82dDrSPe5M4sd4rJLy931EBmlRIIu3BOceUTbs
        yhP2wue+1e/DPkhqFcZFgmJDrdmsGnGZLC/9LcLkYwM2D83YVMZ8nm52Qepqd9nHJt0YmieimA7f1
        LGIoVe3Xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMZy1-00068f-85; Fri, 03 May 2019 15:19:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15A2E29B7D6A1; Fri,  3 May 2019 17:19:15 +0200 (CEST)
Date:   Fri, 3 May 2019 17:19:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: f68f031d ("Documentation: atomic_t.txt: Explain ordering
 provided by smp_mb__{before,after}_atomic()")
Message-ID: <20190503151915.GD2606@hirez.programming.kicks-ass.net>
References: <20190503145326.GA21541@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503145326.GA21541@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 03, 2019 at 07:53:26AM -0700, Paul E. McKenney wrote:
> Hello, Alan,
> 
> Just following up on the -rcu commit below.  I believe that it needs
> some adjustment given Peter Zijlstra's addition of "memory" to the x86
> non-value-returning atomics, but thought I should double-check.

Right; I should get back to that thread...
