Return-Path: <linux-arch+bounces-12808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BF7B0761A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20531C26F64
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7F11411EB;
	Wed, 16 Jul 2025 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kblftK53"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3B2BB17;
	Wed, 16 Jul 2025 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670041; cv=none; b=InhZTM11Gq4kswBSYEmlp9fMlhRRgNkYopHztYiZcnvi2xZIDFOy4gM3evEl3Xqk+D5I7uA75cCPW5i41Zfk5WnDZ2tiCNobJ7NT9mNIdNNcBGWOBS0JLaUYqYKYvZ9AZx2JOrHwXTaEO8GhBKGM7JRLRjrVFkz9UUAni68+ckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670041; c=relaxed/simple;
	bh=x/Mw/JSlYMZ6Lt3QpSm6w9oNOPkux1bSqs9TbqXd9h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SheWwb8aiS92PiSGZ75kFNlcAnBSlCCzIm3JMGh4FqqD9xsB0x493w4RPONJ6bgbncBPXMOwxsv4N86C3na2yH4fMwUhXvL8d90Ba68etkPwaflw78EVPUcNs7ah8nQfy5IhQ1pvRofBzOXSjJfS3ouC6gvR7rZDEDCRPRlp9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kblftK53; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JnkhFjzbZDjJK3u4ETDcTw7sJ97GVgfPFmw1WSp/CBI=; b=kblftK53mxwfrHj+ku4R6OpdeL
	grQQfbfs955vCi2VqUdBWBygEeFM4Kw/KlMRfgInbXbiGoePXSfVI9OpJFe/OmT0CzBBgm05Gnaxi
	D9aSg7ZF90u5iC5jA+dnl809lKZOik7znWjMxN9EXGEZhrvwXnjHk2tfnsoEDTUYxmROLYURKcTYB
	CGi09bL8eSm8r8N8FrePssEO5M6tZbjlWeOMhza4KtPCT/rtT5JNGje+bfcnZcucL7iTrjTZS8dge
	5ifASPQ3hThNKel7aL6AUlzhWEmYbbaVrxz7dxjaVmPX6BKexrSU5IDZzuPz3hn27GwNT/XtQfI+V
	uQ/8Frvw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1XW-0000000A6Gb-0KyK;
	Wed, 16 Jul 2025 12:47:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 293B7300186; Wed, 16 Jul 2025 14:47:13 +0200 (CEST)
Date: Wed, 16 Jul 2025 14:47:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 1/9] rust: Introduce atomic API helpers
Message-ID: <20250716124713.GW905792@noisy.programming.kicks-ass.net>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-2-boqun.feng@gmail.com>
 <2025071611-factsheet-sitter-93b6@gregkh>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071611-factsheet-sitter-93b6@gregkh>

On Wed, Jul 16, 2025 at 11:23:09AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 13, 2025 at 10:36:48PM -0700, Boqun Feng wrote:
> > In order to support LKMM atomics in Rust, add rust_helper_* for atomic
> > APIs. These helpers ensure the implementation of LKMM atomics in Rust is
> > the same as in C. This could save the maintenance burden of having two
> > similar atomic implementations in asm.
> > 
> > Originally-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++
> >  rust/helpers/helpers.c                    |    1 +
> >  scripts/atomic/gen-atomics.sh             |    1 +
> >  scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
> >  4 files changed, 1109 insertions(+)
> >  create mode 100644 rust/helpers/atomic.c
> >  create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh
> > 
> > diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
> > new file mode 100644
> > index 000000000000..cf06b7ef9a1c
> > --- /dev/null
> > +++ b/rust/helpers/atomic.c
> > @@ -0,0 +1,1040 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> > +// DO NOT MODIFY THIS FILE DIRECTLY
> 
> As this is auto-generated, how do we know when to auto-generate it
> again?  What files does it depend on?  And why can't we just
> auto-generate it at build time instead of having a static file in the
> tree that no one knows when to regenerate it?  :)

It depends on the scripts/atomic/* bits. They hardly if ever change. We
do it this way because:

 - generating these files every build is 'slow'-ish;
 - code navigation suffers;
 - Linus asked for this.

Specifically, pretty much the entire atomic_*() namespace would
disappear from ctags / code-browsing-tool-of-choice if we would not
check in these files.

