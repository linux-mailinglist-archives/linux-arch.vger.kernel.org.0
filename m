Return-Path: <linux-arch+bounces-12803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7F1B0718B
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E0A500CE5
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58B2F19A9;
	Wed, 16 Jul 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4E4XvUn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1D2F199D;
	Wed, 16 Jul 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657792; cv=none; b=n4YyZvsjbxzoWjF1DFQfXVYS9xd2ES75JWav6ahklIFeoeRLec/IWbUIcWxvmSIWF/URsn4ei2EkhV+jmQyb8dwnJtHRTFZMXOtGRLbDT2t6kk86MZ+gxQV3EPKBteY9+24IMbwmrVTsjqufiMDkKRjh9HzALLdtBG+SCGf8t3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657792; c=relaxed/simple;
	bh=4jltuwgu6UQqufrQ8GvuspkBPjXn1RWYCM93+tWOJVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH4fINc6P9mk61w0k6nGDBHx4fKLaYIMoclkDUJSbFqXkMRmN0/JQ9jZOmORqSjpW6aOKscG+O8Sq5aOfFFPR+i371gA9eiSLw42p5BCUH8UTxlBRWNeIlRAV2QOAvBREgjlB6PYnR+vBsz8+huglI9IRQRgPuERpd0wAIrhhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r4E4XvUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F09C4CEF0;
	Wed, 16 Jul 2025 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752657792;
	bh=4jltuwgu6UQqufrQ8GvuspkBPjXn1RWYCM93+tWOJVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4E4XvUnxanHChML6nxeDzNh9ns3fWEKEkH3oU7CfD2IHPiw5NUnT87sqj/8j8WUp
	 XnpaJKcG8aoQcG4e3aE7i/B7m8B2dXedE/h/BdcX+Eedb/7RcB+aq36RNKwBHzo34L
	 vimyJxjHVUEEqXR8GiE/Cz9HDSqRZFIefY8RyYOg=
Date: Wed, 16 Jul 2025 11:23:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <2025071611-factsheet-sitter-93b6@gregkh>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714053656.66712-2-boqun.feng@gmail.com>

On Sun, Jul 13, 2025 at 10:36:48PM -0700, Boqun Feng wrote:
> In order to support LKMM atomics in Rust, add rust_helper_* for atomic
> APIs. These helpers ensure the implementation of LKMM atomics in Rust is
> the same as in C. This could save the maintenance burden of having two
> similar atomic implementations in asm.
> 
> Originally-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++
>  rust/helpers/helpers.c                    |    1 +
>  scripts/atomic/gen-atomics.sh             |    1 +
>  scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
>  4 files changed, 1109 insertions(+)
>  create mode 100644 rust/helpers/atomic.c
>  create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh
> 
> diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
> new file mode 100644
> index 000000000000..cf06b7ef9a1c
> --- /dev/null
> +++ b/rust/helpers/atomic.c
> @@ -0,0 +1,1040 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> +// DO NOT MODIFY THIS FILE DIRECTLY

As this is auto-generated, how do we know when to auto-generate it
again?  What files does it depend on?  And why can't we just
auto-generate it at build time instead of having a static file in the
tree that no one knows when to regenerate it?  :)

thanks,

greg k-h

