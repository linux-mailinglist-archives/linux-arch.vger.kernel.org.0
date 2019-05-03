Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19113245
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfECQeO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 12:34:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfECQeO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 12:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f8wSjJ87f85s5sybHGpZ4OlS7anrKlXCSX6wnmocWaQ=; b=nPlN06eYiVMd4BhKWEoEltJe1
        vjzyN8kpvtiCH1EQrdhcogrwESSz+S8qU6Sn7tOEPrXod1jpE7u95MMYWKCD726B8WC6/PMoQwhV1
        AnNhHauYZVDaDpoXzfOL0V1iVW9iZ5Iq6/NHI2tGzPvQMZsRbhM6KEL5A/9XylkKdDOzLs7B0Xz5y
        Khvu9nxVpLFEuyjDQGIaQobcabArOPrtMt9NJBYUd+iXI1g512MiCD4RDfNxsevt2IT749vge3Xgb
        isvwpO7MAG1dqOdncnaBP0JBZQNDOpnzhAx5jerNuy4Vl/fT4GlJUdkTAl3AtJtIIagrsP3mRME2G
        qY6UkwKcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMb8X-00068T-3j; Fri, 03 May 2019 16:34:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98487286B6529; Fri,  3 May 2019 18:34:11 +0200 (CEST)
Date:   Fri, 3 May 2019 18:34:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: f68f031d ("Documentation: atomic_t.txt: Explain ordering
 provided by smp_mb__{before,after}_atomic()")
Message-ID: <20190503163411.GH2606@hirez.programming.kicks-ass.net>
References: <20190503151915.GD2606@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1905031216310.1437-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1905031216310.1437-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 03, 2019 at 12:19:21PM -0400, Alan Stern wrote:
> On Fri, 3 May 2019, Peter Zijlstra wrote:
> 
> > On Fri, May 03, 2019 at 07:53:26AM -0700, Paul E. McKenney wrote:
> > > Hello, Alan,
> > > 
> > > Just following up on the -rcu commit below.  I believe that it needs
> > > some adjustment given Peter Zijlstra's addition of "memory" to the x86
> > > non-value-returning atomics, but thought I should double-check.
> > 
> > Right; I should get back to that thread...
> 
> The real question, still outstanding, is whether smp_mb__before_atomic 
> orders anything following the RMW instruction (and similarly, whether 
> smp_mb__after_atomic orders anything preceding the RMW instruction).

Yes -- that was very much the intent, and only (some) x86 ops and (some)
MIPS config have issues with that.
