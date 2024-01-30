Return-Path: <linux-arch+bounces-1855-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96684295D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 17:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389F32928E1
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F285C6F;
	Tue, 30 Jan 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K95DzjwF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1638DDF;
	Tue, 30 Jan 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632402; cv=none; b=A/AhCHqTgv1XFs50GV9Bxmq6waOWEggEbbAVEZNHRhOEydLTBlyijAdaUMG6IUdIRpDcZJjMmAzyIV+mLMfl0WbbfFKS7Y6hxL4bo5o4AKexLSTQSGm1evxv37wYWLo85kDGagMr/jJKWYhaloUnh3IiI512CXeWk5VuMUFgVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632402; c=relaxed/simple;
	bh=7lcXGcjnNomt+i2x6M1dhs33eS+R8FWYGL8TkfLV164=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f60AhquwWo7KUhYLjPFMh5XTZnEL6gVeJgYeMOjjnMfoebo7qXeLPFMRyNWrYkzwj0b8AkKuKwo0wq4IQi/o0ZHgJ+xT2Iv+mts5gCQoMmoWEsOJhh7a29Fc5e3fb67Aj322S0cuXdNciLx8cJZ5KI6uc6Ty3u/z9OENpAuCxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K95DzjwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22BFC433F1;
	Tue, 30 Jan 2024 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706632401;
	bh=7lcXGcjnNomt+i2x6M1dhs33eS+R8FWYGL8TkfLV164=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=K95DzjwFeGX+F/y1ok9451Ib5LX5ZEJ4E0D+ZjuWleALpCIE99fi41NAKHj9en2NJ
	 U5FmJ4e7R9SPvgRO9UpMYC0FnSlPxSYr5QNk8tao0YmswsccE/Vl+rHAK0X4AM7+zv
	 w+WWKlwsAQ9kQ4bZmzCCmWpJwlYiZ5bxnArZsciBJPudRelHCtZXEfb+owvFN3mOO5
	 Wnp6/fiKK0egb1O1NW0nmzC1CY2OPog7wPVXXfN/3N1Shgcv2aquiT72aMGNDVBh7U
	 mnEXz8gU1Xvu213BsRH5Cvcicvwj6r3FElH/WtLuqCP+4bNSM1XmDmTtnMujAmDP4n
	 +PAfg5gfC7gkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E4A2CE14F0; Tue, 30 Jan 2024 08:33:21 -0800 (PST)
Date: Tue, 30 Jan 2024 08:33:21 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	"E."@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Paul@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH doc] Emphasize that failed atomic operations give no
 ordering
Message-ID: <db3d2a7e-a459-46e1-9c79-2b4e1d503ce5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <63d9d6f6-05e8-473d-9d09-ce8d3a33ca39@paulmck-laptop>
 <ZbkdqYFlFOdcZ63m@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbkdqYFlFOdcZ63m@andrea>

On Tue, Jan 30, 2024 at 05:02:49PM +0100, Andrea Parri wrote:
> On Tue, Jan 30, 2024 at 06:53:38AM -0800, Paul E. McKenney wrote:
> > The ORDERING section of Documentation/atomic_t.txt can easily be read as
> > saying that conditional atomic RMW operations that fail are ordered when
> > those operations have the _acquire() or _release() prefixes.  This is
> 
> s/prefixes/suffixes

Good catch, fixed.

> > not the case, therefore update this section to make it clear that failed
> > conditional atomic RMW operations provide no ordering.
> > 
> > Reported-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> You may want to add a "subsystem" to the subject line, git-log suggests
> "Documentation/atomic_t".  Anyway,

Good point, done.

> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you!

							Thanx, Paul

