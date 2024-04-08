Return-Path: <linux-arch+bounces-3509-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C744089CD10
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 22:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C880283F0E
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB87146D6C;
	Mon,  8 Apr 2024 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa6YA5UD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C014601C;
	Mon,  8 Apr 2024 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609633; cv=none; b=MVfYJ7jx23FFPZL1lG3OK/CWdyAdr+Bf+r5WHXfwuxprUsaoVd9XJw7JL0MExKLF4X9oMEeSW4nTvdCCSMT0SVqypVb4fz1qxWtFoE1XTtMpkeEI5jFY8H25pyk8aaNxSO39/1m8mxwRwEWtj4wxz2fbg95Z5EBXwvRJEniYf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609633; c=relaxed/simple;
	bh=KU0aZoQogbYaaiBUupsRPlXydh4mg/fVrHbYunWm8SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9hCvutkyGEvoq2pvLW6arsdIhZtrs56A2v85BzzgJEwW3U5BUjLOGSHEq8OpXCF55dXalpy/5+OrI2XUqFsK0K7zzqymt011G/l+T1xif6jjNi0eDmPDafzO1BtpkGj4uKIcsvzkk2IVXCFzefcHhzuPOSzKd9DnkmxMIDlSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa6YA5UD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4455BC433C7;
	Mon,  8 Apr 2024 20:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712609633;
	bh=KU0aZoQogbYaaiBUupsRPlXydh4mg/fVrHbYunWm8SI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Wa6YA5UDRRxQIpnvaOrK2H3MZdsCJhqVYthmIc2LaQPtVrDqIbuVv3xe0JklgbhNC
	 GCVMXHk8fHCVF4yWCkQKCePn3vRFXrmoOqMFR3nKA4uQxSlw2SziX//OeQBKuphiyC
	 xjEOs8LtMk3vRvXeK+L/BjWkmlxHOzGVj5uasadKrg16xJan1ROKTeIcXAWHYKrfYq
	 rcm7WL09lN8NXVQTSDLNcspSF7NgZuZQp8jJ3SObo2NPjTdXqTpI31iZ4/yJurH1lQ
	 RLGcI/mgf5usU37YfRdoULegxw4bwQ7+0uOToPT8u6nRbW+Q4lfsOaYIJPMXMycDR1
	 U7PKsikuTrd1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E10A8CE126C; Mon,  8 Apr 2024 13:53:52 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:53:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH cmpxchg 08/14] parisc: add u16 support to cmpxchg()
Message-ID: <ce6522d9-01fa-4f71-9e4c-66fa91cd65ba@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <20240408174944.907695-8-paulmck@kernel.org>
 <CAHk-=whwbdbNXeJ0m+YZqZcxKPD3v4dbcPVCd6gP7YkwCM=X7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whwbdbNXeJ0m+YZqZcxKPD3v4dbcPVCd6gP7YkwCM=X7w@mail.gmail.com>

On Mon, Apr 08, 2024 at 01:10:40PM -0700, Linus Torvalds wrote:
> On Mon, 8 Apr 2024 at 10:50, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > And get rid of manual truncation down to u8, etc. in there - the
> > only reason for those is to avoid bogus warnings about constant
> > truncation from sparse, and those are easy to avoid by turning
> > that switch into conditional expression.
> 
> I support the use of the conditional, but why add the 16-bit case when
> it turns out we don't want it after all?

You are quite right that we do not want it for emulation.  However, this
commit is providing native parisc support for the full set of cases,
just like x86 already does.

Plus this native parisc/sparc32 support is harmless.  If someone adds a
16-bit cmpxchg() in core code, which (as you say) is a bug given that
some systems do not support 16-bit loads and stores, then kernel test
robot builds of arc, csky, sh, xtensa, and riscv will complain bitterly.

Plus I hope that ongoing removal of support for antique systems will allow
us to support 16-bit cmpxchg() in core code sooner rather than later.
(Hey, I can dream, can't I?)

							Thanx, Paul

