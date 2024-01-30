Return-Path: <linux-arch+bounces-1866-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A965842B58
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 18:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA42D283FFE
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1786157E8C;
	Tue, 30 Jan 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na+L/uRN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4319157E84;
	Tue, 30 Jan 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637520; cv=none; b=K1qwggkm1VPz8t9NmXFbG9pwx2waCYdBuDsIa7dhrgZ2YwRqBIXyn96M/gZb1yClwU4m4Wy2ePlvuvc1HO6Aa9s+PUfP01usz142HCSafRl5F6m5guxp0O4SmwUhl6t9OHNL59RoXdnihaigHu75T3ibYH4PfUC/INt/NQmaYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637520; c=relaxed/simple;
	bh=yXMMtnxUsKg0X6iL7HcedZmBBWU1t0iBPBqV3q7qVo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf9FgoWLpWKCJUFTkbSll+3Z3PEK3mi6cFSfx7AmeYJ4dpuscOraeuaKLzi7kR3VoQMqnKEezRUGeeDoEndHme3tgwMyjS7P3e2HqV7SMMTKCaJQKp/Jr/59MWZxw+FRm8HSVJKQhbdsat4q8XZIGlBNm4IkST5L4XmVIbWkCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na+L/uRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C444C4166C;
	Tue, 30 Jan 2024 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637520;
	bh=yXMMtnxUsKg0X6iL7HcedZmBBWU1t0iBPBqV3q7qVo0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=na+L/uRNaFh2JgRdTF3pQDaETM6d+oaE29FxkaizaKiEgPjyuL0AdGNi7Vw8YKIUX
	 FxbvS3afblTtrhntqsndz+QpYU4Cp5h80pxx9MNnjPoMoMXoDFBd06UCSriPsR/jzZ
	 fDX+zxxbgxqW4CAx6Yqmrt+XXE0WSJh1vlGyTsdaGPpWxbwcj8O7rrUsZngwZq4qVY
	 hmoeLC0KvTFOa6shLX3fcqCn6pVc+MNHDhnPBfJP2zEPVvBv5u/QqSdfj0mL65mGr2
	 Y/r84c+A+s1D+YT+vzwNpNLYTh4eZuaeQrfVM/cUPEx8dSRk+4WukEAe0ZiAM+E27c
	 /2WkVxqLDbDMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DA76BCE0556; Tue, 30 Jan 2024 09:58:39 -0800 (PST)
Date: Tue, 30 Jan 2024 09:58:39 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"E."@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Paul@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH doc] Emphasize that failed atomic operations give no
 ordering
Message-ID: <5feeddda-f000-4b83-9981-e422c0d04881@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <63d9d6f6-05e8-473d-9d09-ce8d3a33ca39@paulmck-laptop>
 <Zbkt94Q8a-xFXrve@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbkt94Q8a-xFXrve@FVFF77S0Q05N>

On Tue, Jan 30, 2024 at 05:12:23PM +0000, Mark Rutland wrote:
> On Tue, Jan 30, 2024 at 06:53:38AM -0800, Paul E. McKenney wrote:
> > The ORDERING section of Documentation/atomic_t.txt can easily be read as
> > saying that conditional atomic RMW operations that fail are ordered when
> > those operations have the _acquire() or _release() prefixes.  This is
> > not the case, therefore update this section to make it clear that failed
> > conditional atomic RMW operations provide no ordering.
> > 
> > Reported-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Andrea Parri <parri.andrea@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Daniel Lustig <dlustig@nvidia.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: <linux-arch@vger.kernel.org>
> > Cc: <linux-doc@vger.kernel.org>
> > 
> > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > index d7adc6d543db4..bee3b1bca9a7b 100644
> > --- a/Documentation/atomic_t.txt
> > +++ b/Documentation/atomic_t.txt
> > @@ -171,14 +171,14 @@ The rule of thumb:
> >   - RMW operations that are conditional are unordered on FAILURE,
> >     otherwise the above rules apply.
> >  
> > -Except of course when an operation has an explicit ordering like:
> > +Except of course when a successful operation has an explicit ordering like:
> >  
> >   {}_relaxed: unordered
> >   {}_acquire: the R of the RMW (or atomic_read) is an ACQUIRE
> >   {}_release: the W of the RMW (or atomic_set)  is a  RELEASE
> >  
> >  Where 'unordered' is against other memory locations. Address dependencies are
> > -not defeated.
> > +not defeated.  Conditional operations are still unordered on FAILURE.
> >  
> >  Fully ordered primitives are ordered against everything prior and everything
> >  subsequent. Therefore a fully ordered primitive is like having an smp_mb()
> > 
> 
> FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Applied, thank you!

							Thanx, Paul

