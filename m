Return-Path: <linux-arch+bounces-4223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965C58BD443
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 20:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69041C20EB9
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5A3158844;
	Mon,  6 May 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7MAKZ6s"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112D1586F6;
	Mon,  6 May 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018444; cv=none; b=RAfsnX/BqoaRLThAyeaCtYCl74cohYihrNhquC5LEe8ZnfmrYWzc3wA0knHpFUdHzPsbtafHAq6uAbmLbHTv0DZUfikdGlU0ZxwICW2Uc6e1TlhS4fbGjcfWj8nx26tRqpOL7Kef5rWm8cHZlHLf5iwzmCvVtzsFRfmkjfzteeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018444; c=relaxed/simple;
	bh=E4hbksdLHR9sHb2ZSc5jxVRHZXCWdBpad5C427cdk04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTAlm9nMe9GE+0sfJXTZ8MjJ/feOuogjE2f3KpvVmqCyd0ybYAjFHgVRA9d1mtbb+a3MExpD4A4K9vPS0bLAiZqIwqeQGoEpaTSdePBYKoOMJ7PPMRniWhorEiPUxzktAEo8GWbVYVqE/mCG9jtOon2D6cQ1pZa7OgmxQ8eEeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7MAKZ6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AD2C4AF65;
	Mon,  6 May 2024 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715018443;
	bh=E4hbksdLHR9sHb2ZSc5jxVRHZXCWdBpad5C427cdk04=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=H7MAKZ6sSZCaWpWOiPH6SFvlmEfZPnKvzhqE9Lo89A9/yP3lbXAB5x5ohwrCAjTtf
	 q3AholZWwc5yrCvc9qvQlk9KuaDzY/Yux6LeMsd7jHHgGtq5HOlN3luNSk/UwS0sdv
	 EPmsQUTY2u5wwmgq/SusblpzIVFO4zcAq0raksZAqUgkCsE1C+Un8/WoYpsBHB2Lr2
	 cL8cxNhv6CInqxZf3RBnkGd0C0wh1tnZoic8cIgPvHmQsY5rOJB3MjISc+3vmjb3fM
	 04Q4xf3PPKDL+ZRGS+M+kp0WvIuoBAYvRNmGpZ8vEEm21yep98uJ54LOwVFIcLjKBr
	 EcOYtlPqWUfMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D5335CE0C56; Mon,  6 May 2024 11:00:42 -0700 (PDT)
Date: Mon, 6 May 2024 11:00:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
Message-ID: <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
 <20240501232132.1785861-2-paulmck@kernel.org>
 <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
 <16381d02-cb70-4ae5-b24e-aa73afad9aed@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16381d02-cb70-4ae5-b24e-aa73afad9aed@huaweicloud.com>

On Mon, May 06, 2024 at 06:30:45PM +0200, Jonas Oberhauser wrote:
> Am 5/6/2024 um 12:05 PM schrieb Jonas Oberhauser:
> > Am 5/2/2024 um 1:21 AM schrieb Paul E. McKenney:
> > > This commit adds four litmus tests showing that a failing cmpxchg()
> > > operation is unordered unless followed by an smp_mb__after_atomic()
> > > operation.
> > 
> > So far, my understanding was that all RMW operations without suffix
> > (xchg(), cmpxchg(), ...) will be interpreted as F[Mb];...;F[Mb].
> > 
> > I guess this shows again how important it is to model these full
> > barriers explicitly inside the cat model, instead of relying on implicit
> > conversions internal to herd.
> > 
> > I'd like to propose a patch to this effect.
> > 
> > What is the intended behavior of a failed cmpxchg()? Is it the same as a
> > relaxed one?

Yes, and unless I am too confused, LKMM currently does implement this.
Please let me know if I am missing something.

> > My suggestion would be in the direction of marking read and write events
> > of these operations as Mb, and then defining
> > 
> > (* full barrier events that appear in non-failing RMW *)
> > let RMW_MB = Mb & (dom(rmw) | range(rmw))
> > 
> > 
> > let mb =
> >      [M] ; fencerel(Mb) ; [M]
> >    | [M] ; (po \ rmw) ; [RMW_MB] ; po^? ; [M]
> >    | [M] ; po^? ; [RMW_MB] ; (po \ rmw) ; [M]
> >    | ...
> > 
> > The po \ rmw is because ordering is not provided internally of the rmw
> 
> (removed the unnecessary si since LKMM is still non-mixed-accesses)

Addition of mixed-access support would be quite welcome!

> This could also be written with a single rule:
> 
>      | [M] ; (po \ rmw) & (po^?; [RMW_MB] ; po^?) ; [M]
> 
> > I suspect that after we added [rmw] sequences it could perhaps be
> > simplified [...]
> 
> No, my suspicion is wrong - this would incorrectly let full-barrier RMWs
> act like strong fences when they appear in an rmw sequence.
> 
>  if (z==1)  ||  x = 2;     ||  xchg(&y,2)  || if (y==2)
>    x = 1;   ||  y =_rel 1; ||              ||    z=1;
> 
> 
> right now, we allow x=2 overwriting x=1 (in case the last thread does not
> propagate x=2 along with z=1) because on power, the xchg might be
> implemented with a sync that doesn't get executed until the very end
> of the program run.
> 
> 
> Instead of its negative form (everything other than inside the rmw),
> it could also be rewritten positively. Here's a somewhat short form:
> 
> let mb =
>      [M] ; fencerel(Mb) ; [M]
>    (* everything across a full barrier RMW is ordered. This includes up to
> one event inside the RMW. *)
>    | [M] ; po ; [RMW_MB] ; po ; [M]
>    (* full barrier RMW writes are ordered with everything behind the RMW *)
>    | [W & RMW_MB] ; po ; [M]
>    (* full barrier RMW reads are ordered with everything before the RMW *)
>    | [M] ; po ; [R & RMW_MB]
>    | ...

Does this produce the results expected by the litmus tests in the Linux
kernel source tree and also those at https://github.com/paulmckrcu/litmus?

							Thanx, Paul

