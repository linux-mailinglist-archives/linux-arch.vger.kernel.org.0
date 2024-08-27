Return-Path: <linux-arch+bounces-6648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7350960456
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82ABB1F20D3B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FBF156F4C;
	Tue, 27 Aug 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eJrITo3p"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B711154BEB;
	Tue, 27 Aug 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747040; cv=none; b=jaXQs0Wtktz6ybyp3CJD+ZB1ixBsDi9A9wcxG32KsXyiYbZ8LtCppzXCll8uN7fUz01FqDwCea6kYBGeIKZcoVAy+nFrrJIlJF60i6B7ooAU+9/PMjWnrwBgWgkbZupwCyEnLVg6k6URHyptsTL0QrsQ+lTrkozOsoH/Bldf3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747040; c=relaxed/simple;
	bh=ZQoe9VQ0ADakiAR1Y3621lCKv37S8UpxGnuefQ+uoKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiCeieLAC1sCD3z9fC6h+enwzOdWtyWuaeTinblDFzfhrj8kJp+2ZKPudr4TvOd/aBfNLNXWtxf4SPhJOJwiu8LgKwI8DNsfGu87o9ZqS4u+qhUlX86T2fXuKWIWv2rXNeWZQh4aNMORnTOOFsCJ9HO/Usb0OIMwwHuF2WWwygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eJrITo3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB19C8B7A1;
	Tue, 27 Aug 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eJrITo3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724747037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WmuK606DFi2DMVMI66hSRWyNshgp94GdeNA0AaiDqDE=;
	b=eJrITo3pS1iTlmVRqXA4ossHQBCcqlsHt8xrxE0R9KhNEW05nlyFHJ7Q5ejNuECbDi0JQL
	dyZtB2nZ/WNhieoOU8GA6Sh0CZEvlKXGqRVYQTGP9gO5q25pQSZWNFCM1tqp8r5qUzm5kj
	tdyLngda2WPJXrCNlqQ+6kee5gX21+s=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 865e0cd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 08:23:57 +0000 (UTC)
Date: Tue, 27 Aug 2024 10:23:50 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/4] random: vDSO: Don't use PAGE_SIZE and PAGE_MASK
Message-ID: <Zs2NFjfBKKjfoI2d@zx2c4.com>
References: <cover.1724743492.git.christophe.leroy@csgroup.eu>
 <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <Zs2FJku2hM2bp4ik@zx2c4.com>
 <55a7d3ba-b384-4fb0-8fbb-e05ddf0d1fb8@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55a7d3ba-b384-4fb0-8fbb-e05ddf0d1fb8@csgroup.eu>

On Tue, Aug 27, 2024 at 10:16:18AM +0200, Christophe Leroy wrote:
> tglx or yourself suggested to put in a one of the vdso headers instead 
> of directly in getrandom.c. This is too fragile because PAGE_SIZE might 
> be absent in that header but arrive in getrandom.c through another header.

Oh jeeze, yea.

FYI, _PAGE_SIZE is defined on s390, so that might not be such a good
idea (from the previous version).

> The best would be to have an asm-generic definition of
> PAGE_SIZE and PAGE_MASK that all architectures use, but that's another
> level of work.

Yea that seems far too large of an operation to do here.

> > I'm really not a fan of making the code less idiomatic...
> 
> Ok, I have another idea, let's give it a try.

What's the other idea?

