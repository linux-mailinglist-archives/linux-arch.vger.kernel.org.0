Return-Path: <linux-arch+bounces-15577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD200CE6C62
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEF8D3004437
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3A313528;
	Mon, 29 Dec 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB1mGMvQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE63126A2
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767012975; cv=none; b=aQbfMPjQ00Rijt4mCcO9y5zo7NBNPalsNQPz4JCZirdq8icDcn7wxAY4jMlK7HXrDhFnfAcd0DqEEun5Br1JlyQpg80LkqiTk/VrJ+vjZO6qWcCHWB/neLXlkrM5m3DrtwV/XfkKywayt2FYRy/wQi6HST1EfF/9LDBaJgS+aek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767012975; c=relaxed/simple;
	bh=tee6VdvlFEm6Uv3axyApSiS7QpUBnPGjnoyMGf8BiJ8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Kj47jDA+N8D6VliKOV8Vw9BLCU33gTADH4kG/gdujT5ASjZ0LKowUsmIRN4Oi/2NsNaLWIfZrqto0o0r3xGxX5FBv+Mny6DMKJzrnmUmX4P4C2rXttFNv2D0llOSpp+YrMFSNvjv5ObNKo2Cu5MtiAYXJwmmiWTS83+SVtfVjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB1mGMvQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so5209680a91.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 04:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767012973; x=1767617773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i30eW66LPFBRKvJvSquZtVLn6ykVWMM+OPHaW6Kkm8o=;
        b=BB1mGMvQcJHROs2hn3REDyQB9XBlDVjVnFFgO1npO1oEJDabYWXIkKmGY/uOU/2XS7
         bvOoGb5Vitnatr3jO7y7Ak0aQgHeWU2smcgcwEf2i4dO+xUmNJpv7EDQbhMsCf/todXc
         mR6WWvU+1P6RzUsnIsNEpTBfTXbIhZ/0qRO7mlvbJ10dsfGsXAXZcZR3ES8pNctmg9CA
         zzc4akusZ45AK9miU/BT//vtPdND7mMSeyzYBltSI+xfcXpHC3qrF6au0SiF8U3/2kwg
         gOygvrt79Iu/IUQhauvbibPqcR6JscwqjxOtOyT5sFJz0HFzcys3vkOiRqmYHUXig/Xr
         hZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767012973; x=1767617773;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i30eW66LPFBRKvJvSquZtVLn6ykVWMM+OPHaW6Kkm8o=;
        b=hxQZmSXNSabz20Y4ktEKfNhPK5hPA+08jdBW3AMaPOewm6NAkeUvy0cXooooZd7noK
         golcNtsD639rrF1jwVcie5BKfU8StVuA46SG751OdFLXz1tWsxzWWlOLc/rYopE39vi+
         UIuhuCaDlQporLvBNu5cL5tzr4kA5jTdrU3/XAhdF/UxRFZUecJBrl+wnE3gFXyL0VKa
         D6RMMRD3yx4EvjrTBhFagy4rXaljtgWwOUH3HVwFIc5te4qZ/jNLyhmW9FncCh5X1psj
         u5U4GnnbpYvrFGN2i7iWtJsEsDEMJCsEMnAcGs2GKJ/tuIu5Hjdl2I+/NWWT9KvVvE43
         B2CA==
X-Forwarded-Encrypted: i=1; AJvYcCVTb8ULgICetM5MQ13GUlFSf0tLW+oQ5HfphHXmsUNb6urs3fvUaft8cuia1gHcYysyeDv9+cXmU+Li@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgPNnZigBNGeLOg/lR2CMVxWR/oyVH5x/oCCx8j5dMxPB9Xp4
	aLrRl2n22vg0V+8kUobqh2LUwwlMkXbEHHsxUu0CCW7w/Nt9E6GUmjB4
