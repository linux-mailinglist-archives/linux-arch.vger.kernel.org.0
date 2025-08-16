Return-Path: <linux-arch+bounces-13175-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C881B2903C
	for <lists+linux-arch@lfdr.de>; Sat, 16 Aug 2025 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13294AA6A2A
	for <lists+linux-arch@lfdr.de>; Sat, 16 Aug 2025 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F077D1EC01B;
	Sat, 16 Aug 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGP8DpDo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9371DC9B5;
	Sat, 16 Aug 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755372933; cv=none; b=raLVoWhdxVonuw9ukXlJDXh7PkWzFm/Wt5AOtOkMp60m6fiRwNHGkmRSgXhFeuGWW6qaT12SsLfV4b8F60oy3Ft8/GmG7GmlfuJ8gTs0ivhC+fEUlvCsxn7tFutOQK5GQDNWvZC0tlqOnlkL6T35dFjMT8TwQ+cu1pXiwFO1gNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755372933; c=relaxed/simple;
	bh=WlPCp9fVlPwFTXS7XmQr33PixxriCbunSTJIpHN/Lvg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TAC2P0+hl4fI2ViAjp/foTHWPljn6+3UTipkK4x+w6DjIEyC7psunzw+VATHyQoSNb9XV0Nb58eEvsZiAvf1FQExIoWjwWwmrl5U+EyR/Z8WP0YZR7gjRX4fRdWnFpgqiP+jsxuiDSSsakW+ajrUYglkaztTVnw3mbHSkbt1LB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGP8DpDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0ADC4CEEF;
	Sat, 16 Aug 2025 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755372933;
	bh=WlPCp9fVlPwFTXS7XmQr33PixxriCbunSTJIpHN/Lvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGP8DpDoQHmXQZJhujUuaz5XK7bx94w3tlAszPyywczhD/Qlt7TI+nFQF9cJeMjmH
	 qfIkSax1djg7lcCDwXQcycsuQ+a4n0yktlZVIU0c4aE+HBc3Qq+sA+UtvEdN98Oqed
	 3HiWP0pgRV9vKXLVHAnZouzQAphHCPV83BnARNrKLvuBELFbZ6MnKb7FRecx3KNtuX
	 FjAEJzY0Em5+8j0GVjV0jVtKnHmB5Tqp8F/e724kPixcMSmykK1dd6hIUF3jydOFVR
	 yfY5vaTs7Nbonto/cUG+r/Ugp2BFvesaGJWeTuFIZ5vMOVR/r5d40HK8fYBE/nSrIg
	 LFrfCO37hTrWA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 Aug 2025 21:35:26 +0200
Message-Id: <DC43RPUDBY6M.1TGSQKJV9BKSF@kernel.org>
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
Subject: Re: [PATCH v8 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
X-Mailer: aerc 0.20.1
References: <20250719030827.61357-1-boqun.feng@gmail.com>
 <20250719030827.61357-7-boqun.feng@gmail.com>
 <DC0AKAL1LW84.MR2RFTMX1H61@kernel.org> <aKCtbSDuJNrtdLNp@tardis-2.local>
In-Reply-To: <aKCtbSDuJNrtdLNp@tardis-2.local>

On Sat Aug 16, 2025 at 6:10 PM CEST, Boqun Feng wrote:
> On Tue, Aug 12, 2025 at 10:04:12AM +0200, Benno Lossin wrote:
>> On Sat Jul 19, 2025 at 5:08 AM CEST, Boqun Feng wrote:
>> > +/// Types that support atomic add operations.
>> > +///
>> > +/// # Safety
>> > +///
>> > +/// `wrapping_add` any value of type `Self::Repr::Delta` obtained by =
[`Self::rhs_into_delta()`] to
>>=20
>> Can you add a normal comment TODO here:
>>=20
>>     // TODO: properly define `wrapping_add` in this context.
>
> Yeah, this sounds good to me. How do you propose we arrange the normal
> comment with the doc comment, somthing like:
>
>     // TODO: properly define `wrapping_add` in this context.
>    =20
>     /// Types that support atomic add operations.
>     ///
>     /// # Safety
>     ///
>     /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by =
[`Self::rhs_into_delta()`] to
>     ...
>     pub unsafe trait AtomicAdd<...> {
>         ...
>     }


Inline maybe?

    /// Types that support atomic add operations.
    ///
    /// # Safety
    ///
    // TODO: properly define `wrapping_add` in this context:
    /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`=
Self::rhs_into_delta()`] to
    /// any value of type `Self::Repr` obtained through transmuting a value=
 of type `Self` to must
    /// yield a value with a bit pattern also valid for `Self`.

---
Cheers,
Benno

