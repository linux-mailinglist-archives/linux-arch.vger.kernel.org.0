Return-Path: <linux-arch+bounces-12637-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AF0B00778
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414227B3767
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82426276021;
	Thu, 10 Jul 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiOxgfCx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6F26FD91;
	Thu, 10 Jul 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162423; cv=none; b=Qg0jcQIndxjrmKGl0nWYH1d825h+ACIcRRYGpf+5XW/A80GmdHZDPT0tR9wVqwx/HGR2dgvfYyKunyHd0pd593G+4NWs2sV/qe2Qer6yNEP1wvhXEPIQ4p8/v7Uf8dnmBtA9tk+kejsjWUxzWniWjWG9Ida084bjERgk65QSJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162423; c=relaxed/simple;
	bh=dj/zefq/c/lty1/gzqNGCChSOInPa4AmaihOcg4LMic=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=svhrapVWFKqRMWdqx9U/5G8ML8is4ngRNrHdfYsGoM1n5E4kK65HAr/du68Isx1/nOgcbDjyUsUFQ//fHFy/b0ECKo7oX+OHAuLJi3iqcVr2JeNUeXkkHdhPvulIebGfMd+3Nm+iVBz/CJLH3vVM1Hh+9aFK4dIt2lyODY4vOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiOxgfCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F11C4CEE3;
	Thu, 10 Jul 2025 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752162422;
	bh=dj/zefq/c/lty1/gzqNGCChSOInPa4AmaihOcg4LMic=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=tiOxgfCxr2rALjGlJZ0lnUQamjwLinJkFLMVpq/P5AgYYAXWFPc6AfqEBrmtuRJus
	 AFEOKQwmYCz3X9VjcIPJaYF+Q71WMi9zLmtXPTDgeI4abQPFyooFJVYf13BykHHkvZ
	 TjUhB9qlxy6Q92ZthME7pzMBWcYBNtQo1Gqhm0MfIiP5Yah/1b6fxP2GgIy3D/WEs3
	 FgYl5TMCbmUIHxIassSBpygpCtAnN+BaAjZjzPXYP01E8kdrmEWU5axr4A39UYx7qc
	 zcNl5cekAtdnfB3DNPVOaa8yQ4dx4H1/v0vaDWsSHKFXI5oWrgvCWVOEm7ubT+DK2e
	 RBRpXPYSONXxQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 17:46:56 +0200
Message-Id: <DB8HQLY48DFX.3PBBUTQLV14PC@kernel.org>
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
Subject: Re: [PATCH v6 2/9] rust: sync: Add basic atomic operation mapping
 framework
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-3-boqun.feng@gmail.com>
 <DB8BQGJNFDAY.BGQ8CZSFFOLH@kernel.org> <aG_Yah5FFHcA3IZy@Mac.home>
In-Reply-To: <aG_Yah5FFHcA3IZy@Mac.home>

