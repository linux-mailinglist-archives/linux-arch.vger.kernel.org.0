Return-Path: <linux-arch+bounces-4123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022468B9234
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D6C282127
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A96168AE2;
	Wed,  1 May 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HziUBFXs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D317C6B;
	Wed,  1 May 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605679; cv=none; b=mlpEp06xQahivGa7FnSbbs2NyTS+TUdiZIcYS5UnFSkhNw0bwViBxRGGivG4klb1/Cd3WJz5gsn6S4sQrUYbEZI6EwV/FcxedKaCl7Xb+CU+jMzkIe2HmEWerqoH4s6TqDn05sQUoFJkGIAw+7Ze/SPheAb/D8V8eJ3cb8JsXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605679; c=relaxed/simple;
	bh=V7pdb33RKpwAz8QMydHY2xEB2tvjZSeTxTovguE8X0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiLaJi/N82j51i7xsJfxULZEQ1DtKPK9JvY0v+5HiomNi7tqieRYxGw1Ai+qDd4FNsjVzhIN58WOofFv0TMQVnYlfDmECMCVPH/t1hOnl6yPMGBa1qVCj4OHAST1Vq2c9H/nckf0WQhIVyAtLTJiLiiNlTnIVcKgu1J7bat3QfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HziUBFXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D91C072AA;
	Wed,  1 May 2024 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714605679;
	bh=V7pdb33RKpwAz8QMydHY2xEB2tvjZSeTxTovguE8X0I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HziUBFXstSH5ymhJcTtj4AFDWpG3Px9nNCGWDWuMhb+AtI2l4hnPhMtMOdIAMSs0H
	 I/gqMWv/1x+okZj5BEARdXTtcnE8A7XPEIgBv78raHnLtekXpJ6ADUTUDLyBQ+Vjph
	 lQyyISGLd9Menw0jt7bHQ1I0otSxWg8zXSoa//BwSpxhyl2O7YqDivgrgvZ9sxoh7w
	 NQo3lwFecfCkt5VpjJ4Wj8oFXjLUl+GpW6jMO9qjZpiKt74Hx8Dy19wYS2WiTOkoVY
	 UyWOi6aALMMMcQY+p5D8g6DvkXhHG2fqxJ5nuB58Y99w4wfaTXoH/lyTXMnSKePnMZ
	 oNJckzapCRUWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 809DACE1073; Wed,  1 May 2024 16:21:18 -0700 (PDT)
Date: Wed, 1 May 2024 16:21:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com
Subject: [PATCH v2 memory-model 0/3] LKMM updates for v6.10
Message-ID: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>

Hello!

This series contains LKMM documentation updates:

1.	Documentation/litmus-tests: Add locking tests to README.

2.	Documentation/litmus-tests: Demonstrate unordered failing cmpxchg.

3.	Documentation/atomic_t: Emphasize that failed atomic operations
	give no ordering.

4.	Documentation/litmus-tests: Make cmpxchg() tests safe for klitmus.

Changes since V1:

o	Apply formatting feedback from Andrea Parri

o	Add patch 4 that makes tests safe for klitmus, also based on
	feedback from Andrea Parri.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/litmus-tests/README                                   |   16 ++++
 Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus     |    1 
 Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus     |    4 -
 Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus   |    1 
 Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus   |    4 -
 b/Documentation/atomic_t.txt                                        |    4 -
 b/Documentation/litmus-tests/README                                 |   29 ++++++++
 b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus   |   34 ++++++++++
 b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus   |   30 ++++++++
 b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus |   33 +++++++++
 b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus |   30 ++++++++
 11 files changed, 180 insertions(+), 6 deletions(-)

