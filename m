Return-Path: <linux-arch+bounces-4901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 196719093AA
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2024 23:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F03BB22CC2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2024 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518151836C7;
	Fri, 14 Jun 2024 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GGbMHccH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843F13A24B;
	Fri, 14 Jun 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718400163; cv=none; b=WZx+ewLtxT3GZETcRxljiCmxmcPc0mdZfjUOh4XUWyqfYcBt8OQJuEd9CrEudT1q4n4P0dhVE/AZNwD+NZLORFI9u/jrPyV2Lrr+J25PStiig36edQ+V3uY0mpzYxQZA+sFIF3V87/tiXRZAUA8TgwgWusag6rqeP8Xx5MVi0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718400163; c=relaxed/simple;
	bh=mI0xdPiIrvwp6EccuD83bzOdj0amVBKo2auwQXYt8uE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q61tnWaCXIGZQYHYEHlOtSsjB8DrW02zqtDGn9zT2s9hfk8d6jo29gcFiSpwED268xntkWbRo3S43EEGyMQ60/VldFzFngj4ni4WdWk+Om8y4LsJUYDd95ptW3OlTtOVPiQCrWzDEC1W7cpdxyQXee8/QDczuJfAlrCzCLo+nwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GGbMHccH; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=masz3u7cozgmbioxpjqwm7i5ae.protonmail; t=1718400152; x=1718659352;
	bh=mI0xdPiIrvwp6EccuD83bzOdj0amVBKo2auwQXYt8uE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GGbMHccHMMsGnA/ccfGbUrR5Ou/GaweRk7E0oAtlGGyBcg52NBBjlrI00Y/agaBDJ
	 CEufLLgMBzlcAvbGboVOpXkQluxsmGSAzGhdhYEtoFmexZg5DmttSiVAvUGT51qbBe
	 V33dUaziIsAWC4qndI9dLduaBwSF+BZdcDikAIXaIm1bjM3RIJ/ARE05k6WRxH38GZ
	 K+dNjGtj7D7LksWZAk+iuEDyO+dWA7bDW9f44Eqxpwld1dTVHkP0nHv0L3ES4lwzdS
	 7/dA6hIHPXoLvQ25Yht47pYU0Cav3JsEJrb3po6zYvO07E+iCD1RN5VagbqatQnhMM
	 mb3QBQhupzr1A==
Date: Fri, 14 Jun 2024 21:22:24 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
In-Reply-To: <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
References: <20240612223025.1158537-1-boqun.feng@gmail.com> <20240612223025.1158537-3-boqun.feng@gmail.com> <20240613144432.77711a3a@eugeo> <ZmseosxVQXdsQjNB@boqun-archlinux> <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com> <ZmtC7h7v1t6XJ6EI@boqun-archlinux> <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com> <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 53ca9493f4ed178b60e9c57bdabd3b5e208fb377
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.06.24 16:33, Boqun Feng wrote:
> On Fri, Jun 14, 2024 at 11:59:58AM +0200, Miguel Ojeda wrote:
>> On Thu, Jun 13, 2024 at 9:05=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com=
> wrote:
>>>
>>> Does this make sense?
>>
>> Implementation-wise, if you think it is simpler or more clear/elegant
>> to have the extra lower level layer, then that sounds fine.
>>
>> However, I was mainly talking about what we would eventually expose to
>> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
>=20
> The truth is I don't know ;-) I don't have much data on which one is
> better. Personally, I think AtomicI32 and AtomicI64 make the users have
> to think about size, alignment, etc, and I think that's important for
> atomic users and people who review their code, because before one uses
> atomics, one should ask themselves: why don't I use a lock? Atomics
> provide the ablities to do low level stuffs and when doing low level
> stuffs, you want to be more explicit than ergonomic.

How would this be different with `Atomic<i32>` and `Atomic<i64>`? Just
because the underlying `Atomic<I>` type is generic shouldn't change
this, right?

---
Cheers,
Benno


