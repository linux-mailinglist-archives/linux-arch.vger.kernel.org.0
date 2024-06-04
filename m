Return-Path: <linux-arch+bounces-4689-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCD68FBDE8
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 23:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29ECB1C20B68
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1045514BF91;
	Tue,  4 Jun 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEzB71An"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CC814B97F;
	Tue,  4 Jun 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535695; cv=none; b=JzdRHgwk9qRAcXBXYpxNeh1g/ZLh4erKTZQAGaKX/C6IAM+T5t0L/B17EHi3Ghz5yH5Y74Sa9dtw1+/gjp/DuN/2XQiHLidDPYRV49vR0iB/+V8vrGiR5HfIwxicdMdJf9drymNj0FB3YnLUvWeLkuBILRmTgC0oHwp3Ks+R9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535695; c=relaxed/simple;
	bh=ug4kl8tVRRMSrUddt7jPNRVoWYUz/TKHzlCL+ra/QT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8u73rgmIg860Y/EUMKcsaDE4FmFRM8PFSCRhk2bBBMYu6JAXQoLftD4HTyreE+q+bbd8k5oCVHZx/lHKJ5aOZID3PUpddG1sfUsRTOr+PB1jAXE2hqFolSwt4UYr3jLJya9747B5FbV9J1mPnXBpIfzEN7dU2AS3zdCljWwn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEzB71An; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62862C2BBFC;
	Tue,  4 Jun 2024 21:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717535694;
	bh=ug4kl8tVRRMSrUddt7jPNRVoWYUz/TKHzlCL+ra/QT8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vEzB71An41H6VZrQiPvJ5pBuqUVk6yA5Qvv82toCpbRXV7aRxsKlUk/Unea7m2jI2
	 nD8hU9wLYwExceHNyNpywgnBMhodmlq93BN4qAPzxECp3xUHY+WTC/9RBzAR6Fu1UB
	 9+W9IO2LlV57Vzx5rB3uDUytsN/4eugKtEDLzZNYyLypPSY+YEmhvpFXffysQFfRWA
	 zoPZ4wOwMOtPxXxCNBIi6jMAqFAYUnQvNqpXUbYViUMjPXEl7QR2DhV5qw9kUBsZuF
	 nc8t9lFO7RlyQbGvdubOzcJVk6tmTQajM6AGjnto+2+UsKfJLZY6sibK17SowUnAPM
	 c4fzNHqukNs9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 112F9CE3ED6; Tue,  4 Jun 2024 14:14:54 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:14:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org,
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org,
	pmladek@suse.com, torvalds@linux-foundation.org, arnd@arndb.de,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v3 cmpxchg 2/4] sh: Emulate one-byte cmpxchg
Message-ID: <972d3e89-ffda-49bc-8c0c-4d23484ca964@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
 <20240604170437.2362545-2-paulmck@kernel.org>
 <c44890de1c3d54d93fbde09ada558e7cb4a7177c.camel@physik.fu-berlin.de>
 <fcfa4d17-ea05-46f2-840d-9486923fd01d@paulmck-laptop>
 <fc6bbbcd0b2a79d8fdcbde576ae3e5a52ffab02a.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6bbbcd0b2a79d8fdcbde576ae3e5a52ffab02a.camel@physik.fu-berlin.de>

On Tue, Jun 04, 2024 at 07:56:49PM +0200, John Paul Adrian Glaubitz wrote:
> Hello,
> 
> On Tue, 2024-06-04 at 10:50 -0700, Paul E. McKenney wrote:
> > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > 
> > > I can pick this up through my SH tree unless someone insists this to
> > > go through some other tree.
> > 
> > Please do take it, and thank you!  When I see it in -next, I will drop
> > it from my tree.
> 
> I'll pick it up over the weekend for which I have planned my usual kernel
> review and merge session.

Very good, and again, thank you!

> > > Adrian
> > > 
> > > PS: I'm a bit stumped that I'm not CC'ed as the SH maintainer.
> > 
> > Me too, now that you mention it.  I did generate the list some time
> > back, but "git blame" shows you being maintainer for more than a year.
> > Yet I do have the linux-sh email list, so it is unlikely that I pasted
> > the get_maintainer.pl output from the wrong commit.
> > 
> > I am forced to hypothesize that I fat-fingered the output of
> > get_maintainer.pl when adding the Cc lines to that commit.
> > 
> > Please accept my apologies for having left you out!
> 
> No worries. I was just surprised as I assume get_maintainer.pl should have
> done the right thing and spit out the names of the responsible maintainers.

I will look more carefully next time.

							Thanx, Paul

