Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC541E894B
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgE2Uxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE2Uxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 16:53:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF686C03E969;
        Fri, 29 May 2020 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6nnpKQ78aF/xhKEUVRrmt4yxxhj1GTVxNLuwok3N+bc=; b=IQaWs8OREKI3KCKjJJReDHgeP2
        /B9o2SCenhLoFC955fx8N8oXk8MK5T23dO5W07voFMuxVTFBhLVnmXl+CKy15WDYUCFleb17WuIIo
        HSv3WM7NX/sLsKG/JOdedYW0GaOVQ5mNc3v6LBnPxWMdsnXDp4O/rOvtNATTjISUqMs/zmQxrTC7X
        Qmezao7kSCjI2BdMCuqTENeTDaSs17eYrEXpO7ODtB7X0l2vBiOQwax/gSYW6yFNMoz3qPiPxSj9u
        Lf46T1dSHd+0RDbRwcBBsMe+w6VDCsFWEPhzzN/YnvNuFMlD5glrq5eKAvMdfxd8C9DwCrr6myXmO
        OZ0iF66Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jem0V-0007Vh-7h; Fri, 29 May 2020 20:53:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE2A69834CF; Fri, 29 May 2020 22:53:31 +0200 (CEST)
Date:   Fri, 29 May 2020 22:53:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>,
        dlustig@nvidia.com, open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200529205331.GV2483@worktop.programming.kicks-ass.net>
References: <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72>
 <20200528220047.GB211369@google.com>
 <20200528221659.GS2483@worktop.programming.kicks-ass.net>
 <CAEf4BzYf6jjrStc08R1bDASFyEdKj6vYg_MOaipUJ3vbdqNrSg@mail.gmail.com>
 <20200529123626.GL706495@hirez.programming.kicks-ass.net>
 <CAEf4Bzb9D1jTdmUzopc35qmFopaW-UfvLO9ohFsFsBuLVm0ZCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb9D1jTdmUzopc35qmFopaW-UfvLO9ohFsFsBuLVm0ZCw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 29, 2020 at 01:01:51PM -0700, Andrii Nakryiko wrote:

> > question though; why are you using xchg() for the commit? Isn't that
> > more expensive than it should be?
> >
> > That is, why isn't that:
> >
> >   smp_store_release(&hdr->len, new_len);
> >
> > ? Or are you needing the smp_mb() for the store->load ordering for the
> > ->consumer_pos load? That really needs a comment.
> 
> Yeah, smp_store_release() is not strong enough, this memory barrier is
> necessary. And yeah, I'll follow up with some more comments, that's
> been what Joel requested as well.

Ok, great.

> > I think you can get rid of the smp_load_acquire() there, you're ordering
> > a load->store and could rely on the branch to do that:
> >
> >         cons_pos = READ_ONCE(&rb->consumer_pos) & rb->mask;
> >         if ((flags & BPF_RB_FORCE_WAKEUP) || (cons_pos == rec_pos && !(flags &BPF_RB_NO_WAKEUP))
> >                 irq_work_queue(&rq->work);
> >
> > should be a control dependency.
> 
> Could be. I tried to keep consistent
> smp_load_acquire/smp_store_release usage to keep it simpler. It might
> not be the absolutely minimal amount of ordering that would still be
> correct. We might be able to tweak and tune this without changing
> correctness.

We can even rely on the irq_work_queue() being an atomic, but sure, get
it all working and correct first before you wreck it ;-)
