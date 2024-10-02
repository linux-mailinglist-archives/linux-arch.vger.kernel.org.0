Return-Path: <linux-arch+bounces-7634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6EB98E4D8
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 23:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3A01C21C6F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 21:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FABA216A3D;
	Wed,  2 Oct 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fCuUIFcn"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE391946B9;
	Wed,  2 Oct 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904282; cv=none; b=W6hBt8tA/QwZ9w8XjRLrarhBdgqTaqa7+0LcYh7dsd+FVigx0FScqWEUZp7xNgaWkO0OpuGcINRtz6sKxiEbM8BtpPNM2palC9IwxVc9MmFxiAxjCz7kNw4fzDB31v4axbtUJpS0S0/3W0YXzUrfSVWKHkVxcgjlWJrxkcsG8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904282; c=relaxed/simple;
	bh=Olm/UfX5pvQOEYSTJrVoiU4BvfCepDmmVDZA5VNYg0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS989M0GmQ1iNQ0qqAKjmKpxOOY2ffJmClAE++h8umbQiPsdfNqn3aDLU814ksgijobZQwF+6IwLCcWVYzZ2oTxCj2gj/lqrJ1r8iR3w9oOIF5gksWU2GxPhioHTxVg8Q9XjU9/Zf2wDFGsi8FCDBIjE72wzIngujjbkP2G0xHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fCuUIFcn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iLTAakP6KaTQCvlhDHZzbsJqOUGPxhWT30ppfemZxiY=; b=fCuUIFcnvb2E1qKpYJlZ2wbubH
	SP08d0EjlToOmr7julhwjkhOos6FJF+gwmDr+ZeFjrtQHWkVlmT5PMCWsCLsptf6suogUwLMmxpzq
	MA1aO5fMWLj/3Ru8MIaI78bZife9uahnov+MamFv+h0TPwy4BQ6I5Vmc7U79BYt3Ebi/yQK+UGznS
	iFsvIHJYJ4od7QiAu1bDJh45H1Jlargany8wN4iDxqkaowqpyvDks5PWwxK/c4uMjTaA0wm8c6PHl
	1tSTqPFHncLTdIYGRneS+PbmdbUQGUN2md0doiPYNZo18q9VnfHFOtq7MNFK9PL7Av6yOoQF0/nlz
	DGupUv9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw6pp-00000000JzQ-48t3;
	Wed, 02 Oct 2024 21:24:38 +0000
Date: Wed, 2 Oct 2024 22:24:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Vineet Gupta <vgupta@kernel.org>
Cc: linux-arch@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH 2/3] arc: get rid of private asm/unaligned.h
Message-ID: <20241002212437.GF4017910@ZenIV>
References: <20241001195107.GA4017910@ZenIV>
 <20241001195300.GB4135693@ZenIV>
 <374574a7-7060-48d5-b395-8a6d2c9f84a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374574a7-7060-48d5-b395-8a6d2c9f84a5@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 02, 2024 at 02:03:30PM -0700, Vineet Gupta wrote:
> On 10/1/24 12:53, Al Viro wrote:
> > Declarations local to arch/*/kernel/*.c are better off *not* in a public
> > header - arch/arc/kernel/unaligned.h is just fine for those
> > bits.
> >
> > Unlike the parisc case, here we have an extra twist - asm/mmu.h
> > has an implicit dependency on struct pt_regs, and in some users
> > that used to be satisfied by include of asm/ptrace.h from
> > asm/unaligned.h (note that asm/mmu.h itself did _not_ pull asm/unaligned.h
> > - it relied upon the users having pulled asm/unaligned.h before asm/mmu.h
> > got there).
> >
> > Seeing that asm/mmu.h only wants struct pt_regs * arguments in
> > an extern, just pre-declare it there - less brittle that way.
> >
> > With that done _all_ asm/unaligned.h instances are reduced to include
> > of asm-generic/unaligned.h and can be removed - unaligned.h is in
> > mandatory-y in include/asm-generic/Kbuild.
> >
> > What's more, we can move asm-generic/unaligned.h to linux/unaligned.h
> > and switch includes of <asm/unaligned.h> to <linux/unaligned.h>; that's
> > better off as an auto-generated commit, though, to be done by Linus
> > at -rc1 time next cycle.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Acked-by: Vineet Gupta <vgupta@kernel.org>
> 
> LGTM. And by your next tree is fine/preferred.

Done.  It's in #for-next, and if nobody introduces arch/*/include/asm/unaligned.h
this cycle, the pull request will be followed by request to run the conversion
script at -rc1...

