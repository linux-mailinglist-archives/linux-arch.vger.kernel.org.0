Return-Path: <linux-arch+bounces-7632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B598E489
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 23:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372AC1F232B1
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D2195FE5;
	Wed,  2 Oct 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl8KC3tZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5E745F4;
	Wed,  2 Oct 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903012; cv=none; b=mKd6azZY2ATmXYb6Zs13nVirWliprvCi6uyqbey3kXTACgMp3WRRwsr7JPEILXTfhhgQmUNmWRroKxCvsBV5M2LkqWcp9u1F7T5LD3EvMLnUrFVg2AVoU7ozUUG8UDQriJrR8W1i6D8M9n0hxBquz6L6EdrSsv5f8HJqTt1/Oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903012; c=relaxed/simple;
	bh=m5V8nEEpYlGlVZDWEQ7TptbaHMCfNm7rcio6nGSaJJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcEzWHHXOJ6VjzqYTXZYs/9vU4aBf8sGZj9UNaXba9NfaLFMc2wsCaGWkEdYDEZyMBfPshwAlBveq+modMKuYn0CAJbEgT+DeodKrrpRQQ8Z9gjYbwBdiK22KrEtmQb9YgZVtE98Q33CNGgjuF08gCwUCnC0BO1Kqa07KxZiWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl8KC3tZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A291AC4CEC2;
	Wed,  2 Oct 2024 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727903011;
	bh=m5V8nEEpYlGlVZDWEQ7TptbaHMCfNm7rcio6nGSaJJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rl8KC3tZd039rFR6rkDKflcdPDktKVc62jDj1zBQ+ExZeAegFfAFcW0jURgy0ru0Q
	 z+EE6i7OL97uK7BOzZmrzS3WzZjcglbRF4ENV1uZHOUXaKoNI8o63IZkYGLrhgKSOw
	 zizpqO9sgkFqPGsWPZQEuJba4/gE7HlJN9f8smFftsj+15SVFJdVfNCsL8aOy691GK
	 /oQ2j3L6y8mfPyVG0P5RZBl/7M/g8T/SDen74+v/A19iBumsR3UbcCSNNraXToOfY2
	 WRn5D+lCRksHKBWcuaaISSf7nJ+N4ukdJpNN7+rFYc4lqArz7OSe2uBV5adDlSiCWA
	 aSGiVTST+N4TQ==
Message-ID: <374574a7-7060-48d5-b395-8a6d2c9f84a5@kernel.org>
Date: Wed, 2 Oct 2024 14:03:30 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arc: get rid of private asm/unaligned.h
To: Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>
References: <20241001195107.GA4017910@ZenIV> <20241001195300.GB4135693@ZenIV>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <20241001195300.GB4135693@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 12:53, Al Viro wrote:
> Declarations local to arch/*/kernel/*.c are better off *not* in a public
> header - arch/arc/kernel/unaligned.h is just fine for those
> bits.
>
> Unlike the parisc case, here we have an extra twist - asm/mmu.h
> has an implicit dependency on struct pt_regs, and in some users
> that used to be satisfied by include of asm/ptrace.h from
> asm/unaligned.h (note that asm/mmu.h itself did _not_ pull asm/unaligned.h
> - it relied upon the users having pulled asm/unaligned.h before asm/mmu.h
> got there).
>
> Seeing that asm/mmu.h only wants struct pt_regs * arguments in
> an extern, just pre-declare it there - less brittle that way.
>
> With that done _all_ asm/unaligned.h instances are reduced to include
> of asm-generic/unaligned.h and can be removed - unaligned.h is in
> mandatory-y in include/asm-generic/Kbuild.
>
> What's more, we can move asm-generic/unaligned.h to linux/unaligned.h
> and switch includes of <asm/unaligned.h> to <linux/unaligned.h>; that's
> better off as an auto-generated commit, though, to be done by Linus
> at -rc1 time next cycle.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Vineet Gupta <vgupta@kernel.org>

LGTM. And by your next tree is fine/preferred.

Thx,
-Vineet

