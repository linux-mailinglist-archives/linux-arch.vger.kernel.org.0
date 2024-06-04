Return-Path: <linux-arch+bounces-4688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2958FBDE6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 23:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C85286270
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13E14BF8F;
	Tue,  4 Jun 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWHcPG8z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681E14B95F;
	Tue,  4 Jun 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535647; cv=none; b=ACMwHeehhaE/vvUYfLgGovWyqz57SpGxLIuS+Wy1Kum1TLXpb5Ymakf+UuHb/34y/It4wi0Ds21g6uEU37L9N3q5qMJu+xU2lA4PzepzMB86s8f2/YGboBgIveCzctdhuaRh+0DuJoF+XU9ezzARfbkSJmDOJJIiPfkgZV8fQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535647; c=relaxed/simple;
	bh=CAp13sZ7M4MgUyj523wMYv5f7s1+3dQaiYzmf+CALUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d65bwOazvFLDA+RJPtTBlvijNnhIgBZ52INTmQ5z54XQUBIpWOEcNEk+kUrf+I8pi1D4jEb9RMU44uPLMYQREKIZceFwTGWp8+0Z1xZDhUV/X3g78TW0JIClwMLZknbpZkKaTn3ufHyRAcgKen+LmUTqjk+4K25ExonByCFvPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWHcPG8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8BFC2BBFC;
	Tue,  4 Jun 2024 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717535646;
	bh=CAp13sZ7M4MgUyj523wMYv5f7s1+3dQaiYzmf+CALUE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YWHcPG8zSzkxbQ2gjOWPg9XOi7yjjgQ7TQGjcnThDcySzE7e/8ZtQBWrO0oaOwGbI
	 5dSTQVZ1aR+4VB286yYr3o6B2oyNTuAXw8fVDjDLGRJ1mbVgVUcsbzNucAI74Rnw6I
	 gu/zz1xhOazlSg3yNOcBNSxMOiMzusPUL9eRzXESVC/X3Z8ZPy3p0ww5k01vpSSx1I
	 sfWb4M1kc8T58kJMPNVoj4xogRQAv/dmEc/3BLy0CodAOcQMAJisxQBqTXsjYFkI2l
	 YKsnMZaIPuXS0Yy82yEGrm7eG087oIlbjvsx8Mxx2Us6A4/czu0rwYgY0iTX0pp8BR
	 tCBQG9EroRJJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F68CCE3ED6; Tue,  4 Jun 2024 14:14:06 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:14:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org,
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org,
	pmladek@suse.com, torvalds@linux-foundation.org, arnd@arndb.de,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>, Eric DeVolder <eric.devolder@oracle.com>,
	Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 cmpxchg 4/4] ARM: Emulate one-byte cmpxchg
Message-ID: <2fbe86b7-70f0-46cd-b7b7-9d67e78d72f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
 <20240604170437.2362545-4-paulmck@kernel.org>
 <CACRpkdaYQWGsjtDPzbJS4C9Y9z8JGv=3ihQrVKvegJf8ujqSmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaYQWGsjtDPzbJS4C9Y9z8JGv=3ihQrVKvegJf8ujqSmA@mail.gmail.com>

On Tue, Jun 04, 2024 at 10:52:23PM +0200, Linus Walleij wrote:
> Hi Paul,
> 
> thanks for your patch! This caught my eye:
> 
> On Tue, Jun 4, 2024 at 7:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on ARM systems
> > with ARCH < ARMv6K.
> 
> ARCH == ARMv6.
> 
> This ARCH < ARMv6K comes from inversion of the the a bit terse
> comment for ifndef CONFIG_CPU_V6, which means "out of the
> post-v6 CPUs, the following applies to those > V6".
> 
> The code in the patch, IIUC make use of cmpxchg_emu_u8()
> if and only if the CPU is V6.
> 
> > -#ifndef CONFIG_CPU_V6  /* min ARCH >= ARMv6K */
> > +#ifdef CONFIG_CPU_V6   /* min ARCH < ARMv6K */
> 
> This is now a set with one member so this comment should say:
> 
> /* ARCH == ARMv6 */
> 
> After this change.

Thank you for looking this over!  Does the following patch (to be merged
into the original) capture it properly?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index a428e06fe94ee..9beb64d305866 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -163,11 +163,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	prefetchw((const void *)ptr);
 
 	switch (size) {
-#ifdef CONFIG_CPU_V6	/* min ARCH < ARMv6K */
+#ifdef CONFIG_CPU_V6	/* ARCH == ARMv6 */
 	case 1:
 		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
 		break;
-#else /* min ARCH >= ARMv6K */
+#else /* min ARCH > ARMv6 */
 	case 1:
 		do {
 			asm volatile("@ __cmpxchg1\n"

