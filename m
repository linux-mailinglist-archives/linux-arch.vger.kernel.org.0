Return-Path: <linux-arch+bounces-15817-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 017BCD29695
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 01:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F01305CAA3
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C12F7AAB;
	Fri, 16 Jan 2026 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vEKoIAY6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9E2F7478;
	Fri, 16 Jan 2026 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768523280; cv=none; b=V8ggWC2xG1R5gp0GA2p0rBL0b9fLK8L4lw7gnVkFGDL0GCmAxE44Cwp80JHyoX2fKuIOmVI8l3ZeVH9f+AcQJcdlpxXyZWe4XK3iq3EzRHbqQYA4GaoHq+wpFtxnf0cVKLyPxjDAy7eVAG+RSqX0SE9ulGRbQcnoGym+XRnN5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768523280; c=relaxed/simple;
	bh=YV6ChD24v87T0e1S9B6uWgobgiLdIGOUGGt8/uzGG/s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bQJvxzs90q5WDnGJSzCZNkJQfdvZUbi53jLyQ3IXmDWa7w0523wB7U0bzHoyQFaovFIPzBt8PyhratcPX0Zj34ZNxYYt95Vb+g/EVcPohanD6APSf4jllDlJi2wSebBXCQ5wQ6mMnd81GMXVP6GdAOTbCD0a14cQl+qvSC4zGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vEKoIAY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E71C116D0;
	Fri, 16 Jan 2026 00:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768523279;
	bh=YV6ChD24v87T0e1S9B6uWgobgiLdIGOUGGt8/uzGG/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vEKoIAY6eL4hRGcdCttIzUgXRzV5Iiurh95nHkTsQfRUJJGyvrPt17mGFK+MrgLYM
	 sKRJtzIq7qmrO1LIXaBocTkhWOusYT5KQWowJuXVqVkCdY6rjXakEfL6boM4W/7wZb
	 nEva7fgF42qfT7z+KryQ9vp9kpLzKo8pGQStcm00=
Date: Thu, 15 Jan 2026 16:27:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra
 <peterz@infradead.org>, Will Deacon <will@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Sasha Levin <sashal@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 3/4] atomic: Add alignment check to instrumented
 atomic operations
Message-Id: <20260115162758.4d29875e8b75d8bdbb04d170@linux-foundation.org>
In-Reply-To: <740c3d41-42d8-efa8-3ff0-a2f9cc7a2c49@linux-m68k.org>
References: <cover.1768281748.git.fthain@linux-m68k.org>
	<51ebf844e006ca0de408f5d3a831e7b39d7fc31c.1768281748.git.fthain@linux-m68k.org>
	<CAMuHMdXSXcxzhgfFyc3sBdyoJ4vq9sMpzLBLcZskqtZXdAjH+g@mail.gmail.com>
	<740c3d41-42d8-efa8-3ff0-a2f9cc7a2c49@linux-m68k.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 14:53:33 +1100 (AEDT) Finn Thain <fthain@linux-m68k.org> wrote:

> 
> On Tue, 13 Jan 2026, Geert Uytterhoeven wrote:
> 
> > >
> > > ---
> > > Checkpatch.pl says...
> > > ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Ziljstra <peterz@infradead.org>'
> > 
> > Alternatively, you can credit Peter using
> > 
> >     Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > 
> > just before the Link-header pointing to his suggestion.
> > 
> 
> I'll leave that up to Peter as he's both author and maintainer.

We have his signoff.

> If there was to be another revision, perhaps I can add --
> 
>     Suggested-by-suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>

edited and added, thanks.

