Return-Path: <linux-arch+bounces-4760-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB0D90144E
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 05:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617A8282168
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 03:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0B86139;
	Sun,  9 Jun 2024 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXyQR9NU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723334C79;
	Sun,  9 Jun 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717902659; cv=none; b=XYWQOmdC+RrjW2424jN94bdWFlNHhIIxED8vPLGMT+dLcvWuL+KbnMPDyRQQSDQ6mXMldEwPjWxLGtC4/De4dN3kJZ4c4h510KiNevXAerVYqVAWXeh5H9XC4PYmYH8ZK2oAC0RcnuMbP7C/atKNfAdBHrBwK0wAKzEUF93ezQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717902659; c=relaxed/simple;
	bh=5D9tJLK8Yxi2FMWVVXhn5pe1Qnp5Kh/4GRapemA6eRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YouEPp5cNGwD+DpqeDgPTsUbh56PBN3RPKCSzxl7CBeSv/X1SwjIVmHBLlLwmP+r2QhUJWRGMGnPYuJrvuCrPNhWaE7OXdnynjfNhOPqvD84A5+8ccOUow3K4UWh286j4tQHhMx59SYvA1S/TvmhloSwQRaoU0H2oH2PirEXP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXyQR9NU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA42C4AF1C;
	Sun,  9 Jun 2024 03:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717902658;
	bh=5D9tJLK8Yxi2FMWVVXhn5pe1Qnp5Kh/4GRapemA6eRg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZXyQR9NUUiCecQY26AiSDvnRho0aiOSYjN69b9ADzgqWzIzf+elOuL87JEbD0BYR3
	 cP4kipaKzxodyHO5BAfc/dzGzUb/h3D8epa8eLmLplmB0vSCHtEaM5hKz0Z3rOYqS6
	 rUoJKXLlzQejoQN1Un8ffsY3JpWN0vag8uJHkZu1AirTO1JOyXWnsE/3KUaLeuOuz9
	 1GN63VTrTCNIVZucSqO6ICkpv+FYdKzN4+QSgoJIk1L6maCZismCYIhNyOVJfEO5sY
	 zcU2DwL7cO0hMPQrQ8if7X4K9dKYp17GVy7ZJTClN9Bv693OLWnLcaVESzByPP3AFM
	 k5jS7GfwUhMpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5AB57CE0F92; Sat,  8 Jun 2024 20:10:58 -0700 (PDT)
Date: Sat, 8 Jun 2024 20:10:58 -0700
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
Message-ID: <fbb89aa4-3e1c-42bf-8202-4f35e2dcb17b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-3-paulmck@kernel.org>
 <42fa4660-b3bf-4d09-bbad-064f9d4cc727@gmail.com>
 <f11f7230-7c16-45a3-83be-9aba32e10a3b@paulmck-laptop>
 <3c5a53e2-b5a9-4197-97a3-247abb7f3061@gmail.com>
 <6bb5f789-f143-493c-a804-62b7c81dabb0@paulmck-laptop>
 <a3ff0522-fd2d-4c87-9c7b-00cbdd5f3c68@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ff0522-fd2d-4c87-9c7b-00cbdd5f3c68@gmail.com>

On Sun, Jun 09, 2024 at 09:04:14AM +0900, Akira Yokosawa wrote:
> On 2024/06/09 0:48, Paul E. McKenney wrote:
> > On Sat, Jun 08, 2024 at 08:38:12AM +0900, Akira Yokosawa wrote:
> >> On 2024/06/05 13:02, Paul E. McKenney wrote:
> >>> On Wed, Jun 05, 2024 at 10:57:27AM +0900, Akira Yokosawa wrote:
> >>>> On Tue,  4 Jun 2024 15:14:19 -0700, Paul E. McKenney wrote:
> >>>>> Add a citation to Marco's LF mentorship session presentation entitled
> >>>>> "The Kernel Concurrency Sanitizer"
> >>>>>
> >>>>> [ paulmck: Apply Marco Elver feedback. ]
> >>>>>
> >>>>> Reported-by: Marco Elver <elver@google.com>
> >>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>>>> Cc: Alan Stern <stern@rowland.harvard.edu>
> >>>>> Cc: Andrea Parri <parri.andrea@gmail.com>
> >>>>> Cc: Will Deacon <will@kernel.org>
> >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
> >>>>> Cc: Nicholas Piggin <npiggin@gmail.com>
> >>>>> Cc: David Howells <dhowells@redhat.com>
> >>>>> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> >>>>> Cc: Luc Maranget <luc.maranget@inria.fr>
> >>>>> Cc: Akira Yokosawa <akiyks@gmail.com>
> >>>>
> >>>> Paul,
> >>>>
> >>>> While reviewing this, I noticed that
> >>>> tools/memory-model/Documentation/README has no mention of
> >>>> access-marking.txt.
> >>>>
> >>>> It has no mention of glossary.txt or locking.txt, either.
> >>>>
> >>>> I'm not sure where are the right places in README for them.
> >>>> Can you update it in a follow-up change?
> >>>>
> >>>> Anyway, for this change,
> >>>>
> >>>> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> >>>
> >>> Thank you, and good catch!  Does the patch below look appropriate?
> >>
> >> Well, I must say this is not what I expected.
> >> Please see below.
> > 
> > OK, I was clearly in way too much of a hurry when doing this, and please
> > accept my apologies for my inattention.  I am therefore going to do
> > what I should have done in the first place, which is to ask you if you
> > would like to send a patch fixing this.  If so, I would be quite happy
> > to replace mine with yours.
> 
> OK.
> I think I can submit a draft patch after fixing perfbook's build error
> caused by changes in core LaTeX packages released last week.

Ouch!  Thank you for keeping up with this!

> Can you wait for a while ?

No hurry here.  It has been this way for some years, so a little while
longer is not a disaster.

							Thanx, Paul

