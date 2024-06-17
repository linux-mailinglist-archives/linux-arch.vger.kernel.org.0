Return-Path: <linux-arch+bounces-4947-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB29D90B7E7
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 19:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0372B2C093
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B0161924;
	Mon, 17 Jun 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaYUk+ZS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E3161904;
	Mon, 17 Jun 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643017; cv=none; b=KQa+NxW7oDt59YPkVIgWunLBy7C5zplUdY0AQ1s1PWVDbBRKY68/2UjPnbzpPQWQUGCRFTdsgdt0Ns8u0Wde4ICSoX/snGmVMauM0bdaNgEgrcuSnsME1llzZtywVmtcbc5dUwFTDCV5Er1czgy4rjyS3stMcaWYCM4NgwGRoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643017; c=relaxed/simple;
	bh=HFw7kEWg83KFfdF14yg6+GNQhXkIRwXKH5xj2oEoVEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=somLSgLrsx4hauoijv1vhGFJRaQKH03lfiC3l4t+BKiX5Seh29Ozbdl37jN4WI2nd0iZNCe85Z4a1GYobRfzrE1Y2wBEkGkswACl8Y5bzQjBLNidE6r2HiQkakzSHuM1c0qm+7bevmS49QZ4OU/W8XydOjNSvNGTdo7vV+r5ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaYUk+ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9916AC2BD10;
	Mon, 17 Jun 2024 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718643017;
	bh=HFw7kEWg83KFfdF14yg6+GNQhXkIRwXKH5xj2oEoVEI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gaYUk+ZSBu2RefnBo3X/F2/jC08++tCA0xErNiQCBmT9jLE/siwyjTHaL2/AAjUXK
	 adZAXanHJyip8MO1T4vUrptmDztkTF9oCN/yEdIfx0eVtmOY7dI65kppnwGZtpdlEX
	 mfFbWQBr5GbsxSQ1+zDbzGZsPtWDo8KfoikxmBgVcGiUhHKEy4MFDVz4OfoS4WZkTB
	 rISlrYf/olYwkzrnJXrx59vnrKc42V9zC5PAxk5bfl4uzEXWWuj64ymxzMxc/kKyq+
	 +VoB+50Q8QmL45BDCsa64oHMIG7tBhnv4t4r2PO3Vu+Nms8jQL4z8cjAiXbW/h/Ddo
	 sIDgc6hHyofYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F287CE09DB; Mon, 17 Jun 2024 09:50:17 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:50:17 -0700
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
Message-ID: <add0cb7b-6ec2-4b13-b327-8ff93358993e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
 <20240604170437.2362545-2-paulmck@kernel.org>
 <c44890de1c3d54d93fbde09ada558e7cb4a7177c.camel@physik.fu-berlin.de>
 <fcfa4d17-ea05-46f2-840d-9486923fd01d@paulmck-laptop>
 <fc6bbbcd0b2a79d8fdcbde576ae3e5a52ffab02a.camel@physik.fu-berlin.de>
 <972d3e89-ffda-49bc-8c0c-4d23484ca964@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972d3e89-ffda-49bc-8c0c-4d23484ca964@paulmck-laptop>

On Tue, Jun 04, 2024 at 02:14:54PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 04, 2024 at 07:56:49PM +0200, John Paul Adrian Glaubitz wrote:
> > Hello,
> > 
> > On Tue, 2024-06-04 at 10:50 -0700, Paul E. McKenney wrote:
> > > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > > 
> > > > I can pick this up through my SH tree unless someone insists this to
> > > > go through some other tree.
> > > 
> > > Please do take it, and thank you!  When I see it in -next, I will drop
> > > it from my tree.
> > 
> > I'll pick it up over the weekend for which I have planned my usual kernel
> > review and merge session.
> 
> Very good, and again, thank you!

Just following up...  I don't yet see this from you in -next.  When your
version does show up in -next, I will drop my copy from -rcu.

							Thanx, Paul

