Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03016283A97
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgJEPfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgJEPfc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 11:35:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44BC0613CE;
        Mon,  5 Oct 2020 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vS9qnX+J6NAaHezm+oFfmXrdFmYZbN3sVo5ZH5k3my4=; b=cd5xEmSZeFUOf1VgpMSRZHg4S5
        dVTqg/PaJ8o1nAMmxYa2aHyYjWi1CvmJ1jtQRRdbbClGUe+IVQ1qcZVTTogBcoUYbbnFEVbv45g8H
        wcAPouh5IwsgN5O/iqXJctI1nHsIFoIXsLu/7RwOPgjbKLShOdNMjpI8klC02iHCfxbmjF4WhgWjX
        hVMYz+7ZTqDShE5gL0ZHvY78lF/E2cke3NxR0i5JpXkEI8i0bNqt0cDOOtN1wTQxrEvM89P+F1D44
        mneP4e4lFMDXrc0G/KUtdHbIQnHGDY9TXP9wTd0Yd2z/eTzvvUQHkKbHMWZj4+8B8kd0s7aXRT5hL
        1ArjKo8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPSWG-0002Xu-Ez; Mon, 05 Oct 2020 15:35:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FA6F30768E;
        Mon,  5 Oct 2020 17:35:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 442A620C19001; Mon,  5 Oct 2020 17:35:19 +0200 (CEST)
Date:   Mon, 5 Oct 2020 17:35:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005153519.GJ2628@hirez.programming.kicks-ass.net>
References: <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <20201005023846.GA359428@rowland.harvard.edu>
 <20201005082002.GA23216@willie-the-truck>
 <20201005091247.GA23575@willie-the-truck>
 <20201005142351.GB376584@rowland.harvard.edu>
 <20201005151313.GA23892@willie-the-truck>
 <20201005151639.GE376584@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005151639.GE376584@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 11:16:39AM -0400, Alan Stern wrote:
> On Mon, Oct 05, 2020 at 04:13:13PM +0100, Will Deacon wrote:
> > > The failure to recognize the dependency in P0 should be considered a 
> > > combined limitation of the memory model and herd7.  It's not a simple 
> > > mistake that can be fixed by a small rewrite of herd7; rather it's a 
> > > deliberate choice we made based on herd7's inherent design.  We 
> > > explicitly said that control dependencies extend only to the code in the 
> > > branches of an "if" statement; anything beyond the end of the statement 
> > > is not considered to be dependent.
> > 
> > Interesting. How does this interact with loops that are conditionally broken
> > out of, e.g.  a relaxed cmpxchg() loop or an smp_cond_load_relaxed() call
> > prior to a WRITE_ONCE()?
> 
> Heh --  We finesse this issue by not supporting loops at all!  :-)

Right, so something like:

	smp_cond_load_relaxed(x, !VAL);
	WRITE_ONCE(*y, 1);

Would be modeled like:

	r1 = READ_ONCE(*x);
	if (!r1)
		WRITE_ONCE(*y, 1);

with an r1==0 constraint in the condition I suppose ?
