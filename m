Return-Path: <linux-arch+bounces-6716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B5F962A11
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6CF1C22C13
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D018B469;
	Wed, 28 Aug 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6S6p8Ac"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238A2D600;
	Wed, 28 Aug 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854929; cv=none; b=hJQZb9kyI1d5J1kUpP94seo7cOwvLxcsl5W5saBmWpvdLT2WGDdZ8IwNIkDiiDG6rvqHa93Jib8NJB2i8V+w5JBwmuPVxDnCF+gf/sRdMSRXWemXV5PRx//TUcMyjXfaBTq2AhcED+zz3Ou8srZz94UGwz4RGzhBkmzOluiK5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854929; c=relaxed/simple;
	bh=DoKFq1bkScfgxFSEbvED0KugkRB+GgWz8OiOHOBBJMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLJjX/Fd59jU7GVINZ5eDUckRZ2EAfjFya8b3DWEXUr33eajW3WyIgq6QxjyxTsmEFEqf9hyK+6pPAieXWOOb3J/kYdSFO5Otewz3EYg0n1r3uY05vwoEyAf0cYg5cg8Ll8wqK+vHuiaduk+kSPhXA8CAkRuQvm3hZymGHXqYag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6S6p8Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E124C582B5;
	Wed, 28 Aug 2024 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724854929;
	bh=DoKFq1bkScfgxFSEbvED0KugkRB+GgWz8OiOHOBBJMs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=g6S6p8AcEkdsdWt6mHQdUcTjKWLDY6lYMIOvnftvikU7ANIHDZ/SlLUq49CRbiW9D
	 TxnvDxfm5r5kP4OZD2pQw2B1kjDkTzeBhOmbHV3RgmbGgp4gcBnNGI8NfZtQwM1j+T
	 lMOMC9uSz3tz1E3oK3dndzFnr5W8n9ahi6gxse588vTcQgbuwp1P3tpGgYkbmnNNFQ
	 httsnZ2UFEV5WfbTWN/b5fX9hWDSQ7UC1g1EFgVMFRNJPmqNFTFFpWYkCON+COn0rw
	 sj8IYFY3kGKYpsDzM5An/+4rptglrGqaGdmuLlU41diVL1pZcnB6DTkRvKL9MeKQrV
	 QBJpNyTBpDNoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5E71CE1697; Wed, 28 Aug 2024 07:22:08 -0700 (PDT)
Date: Wed, 28 Aug 2024 07:22:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: 16-bit store instructions &c?
Message-ID: <289c7e10-06df-435b-a30d-c2a5bc4eea29@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3ca4590a-8256-42d1-89ca-f337ae6f755c@paulmck-laptop>
 <b3512703-bab3-4999-ac20-b1b874fcfcc3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3512703-bab3-4999-ac20-b1b874fcfcc3@app.fastmail.com>

On Wed, Aug 28, 2024 at 01:48:41PM +0000, Arnd Bergmann wrote:
> On Wed, Aug 28, 2024, at 13:11, Paul E. McKenney wrote:
> > Hello, Arnd,
> >
> > You know how it goes, give them an inch...
> >
> > I did get a request for 16-bit xchg(), but last I checked, Linux still
> > supports some systems that do not have 16-bit store instructions.
> >
> > Could you please let me know whether this is still the case?
> 
> Hi Paul,
> 
> The only one I'm aware of that can't do it easily
> is a configuration on 32-bit ARM that enables both 
> CONFIG_CPU_V6 and CONFIG_SMP, but I already wrote
> a patch that forbids that configuration for other
> reasons. I just need to send that patch.

Very good, and thank you!

> There is a related problem with ARM RiscPC, which
> uses a kernel built with -march=armv3, and that
> disallows 16-bit load/store instructions entirely,
> similar to how alpha ev5 and earlier lacked both
> byte and word access.

And one left to go.  Progress, anyway.  ;-)

> Everything else that I see has native load/store
> on 16-bit words and either has 16-bit atomics or
> can emulate them using the 32-bit ones.
> 
> However, the one thing that people usually
> want 16-bit xchg() for is qspinlock, and that
> one not only depends on it being atomic but also
> on strict forward-progress guarantees, which
> I think the emulated version can't provide
> in general.
> 
> This does not prevent architectures from doing
> it anyway.

Given that the simpler spinlock does not provide forward-progress
guarantees, I don't see any reason that these guarantees cannot be voided
for architectures without native 16-bit stores and atomics.

After all, even without those guarantees, qspinlock provides very real
benefits over simple spinlocks.

							Thanx, Paul

