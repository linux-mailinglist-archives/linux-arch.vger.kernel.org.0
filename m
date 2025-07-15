Return-Path: <linux-arch+bounces-12774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3EEB056AF
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 11:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6732F3A3120
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3092D77E0;
	Tue, 15 Jul 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="robPKuiH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCB2D6402;
	Tue, 15 Jul 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572216; cv=none; b=EzMRiFzsUT5/DzaxgCRJg5kadmuzJBQBWwJHANXRTfou/vWZHtShB6RhZ70N6f+frK8hvNhGNC1Zv1NV0oIAft6wxK8Vdk0gRq2m8WvNbYWnRFONAZnlq62TDMeMEFaX1RX6mkRvxy4XDhPbV9oMSe+Vmb7VD6fvttbp0PZjGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572216; c=relaxed/simple;
	bh=y62YdeKQb3Brz+vPDdJj6AAr/0IGdUwhUAr08AzvvCM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cxjOSSa1ld1wOQRUvjK14jZq6BEbCmAfu8goKlkjV7teDsCtCUYigJT5oYFD8db6H4xR+76NkQj/inb+gHneznnUFRddfryZ7jnph55wTkvhBs9noRg06qF1fa/0nyHUV+NcRFC+qd2C8RsHFPLmzq3HCENWV+IDF9MsVAj0spk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=robPKuiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049EDC4CEF5;
	Tue, 15 Jul 2025 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752572216;
	bh=y62YdeKQb3Brz+vPDdJj6AAr/0IGdUwhUAr08AzvvCM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=robPKuiHQGjfNsHS936U4Wh0KdyxNe6rQBPxbPs4WcCmJaZECEXUVROdOCxgrXdF3
	 SbpLQN2KpTfZakdjTgd4c3zNP0TUqlFA5eTGi8YO2u5BX1srqI7WvXZoi4Q2IW/Pk+
	 Gr5Ngk9c882ZUKNLaIV75TM0BpQfZskSC02fB0g7p+iSJs2rGuUExptnRqYoBDZ32t
	 tM8p4R54r6bZpIlhV6JPC70qhuUNqSbFZrEd5mcxqCd81LvJSyR8dNfyYm1/u3Xv9b
	 qLtqee/ZfevZDHAYMxGYJFbWOpMFFqIYun1MPYlAdeDBC1lm7YDJM3IMo6DUekJCVJ
	 znl9emV8otw1w==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 11:36:49 +0200
Message-Id: <DBCIZY29JWTD.1G6AKZ08ZWBQG@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude Paul" <lyude@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org> <aHUSgXW9A6LzjBIS@Mac.home>
 <DBBVD70MASPW.2LUTJ51Y6SGMI@kernel.org> <aHUjIQlqphtgVP2g@Mac.home>
In-Reply-To: <aHUjIQlqphtgVP2g@Mac.home>

On Mon Jul 14, 2025 at 5:32 PM CEST, Boqun Feng wrote:
> On Mon, Jul 14, 2025 at 05:05:40PM +0200, Benno Lossin wrote:
> [...]
>> >> >  //!
>> >> >  //! [`LKMM`]: srctree/tools/memory-model/
>> >> > =20
>> >> > +pub mod generic;
>> >>=20
>> >> Hmm, maybe just re-export the stuff? I don't think there's an advanta=
ge
>> >> to having the generic module be public.
>> >>=20
>> >
>> > If `generic` is not public, then in the kernel::sync::atomic page, it
>> > won't should up, and there is no mentioning of struct `Atomic` either.
>> >
>> > If I made it public and also re-export the `Atomic`, there would be a
>> > "Re-export" section mentioning all the re-exports, so I will keep
>> > `generic` unless you have some tricks that I don't know.
>>=20
>> Just use `#[doc(inline)]` :)
>>=20
>>     https://doc.rust-lang.org/rustdoc/write-documentation/the-doc-attrib=
ute.html#inline-and-no_inline
>>=20
>> > Also I feel it's a bit naturally that `AllowAtomic` and `AllowAtomicAd=
d`
>> > stay under `generic` (instead of re-export them at `atomic` mod level)
>> > because they are about the generic part of `Atomic`, right?
>>=20
>> Why is that more natural? It only adds an extra path layer in any import
>> for atomics.
>>=20
>
> Exactly, users need to go through extra steps if they want to use the
> "generic" part of the atomic, and I think that makes user more aware of
> what they are essentially doing:
>
> - If you want to use the predefined types for atomic, just
>
>   use kernel::sync::atomic::Atomic;
>
>   and just operate on an `Atomic<_>`.
>
> - If you want to bring your own type for atomic operations, you need to
>
>   use kernel::sync::atomic::generic::AllowAtomic;
>
>   (essentially you go into the "generic" part of the atomic)
>
>   and provide your own implementation for `AllowAtomic` and then you
>   could use it for your own type.
>
> I feel it's natural because for extra features you fetch more modules
> in.

The same would apply if you had to import `AllowAtomic` from atomic
directly? I don't really see the value in this.

---
Cheers,
Benno

