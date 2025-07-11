Return-Path: <linux-arch+bounces-12679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E8B02436
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 20:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5533B3811
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 18:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F02F2C4A;
	Fri, 11 Jul 2025 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYV1g8oo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D82F2372;
	Fri, 11 Jul 2025 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260265; cv=none; b=XHMQgfXD5zr62u/TgHXzPSDUzl/4Gt9XZWZO1iN1HWhy9WcYqA7AyDPnMHnS/83MHiRld00YwbpJQadhpxs7iOY0Ymcb9NHy40MYyvvSmVN9bArp2w8IuSNxHA0PuoSA1AalkdH0wld10l2zqbzT14G3Atvz2iHNLWhhzYBcEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260265; c=relaxed/simple;
	bh=zBFgjGE0qiA4eMpmxcOVWz5VA6O7WUGGpA2k/xgboLE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dwZo/PWfE+MWis+Dl3a4iZdnUn7J9jrMWda/U8AqkURAgz99MUYB2ItC5IywMCvAlNw9HPgnqt1YbnP+ka/VCDWk7BMtAlv51R/9r8L23Om8lMxxslP0IguS+OqE5evANaviFB68OT8f3Ivk7NFiHq3QaM7/4xVGCxgOfqtDadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYV1g8oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005ECC4CEF6;
	Fri, 11 Jul 2025 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752260264;
	bh=zBFgjGE0qiA4eMpmxcOVWz5VA6O7WUGGpA2k/xgboLE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GYV1g8oo+l6YMqt0RSCrvzaRd/rEbAPJKxNccDUUH2hRg03MGRpTRGb9zTj3+3jBm
	 jVNWr96EGC/L0tRS/pgv19fB3PvarDRyN6LdmVL2hgttg3c6Ebaj6fm9jpRYoJoGPY
	 opKw+x0lQr+rG3d+FlEWZBDnQlcJ/BrUZhjzmNzCg/swBfHHmXVH5juwgzKU7ecthh
	 gRR6ju4tIPQcYeZRTSj48wkVipeuPxfPy8ZNR1nNB9vYgvA7k4r2N8tG7X1WfTRudy
	 XTDQ+et3ZcPWAfsYhRKlssKpUMDd2C6lgIRY4qmqkNd3JfPqmowam2c8xvw16IfhsW
	 45azOhVTPdcfA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 20:57:27 +0200
Message-Id: <DB9GF0U3JJWL.3FQFMRTBO52C1@kernel.org>
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
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-9-boqun.feng@gmail.com>
 <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org> <aHESYzVOTCwADqpP@Mac.home>
In-Reply-To: <aHESYzVOTCwADqpP@Mac.home>

On Fri Jul 11, 2025 at 3:32 PM CEST, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 10:57:48AM +0200, Benno Lossin wrote:
> [...]
>> > +}
>> > +
>> > +/// A full memory barrier.
>> > +///
>> > +/// A barrier that prevents compiler and CPU from reordering memory a=
ccesses across the barrier.
>> > +pub fn smp_mb() {
>> > +    if cfg!(CONFIG_SMP) {
>> > +        // SAFETY: `smp_mb()` is safe to call.
>> > +        unsafe {
>> > +            bindings::smp_mb();
>>=20
>> Does this really work? How does the Rust compiler know this is a memory
>> barrier?
>>=20
>
> - Without INLINE_HELPER, this is an FFI call, it's safe to assume that
>   Rust compiler would treat it as a compiler barrier and in smp_mb() a
>   real memory barrier instruction will be executed.=20
>
> - With INLINE_HELPER, this will be inlined as an asm block with "memory"
>   as clobber, and LLVM will know it's a compiler memory barrier, and the
>   real memory barrier instruction guarantees it's a memory barrier at
>   CPU reordering level as well.
>
> Think about this, SpinLock and Mutex need memory barriers for critical
> section, if this doesn't work, then SpinLock and Mutex don't work
> either, then we have a bigger problem ;-)

By "this not working" I meant that he barrier would be too strong :)

So essentially without INLINE_HELPER, all barriers in this file are the
same, but with it, we get less strict ones?

---
Cheers,
Benno

