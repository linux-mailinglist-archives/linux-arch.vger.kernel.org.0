Return-Path: <linux-arch+bounces-15651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE29CF0E27
	for <lists+linux-arch@lfdr.de>; Sun, 04 Jan 2026 13:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC5E30081A4
	for <lists+linux-arch@lfdr.de>; Sun,  4 Jan 2026 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDB6286889;
	Sun,  4 Jan 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnHzJgQQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5AD2641C6
	for <linux-arch@vger.kernel.org>; Sun,  4 Jan 2026 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767528460; cv=none; b=JcK5XOBvqDGwxAzuHXlffcJ6Li5NHCdwa4FS+JwYTZxIsqlQjYDussru9N2sOzPxcwhedPhkq2WiSjQd58wVVPgFtEfOWQbQUGyXyLUPgf8PblqU/17IO2IkVrl+OiB7aO83Qoo/bX2lCxB/0KN7YLwl2iXNJMlByIm+y5s+xLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767528460; c=relaxed/simple;
	bh=8WPe4EtZF9PVPtEplVTrsX6Iu/noiguDsReJP49r0Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUkdIEkxQg/LxUPQRtshqdKaaWVshyzjGBSrEP1dTE+9B3qVyZR33B8lir9tP2Gk+Hey/Xl/kL2S/p8MHMZaljSULHW9iizn3CWErTsgOViC1Zi6hkmX42UnVB9K+I8AZF+OQ4XxYgHnvuDoGLeZoDv42tY/XT0fJ2FMJZ4Y3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnHzJgQQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34ab8682357so1580053a91.2
        for <linux-arch@vger.kernel.org>; Sun, 04 Jan 2026 04:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767528459; x=1768133259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WPe4EtZF9PVPtEplVTrsX6Iu/noiguDsReJP49r0Ag=;
        b=nnHzJgQQYQq5NyTt5UK0CMhrGBjfGhUHIcT4BitDWhXXciv4YuRNTMqnHO+cEIW3vU
         Z0GfLaUNfoX4zoS3Z1rXtSAR351OHbIQfPixyZwlEE2YbCzcn3f5Ii4CwNmN6tUZGpdw
         BrMLWVoiaOOlrAaDgZL15iW8Lb5c2Nmj30bxc/6ZTcWVKdyeWqKv46UpXCtyx8tOykMv
         B8ltN6M+DUEDkveac5GbC0imJjbpdei/0C48D4yPi7vdPPoOWCfSnMYa18aVbo7OlDO0
         XI5BcHwjSJL46dYK5YVdiMrK2kWO3LO3Egj/h0tiv57RyZmBCH3DBGXu6dQnXYB2vYfR
         YzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767528459; x=1768133259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8WPe4EtZF9PVPtEplVTrsX6Iu/noiguDsReJP49r0Ag=;
        b=r4+/hNaKYStcADAQg5g8OOMSFi4GXnBNqGsZ1Kx34Pja6Bwob6OJKss3iPLIDQWyH1
         W/LlYd0IhDhyKSBU6qLgqAvyj8++BtiGoL8XMhwBVzdCu6tibcwlprj6SGxCuvyk5fs+
         imt73gafs1OLrkZzqM/Xgk8RWUAF2ezxCzedYiMXEV91Pcqfg2BKeWbeNICV7ALQbYa5
         vjcavrdWtwYqt4YH4TkfK+xXt4rN5NA6RBWfM537kcjvQKiEHM5lA7NEJIKrC2EUKmwc
         2n9eXuq1QLMFN9g6DJEclu4L+Gkd6Gst61/gIef2UsHpJ6q12LFKL1ipHTJbdU4Cbu+S
         TQ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVLg32alZrP8mClkqSBiNTfx+ZkPuvTXgLIs4GKufHZzmaBvIjxP2EldCjx9HiTrYF1BBwS78a4ma3d@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhEhG7hlSOjWAMDDyi6kSiCOYmOS55gqnE1gbwWdQZvflcgJc
	lC2mYpFsjyemqA+iOqim6sjbuE/kGajpi8POED6Umi0wLeU8aY3LkIoDzGvqWNFiWAr9gG8mMwi
	rSqairRouZKjg5dk/w6ME/EEmYgMuHB0=
X-Gm-Gg: AY/fxX5yjYItadasMHuyoBrQeks+CcY3idS1i8X96S4Fs/48N3QLHocVpRZLBfFxStY
	n9Wkbqgo9Bd4wMOSHX9shk4kxOeB6knE6aVfR056qu0BUQKM31v8VJfIOYhVMVHVADkmAAJAQzA
	U4yJqQe06D1ldOeJRMKtDp/aw719eLewljPH3PfEux3UfGgmJLsBz/3I18sAmu7nzClItfdmxzY
	MW7IR/Z99IDnm3VbAhumjeqi4xfsPplUXdHelq3EV/k8kE3usnG7IKTGgthfGylAZETWbieJ9zo
	JiFUk8QVY6/OZ5odsTXgxaUznrHZVOiIB2KFfJGQAaADQ5pl53A9DADhfA/2eMsbtqP838Cjvds
	0IMM9jez5J8tW
X-Google-Smtp-Source: AGHT+IGwM9o7xrK/tz9KLRjUBIXDcSGXhFpqKpX4LOwc9gJ+IuTJfpXmxlpq+AAD5RZkUI3trJaOU+TYum/SkotLQ4A=
X-Received: by 2002:a05:7300:cf84:b0:2ae:5a24:249 with SMTP id
 5a478bee46e88-2b05ea0b213mr15849313eec.0.1767528458660; Sun, 04 Jan 2026
 04:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101102718.2073674-1-fujita.tomonori@gmail.com>
In-Reply-To: <20260101102718.2073674-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 Jan 2026 13:07:26 +0100
X-Gm-Features: AQt7F2pG_lHlI2NIk73VUM3WnC4E6P21J9OPzN15s__U1mU6PIyqEuWDbRMX4xY
Message-ID: <CANiq72kRipkW-djNqUy3hSb9Dy5LJOr1QgFAaY8vT6KjrMcDEg@mail.gmail.com>
Subject: Re: [PATCH v1] rust: sync: atomic: Add i32-backed Flag for atomic booleans
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org, 
	gary@garyguo.net, lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com, 
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 11:27=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> +/// An atomic flag type backed by `i32`.

A few nits I noticed while reading the thread: intra-doc links where
possible/simple, i.e. if some of them require something involved to
make them work, please ignore it!

> +/// ## Examples

First level header, i.e. `#`.

> +/// use kernel::sync::atomic::{Atomic, Flag, Relaxed};
> +/// let flag =3D Atomic::new(Flag::Clear);

Generally we leave a newline after the `use`s block in examples.

Thanks!

Cheers,
Miguel

