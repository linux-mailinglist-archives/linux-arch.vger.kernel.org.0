Return-Path: <linux-arch+bounces-9370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF59EFAB5
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 19:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4B31890CCF
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF0822C354;
	Thu, 12 Dec 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nldMsqM9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D82253FC;
	Thu, 12 Dec 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026938; cv=none; b=B27CvdJZ2g5q79Pl97S9f2MX5HSr80sWoJLZHY369Hh69Gh/dTWX608V8o5JPxuWab0wCNIZs8bp8JyC+QLsdHCrNaoL+NxVoQX+x2UskcFlwwjNuFEAGI6YD4NQgkQNwYqTL9AO0QKs1fDhech822KTmQwNYszRZ/U/KdyC3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026938; c=relaxed/simple;
	bh=8NrVgyvw6gNljikFdLNfOJ2Px+yIA4Ixm4ziCPFuyqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azMNTNF4Hyc/Y4tgUK4TCAc1XB6kXn5B2ywYcuublmgWXxWOuEVEOGgwVr6ivnoE4qx3ddZta1+qs1yM8kyogmgq4WoizlMgWzkFdpFr1gwjidRMXxz6KE17HISdZgL20NdnveNNp29XdDCaRV3JcPoT81F94OV7JdFulNVmSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nldMsqM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FA0C4CECE;
	Thu, 12 Dec 2024 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026938;
	bh=8NrVgyvw6gNljikFdLNfOJ2Px+yIA4Ixm4ziCPFuyqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nldMsqM9LMd4Ih2dMDG99LlbVakVaNlz/D03looKnbC95VyvgT7bv+BGH6azjgWDJ
	 aTNF8TrKq2WMRAzlfS4oDTbQGxi7JMix/lX5kLLxJeISJsl9xebHrFnYwkkwK3Vkso
	 Xn8GErSlebSMGg2RvZKl2xL2A8dC7sGAPYwQXOiWfYAJK1cjLx8GCkB6n37nT+VU87
	 zluiVt8L5ZMwm63WBBJYgXPNaIaD7Prnv0LSFXwMZMvuLgt0Gtam2wil2++7G8gKL1
	 uODVwQAD/IEGq1G4x0mBDqbvrujQI0NsdJlk8QTBHABGLUBu5nlyb2LxLU2OHyoECP
	 otu4tF+HFr88g==
Date: Thu, 12 Dec 2024 18:08:56 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 243/321] x86/asm/crypto: Annotate local functions
Message-ID: <20241212180856.GB112010@google.com>
References: <20241212144229.291682835@linuxfoundation.org>
 <20241212144239.574474355@linuxfoundation.org>
 <20241212180023.GA112010@google.com>
 <2024121201-recoup-gumming-92ce@gregkh>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121201-recoup-gumming-92ce@gregkh>

On Thu, Dec 12, 2024 at 07:05:24PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 12, 2024 at 06:00:23PM +0000, Eric Biggers wrote:
> > On Thu, Dec 12, 2024 at 04:02:41PM +0100, Greg Kroah-Hartman wrote:
> > > 5.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Jiri Slaby <jslaby@suse.cz>
> > > 
> > > [ Upstream commit 74d8b90a889022e306b543ff2147a6941c99b354 ]
> > > 
> > > Use the newly added SYM_FUNC_START_LOCAL to annotate beginnings of all
> > > functions which do not have ".globl" annotation, but their endings are
> > > annotated by ENDPROC. This is needed to balance ENDPROC for tools that
> > > generate debuginfo.
> > > 
> > > These function names are not prepended with ".L" as they might appear in
> > > call traces and they wouldn't be visible after such change.
> > > 
> > > To be symmetric, the functions' ENDPROCs are converted to the new
> > > SYM_FUNC_END.
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > Signed-off-by: Borislav Petkov <bp@suse.de>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: linux-arch@vger.kernel.org
> > > Cc: linux-crypto@vger.kernel.org
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: x86-ml <x86@kernel.org>
> > > Link: https://lkml.kernel.org/r/20191011115108.12392-7-jslaby@suse.cz
> > > Stable-dep-of: 3b2f2d22fb42 ("crypto: x86/aegis128 - access 32-bit arguments as 32-bit")
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  arch/x86/crypto/aegis128-aesni-asm.S         |  8 ++--
> > >  arch/x86/crypto/aesni-intel_asm.S            | 49 ++++++++------------
> > >  arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 20 ++++----
> > >  arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 20 ++++----
> > >  arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  8 ++--
> > >  arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  8 ++--
> > >  arch/x86/crypto/chacha-ssse3-x86_64.S        |  4 +-
> > >  arch/x86/crypto/ghash-clmulni-intel_asm.S    |  4 +-
> > >  arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  8 ++--
> > >  arch/x86/crypto/serpent-avx2-asm_64.S        |  8 ++--
> > >  arch/x86/crypto/twofish-avx-x86_64-asm_64.S  |  8 ++--
> > >  11 files changed, 68 insertions(+), 77 deletions(-)
> > 
> > Unless the author of this patch acks this I'd rather you skipped this.  It's not
> > worth the risk of regressions in the crypto code.
> 
> It's a dependancy of commit 3b2f2d22fb42 ("crypto: x86/aegis128 - access
> 32-bit arguments as 32-bit"), so should we drop that one also?
> 

Well it is not a dependency if the conflict is properly resolved, but I would
just drop it too.  In theory it fixes a bug, but we haven't seen gcc or clang
generating code that makes it matter.  Also I've noticed that some other asm
files have the same issue...

- Eric

