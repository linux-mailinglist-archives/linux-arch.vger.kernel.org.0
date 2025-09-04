Return-Path: <linux-arch+bounces-13384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F12B44425
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176CF7AF985
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D363009D2;
	Thu,  4 Sep 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSTBIsKs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0DA1DFDB8;
	Thu,  4 Sep 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006054; cv=none; b=OmmwhWYXA/C/XsDVc2b/YgiMdUvH6CVg/2oa9J6eZp2Z8PJft0XhpJpS++0pKtNu6c1tQ0pp4ru/IsjZzhYDJFwgOIcaGkpzvpf8rkEsu6bAxtPoiNMq/y2djmbCCqbTJNMGFy4bq1h/VjGN9aDWxXG3DiFBkEJddxECqU4hsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006054; c=relaxed/simple;
	bh=aXY/vaQCquq1+9q6IEMxEYmqHzU/u7woNjIe1m8hvLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZObr8sOHXKVKi82JQ+YEShV5mitsfAlR3kPCqZfv7xIL0IQhMTtZeu+EnIHIaVt7Lfdf4//PASNiXAgPTJumFbsNmJQQ6N2WvVYfke7u7jdHj8IKkxCdDrU/KB6lo3hYbFq+TLMYbg6yVNV1qv8j63hVVy+rooRS9dRloe3zHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSTBIsKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D271FC4CEF0;
	Thu,  4 Sep 2025 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757006052;
	bh=aXY/vaQCquq1+9q6IEMxEYmqHzU/u7woNjIe1m8hvLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSTBIsKs+EjPUtCpJxohRt/IpY76JRePQfFvTkih75J8faFyAyWrphA+9Z4XXtskT
	 jWiMHm0McfeV/OHRKLslAA6kUkKjRlBgnZvookA7pma/cyUKZN0t+S+sDjKbfMYFqz
	 b/R8v4SFaCcbLGlrmVqgPXI+2T35yyum/GLrdpGlI4HIxsGK5rk1uJZfhnYpduGng7
	 kNnT0c3CarITMI24Hi1XLy4ZxQDMaoC28tPo1XUpv5PfVSliemmsW6AKVK+vhwsWeN
	 zWi7og/YIcTUBWj5ooYYcjoQXWzerY8T1vXbMfgF3PonNkhZj+AmeOw0+slacMmMn9
	 jxeTMW8QOvsUQ==
Date: Thu, 4 Sep 2025 10:14:09 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Matthias Klose <doko@debian.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Binutils <binutils@sourceware.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] Don't create sframes during build
Message-ID: <jdw2iyr2dd6fzasbiwbzsaqohbi46hwd7wb3ze6qhztje2b6ld@qnween3ajj5e>
References: <20250904131835.sfcG19NV@linutronix.de>
 <b3db475e-e84d-4056-9420-bc0acc8b9fe5@debian.org>
 <20250904163404.QMU7nfbA@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904163404.QMU7nfbA@linutronix.de>

On Thu, Sep 04, 2025 at 06:34:04PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-04 16:02:42 [+0200], Matthias Klose wrote:
> > [ CCing binutils@sourceware.org ]
> > 
> > On 9/4/25 15:18, Sebastian Andrzej Siewior wrote:
> > > Hi,
> > > 
> > > gcc in Debian, starting with 15.2.0-2, 14.3.0-6 enables sframe
> > > generation. Unless options like -ffreestanding are passed. Since this
> > > isn't done, there are a few warnings during compile
> > 
> > If there are other options when sframe shouldn't be enabled, please tell.
> 
> No, I think this is okay.
> 
> …
> > > We could drop the sframe during the final link but this does not get rid
> > > of the objtool warnings so we would have to ignore them. But we don't
> > > need it. So what about the following:
> > > 
> > > diff --git a/Makefile b/Makefile
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -886,6 +886,8 @@ ifdef CONFIG_CC_IS_GCC
> > >   KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
> > >   KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
> > >   endif
> > > +# No sframe generation for kernel if enabled by default
> > > +KBUILD_CFLAGS	+= $(call cc-option,-Xassembler --gsframe=no)
> > >   ifdef CONFIG_READABLE_ASM
> > >   # Disable optimizations that make assembler listings hard to read.
> > This is what I chose for package builds that need disablement of sframe.
> 
> I think this would work for now. Longterm we would have to allow sframe
> creation and keep section if an architecture decides to use it for its
> backtracing. While orc seems fine on x86, there are arm64 patches to use
> for as a stack unwinder.

This is probably fine, but... how does this interact with other kernel
makefiles enabling sframe?  For example, x86 will soon have a patch to
enable sframe generation for vdso.  And as you mentioned, arm64 will
enable it kernel-wide.

Removing the objtool !ENDBR warnings would be trivial (and is a good
thing to do regardless).

-- 
Josh

