Return-Path: <linux-arch+bounces-12393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21F1AE02B5
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 12:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643F33A9C71
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 10:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B2E2222C1;
	Thu, 19 Jun 2025 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T++0IscD"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C41E2312;
	Thu, 19 Jun 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329124; cv=none; b=Imgqqx+QgWa1vC48szRnz3tEr5b4quQwCu3B5rjd6EkqG4B6cKb48Cmpz7P7kbWQCE7Ki9RGYfmZ9oulAxtTYF0UfWaOYZyp56vrOV2d/TXydJqNG/WIwcOauQl8fsg+dSVjrECQwgJayJi34yeVt1i5zxLFjQQaL9ApkKPEWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329124; c=relaxed/simple;
	bh=Khe/sdUUkDDqg1DjiaL2gTiOly2J6fsQL2KHmvONI2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut3t2DdIde3Gbl6oAa11Yygck/5kuYzuA9VUXfOvckhZPkRLh0U3wDoPJIX+ID7Bhrfz4wF1EXePC8Me14Yg2LlVkgbsHOfR0XgjQ88QngC6CqKd3LnAScfRRyxORCXVRH7dBdjiFQY4GosMzOlofXrBhO/WviniksBGfb8mOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T++0IscD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w1pniWAitZ7xsbl8EX2cBNfwJUGO6gUBYk8UsyzHaho=; b=T++0IscDTMH7RV/B13VlfwthTO
	ocClwLWiSq5vhdXUmVM8gBi1SzG4bbvemjpW501sZlrU2uz4YOxforUAKJ+5ObYEFa3SxnbOiCd0k
	TEK9F2H9iDYc6rxTdlrx9CSfCAl6P0SB4LxNQPp2rH1+vAsl9snvEv+NV3vVLtWRai3k0aVxDEANJ
	YUWwo1d3cMR5Sk6nyaThKPq2nwpwpzx/hZf8edvc2wN/LB3re0uolTEKg9IdrEw7qMR4WvHa96lGZ
	a0Cy8pN0ix0sd+rF5z81jdqTdyXw8QwZhmMCuBkQkOShQj2q57sCV4lyc3O078BZMBx7UKr8BnzEW
	vtaQRULw==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSCYm-00000008GyW-2KJ1;
	Thu, 19 Jun 2025 10:31:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9FB5A30890E; Thu, 19 Jun 2025 12:31:55 +0200 (CEST)
Date: Thu, 19 Jun 2025 12:31:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618164934.19817-4-boqun.feng@gmail.com>

On Wed, Jun 18, 2025 at 09:49:27AM -0700, Boqun Feng wrote:

> +//! Memory orderings.
> +//!
> +//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
> +//!
> +//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.

So I've no clue what the Rust memory model states, and I'm assuming
it is very similar to the C11 model. I have also forgotten what LKMM
states :/

Do they all agree on what RELEASE+ACQUIRE makes?

> +//! - [`Full`] means "fully-ordered", that is:
> +//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
> +//!   - It provides ordering between the annotated operation and all the following memory accesses.
> +//!   - It provides ordering between all the preceding memory accesses and all the fllowing memory
> +//!     accesses.
> +//!   - All the orderings are the same strong as a full memory barrier (i.e. `smp_mb()`).

s/strong/strength/ ?

> +//! - [`Relaxed`] is similar to the counterpart in Rust memory model, except that dependency
> +//!   orderings are also honored in [`LKMM`]. Dependency orderings are described in "DEPENDENCY
> +//!   RELATIONS" in [`LKMM`]'s [`explanation`].
> +//!
> +//! [`LKMM`]: srctree/tools/memory-model/
> +//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt

