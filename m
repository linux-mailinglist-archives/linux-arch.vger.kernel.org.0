Return-Path: <linux-arch+bounces-12714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913AEB02619
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 23:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54DD1C263AD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFA1DF25C;
	Fri, 11 Jul 2025 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqMV6ahU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A9288CC;
	Fri, 11 Jul 2025 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267857; cv=none; b=fw7+yQo+x+wofVv2iq7ZejfmdBSZD1ixYCtQSp0tsKBRt0Z6DpKD9JX5YV8v8fxb/Jq6ib2qfR4waJcoMnR73Sw7bi9fVjuNojlR/hoYzX1wVQd60oh7w/51F1iaEvBZucDCoULYpyJTbnPX2RjCuFqYBX/rD2JxhPh8xdDo2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267857; c=relaxed/simple;
	bh=rn16cvdN403qOcjWimJ2fVcoqyZNuixWbvbKS5/G03w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=j0ccV7HnT4OnKaRPVAm4SB82xgWvKlBZ2na7//Qj+Vhdor5Sv3EKSnAE7CXwi6EnCwJg96hn1I749nXJx3HVxgFPf3bPzqaFb9EEWxiTHIG6jhAgyJED7GYRMPVMjFPQOVY70QCspPgdNe+dpNEbcdzjK6rlGQ31IYOxyxzPOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqMV6ahU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B50CC4CEED;
	Fri, 11 Jul 2025 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752267856;
	bh=rn16cvdN403qOcjWimJ2fVcoqyZNuixWbvbKS5/G03w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqMV6ahUAm6mfMakxAisU+hvQ952AxcgO5Gm3DyyLtOPkFjbioIMRR+zHMF5SA2KX
	 lMF6YgLMvXRevWnDXid97D4DD5gfTzsARJ4/2L7pMeEix3YeuAlxF3vWQ+SQmmCIfR
	 13cl3dNh+GILL/73/qjLZ9bqVimpE9hxik8lDIpsY2CO/3b7BAfEKPuU7GdliNG8N6
	 ENBEfSES6aGOOonhlZYu/h2QKu9nZRZQz3vRWZVTAzTdrk3otKyckhOFWBLuqD39rQ
	 w9E2AdHcFU5yDcSpS8HKZCmJNBdkQrPuQJXdbBVz7cGKECaoGGu6bfULwKIZ/ffQcP
	 SWeGo/TXuRlzA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 23:04:09 +0200
Message-Id: <DB9J417F3XRT.1XGPA6VLF9T8K@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
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
Subject: Re: [PATCH v6 8/9] rust: sync: Add memory barriers
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-9-boqun.feng@gmail.com>
 <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org> <aHESYzVOTCwADqpP@Mac.home>
 <DB9GF0U3JJWL.3FQFMRTBO52C1@kernel.org> <aHFlS96FTRgS0dH_@tardis-2.local>
In-Reply-To: <aHFlS96FTRgS0dH_@tardis-2.local>

On Fri Jul 11, 2025 at 9:26 PM CEST, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 08:57:27PM +0200, Benno Lossin wrote:
>> On Fri Jul 11, 2025 at 3:32 PM CEST, Boqun Feng wrote:
>> > On Fri, Jul 11, 2025 at 10:57:48AM +0200, Benno Lossin wrote:
>> > [...]
>> >> > +}
>> >> > +
>> >> > +/// A full memory barrier.
>> >> > +///
>> >> > +/// A barrier that prevents compiler and CPU from reordering memor=
y accesses across the barrier.
>> >> > +pub fn smp_mb() {
>> >> > +    if cfg!(CONFIG_SMP) {
>> >> > +        // SAFETY: `smp_mb()` is safe to call.
>> >> > +        unsafe {
>> >> > +            bindings::smp_mb();
>> >>=20
>> >> Does this really work? How does the Rust compiler know this is a memo=
ry
>> >> barrier?
>> >>=20
>> >
>> > - Without INLINE_HELPER, this is an FFI call, it's safe to assume that
>> >   Rust compiler would treat it as a compiler barrier and in smp_mb() a
>> >   real memory barrier instruction will be executed.=20
>> >
>> > - With INLINE_HELPER, this will be inlined as an asm block with "memor=
y"
>> >   as clobber, and LLVM will know it's a compiler memory barrier, and t=
he
>> >   real memory barrier instruction guarantees it's a memory barrier at
>> >   CPU reordering level as well.
>> >
>> > Think about this, SpinLock and Mutex need memory barriers for critical
>> > section, if this doesn't work, then SpinLock and Mutex don't work
>> > either, then we have a bigger problem ;-)
>>=20
>> By "this not working" I meant that he barrier would be too strong :)
>>=20
>> So essentially without INLINE_HELPER, all barriers in this file are the
>> same, but with it, we get less strict ones?
>
> Not the same, each barrier function may generate a different hardware
> instruction ;-)
>
> I would say for a Rust function (e.g. smp_mb()), the difference between
> with and without INLINE_HELPER is:
>
> - with INLINE_HELPER enabled, they behave exactly like a C function
>   calling a C smp_mb().
>
> - without INLINE_HELPER enabled, they behave like a C function calling=20
>   a function that never inlined:
>
>   void outofline_smp_mb(void)
>   {
>     smp_mb();
>   }
>
>   It might be stronger than the "with INLINE_HELPER" case but both are
>   correct regarding memory ordering.

Yes, this is exactly what I meant with "not working" :)

---
Cheers,
Benno

