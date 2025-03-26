Return-Path: <linux-arch+bounces-11152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C115A726AC
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 23:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEBF1891802
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41CF1ACECE;
	Wed, 26 Mar 2025 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUg/1wg7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4D18801A;
	Wed, 26 Mar 2025 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029688; cv=none; b=O85q2KIDAP/jiu7mP6XfvYGO5bQhRbL0FtoAjkM5RHPIEMKmyG2YDj/WQFp3aabWVDWGuUbnjbS9+zbQc9H/ntgXTJwBloztPyhFuEeBlypBX9AHh28EnTZX1lTK0HlnZgom/0hehtXYxlOgDhiahRpz5O2j9jYkFhRcPU5ogpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029688; c=relaxed/simple;
	bh=GgcljgfG1DaQG+oMSBUTyUxRnnHejAcnjTuk1lFoG8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoM/5jAOO5i5xIOrBf/gOHs/N8Nfg/4bVtFz0zUuIO//Ab2WIganJXyf3M8A1xRxuQQiDXPbb93sNaFL6GggFDwgWXCq9FgAu3HM4rOXTqp8F4T5OqoM4dbLpfE3fQujlrw2og48I0GyLlRPBnr/wLGaZwxTOhxa6BFlPwXmwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUg/1wg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53EDC4CEE2;
	Wed, 26 Mar 2025 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743029688;
	bh=GgcljgfG1DaQG+oMSBUTyUxRnnHejAcnjTuk1lFoG8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUg/1wg7gKlXDctU9lZcZ29ktJ6dAug9ISQTcZAyjyW/3lerzJnqXGawMcCCXtkxv
	 S9lxkaNBiNwC0AXnCtSJF9ftHbWqCg9ZG3q45v2xKADoIIRo+rhEfgXxTFRfI3kTS8
	 bHyUceuL/aeGtwZDmQHGlYlV3Uc6TervIudLA0Dc4B2dBSL0JsHW4VZB+kDyY0ANu6
	 ZJTAcAT7yajiJA3qw2tBnSZzyLThIHuHGwPVN/5JhC8YV68sC0kOSmiKnP7KP7ypIf
	 24i2RY5QwKKcCG91GaMLhNTUWbzxErhs3vQMEEf3qQdxVSBhlYgTZGXpFG5ioLbelF
	 gb84SCYi+49nA==
Date: Wed, 26 Mar 2025 15:54:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
	Marco Elver <elver@google.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwonce: fix crash by removing READ_ONCE() for unaligned
 read
Message-ID: <20250326225444.GA1743548@ax162>
References: <20250326-rwaat-fix-v1-1-600f411eaf23@google.com>
 <4b412238-b20a-4346-bf67-f31df0a9f259@app.fastmail.com>
 <CAHk-=wikuhxhdSEgqb-Lkb2ibQM_hAHR1Cu7yxg-gHZu1NF+ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wikuhxhdSEgqb-Lkb2ibQM_hAHR1Cu7yxg-gHZu1NF+ug@mail.gmail.com>

On Wed, Mar 26, 2025 at 03:41:34PM -0700, Linus Torvalds wrote:
> That said, this whole thing worries me. The fact that the compiler
> magically makes READ_ONCE() require alignment that it normally doesn't
> require seems like a bug waiting to happen somewhere else.

For the record, I do not think it is the compiler doing this, it is the
arm64 code after commit e35123d83ee3 ("arm64: lto: Strengthen
READ_ONCE() to acquire when CONFIG_LTO=y") back in 5.11.

> Because I do think that we might want READ_ONCE() on unaligned data in
> general. Should said places generally use "get_unaligned()"? Sure. And
> are unaligned accesses potentially non-atomic anyway because of
> hardware? Also sure.
> 
> But one reason for READ_ONCE() isn't for some kind of hardware
> atomicity, it is to avoid any ToCToU issues due to compilers doing bad
> things.
> 
> And then this seems to be a serious issue with the whole "READ_ONCE()
> now requires alignment that it didn't require before".
> 
> Put another way: I wonder what other cases may lurk around this all...

That change has caused only one issue that I know of, which was fixed by
commit d3f450533bbc ("efi: tpm: Avoid READ_ONCE() for accessing the
event log"). I have not seen any since then until this point and I do
daily boots of -next with LTO enabled on both of my arm64 test machines.

Cheers,
Nathan