On Thu Jul 10, 2025 at 5:12 PM CEST, Boqun Feng wrote:
> On Thu, Jul 10, 2025 at 01:04:38PM +0200, Benno Lossin wrote:
>> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
>> > +declare_and_impl_atomic_methods!(
>> > +    AtomicHasBasicOps ("Basic atomic operations") {
>> > +        read[acquire](ptr: *mut Self) -> Self {
>> > +            call(ptr.cast())
>> > +        }
>> > +
>> > +        set[release](ptr: *mut Self, v: Self) {
>> > +            call(ptr.cast(), v)
>> > +        }
>> > +    }
>>=20
>> I think this would look a bit better:
>>=20
>>     /// Basic atomic operations.
>>     pub trait AtomicHasBasicOps {
>>         unsafe fn read[acquire](ptr: *mut Self) -> Self {
>>             bindings::#call(ptr.cast())
>>         }
>>=20
>>         unsafe fn set[release](ptr: *mut Self, v: Self) {
>>             bindings::#call(ptr.cast(), v)
>>         }
>>     }
>>=20
>
> Make sense, I've made `pub trait`, `bindings::#` and `unsafe fn`
> hard-coded:
>
> macro_rules! declare_and_impl_atomic_methods {
>     (#[doc =3D $doc:expr] pub trait $ops:ident {

You should allow any kind of attribute (and multiple), that makes it
much simpler.

>         $(
>             unsafe fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) =
$( -> $ret:ty)? {
>                 bindings::#call($($arg:tt)*)
>             }
>         )*
>     }) =3D> {
>
> It shouldn't be very hard to make use of the actual visibility or
> unsafe, but we currently don't have other visibility or safe function,
> so it's simple to keep it as it is.

Yeah I also meant hardcoding them.

>> And then we could also put the safety comments inline:
>>=20
>>     /// Basic atomic operations.
>>     pub trait AtomicHasBasicOps {
>>         /// Atomic read
>>         ///
>>         /// # Safety
>>         /// - Any pointer passed to the function has to be a valid point=
er
>>         /// - Accesses must not cause data races per LKMM:
>>         ///   - Atomic read racing with normal read, normal write or ato=
mic write is not a data race.
>>         ///   - Atomic write racing with normal read or normal write is =
a data race, unless the
>>         ///     normal access is done from the C side and considered imm=
une to data races, e.g.
>>         ///     `CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC`.
>>         unsafe fn read[acquire](ptr: *mut Self) -> Self {
>>             // SAFETY: Per function safety requirement, all pointers are=
 valid, and accesses won't
>>             // cause data race per LKMM.
>>             unsafe { bindings::#call(ptr.cast()) }
>>         }
>>=20
>>         /// Atomic read
>
> Copy-pasta ;-)
>
>>         ///
>>         /// # Safety
>>         /// - Any pointer passed to the function has to be a valid point=
er
>>         /// - Accesses must not cause data races per LKMM:
>>         ///   - Atomic read racing with normal read, normal write or ato=
mic write is not a data race.
>>         ///   - Atomic write racing with normal read or normal write is =
a data race, unless the
>>         ///     normal access is done from the C side and considered imm=
une to data races, e.g.
>>         ///     `CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC`.
>>         unsafe fn set[release](ptr: *mut Self, v: Self) {
>>             // SAFETY: Per function safety requirement, all pointers are=
 valid, and accesses won't
>>             // cause data race per LKMM.
>>             unsafe { bindings::#call(ptr.cast(), v) }
>>         }
>>     }
>>=20
>> I'm not sure if this is worth it, but for reading the definitions of
>> these operations directly in the code this is going to be a lot more
>> readable. I don't think it's too bad to duplicate it.
>>=20
>> I'm also not fully satisfied with the safety comment on
>> `bindings::#call`...
>>=20
>
> Based on the above, I'm not going to do the change (i.e. duplicating
> the safe comments and improve them), and I would make an issue tracking
> it, and we can revisit it when we have time. Sounds good?

Sure, I feel like some kind of method duplication macro might be much
better here, like:

    multi_functions! {
        pub trait AtomicHasBasicOps {
            /// Atomic read
            ///
            /// # Safety
            /// - Any pointer passed to the function has to be a valid poin=
ter
            /// - Accesses must not cause data races per LKMM:
            ///   - Atomic read racing with normal read, normal write or at=
omic write is not a data race.
            ///   - Atomic write racing with normal read or normal write is=
 a data race, unless the
            ///     normal access is done from the C side and considered im=
mune to data races, e.g.
            ///     `CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC`.
            unsafe fn [<read, read_acquire>](ptr: *mut Self) -> Self;

            // ...
        }
    }

And then also allow it on impls. I don't really like the idea of
duplicating and thus hiding the safety docs... But I also see that just
copy pasting them everywhere isn't really a good solution either...

---
Cheers,
Benno

