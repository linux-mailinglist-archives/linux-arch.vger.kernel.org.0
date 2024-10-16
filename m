Return-Path: <linux-arch+bounces-8232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85269A0B6C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849B41F26D5B
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AB20720B;
	Wed, 16 Oct 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu85BA5R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29CB1C2325;
	Wed, 16 Oct 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085327; cv=none; b=sampo0MzNxthyO3vDJTmB03dmGfZEETCY7VBGcVFARa9lmrqIp9lIOOUTzmGbXtx3Z3yBCSGX8XHmT2OndU3+Z+FvvAlOcowy7XkG9ruSpa5zHuvv5IyrERksLcqS48H9fE5iN/19xNlvSrbrAIkd7Liu23Upf9CRFJOtzQb5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085327; c=relaxed/simple;
	bh=cBK9VJXhGNio9KGkEyEbMzsbPi7Rjfyb8HCMVbU4ft0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS5mKvENGt6AshhjuQpHRyxWVGJ4M9aKPnqBRlN9anoZQjJIZiEI5uRtWFIakIZGa2Su2zGGKOy+H5cCB8vqMwysYt6oqycohLx+yftjaxHx3bzhx8dqPNPGvFqOSvs3jV+XBqYFB7Pqn8KI4ra8rRbSONcI6QOr2WCGlSnQ87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu85BA5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F83C4CEC7;
	Wed, 16 Oct 2024 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729085327;
	bh=cBK9VJXhGNio9KGkEyEbMzsbPi7Rjfyb8HCMVbU4ft0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Iu85BA5R8f8kpBrTPP9K+xwtzv9Av9nr6TK28OSF748Y2v9fUpD8tPY/obNM3W8Hm
	 7ZCuQptoUCKoKmhbHzwrLuGBnVU74AilRs+yrP1KL237KofGCKrp+AZIdX87qIh3GM
	 +0Y1iQLyETo7XNcT9929aEGNv8fiiqHXSYxTCoqlgBT0MVdsz0Arl8bpGt2ZVendTC
	 1O2VDEJtjtznpWjdugSNAmhp+XQC49TLU5s0iOh2KoByVSbsv9ZvfInWtNKbUbjh+Z
	 QDB3MAhcQJ+gSJMc4/um7ZBQyxrEqzp42rpi9cjxSmCGY/0rSBMwwWhMDgaewurNLZ
	 S6zTrt0Sg22Sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D8D6BCE0DCA; Wed, 16 Oct 2024 06:28:46 -0700 (PDT)
Date: Wed, 16 Oct 2024 06:28:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vineet Gupta <vgupta@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org
Subject: Re: ARC: Use __force to suppress per-CPU cmpxchg complaints
Message-ID: <d3779f58-7c8f-4a93-a9f0-c6dc39efa847@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c88fafb4-47d9-49b6-aeb6-5a83c9778791@paulmck-laptop>
 <c1afa8ac-5c6a-4966-975d-915887c8106d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1afa8ac-5c6a-4966-975d-915887c8106d@kernel.org>

On Tue, Oct 15, 2024 at 10:33:14PM -0700, Vineet Gupta wrote:
> On 10/9/24 10:55, Paul E. McKenney wrote:
> > Currently, the cast of the first argument to cmpxchg_emu_u8() drops the
> > __percpu address-space designator, which results in sparse complaints
> > when applying cmpxchg() to per-CPU variables in ARC.  Therefore, use
> > __force to suppress these complaints, given that this does not pertain
> > to cmpxchg() semantics, which are plently well-defined on variables in
> > general, whether per-CPU or otherwise.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202409251336.ToC0TvWB-lkp@intel.com/
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Vineet Gupta <vgupta@kernel.org>
> > Cc: <linux-snps-arc@lists.infradead.org>
> >
> > diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> > index 58045c8983404..76f43db0890fc 100644
> > --- a/arch/arc/include/asm/cmpxchg.h
> > +++ b/arch/arc/include/asm/cmpxchg.h
> > @@ -48,7 +48,7 @@
> >  									\
> >  	switch(sizeof((_p_))) {						\
> >  	case 1:								\
> > -		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> > +		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> >  		break;							\
> >  	case 4:								\
> >  		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
> 
> 
> Added to for-curr.

Thank you!  As soon as it shows up in -next, I will drop it from my tree.

							Thanx, Paul

