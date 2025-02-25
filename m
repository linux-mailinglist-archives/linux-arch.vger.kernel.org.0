Return-Path: <linux-arch+bounces-10366-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAD3A44A29
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 19:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200A4174F15
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673A1A238B;
	Tue, 25 Feb 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbrcTlM4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAE1A0BDB;
	Tue, 25 Feb 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507535; cv=none; b=bwdFP68UJQGUjiC7YGDHZTrs5gc7RzYubJmeHJ1inF2TkBdMgDKJSbTEMyBKpjaOXl6O7Kp/dyzadPTBwaxXg7N69CniJLV+0OEjwJwz/5ICaBUBdTKhIdblHBy97fhMEPeXzRnpaNIlVtm5rWSBdnZV5KLN7+7LXXzG3IxfN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507535; c=relaxed/simple;
	bh=7OXINymZmewil33z64cp8FT/qYn5nUCuIRaRxvDnaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVKVGTO5auJPbSbiu4UHWjBzjcYn7sIH2BOhw8lQVB22/m0YUsbS1wxUjySN8oQOtboCgyTYYNRtpyT9YU1UoYFIHkA2FmHNrmDkh7vcaguIoxxYSZGZRBB5F3aAZ33nR+elBR2b9Z9orGCbbzUUH+FPLTY4ZA36qml8k07MkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbrcTlM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DB1C4CEDD;
	Tue, 25 Feb 2025 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740507534;
	bh=7OXINymZmewil33z64cp8FT/qYn5nUCuIRaRxvDnaTU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XbrcTlM4i+SX3uCIg9f9cb7Bn4JOAxuuN8MBwavcrnobPGBEkOatUNJv7vyfQFov5
	 04pwDcadpWQt+iyvR3aviVmwIOiZTFktw+kCWbcpFWPPFkXStDZmd6AbzgA1v+AVlP
	 x4IawZz5R5rluAoeLJfPBbRvkqqW+apib4kCmhe6q7m1YBO/M+vSTdZMd0OQz2yoDW
	 eD+tktKSIg0U2bfOBqXb/LaTH18fNUgmdIaWL7F5+hy4/4t5Hx6J9Y+ESqnL7cuXBe
	 JVo3Q56+DIV6PNYoKld41AMsLlnR/T4ks3Z1TFCLjmuPLd0AAYE+/Rx7vjLgB/4gVB
	 JK1FrPonE1mzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 302DCCE045A; Tue, 25 Feb 2025 10:18:54 -0800 (PST)
Date: Tue, 25 Feb 2025 10:18:54 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, kernel-team@meta.com, mingo@kernel.org,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [PATCH memory-model 7/7] tools/memory-model: Distinguish between
 syntactic and semantic tags
Message-ID: <42d5f3b4-de3e-4110-8273-01b25b92a7c8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
 <20250220161403.800831-7-paulmck@kernel.org>
 <ec893c4e-b4eb-4279-be66-1ca7e6bce7b1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec893c4e-b4eb-4279-be66-1ca7e6bce7b1@gmail.com>

On Tue, Feb 25, 2025 at 01:28:08PM +0900, Akira Yokosawa wrote:
> On Thu, 20 Feb 2025 08:14:03 -0800, Paul E. McKenney wrote:
> > From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > 
> > Not all annotated accesses provide the semantics their syntactic tags
> > would imply. For example, an 'acquire tag on a write does not imply that
> > the write is finally in the Acquire set and provides acquire ordering.
> > 
> > To distinguish in those cases between the syntactic tags and actual
> > sets, we capitalize the former, so 'ACQUIRE tags may be present on both
> > reads and writes, but only reads will appear in the Acquire set.
> > 
> > For tags where the two concepts are the same we do not use specific
> > capitalization to make this distinction.
> > 
> > Reported-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Tested-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Tested-by: Akira Yokosawa <akiyks@gmail.com> # herdtools7.7.58

I applied your tag to this commit and the previous one, and also your
suggested Co-developed-by tags, thank you very much!

							Thanx, Paul

> > ---
> >  .../Documentation/herd-representation.txt     |  44 ++--
> >  tools/memory-model/linux-kernel.bell          |  22 +-
> >  tools/memory-model/linux-kernel.def           | 198 +++++++++---------
> >  3 files changed, 132 insertions(+), 132 deletions(-)
> 

