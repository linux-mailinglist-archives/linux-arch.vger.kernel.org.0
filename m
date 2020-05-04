Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF32D1C361C
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgEDJub (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 05:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgEDJub (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 May 2020 05:50:31 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC1A20658;
        Mon,  4 May 2020 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588585830;
        bh=Bh0hYmUAkybjdtHios46zxKUR1jzmBVcRcfTV9uaIxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1Yvexcu060UzPkysOQn8KkvaiuhPTx3OlDDJ4n7iR6qLFGSIFLNhoP0zlt6K4fNfb
         lkVQEKQyK6XJAPHc039ExjCvW7rir/ItmQLdKWTYhfnd4DNEA9/fohdB20M83PkwVZ
         FzkhEJVzf8oPabT0zCTq78jAS4v2x9g7xPo1nEaQ=
Date:   Mon, 4 May 2020 11:50:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        David Howells <dhowells@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/14] Move the ReST files from Documentation/*.txt
Message-ID: <20200504115023.2ead040f@coco.lan>
In-Reply-To: <9f79e15a-4e36-3747-51fc-ca2d8ab616b7@gmail.com>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <9f79e15a-4e36-3747-51fc-ca2d8ab616b7@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Mon, 4 May 2020 18:25:51 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> (CC to documentation, get_maintainer, and LKMM maintainers)
> 
> Hi Mauro,
> 
> As I didn't receive "[PATCH 12/14] docs: move remaining stuff under
> Documentation/*.txt to Documentation/staging", I'm replying to
> [PATCH 00/14].
>
> diff stat above shows you are not moving Documentation/atomic_bitops.txt in
> this series. However, PATCH 12/14 contains the following hunks:
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1aa6e89e7424..8aa8f7c0db93 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS  
> [...]
> > @@ -9855,7 +9855,7 @@ L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> > -F:	Documentation/atomic_bitops.txt
> > +F:	Documentation/staging/atomic_bitops.txt
> >  F:	Documentation/atomic_t.txt
> >  F:	Documentation/core-api/atomic_ops.rst
> >  F:	Documentation/core-api/refcount-vs-atomic.rst  
> 
> [...]
> 
> > diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
> > index dd90c9792909..edeeb8375006 100644
> > --- a/include/asm-generic/bitops/atomic.h
> > +++ b/include/asm-generic/bitops/atomic.h
> > @@ -8,7 +8,7 @@
> >  
> >  /*
> >   * Implementation of atomic bitops using atomic-fetch ops.
> > - * See Documentation/atomic_bitops.txt for details.
> > + * See Documentation/staging/atomic_bitops.txt for details.
> >   */
> >  
> >  static inline void set_bit(unsigned int nr, volatile unsigned long *p)  
> 
> Please drop them.

Thanks for pointing! Yeah, I noticed that too from Joe's review.
Already dropped locally. I'll post a new version without such change.


Thanks,
Mauro
