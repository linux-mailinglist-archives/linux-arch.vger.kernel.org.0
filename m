Return-Path: <linux-arch+bounces-11958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40DAB880E
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC51C4E43FA
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF45672627;
	Thu, 15 May 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axIJY2qZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE297481C4;
	Thu, 15 May 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315999; cv=none; b=SLpbSRM/1/bziRzKTg5v36u+uYP7nuSpQZTNHCKFrs7jlwSRtM1WkgiKqRh0kS0Fv3CiZc3Q5Vers8iakYQEBoo/fLgaubMX5DLRLHRiS2WHQQsDLT8Vxha71wDsRgPj/SlsI3iU+mkKiQfNq3zxXj1yrBkIr0RyZz+Q4fE8w44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315999; c=relaxed/simple;
	bh=wQzWtzFVbRLSyT1kOVfalNa0l6P3QoYKfG6IeKaYSd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htRNJxvyOCsu6kbVtP3ZlDyUEFMbOMZa8QpEqX1NhsKKHI2Ykh9z2d9Ss05QUPhUKlJw5tf+n8JfNeo/1gQ1qgd4xoyw5AZEGP00OfTwoeqnrs+lszIrnDfNzljHWyaKjqBK/6EtbSYdIJ+d/HURfnwjTJdP0EFu9Ptd85+gMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axIJY2qZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403C6C4CEE7;
	Thu, 15 May 2025 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747315998;
	bh=wQzWtzFVbRLSyT1kOVfalNa0l6P3QoYKfG6IeKaYSd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axIJY2qZ51keUz71syARwcRIoH8q/2hvAUPBST+E9n8yHtI92gFEc7bsA/4AS7nEJ
	 RhYobVI1Efx2MUouRhi5JQ8XvIgckDgPkkqqIzIwUfWw0IzWPcNk1D3SmGZIS/nYd7
	 7/TwwNn/sKQuJG82uyE6Kq2bPfIj1dR4Mr8dYgpQRocOnWGbdEAp5PIv537ySnASNe
	 2PsRy/A7Lx2S04HyQh1ULH3pgMEFRkMXU9u5Fve3YutlE/E56t+fE5WeAw3QIVD+fG
	 mR4teecHQGRoP1kfoDy0Jtf2Nsmt8mO0gjCJtOgj4s+RAL/LU2GbAYEd3vOfQ0CcqR
	 bi0JioNvo9Y9Q==
Date: Thu, 15 May 2025 15:33:13 +0200
From: Ingo Molnar <mingo@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH 14/15] bugs/sh: Concatenate 'cond_str' with '__FILE__' in
 __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
Message-ID: <aCXtGRr5pSLKoKg8@gmail.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-15-mingo@kernel.org>
 <ba1e1ae6824f47bcb49387ae4f2c70dfd45209bc.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba1e1ae6824f47bcb49387ae4f2c70dfd45209bc.camel@physik.fu-berlin.de>


* John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Ingo,
> 
> On Thu, 2025-05-15 at 14:46 +0200, Ingo Molnar wrote:
> > Extend WARN_ON and BUG_ON style output from:
> > 
> >   WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410
> > 
> > to:
> > 
> >   WARNING: CPU: 0 PID: 0 at [idx < 0 && ptr] kernel/sched/core.c:8511 sched_init+0x20/0x410
> > 
> > Note that the output will be further reorganized later in this series.
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: linux-sh@vger.kernel.org
> > Cc: <linux-arch@vger.kernel.org>
> > ---
> >  arch/sh/include/asm/bug.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
> > index 834c621ab249..891276687355 100644
> > --- a/arch/sh/include/asm/bug.h
> > +++ b/arch/sh/include/asm/bug.h
> > @@ -59,7 +59,7 @@ do {							\
> >  		 _EMIT_BUG_ENTRY			\
> >  		 :					\
> >  		 : "n" (TRAPA_BUG_OPCODE),		\
> > -		   "i" (__FILE__),			\
> > +		   "i" (WARN_CONDITION_STR(cond_str) __FILE__),	\
> >  		   "i" (__LINE__),			\
> >  		   "i" (BUGFLAG_WARNING|(flags)),	\
> >  		   "i" (sizeof(struct bug_entry)));	\
> 
> Looks good to me, however I'm not happy with the summary line.
> 
> It's too long and the prefix "bugs/sh:" is very confusing. I usually just
> use "sh:" to mark anything that affects arch/sh.

Fair enough, I've changed the title to and pushed out the new tree:

  sh: Concatenate 'cond_str' with '__FILE__' in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output

> Can I pick this patch for my sh-linux tree?

So since it depends on the previous patches, in isolation this would 
break the build.

Can I add your Reviewed-by or Acked-by?

Thanks,

	Ingo

