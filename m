Return-Path: <linux-arch+bounces-12783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D9B0632A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B1B7AF406
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 15:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0842246BA7;
	Tue, 15 Jul 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC7JbDzL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC324337B;
	Tue, 15 Jul 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593729; cv=none; b=qjyw5AifJVCdp20xmyWikSfs+aVV5glQFqgLf2mLfsJTXMJSBUYNjvcjg1tpINYLCzDBgX9BKGAyNKl0njQCPAPCvf8yXlPgmZrRJVHresT/k9YiEc8vGFX9uU9NJcabmcNiU0P5XGMQGWIeQnpcWr/d28/5p2JfxCeJSgzg53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593729; c=relaxed/simple;
	bh=Ds3Unjbza1/cF66Vf+z3ZVebDx1X4MC2m4XT4rnZRac=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=L5/D2+PBzE1TdpJU9JpJPElAAB4td7aBz1vZzhpC3IStvBownR5iXTb7AjvSzfYA6Qind99oHVVo8nVGV+0FAvHFkIkAKFrVowYbz9ciDGEe1W94f9fqqhYffDuQbibhG+hdHNKXp/i4wZA0zvOWUpnX17OBX/HY3Iu4j1V7A0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC7JbDzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFA3C4CEE3;
	Tue, 15 Jul 2025 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752593728;
	bh=Ds3Unjbza1/cF66Vf+z3ZVebDx1X4MC2m4XT4rnZRac=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=UC7JbDzL5ZgPsIPM7YbSe+BaJGdh9ax6k4XUrRb/Hd/hHEgjMZYYE6A3nq1J1+F1t
	 +hbGAkS9cK9gq4CqMMdDo7arspwQcfVBMXDKLQNA628uYovpFUYLI34Ez0rWKXlV7/
	 5y8JcVNlWytqJ4+KnOa6165vZQC5exD1YnbgssA61CMWuuwbiVSuJHkiXhFkeMEgFt
	 fYXJgoinpU9hnSGXjVNrxndd3bvEaxZ4pGLGxhtGR9HZuCbZv9AtLdJdqXQw/TqmzS
	 Lvc2vUCj8tQabLc+8Td78xVnSMh1q10JuQujFhfiiTXAE/992h3GyiQwqlD6D7H+lQ
	 S2bZ+1lrglZtw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 17:35:22 +0200
Message-Id: <DBCQMGZUV0GY.1D2U4FQT6E2PF@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
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
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org> <aHUSgXW9A6LzjBIS@Mac.home>
 <DBBVD70MASPW.2LUTJ51Y6SGMI@kernel.org> <aHUjIQlqphtgVP2g@Mac.home>
 <DBCIZY29JWTD.1G6AKZ08ZWBQG@kernel.org> <aHZUO4NwMlw-FsnZ@Mac.home>
In-Reply-To: <aHZUO4NwMlw-FsnZ@Mac.home>

On Tue Jul 15, 2025 at 3:14 PM CEST, Boqun Feng wrote:
> On Tue, Jul 15, 2025 at 11:36:49AM +0200, Benno Lossin wrote:
>> On Mon Jul 14, 2025 at 5:32 PM CEST, Boqun Feng wrote:
>> > On Mon, Jul 14, 2025 at 05:05:40PM +0200, Benno Lossin wrote:
>> > [...]
>> >> >> >  //!
>> >> >> >  //! [`LKMM`]: srctree/tools/memory-model/
>> >> >> > =20
>> >> >> > +pub mod generic;
>> >> >>=20
>> >> >> Hmm, maybe just re-export the stuff? I don't think there's an adva=
ntage
>> >> >> to having the generic module be public.
>> >> >>=20
>> >> >
>> >> > If `generic` is not public, then in the kernel::sync::atomic page, =
it
>> >> > won't should up, and there is no mentioning of struct `Atomic` eith=
er.
>> >> >
>> >> > If I made it public and also re-export the `Atomic`, there would be=
 a
>> >> > "Re-export" section mentioning all the re-exports, so I will keep
>> >> > `generic` unless you have some tricks that I don't know.
>> >>=20
>> >> Just use `#[doc(inline)]` :)
>> >>=20
>> >>     https://doc.rust-lang.org/rustdoc/write-documentation/the-doc-att=
ribute.html#inline-and-no_inline
>> >>=20
>> >> > Also I feel it's a bit naturally that `AllowAtomic` and `AllowAtomi=
cAdd`
>> >> > stay under `generic` (instead of re-export them at `atomic` mod lev=
el)
>> >> > because they are about the generic part of `Atomic`, right?
>> >>=20
>> >> Why is that more natural? It only adds an extra path layer in any imp=
ort
>> >> for atomics.
>> >>=20
>> >
>> > Exactly, users need to go through extra steps if they want to use the
>> > "generic" part of the atomic, and I think that makes user more aware o=
f
>> > what they are essentially doing:
>> >
>> > - If you want to use the predefined types for atomic, just
>> >
>> >   use kernel::sync::atomic::Atomic;
>> >
>> >   and just operate on an `Atomic<_>`.
>> >
>> > - If you want to bring your own type for atomic operations, you need t=
o
>> >
>> >   use kernel::sync::atomic::generic::AllowAtomic;
>> >
>> >   (essentially you go into the "generic" part of the atomic)
>> >
>> >   and provide your own implementation for `AllowAtomic` and then you
>> >   could use it for your own type.
>> >
>> > I feel it's natural because for extra features you fetch more modules
>> > in.
>>=20
>> The same would apply if you had to import `AllowAtomic` from atomic
>> directly? I don't really see the value in this.
>>=20
>
> Because generic::AllowAtomic is more clear that the user is using the
> generic part of the API, or the user is extending the Atomic type with
> the generic ability. Grouping functionality with a namespace is
> basically what I want to achieve here. It's similar to why do we put
> `atomic` (and `lock`) under `sync`.

For `sync::{atomic, lock}` this makes sense, because `sync` might get
other submodules in the future (eg `once`). But for atomics, I don't see
any new modules similar to `generic` and even if, `AllowAtomic` still
makes sense in the top-level atomic module. I don't think the
namespacing argument makes sense in this case.

---
Cheers,
Benno

