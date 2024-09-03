Return-Path: <linux-arch+bounces-6977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FE96AC3D
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 00:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5151C243D6
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 22:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36100187552;
	Tue,  3 Sep 2024 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl1JUbCM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1D186E30;
	Tue,  3 Sep 2024 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402841; cv=none; b=bpnzZQd1aCQts54c5gp2Y7WGjC/jZbyTMBGgCV5g3csgMS96mt3XGXoid5xKrQRYPXnZskIIeQbueRPdAk/K6gMlNMqg6I/yo3Ll/NNXDvALyU2UNLnQXWNLilqaYBqw3kjJH9ct1Df4+YsLEMB9FacyZuYDsNcixG6VP2Nps+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402841; c=relaxed/simple;
	bh=PJuaEhOFGYtVYPKXwDpttFc+q5OxRf2zKobxdkoJmTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K//wJPfSpYyF+/ye7k80CBlGo2aCH2VPno69gSuYuumKkB8ERtGJZjwNvyMu/+0ALmaHEl4UBAFF5getHjCj5f3oBzfmLmkW+027dV32T3z5hihyw2QPnNnrmFFznSPDEUGN8Zj66YYbY1z+Tmc4YfMhZiJDOlS6242n7ijSk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl1JUbCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93953C4CEC4;
	Tue,  3 Sep 2024 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725402840;
	bh=PJuaEhOFGYtVYPKXwDpttFc+q5OxRf2zKobxdkoJmTg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cl1JUbCM9uq01AMIDCJyqCBNoHE8kVLu1Zlum4zDmNcdU2M0Z6EnPJa4JG9Wf+Lxg
	 9ikXHR3b/LYZxALX/n3kJYWb7UJYyMiEn1vNR5OCoz4ZCXgdA7WsjjR/KAa4Pi2vy9
	 9/lR7RZJ0t3ms1ZapFF6OgOvJnROLB0By59ayo2ih88WYMa7m3GTJJC01d/rn3oYQ0
	 24PkAfQWeVHT5hlr+LZ2A/A4/cCBMd4MI4fJ26ElWmpyUx65ztX3RD57VttODew+X/
	 4AHQ8QRRDKcdEeX934gyYgqkJhQY1wkPe5af2W/7hZ+emoTMzhPMVelMq2ZT4TGqhg
	 trCXY1uR0rR5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3796ACE1257; Tue,  3 Sep 2024 15:34:00 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:34:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: 16-bit store instructions &c?
Message-ID: <0974da0a-8788-470d-bb9c-8fc90d7e6f08@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3ca4590a-8256-42d1-89ca-f337ae6f755c@paulmck-laptop>
 <b3512703-bab3-4999-ac20-b1b874fcfcc3@app.fastmail.com>
 <289c7e10-06df-435b-a30d-c2a5bc4eea29@paulmck-laptop>
 <9242c5c2-2011-45bf-8679-3f918323788e@app.fastmail.com>
 <1bb58d8d-4a2a-4728-a8f3-9295145dbbb0@paulmck-laptop>
 <f209bf4d-1d14-404b-8bff-8d6d2854d704@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f209bf4d-1d14-404b-8bff-8d6d2854d704@app.fastmail.com>

On Thu, Aug 29, 2024 at 09:56:52PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 29, 2024, at 15:37, Paul E. McKenney wrote:
> > My plan is to submit a pull request for the remaining three 8-bit
> > cmpxchg() emulation commits into the upcoming merge window.  In the
> > meantime, I will create similar patches for 16-bit cmpxchg() and perhaps
> > also both 8-bit and 16-bit xchg().  I will obviously CC both you and
> > Russell on the full set.  And if there are hardware-incompatibility
> > complaints, we can deal with them, whether by dropping the offending
> > pieces of my patches or by whatever other adjustments make sense.
> >
> > Does that seem like a reasonable approach, or is there a better way?
> 
> There is one thing I'd really like to see happen here, and that is
> changing the architectures so they only define the fixed-length
> __arch_xchg{8,16,32,64} and __arch_cmpxchg{8,16,32,64} helpers,
> ideally as inline functions to have type checking on the pointer.
> 
> If we make the xchg()/cmpxchg() functiuons handle all sizes
> across architectures, that just ends up cementing the type
> agnostic macros, so I feel it would be better to have
> fixed-size helpers as the generic API so we can phase out the
> use of the existing macros on smaller-than-u32 arguments.
> 
> The macro is still needed to allow dealing with both integer
> and pointer objects, as well as a mix of 'int' and 'long'
> arguments on 64-bit, but for normal fixed-size objects I
> think we can best use the same method as the current
> xchg64()/cmpxchg64().

So the idea is to have architecture-independent xchg()/cmpxchg() that
invoke the __arch_xchg{8,16,32,64} and __arch_cmpxchg{8,16,32,64} helpers?
Seems plausible to me.

How can I best help?  My guess is that I should prototype an emulated
xchg() function, given my limited familiarity with the architectures.

						Thanx, Paul

