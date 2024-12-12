Return-Path: <linux-arch+bounces-9369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E59EFA75
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 19:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B201188D01D
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 18:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7536235886;
	Thu, 12 Dec 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XG2faRez"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56B2336B6;
	Thu, 12 Dec 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026728; cv=none; b=q6CHKl9NJrB5y9oQTp/IGdF/JigTKUsbLNBCsmO4GPEbiWCIkm+amKS6AM7B30EkIUUfFM05FnPu0NnlXfQR70eQazDc8qvwO3Z2JSiuS6l1rIYutPsRF6fSa5jT2s9y8mBi9F/heJzxGNHzaE7a0zapGkTa692pwiXXeZe9M9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026728; c=relaxed/simple;
	bh=eEQ6dGGYGguF/NY4nMXxShJHfOZ+Uua4Ut2LTyixOUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+sjPg7rhygU8dY4iDfxGAR9gDBfjyxHeIoMLWipPyOP+rA4mTmevJkckNvAoBy7Fwsb6xLWITEyMCYo7pgx6qB3+OWEdT+gS+F+OnWIcnhrU+lRTS6QuPHy+f7Jig7MnwMeIoZU7oZXnoeykLV+evM52x1Zm5fd3fCgt+4MBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XG2faRez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479D1C4CEE1;
	Thu, 12 Dec 2024 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734026728;
	bh=eEQ6dGGYGguF/NY4nMXxShJHfOZ+Uua4Ut2LTyixOUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XG2faRezMybQf+yehFrpglZgJuDJP5Vmtuj1m3Oa77FVckhaQpa456AuGeV2O3UVP
	 vD7lDhNUvxmxgknw/ANXHf/XGqGm91LET5EHciPseFQtCnz0eYGFMOc39gG2F5YGep
	 vYc+Cp9QuPHPGmjLItnh2f3xvibLvqDXZUSkp0qE=
Date: Thu, 12 Dec 2024 19:05:24 +0100
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
Message-ID: <2024121201-recoup-gumming-92ce@gregkh>
References: <20241212144229.291682835@linuxfoundation.org>
 <20241212144239.574474355@linuxfoundation.org>
 <20241212180023.GA112010@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212180023.GA112010@google.com>

On Thu, Dec 12, 2024 at 06:00:23PM +0000, Eric Biggers wrote:
> On Thu, Dec 12, 2024 at 04:02:41PM +0100, Greg Kroah-Hartman wrote:
> > 5.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jiri Slaby <jslaby@suse.cz>
> > 
> > [ Upstream commit 74d8b90a889022e306b543ff2147a6941c99b354 ]
> > 
> > Use the newly added SYM_FUNC_START_LOCAL to annotate beginnings of all
> > functions which do not have ".globl" annotation, but their endings are
> > annotated by ENDPROC. This is needed to balance ENDPROC for tools that
> > generate debuginfo.
> > 
> > These function names are not prepended with ".L" as they might appear in
> > call traces and they wouldn't be visible after such change.
> > 
> > To be symmetric, the functions' ENDPROCs are converted to the new
> > SYM_FUNC_END.
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: x86-ml <x86@kernel.org>
> > Link: https://lkml.kernel.org/r/20191011115108.12392-7-jslaby@suse.cz
> > Stable-dep-of: 3b2f2d22fb42 ("crypto: x86/aegis128 - access 32-bit arguments as 32-bit")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  arch/x86/crypto/aegis128-aesni-asm.S         |  8 ++--
> >  arch/x86/crypto/aesni-intel_asm.S            | 49 ++++++++------------
> >  arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 20 ++++----
> >  arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 20 ++++----
> >  arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  8 ++--
> >  arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  8 ++--
> >  arch/x86/crypto/chacha-ssse3-x86_64.S        |  4 +-
> >  arch/x86/crypto/ghash-clmulni-intel_asm.S    |  4 +-
> >  arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  8 ++--
> >  arch/x86/crypto/serpent-avx2-asm_64.S        |  8 ++--
> >  arch/x86/crypto/twofish-avx-x86_64-asm_64.S  |  8 ++--
> >  11 files changed, 68 insertions(+), 77 deletions(-)
> 
> Unless the author of this patch acks this I'd rather you skipped this.  It's not
> worth the risk of regressions in the crypto code.

It's a dependancy of commit 3b2f2d22fb42 ("crypto: x86/aegis128 - access
32-bit arguments as 32-bit"), so should we drop that one also?

thanks,

greg k-h

