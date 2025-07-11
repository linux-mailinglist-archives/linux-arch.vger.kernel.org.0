Return-Path: <linux-arch+bounces-12656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF77B016EE
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740121C25028
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D228D212FB7;
	Fri, 11 Jul 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk76w/4g"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C678207E1D;
	Fri, 11 Jul 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224062; cv=none; b=JASAAruP0XUWlIRe2qH0y/37zCyaFaWfrioJkcYMRnaXbQAFtJQ951q+Dz9KcboCwCQhzHZRcac4PcoeSyaUUbUbwKHB+DLue1kXv11kN3FiR2N77O9bzhpCWwo1hQCVrZLQ87nG52W9Cjbk8KVx4UqKwYv4n5kXHg5x8xzn1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224062; c=relaxed/simple;
	bh=/k6+wLUuPqTjP0+hmtrbzsCRJXJNpPB1TwR4XXmCSv8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Ip8JzIJ4WeRbSgG2bCmiD6bP206aW7MO5t+QeFnSaLYcxZjX4SHhq+qqerVmJXL6nfMwbtxocPaYbH1aMrbVQQWrSsXQjvd6Qm2U4yyADZ8BLAePzScVitNPg+afxjAvTjyJtPqKQyW4RbWpqePBt4UJg8JvwMoIepPMkqpY+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk76w/4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F56DC4CEED;
	Fri, 11 Jul 2025 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752224062;
	bh=/k6+wLUuPqTjP0+hmtrbzsCRJXJNpPB1TwR4XXmCSv8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=qk76w/4gmLGpaL2Q1cm7V5bo+Ua0WkS54sW+Ua2Awlrz75KtWvMZftYJ9IkM083rV
	 8/KSIv36HYKhTjBJ11rjcHXpbK0Eo7R3putiw799QwweBe673N2Cnyh6Jk6v/9cfRn
	 A+LpKoErqcShJXDAocXvIwSpboalnXSgBRzb3WrNDeRSMmvSG80Yr7w1+JRmm/sD1D
	 9ppLTxapVHclpUb93FoK3mbRooA1/K/3SIwj/9sanEXpNp5ikGQSgmcv+O9fbcJMqH
	 XJ2BxhfJ3Bx03DWd2mPEr7vdPIJtvAORZEOiVcCU+Pc+XWE4K8ypl0kZPCoSCqIG86
	 LcNpKaZwUfKCw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 10:54:15 +0200
Message-Id: <DB93L6OL9RER.1Y0KH8A0ZFNBC@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
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
Subject: Re: [PATCH v6 7/9] rust: sync: atomic: Add Atomic<u{32,64}>
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-8-boqun.feng@gmail.com>
In-Reply-To: <20250710060052.11955-8-boqun.feng@gmail.com>

On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> Add generic atomic support for basic unsigned types that have an
> `AtomicImpl` with the same size and alignment.
>
> Unit tests are added including Atomic<i32> and Atomic<i64>.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/sync/atomic.rs | 99 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)

