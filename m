Return-Path: <linux-arch+bounces-12435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0915FAE5802
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 01:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D664C4547
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 23:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65C223DEE;
	Mon, 23 Jun 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ7U3QbY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C04C83;
	Mon, 23 Jun 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721264; cv=none; b=MGQOn5NopY7U7lG6GKowncurw+iE+Lh/6VDIzyOBlu6yqaPLmNnk7yifdyXxEKryvzUdhzu95D4mytSz7pG4p8CxikrvGfNugvhcKZpN158KO75x89xSFSoBRhFmGYH8fD6y+FZg75u+ktr2qTavVuJEcx96y4G//diUUWTwS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721264; c=relaxed/simple;
	bh=EkXhrcleDOrAWV+vLVGauR+++glgCUMjevKJJH/V2+I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NllGBzu+P9Z77H7IzktRlHf99wnDvYvMTFFNWWGPWbi/EoCpjn6o9ghtkGGZTy30DboPk2mwWsNYh+Umo1C+W/TF17yIjwjBXWSkV3JPj7ZPkRGeBHCphbHUpeDvXTV+RxAGIoxrdKpaT87L20C2xfC7gnRNzL4KFOhsoT1ReFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ7U3QbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81FFC4CEEA;
	Mon, 23 Jun 2025 23:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750721264;
	bh=EkXhrcleDOrAWV+vLVGauR+++glgCUMjevKJJH/V2+I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TQ7U3QbYplPJEbo+K21z0uvaH3Vdr5u1iRtXNeVFrbkPYpgQxY1PE/i4kRnkiIm87
	 XRcTwbg9YSveVE79+kCj8ZkAxP+uR4lcmc0wvjwa361uBMypj2JfSa/M66dtP3uGyn
	 /Qy+0lclK/DO7Y+fAKiIj7QzMiuRqZhlBwx0MpHt/qWMoi5ygkIDL1hOZnt1X/5+v3
	 2Zkq/Q5KEf+iyVRZfh+9khhJkHPkjvy2jKNWlK81O1NH5NWJ5O8MEKtrRCvIsO5RRE
	 eNmyI/nNo9Fc7ib1iYpQiyQwZ2jMcpVGGx5LSTMjfGujysrb1+DAUHhK2MufdgI1fT
	 OFlaWbVdigmyA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Jun 2025 01:27:38 +0200
Message-Id: <DAUAW2Y0HYLY.3CDC9ZW0BUKI4@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net> <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net> <aFmmYSAyvxotYfo7@tardis.local>
In-Reply-To: <aFmmYSAyvxotYfo7@tardis.local>

On Mon Jun 23, 2025 at 9:09 PM CEST, Boqun Feng wrote:
> On Mon, Jun 23, 2025 at 07:30:19PM +0100, Gary Guo wrote:
>> cannot just transmute between from pointers to usize (which is its
>> Repr):
>> * Transmuting from pointer to usize discards provenance
>> * Transmuting from usize to pointer gives invalid provenance
>>=20
>> We want neither behaviour, so we must store `usize` directly and
>> always call into repr functions.
>>=20
>
> If we store `usize`, how can we support the `get_mut()` then? E.g.
>
>     static V: i32 =3D 32;
>
>     let mut x =3D Atomic::new(&V as *const i32 as *mut i32);
>     // ^ assume we expose_provenance() in new().
>
>     let ptr: &mut *mut i32 =3D x.get_mut(); // which is `&mut self.0.get(=
)`.
>
>     let ptr_val =3D *ptr; // Does `ptr_val` have the proper provenance?

If `get_mut` transmutes the integer into a pointer, then it will have
the wrong provenance (it will just have plain invalid provenance).

---
Cheers,
Benno

