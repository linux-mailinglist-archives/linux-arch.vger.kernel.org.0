Return-Path: <linux-arch+bounces-4703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F518FC28F
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 06:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244CB1C22495
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 04:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324E85FB9A;
	Wed,  5 Jun 2024 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGDMG7dj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B925777;
	Wed,  5 Jun 2024 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560362; cv=none; b=obxhxIe9XshJPwvMWAgChS3pIQJAWYL5kA0eQBBqI1eEDOdvh3LULixfZjoA5XXM0MWfxzsK47mfVHUe47qPqzTeN8fetfWmRqZWLAouHOvhBx74JJJTlz8s7kPCa7pRAY7u5FAMFtjvFuUzk6pd6Ckqqs+4WClSoqrCnF3jIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560362; c=relaxed/simple;
	bh=rLGPqPmytPuP+ypZgU32vsrIIMSLhcGGZabsJT7wtxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVNG12fF7xY/YeSSShpnXWtiutOrtEgjjIB0qA4rkQphrYvUOBN3J2xNjU014uT1TKzygjivDaekGHrc+LAcS0iUrHTFntjTnzpvCCiZpeyj5Jo5s7ULH+0Mgobpk9EtfWUTznh9n9Xx0UXnjtDxmKb6vGVr9L1U9MH2jYBEV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGDMG7dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB68C32781;
	Wed,  5 Jun 2024 04:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717560361;
	bh=rLGPqPmytPuP+ypZgU32vsrIIMSLhcGGZabsJT7wtxg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PGDMG7dj2DMj09huh2fYRJ4AhUnZCxFgC1ZlmmNwKMzL9FY6345f3ABeGwMCNYtpX
	 gQDQfo7ICLjrnUJyas5NSfA8z/QZtFdxqauoqvknNGq5Bi2Pm35MWw8U0/3Juc1J59
	 zwfUxBIkQj2FUA8S7jaRj85/KpKgwIgINa0kOw6X2RTd1b79FB4xPPT5rI8RpQxWJS
	 zIW5tZCWAy7vNK1yNwr5e29u2JPS/8LcTVlEj5rviZd7OiYBq7shnr2sX7/1c9tkXH
	 SAHDLInw7ro8r9Qh4unuNrdKUoXMQuG5/3fSWADPX2j7XDNyLFiovoXD86JRihzrWQ
	 awoKr2egCa5/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2C2FACE3ED6; Tue,  4 Jun 2024 21:06:01 -0700 (PDT)
Date: Tue, 4 Jun 2024 21:06:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	Puranjay Mohan <puranjay@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH memory-model 1/3] tools/memory-model: Add
 atomic_and()/or()/xor() and add_negative
Message-ID: <42383b44-5d65-44cd-af98-608e4dd7dfa2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-1-paulmck@kernel.org>
 <99545c09-4a14-4f8d-9d3b-c687fc318714@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99545c09-4a14-4f8d-9d3b-c687fc318714@gmail.com>

On Wed, Jun 05, 2024 at 09:27:12AM +0900, Akira Yokosawa wrote:
> Hi,
> 
> On Tue,  4 Jun 2024 15:14:17 -0700, Paul E. McKenney wrote:
> > From: Puranjay Mohan <puranjay@kernel.org>
> > 
> > Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
> > atomics operations.
> > 
> > Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
> > all their ordering variants.
> > 
> > atomic_add_negative() is already available so add its acquire, release,
> > and relaxed ordering variants.
> > 
> > [1] https://github.com/herd/herdtools7/pull/849
> > 
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > Acked-by: Andrea Parri <parri.andrea@gmail.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> 
> Pull-849 and Pull-855 at herdtools7 happened after the release of 7.57.
> So I thought patches 1/3 and 2/3 needed to wait a next release of
> herdtools7.
> 
> But these changes don't affect existing litmus tests.
> So I don't oppose them to be merged into 6.11.
> 
> It's up to Paul!

I do not intend to send these to mainline before the herd7 changes are
officially released.  But why not be optimistic?  Hence sending the
patches for v6.11.

If the herd7 release is not forthcoming in time for the next merge window,
I will rebase the documentation update underneath the two RMW patches,
and send only the documentation update.

But maybe I should do that rebase sooner rather than later...  Less
opportunity to forget that way.

							Thanx, Paul

