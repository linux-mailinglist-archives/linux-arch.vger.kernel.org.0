Return-Path: <linux-arch+bounces-4953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86490BD1F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 23:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852E2285C1D
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 21:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D508197A62;
	Mon, 17 Jun 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJM196/A"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F4179BD;
	Mon, 17 Jun 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661575; cv=none; b=D7AUPbj7U5CoFB7vB6iIMPYZF0jYPo6q+w7pVXxW5JwVPh62O0YEk2gRjgFjHm9MhT23uXHU3b+TAtkzZS5h521VmmrNinfY5Kzqz0QW7zcKEKHb7sRehm5tKllwXU7X3gNPymAsoic/46idMbNqTV72TUrjz9ctUmeUjI+ku5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661575; c=relaxed/simple;
	bh=OXvlYeDAH1Ydm4s1sBrhvitUZ0K9bQtKwCg/Bnu+SsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6G4fzdf7pJMFmjA1IjomRbc/bnB3NXbNgHHzTzfRh3tSC7o37H5yF1w3t6MwtTZwia868RiWVSfsLYNpXqJ0oxKb+FN0FC4WhkRpB8ixKRkO1gFoLbcRGz3sWjs/uqjt4y/NyEqULiS/Vi6GvQjWDv9XRBCZz+N/i0JROXYyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJM196/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FD1C2BD10;
	Mon, 17 Jun 2024 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718661574;
	bh=OXvlYeDAH1Ydm4s1sBrhvitUZ0K9bQtKwCg/Bnu+SsM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eJM196/Aj1jpNmuYB0F0qZBizNSUVBwIfQnUVQ4QK+/Q44dZCbAjuZZ91vhAjAwuk
	 uWnLdjnKKE1a4kNUlUTez6sD5Q6W7gO+FquqeNZPvwWGpLTqqMBprMqGuAFBzBxaks
	 ui04LC9OqrVUnVxFu40uL36AchAdcDV4oN4uxU2cIZMXPxkYFYpYjNiVkTphqNDDNz
	 HDxdTu9nLmru3SLLNSbK1vIYXn4/fLeN7X/4s/JAxvE92MjNU8djvW4XJopSoqsmCi
	 +l49XwN03/iQgGfUrce9TrpoDoa+wR0ljNDDzHJppJRXSnzvW0uWugcqjr9W1Pa58R
	 n3ZjbZnEO1SkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 370A1CE09DE; Mon, 17 Jun 2024 14:59:34 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:59:34 -0700
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
Message-ID: <9762aac5-ab5c-4016-bc63-09dbb12c3f36@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
 <20240604170437.2362545-2-paulmck@kernel.org>
 <c44890de1c3d54d93fbde09ada558e7cb4a7177c.camel@physik.fu-berlin.de>
 <fcfa4d17-ea05-46f2-840d-9486923fd01d@paulmck-laptop>
 <fc6bbbcd0b2a79d8fdcbde576ae3e5a52ffab02a.camel@physik.fu-berlin.de>
 <972d3e89-ffda-49bc-8c0c-4d23484ca964@paulmck-laptop>
 <add0cb7b-6ec2-4b13-b327-8ff93358993e@paulmck-laptop>
 <4da8ec47366209cdb4d61045cb6e8b2f872a37a1.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da8ec47366209cdb4d61045cb6e8b2f872a37a1.camel@physik.fu-berlin.de>

On Mon, Jun 17, 2024 at 10:30:40PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Paul,
> 
> On Mon, 2024-06-17 at 09:50 -0700, Paul E. McKenney wrote:
> > On Tue, Jun 04, 2024 at 02:14:54PM -0700, Paul E. McKenney wrote:
> > > On Tue, Jun 04, 2024 at 07:56:49PM +0200, John Paul Adrian Glaubitz wrote:
> > > > Hello,
> > > > 
> > > > On Tue, 2024-06-04 at 10:50 -0700, Paul E. McKenney wrote:
> > > > > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > > > > 
> > > > > > I can pick this up through my SH tree unless someone insists this to
> > > > > > go through some other tree.
> > > > > 
> > > > > Please do take it, and thank you!  When I see it in -next, I will drop
> > > > > it from my tree.
> > > > 
> > > > I'll pick it up over the weekend for which I have planned my usual kernel
> > > > review and merge session.
> > > 
> > > Very good, and again, thank you!
> > 
> > Just following up...  I don't yet see this from you in -next.  When your
> > version does show up in -next, I will drop my copy from -rcu.
> 
> Sorry, I was very busy last week and didn't get around to do any kernel stuff.
> 
> I will take care of it this week, I have not forgotten about it and I never let
> patches unanswered, and unmerged once I have reviewed them.

Very good, thank you, and apologies for the noise.

							Thanx, Paul

