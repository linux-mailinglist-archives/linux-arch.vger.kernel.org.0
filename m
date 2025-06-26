Return-Path: <linux-arch+bounces-12460-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A394AE98C2
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A186A1350
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 08:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A412291C07;
	Thu, 26 Jun 2025 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDWWOlop"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDD221FDA;
	Thu, 26 Jun 2025 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927464; cv=none; b=qfvjTZFnJ+Wuib+FcooSkbWO5w9/2vSzVfwnnkZhKOlkRgCKozDcb8B1DwKIlP3oJvB2/fkdsaDz5Z23wgWKtCnp5TUhG6SD8sEf72vonZlhDZHtIHP8d1w7QEf6akteAxUSo36B9jdW8fTKCYdfsSGR95REvqNmGO8KjWvcopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927464; c=relaxed/simple;
	bh=qJllYfkWSydOQyAUEgySBOwOR32Vk67l9y6tXzeF9BA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7WQOdp78eMLkg/oTIKjlgfWWzwFIh7pvBxZyKFuG/K7AOuqUHziMqsF+B33IhHfvBE01Of4ePp00gqV/kXyvXbL4n0medsE3bE8/V55fPHjipuHArfbvFusXbmoAa0K1qJQZ/rBafB6Px5mCdjGjra2c2aPIPykRwbNpy7KGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDWWOlop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F058C4CEEB;
	Thu, 26 Jun 2025 08:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927464;
	bh=qJllYfkWSydOQyAUEgySBOwOR32Vk67l9y6tXzeF9BA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eDWWOlopEX0odwWU7aX6iYDKgBgsKIyIc2cGgnxhF5C3ZOTe7dTJPuL3onhs0n9Wp
	 jTX5HTxvGzTrjrq4qgF/KPe9imTHLGSs7O3Hr4NLyErCbw3DUe3gaNG3NppZWI43fn
	 9OCzDJhCwtfXFFJ26qbgEuM1nHgK5pXuVFRGpzWtI6ItbLNYlqjUxjrBOmn90E2fAQ
	 juiT6UloxUa0110XWprVzaQsCFmEFqbO44L+B/BGhBsREpiZkS5ZFqVdJpxpOuW9Gg
	 wGEhllF5ZkVSZXYD+hX94lOvGYZ3lcg1SrAVl2Y8/g0LhlMA/goKDJb8vD7MzCbxI7
	 ZqoQmph3L8bmQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <lkmm@lists.linux.dev>,  <linux-arch@vger.kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <lossin@kernel.org>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  "Lyude Paul" <lyude@redhat.com>,  "Ingo
 Molnar" <mingo@kernel.org>,  "Mitchell Levy" <levymitchell0@gmail.com>,
  "Paul E. McKenney" <paulmck@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 01/10] rust: Introduce atomic API helpers
In-Reply-To: <20250618164934.19817-2-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:25 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<Uqju6u2xO_vCzY1ykGKU72OTQDzH6QgCbUFbq2e4ibAiXgKNzQRBv5IMVNEaCg9zFQpebc65KefA6rzhLNQ9xA==@protonmail.internalid>
	<20250618164934.19817-2-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 10:44:13 +0200
Message-ID: <87jz4y28pu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> In order to support LKMM atomics in Rust, add rust_helper_* for atomic
> APIs. These helpers ensure the implementation of LKMM atomics in Rust is
> the same as in C. This could save the maintenance burden of having two
> similar atomic implementations in asm.
>
> Originally-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/helpers/atomic.c                     | 1038 +++++++++++++++++++++
>  rust/helpers/helpers.c                    |    1 +
>  scripts/atomic/gen-atomics.sh             |    1 +
>  scripts/atomic/gen-rust-atomic-helpers.sh |   65 ++
>  4 files changed, 1105 insertions(+)
>  create mode 100644 rust/helpers/atomic.c
>  create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh
>
> diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
> new file mode 100644
> index 000000000000..00bf10887928
> --- /dev/null
> +++ b/rust/helpers/atomic.c
> @@ -0,0 +1,1038 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> +// DO NOT MODIFY THIS FILE DIRECTLY

If this file is generated, why check it in? Can't we run the generator
at build time?


Best regards,
Andreas Hindborg



