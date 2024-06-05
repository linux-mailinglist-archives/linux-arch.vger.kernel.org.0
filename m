Return-Path: <linux-arch+bounces-4702-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861C8FC285
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 06:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D081C22449
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 04:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C75660263;
	Wed,  5 Jun 2024 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Prs4TxYi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CA53364;
	Wed,  5 Jun 2024 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560174; cv=none; b=J/Q2M60mHlI2KHl9wCloMLMO3EFh3bO7lE5seR2bejyM66q8E5o/oz1iiMGBaPQ7Jn2iYgsOo8HqQPDJ9mjXl4DwfSZUIsnwgqxtVcz5xR6FHyYf22Kq5eZhlGtInnFZeMOaeqW3hOxEC6MF6WGYcpP9rW+4MBZ0v/kN9C01WpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560174; c=relaxed/simple;
	bh=lOzDDoGjGG+7jUmjJIP8OKT37uawXOdeutEfKT0paB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK4z5b82nieJrOYq8B0ctDfIWrHPpUtiCkQJ4m0d8k9cHdjRZ75jCCL8C5liE+ze9YqNT80Prwz5yUQsWeDJTXh0qb6tS2fazlh1ECiAA8eYs9xORuVYk3K8fNGur4ptMqwRGO8UDuVdnonk1lrI4hopZr9XMEdgWIu280387Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Prs4TxYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B236BC32781;
	Wed,  5 Jun 2024 04:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717560173;
	bh=lOzDDoGjGG+7jUmjJIP8OKT37uawXOdeutEfKT0paB8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Prs4TxYiZK3UiCc6AJk29zneAAUGLYZgJSoYPimYT+R7mEKhzuSFwK317aSlegSVs
	 LUHNuMFuwVOl9EkHs6n7EP8p1lBm1jW8ZUvRN+8kdovDOi4IgSkAgkE7rNhdYsW3bZ
	 JW/TJqMrjO4LsE6gQoog6F0wIydsFT0MTmJeoCA7iuVVLG4BwhiHXIkViqyUXhMvWj
	 FVyuZg/Zh0kBGhnOy/9FHY8deUU2npTK4j0BPSIQO7aTMIB6MuEI9qm/4lNFppscZr
	 RVrSJ7UMLzjZXl/jFWEU+Pk0B48gCfCsJKhPVKucx/+NifAh5yFkg9OHmzfx3IGDxL
	 WT9+G9Ab0a01A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6707FCE3ED6; Tue,  4 Jun 2024 21:02:53 -0700 (PDT)
Date: Tue, 4 Jun 2024 21:02:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com,
	Marco Elver <elver@google.com>, Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF
 mentorship session citation
Message-ID: <7fa1ba8a-9913-408f-a5c0-79686805fb61@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-3-paulmck@kernel.org>
 <Zl+fMRgK7q47PrVy@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl+fMRgK7q47PrVy@andrea>

On Wed, Jun 05, 2024 at 01:11:45AM +0200, Andrea Parri wrote:
> On Tue, Jun 04, 2024 at 03:14:19PM -0700, Paul E. McKenney wrote:
> > Add a citation to Marco's LF mentorship session presentation entitled
> > "The Kernel Concurrency Sanitizer"
> > 
> > [ paulmck: Apply Marco Elver feedback. ]
> > 
> > Reported-by: Marco Elver <elver@google.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you!  I will apply this along with Akira's on my next rebase.

							Thanx, Paul