X-Gm-Gg: AY/fxX6f5wyvJMk6twxC7wAg+Quw6vBfnZssTeM/BdjznhHWjRZsBrVmFgRBEyXqWUx
	xpLqTeIc1io/wGI1TNMlFMo2J2iBgnLAsYCAJ7MrzXrkBSeKnt9Sdy6FvmbahnJq9vvBbJkP7Fx
	6e6X+hdQSJDoE617qUZ9fYC9OYsgjC1HyXpB/Rs5lVvjZ4WjuJhpSh9QBx2jJP0jDicAgi/XvIV
	GZPS9BRh/ypk4MYX5jdUIsV7BMisG9eiddklFuOXHdVSlQnStN8wDubIIpnXbYoVKhjs+3lmN1N
	kE95R87QrNpcBOsiw5cE2t//2CcEqe4JC8rjcomR0G2jKm3vzppoe0Q03sRnMIDCJr0gOAp28zg
	pb9O39jq5AkBms3Tb+wvvNY2yCpWImTXeN7efU5oM1IibZFW8KrvhrqeSyqaROm0pXkXeZ/HZCD
	Np0/pN5LaJT3PbxcaU78BRe3wm17E2TdaeFKaE6bKbFYtXteeYqseYCBllgIAW7JwZoks=
X-Google-Smtp-Source: AGHT+IGmYZ5Q3zIr4+NVsiGSQ1mj+575GKZ2vvEpvzpiHGqXbKEWyPPUny7/9hQuZgY3dpK/c3/XUw==
X-Received: by 2002:a17:90b:1d0d:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-34e90d6980bmr24541421a91.5.1767012972898;
        Mon, 29 Dec 2025 04:56:12 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e920c9a7csm27386716a91.0.2025.12.29.04.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 04:56:12 -0800 (PST)
Date: Mon, 29 Dec 2025 21:55:58 +0900 (JST)
Message-Id: <20251229.215558.697746619121630518.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 gary@garyguo.net, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 2/3] rust: sync: atomic: Remove workaround macro for
 i8/i16 BasicOps
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aVJs-D4V1IpfzR7z@tardis-2.local>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
	<20251228120546.1602275-3-fujita.tomonori@gmail.com>
	<aVJs-D4V1IpfzR7z@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 19:58:48 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sun, Dec 28, 2025 at 09:05:45PM +0900, FUJITA Tomonori wrote:
>> Remove workaround impl_atomic_only_load_and_store_ops macro and use
>> declare_and_impl_atomic_methods to add AtomicBasicOps support for
>> i8/i16.
>> 
> 
> I did the following so that we can drop this ;-)
> 
> 1. Change function names of [1] and [2] from *{load,store}* to
>    *{read,set}*.
> 
> 2. Reorder [3] before [4] to avoid introduction of
>    impl_atomic_only_load_and_store_ops!()
> 
> [1]: https://lore.kernel.org/all/20251211113826.1299077-3-fujita.tomonori@gmail.com/
> [2]: https://lore.kernel.org/all/20251211113826.1299077-2-fujita.tomonori@gmail.com/
> [3]: https://lore.kernel.org/all/20251228120546.1602275-2-fujita.tomonori@gmail.com/
> [4]: https://lore.kernel.org/all/20251211113826.1299077-4-fujita.tomonori@gmail.com/
> 
> I also reorder a bit to make the introduction of helpers are grouped
> together, please see at
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-sync.20251229
> 
> I feel this way we have a cleaner history of changes.

It looks much cleaner now, thanks!

Maybe, you could consider chan ging the following two points:

- change the first patch subject

rust: helpers: Add i8/i16 atomic_read_acquire/atomic_set_release helpers 

- drop the following comment in 12th patch:

+// It is still unclear whether i8/i16 atomics will eventually support
+// the same set of operations as i32/i64, because some architectures
+// do not provide hardware support for the required atomic primitives.
+// Furthermore, supporting Atomic<bool> will require even more
+// significant structural changes.
+//
+// To avoid premature refactoring, a separate macro for i8 and i16 is
+// used for now, leaving the existing macros untouched until the overall
+// design requirements are settled.


