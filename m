Return-Path: <linux-arch+bounces-9386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5D69F0BFA
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 13:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB26F283540
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA321DF721;
	Fri, 13 Dec 2024 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqYbLJa4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7D1DF263;
	Fri, 13 Dec 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092068; cv=none; b=hWNpmoLhbfT8m+WPwLR/PXrQsSsN0c4+aEZ6benbju6mnWFx/AUD1LdTdoXE+JDq5zuv3CG+k1JkujSAUcKTht7U2m9Chx+K4rxlBWEaUotBgikKfbaa6WpcBr/McmWg2NSFQNAOP0yXkhQzcsCKIJs9a8xuDpbvrSyZn3xWGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092068; c=relaxed/simple;
	bh=sDiy10/kD9Kt51SgGl3FtSgXlIXSItrKPlATcZNKpG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZhStXKLPJvnfSqolFQoQslZ0gbf0Ti88OCFzyuOdiWmedbSnlI04GzyqNzlreJLoVtkLIYRTpbz0r6cG9jXTS8IrTH+g/I/hjNyV0w6k59NSlsUnlm7+s0QKutE7lM0pnVevr3Mk8Zh8j7ZAIGq3ZLM8qU7OHdiReVFRBzQWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EqYbLJa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708F0C4CED0;
	Fri, 13 Dec 2024 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734092067;
	bh=sDiy10/kD9Kt51SgGl3FtSgXlIXSItrKPlATcZNKpG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqYbLJa4H7fDN/UxVe8N2CnJOQx/9zyjmrsHGDC+u1Sjsw/EhzMk4/YEKaM2zZy1f
	 xyvDY/fnp5rsV1U+IS2Uc4I/g60opzE/m32ZM8yHWuLQ9Z1BrmUceaAigPC9z8bK0K
	 n19Pgf1iP9fbZDZz3M+Llcc+ctBymtB1llaOu2dA=
Date: Fri, 13 Dec 2024 13:14:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 243/321] x86/asm/crypto: Annotate local functions
Message-ID: <2024121300-immerse-gooey-ee4f@gregkh>
References: <20241212144229.291682835@linuxfoundation.org>
 <20241212144239.574474355@linuxfoundation.org>
 <20241212180023.GA112010@google.com>
 <2024121201-recoup-gumming-92ce@gregkh>
 <20241212180856.GB112010@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212180856.GB112010@google.com>

On Thu, Dec 12, 2024 at 06:08:56PM +0000, Eric Biggers wrote:
> On Thu, Dec 12, 2024 at 07:05:24PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 12, 2024 at 06:00:23PM +0000, Eric Biggers wrote:
> > > On Thu, Dec 12, 2024 at 04:02:41PM +0100, Greg Kroah-Hartman wrote:
> > > > 5.4-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Jiri Slaby <jslaby@suse.cz>
> > > > 
> > > > [ Upstream commit 74d8b90a889022e306b543ff2147a6941c99b354 ]
> > > > 
> > > > Use the newly added SYM_FUNC_START_LOCAL to annotate beginnings of all
> > > > functions which do not have ".globl" annotation, but their endings are
> > > > annotated by ENDPROC. This is needed to balance ENDPROC for tools that
> > > > generate debuginfo.
> > > > 
> > > > These function names are not prepended with ".L" as they might appear in
> > > > call traces and they wouldn't be visible after such change.
> > > > 
> > > > To be symmetric, the functions' ENDPROCs are converted to the new
> > > > SYM_FUNC_END.
> > > > 
> > > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > > Signed-off-by: Borislav Petkov <bp@suse.de>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: linux-arch@vger.kernel.org
> > > > Cc: linux-crypto@vger.kernel.org
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: x86-ml <x86@kernel.org>
> > > > Link: https://lkml.kernel.org/r/20191011115108.12392-7-jslaby@suse.cz
> > > > Stable-dep-of: 3b2f2d22fb42 ("crypto: x86/aegis128 - access 32-bit arguments as 32-bit")
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  arch/x86/crypto/aegis128-aesni-asm.S         |  8 ++--
> > > >  arch/x86/crypto/aesni-intel_asm.S            | 49 ++++++++------------
> > > >  arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 20 ++++----
> > > >  arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 20 ++++----
> > > >  arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  8 ++--
> > > >  arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  8 ++--
> > > >  arch/x86/crypto/chacha-ssse3-x86_64.S        |  4 +-
> > > >  arch/x86/crypto/ghash-clmulni-intel_asm.S    |  4 +-
> > > >  arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  8 ++--
> > > >  arch/x86/crypto/serpent-avx2-asm_64.S        |  8 ++--
> > > >  arch/x86/crypto/twofish-avx-x86_64-asm_64.S  |  8 ++--
> > > >  11 files changed, 68 insertions(+), 77 deletions(-)
> > > 
> > > Unless the author of this patch acks this I'd rather you skipped this.  It's not
> > > worth the risk of regressions in the crypto code.
> > 
> > It's a dependancy of commit 3b2f2d22fb42 ("crypto: x86/aegis128 - access
> > 32-bit arguments as 32-bit"), so should we drop that one also?
> > 
> 
> Well it is not a dependency if the conflict is properly resolved, but I would
> just drop it too.  In theory it fixes a bug, but we haven't seen gcc or clang
> generating code that makes it matter.  Also I've noticed that some other asm
> files have the same issue...

Good point, I've fixed up the dependant patch so that it doesn't need
this one, and dropped this one from the queue.

thanks for the review!

greg k-h

