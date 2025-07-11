Return-Path: <linux-arch+bounces-12657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25AB01707
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 10:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B7D16CA55
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9DC2147E5;
	Fri, 11 Jul 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNP1SDdb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A421F239B;
	Fri, 11 Jul 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224275; cv=none; b=LyA/C74nwDQJ5bwWw+0mSi4Cv2SgXHXcRH8meioNNPqhGxEg79TrzDqMIOCNVdnfqS7sRDOYNUewXigLxDQP0sfUXmpgQWUnNejdGzUdQ59dzwPb5yduLpNFwZpET1JS4mzyey3AsjEjsGP8hOOitFNXTf5nJU+ezFlEzsfbQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224275; c=relaxed/simple;
	bh=SQ+I/i9GcZZDdw9+DjGuncMztUIAcG5mYGhR3c0KWlA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oiH4Zoh2MTmdY3Oh2xJ7H0+Qz8aLja3fSskwrW7MyKtYE3Jt3rG/p5z0apWbKAK2wfty4AXYLcSlB524L/9y7KinvYDtK5WN6LcqMUpB6KC30hQaRIahFp5bavj2iFFcwXyGVZG2z94sbZY6X6sWOi6kgT9Bfp6PIsTMiwUMxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNP1SDdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7F1C4CEF5;
	Fri, 11 Jul 2025 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752224274;
	bh=SQ+I/i9GcZZDdw9+DjGuncMztUIAcG5mYGhR3c0KWlA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kNP1SDdbKprbnfNDIrcSNJYvDFEnmn67uWnRLInGGupetmpDuoBKd3HpdznmV43+g
	 qJgl3QnG88BM74wyFcJhOEgncQSx1R9RPBVqzXXjdkaq2FsFYcQMZmvxA3fUUcRdaM
	 lm2wH4mqhgboHw4DZt7OkBAPLkftZ1P800Q0DsbimFXGVKbzuQyYPrFHBNFMacBsf6
	 dCipUAG2wkpSwiBSfl3mqJbtO7T0IvCZKt1I3m82tf4FaGqScCVkfjWPjaKgIbxacX
	 4y+sGo+ze9pwrULvo+kOyrTyUgaJYbKuZ/DQmLbViVWV+lq1NEkeFe4/oauBT200KO
	 mlgu2xnpklY6A==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 10:57:48 +0200
Message-Id: <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 8/9] rust: sync: Add memory barriers
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-9-boqun.feng@gmail.com>
In-Reply-To: <20250710060052.11955-9-boqun.feng@gmail.com>

On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
> new file mode 100644
> index 000000000000..df4015221503
> --- /dev/null
> +++ b/rust/kernel/sync/barrier.rs
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory barriers.
> +//!
> +//! These primitives have the same semantics as their C counterparts: an=
d the precise definitions
> +//! of semantics can be found at [`LKMM`].
> +//!
> +//! [`LKMM`]: srctree/tools/memory-model/
> +
> +/// A compiler barrier.
> +///
> +/// A barrier that prevents compiler from reordering memory accesses acr=
oss the barrier.
> +pub(crate) fn barrier() {
> +    // By default, Rust inline asms are treated as being able to access =
any memory or flags, hence
> +    // it suffices as a compiler barrier.

I don't know about this, but it also isn't my area of expertise... I
think I heard Ralf talk about this at Rust Week, but I don't remember...

> +    //
> +    // SAFETY: An empty asm block should be safe.

    // SAFETY: An empty asm block.

> +    unsafe {
> +        core::arch::asm!("");
> +    }

    unsafe { core::arch::asm!("") };

> +}
> +
> +/// A full memory barrier.
> +///
> +/// A barrier that prevents compiler and CPU from reordering memory acce=
sses across the barrier.
> +pub fn smp_mb() {
> +    if cfg!(CONFIG_SMP) {
> +        // SAFETY: `smp_mb()` is safe to call.
> +        unsafe {
> +            bindings::smp_mb();

Does this really work? How does the Rust compiler know this is a memory
barrier?

---
Cheers,
Benno

> +        }
> +    } else {
> +        barrier();
> +    }
> +}

