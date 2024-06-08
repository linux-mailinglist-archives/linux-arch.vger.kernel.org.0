Return-Path: <linux-arch+bounces-4756-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59623901269
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2024 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75CDB21A0B
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2024 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173517B4FE;
	Sat,  8 Jun 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9iTnJW1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966B1E888;
	Sat,  8 Jun 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717861727; cv=none; b=jBP8Q0kO7mHehfoiikzSdIdrFOFUExJeE9n71tA2Nqon2chawCfdChfVqi14bRC2ylvgz9O3nQTlgTDhZKFzWjjxxdJ/CrwnPdchc+qcrNEqO5sF40XkrQNZhiwu9tUxWglTkGk3/J3yfcM5A5JEyzmVgZzC3i3H7R7GRIkrANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717861727; c=relaxed/simple;
	bh=3p3kxCe/yhGV0q146IRm30LBrdx5GWV65OqRWxDa644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmC69hgRHqBOmrbA5+qsC6/CjjHJ3J4rsO0kEpnbDWP9rM6oMFKjQIvwgGdlarwWvLU8CrJ4a0HxjXxmeLa29eOVuAkmtu3YEsLgGk9Ov5TY3RYIEWlI6CxtvTI+bG/0altAH3L9ZDQxw18XCOQ4mSMTPrB17PsNdIaErx/57G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9iTnJW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEBCC32781;
	Sat,  8 Jun 2024 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717861726;
	bh=3p3kxCe/yhGV0q146IRm30LBrdx5GWV65OqRWxDa644=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=i9iTnJW1vgPwDQx57ApoXYc9y4CZkj12TYUblreb2RUJQjmkEK4ThrX2dfODGjUcK
	 jZeTQo+ztRwSue2+nuMM/pul0jQRVLy8ryhfUPZmV924bHQOeayMw6Y/G6eLPPmlzP
	 yE+u1liBfLzXRpOGD+eqMKRZoHJ/1iB4Y2r4QjZqhDfdpdcj1lSFjO3XDGWks5LiIa
	 aH5BB7QloSrhf2Z4Thv7lxUg9o3hPuDEdYHQAE3xxW+bPTsiyXN+Sb5MK8dyllUPps
	 0anRM9maFxEhmetGjQ4FEGaGh2VN/WP04ueKz4ajwZSWjOHLn5qSyZnxiZqbJU9JY+
	 qcO94RFcuAxUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46920CE0C16; Sat,  8 Jun 2024 08:48:46 -0700 (PDT)
Date: Sat, 8 Jun 2024 08:48:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	Marco Elver <elver@google.com>, Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF
 mentorship session citation
Message-ID: <6bb5f789-f143-493c-a804-62b7c81dabb0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-3-paulmck@kernel.org>
 <42fa4660-b3bf-4d09-bbad-064f9d4cc727@gmail.com>
 <f11f7230-7c16-45a3-83be-9aba32e10a3b@paulmck-laptop>
 <3c5a53e2-b5a9-4197-97a3-247abb7f3061@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5a53e2-b5a9-4197-97a3-247abb7f3061@gmail.com>

On Sat, Jun 08, 2024 at 08:38:12AM +0900, Akira Yokosawa wrote:
> On 2024/06/05 13:02, Paul E. McKenney wrote:
> > On Wed, Jun 05, 2024 at 10:57:27AM +0900, Akira Yokosawa wrote:
> >> On Tue,  4 Jun 2024 15:14:19 -0700, Paul E. McKenney wrote:
> >>> Add a citation to Marco's LF mentorship session presentation entitled
> >>> "The Kernel Concurrency Sanitizer"
> >>>
> >>> [ paulmck: Apply Marco Elver feedback. ]
> >>>
> >>> Reported-by: Marco Elver <elver@google.com>
> >>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>> Cc: Alan Stern <stern@rowland.harvard.edu>
> >>> Cc: Andrea Parri <parri.andrea@gmail.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Boqun Feng <boqun.feng@gmail.com>
> >>> Cc: Nicholas Piggin <npiggin@gmail.com>
> >>> Cc: David Howells <dhowells@redhat.com>
> >>> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> >>> Cc: Luc Maranget <luc.maranget@inria.fr>
> >>> Cc: Akira Yokosawa <akiyks@gmail.com>
> >>
> >> Paul,
> >>
> >> While reviewing this, I noticed that
> >> tools/memory-model/Documentation/README has no mention of
> >> access-marking.txt.
> >>
> >> It has no mention of glossary.txt or locking.txt, either.
> >>
> >> I'm not sure where are the right places in README for them.
> >> Can you update it in a follow-up change?
> >>
> >> Anyway, for this change,
> >>
> >> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> > 
> > Thank you, and good catch!  Does the patch below look appropriate?
> 
> Well, I must say this is not what I expected.
> Please see below.

OK, I was clearly in way too much of a hurry when doing this, and please
accept my apologies for my inattention.  I am therefore going to do
what I should have done in the first place, which is to ask you if you
would like to send a patch fixing this.  If so, I would be quite happy
to replace mine with yours.

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > commit 834b22ba762fb59024843a64554d38409aaa82ec
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Jun 4 20:59:35 2024 -0700
> > 
> >     tools/memory-model: Add access-marking.txt to README
> >     
> >     Given that access-marking.txt exists, this commit makes it easier to find.
> >     
> >     Reported-by: Akira Yokosawa <akiyks@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> > index db90a26dbdf40..304162743a5b8 100644
> > --- a/tools/memory-model/Documentation/README
> > +++ b/tools/memory-model/Documentation/README
> > @@ -47,6 +47,10 @@ DESCRIPTION OF FILES
> >  README
> >  	This file.
> >  
> > +access-marking.txt
> > +	Guidelines for marking intentionally concurrent accesses to
> > +	shared memory.
> > +
> >  cheatsheet.txt
> >  	Quick-reference guide to the Linux-kernel memory model.
> >
> 
> What I expected was an entry in the bullet list in the upper half
> of README which mentions access-marking.txt along with the update of
> alphabetical list of files.
> 
> Updating the latter wouldn't worth bothering you.
> 
> And you are missing another comment WRT glossary.txt and locking.txt. ;-)
> 
> Let me suggest an idea of their positions in the bullet list where the
> ordering is important.  Looks reasonable to you ?
> 
>   o   simple.txt
>   o   ordering.txt
>   o   locking.txt               <--new
>   o   litmus-test.txt
>   o   recipes.txt
>   o   control-dependencies.txt
>   o   access-marking.txt        <--new
>   o   cheatsheet.txt
>   o   explanation.txt
>   o   references.txt
>   o   glossary.txt              <--new
> 
> Have I made my point clear enough?
> 
>         Thanks, Akira

