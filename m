Return-Path: <linux-arch+bounces-12357-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C424FADCFA0
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5E317DB59
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3D2E3AEB;
	Tue, 17 Jun 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVyMO8g6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720762E3AE7;
	Tue, 17 Jun 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169831; cv=none; b=Krwm0qF2x/XwBVCn4odrQUwWA4NbOXhjRXPvYwxgFG6fgEC6eC4NNIJox1BbpNmTrWlk9Eq+XUUUp4ZgJs+d65Q6a5DufxUco24HPrj+qgLuoY3GwS69PIHeU8OypET+tVSU0t7HhWGNyWOwxgsr/jQTeCIeIIDut8lvPjhJujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169831; c=relaxed/simple;
	bh=3mSinD0JJvo4Mt9YTggDN6jPCaaEW3X4Rzr0cVwpGx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjVlXJnECnBhMTf+u1fhy7bSd6QcTOE0V7lS4fzcyWloe5LcFXIivjHeSBU/lBqD3ozCEz9RUg8lOEJsCU1saKC9Ci6ln4MiEksG93MeVYPh+vooS43tmPq9EeVX9fnFtIh31PjgG3kbNK1MNDO2L5+M9CToFmTgI/3gin7kEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVyMO8g6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EECC4CEE3;
	Tue, 17 Jun 2025 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750169831;
	bh=3mSinD0JJvo4Mt9YTggDN6jPCaaEW3X4Rzr0cVwpGx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVyMO8g6o7tlkp90oFcZWuvEH/bq+nnaD0GZzXPvxd38T+s7Ua6+AeOZYHtp1ey75
	 VZmZiqkACbhZg7HJTVuN/Zp8t+prqP9E+F87ZVdov/jOn+2Yg3V/uKm8f2ZClRYO/t
	 Y59IQ6a5pj0RK6JIGo6EnrasACDj5GzrTu7723Qf23FsgtVwSVmH7Efgoem5VrHR8D
	 bgE5BXAd7syXVpONL8cZxFhAlPid+uVv7tvIm+GgxGOx8tpWVedQG0q8nJCZlOUdkA
	 +Yk+F/xx6dNiJDcDfVfR2rkwvwrWTDF4bUYG04QsRxuFZBWA36+DuprQwYMgnTC8yT
	 B/cFm41njB1kg==
Date: Tue, 17 Jun 2025 15:17:04 +0100
From: Will Deacon <will@kernel.org>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Thomas Haas <t.haas@tu-bs.de>, Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, jonas.oberhauser@huaweicloud.com,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
Message-ID: <20250617141704.GB19021@willie-the-truck>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <20250616142347.GA17781@willie-the-truck>
 <d66d0351-b523-40da-ae47-8b06f37bf3b6@tu-bs.de>
 <2b11f09d-b938-4a8e-8c3a-c39b6fea2b21@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b11f09d-b938-4a8e-8c3a-c39b6fea2b21@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jun 17, 2025 at 10:42:04AM +0200, Hernan Ponce de Leon wrote:
> On 6/17/2025 8:19 AM, Thomas Haas wrote:
> > On 16.06.25 16:23, Will Deacon wrote:
> > > I'm half inclined to think that the Arm memory model should be tightened
> > > here; I can raise that with Arm and see what they say.
> > > 
> > > Although the cited paper does give examples of store-forwarding from a
> > > narrow store to a wider load, the case in qspinlock is further
> > > constrained by having the store come from an atomic rmw and the load
> > > having acquire semantics. Setting aside the MSA part, that specific case
> > > _is_ ordered in the Arm memory model (and C++ release sequences rely on
> > > it iirc), so it's fair to say that Arm CPUs don't permit forwarding from
> > > an atomic rmw to an acquire load.
> > > 
> > > Given that, I don't see how this is going to occur in practice.
> > 
> > You are probably right. The ARM model's atomic-ordered-before relation
> > 
> >       let aob = rmw | [range(rmw)]; lrs; [A | Q]
> > 
> > clearly orders the rmw-store with subsequent acquire loads (lrs = local-
> > read-successor, A = acquire).
> > If we treat this relation (at least the second part) as a "global
> > ordering" and extend it by "si" (same-instruction), then the problematic
> > reordering under MSA should be gone.
> > I quickly ran Dartagnan on the MSA litmus tests with this change to the
> > ARM model and all the tests still pass.
> 
> Even with this change I still get violations (both safety and termination)
> for qspinlock with dartagnan.

Please can you be more specific about the problems you see?

> I think the problem is actually with the Internal visibility axiom, because
> only making that one stronger seems to remove the violations.

That sounds surprising to me, as there's nothing particularly weird about
Arm's coherence requirements when compared to other architectures, as far
as I'm aware.

Will

