Return-Path: <linux-arch+bounces-15578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B3CE6C9C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 13:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 234AC3001C3A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C41312817;
	Mon, 29 Dec 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDZQYnBZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9DA313292
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013036; cv=none; b=tygX1UbkwNiKcBYDl67zGjyAtUs+sKDMI4yak9YM0iQl176QjHjZGiKNVFC7fARiyqa9rbxpS3MvXnt+64va56Z/SypTL2rmWtBZr5mB/j1qIlMWex6FNm8rv205uJ61KQ06Gueh0Kad1kJxpVXr+sO6xy2WtVrUZR+7y2ijK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013036; c=relaxed/simple;
	bh=HkNO+1WhAZLkfngtmvSHkUGk5VLtfuXIstzLTqRDtTk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V14cTJgDb+P2gS3MkXx0AMJ4/lx/ge/tlabkKfSOK4XdXOM4m9v1x2hXgnTHwm7r2uV1wI/izXM59aTSRYqcjX1OpMqz0zKStUhUlWPUOxmz08K4r/qsXKN+zI3rM4VSTtNixp040plMlXRSDcY7R0L691soSPtBp9fAZIObOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDZQYnBZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo10127092b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 04:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767013033; x=1767617833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZ/pv17zVPi7K7N9ClnjKvD02+pq0BmA+DeqVIbJkNM=;
        b=hDZQYnBZGeDCJAZUB4tfszhQnUYPacEdTX4diHY0FtoPWyS0TYca7zZMQ+yZk3n7jy
         lLAsbDW4/ms7nWPtyiR+estPlVYjxYQimW5bB/ngdDFECt+9L4WVmai4wysxRxpLpx3+
         f78rqW+nOShplzPerMuatfsmC0n//Y4DCw5GU14eZS0QoEM3lH50xb3rX37j3tgk2rrY
         HsnG35Wb7nkul/w66+OAC9kQ4/dkTiLpJtc9V5qpIfyrPv0gmI9E+r3NUnKymlHnwKeq
         HPBW7WlinWo5XctGDabTmqeZm94cWLnT2PfLlml6rbjfZBGBUmKPgr+OqZSzMgA5FiVt
         Y8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767013033; x=1767617833;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZ/pv17zVPi7K7N9ClnjKvD02+pq0BmA+DeqVIbJkNM=;
        b=O3QT18Fva4HopbSdNFDBjvqq/o1d0haeGDqKpvn0OI4wpdKhhQwsh0nqteQNoLT+c7
         tESKC1gaysg/1Sexbv1swsbCLH1dV2PecUNqmxFqeFyET44V+ntbkwHlCSs/9H3ykb6H
         ft6GRkqW1uz/ObI05g478FjesZkkNkI9hdG3Td2cYkkN752/vV5N9p5bI4HFk4XFc8uZ
         iSQqPOt37ae/1iDibKF8Gih5blesp48FfCnrIJQm7JSgHiYUXIDpd1+NTtHPaGFmplNo
         kknNs9GaxDzX+k1OGVTuqwXc8FhiMeTMkbkpSTZT53oAP76EBzgzjC3xqzfKtusH8OT4
         qEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+OEO6F9NKS+X4B/P+SyYQ4rJ31HlnXgnhBPwL1hEHuIIw3241HAygiIzx0GwxiNDZEIEfkX9owIDp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyde6CjrQzvU/4DqvBn+hAZyXCUpj3Ju8pWbYcl4zGPHy9gnyFr
	qu9EBmbpDhMfby0+QuB3dUepBGKqWakMIcB+XJ2GTvH9niFbbY8y5i2B
X-Gm-Gg: AY/fxX7N9r3AMZHOaiKZCND+wGMP5eAfeAmW0oqENvGo02UVHvNCq9bGXHz/qeOXe+y
	sgcpoRhGAmj5V8zrT8CX8YBcEvFz9EjDskCSLqQHVqjaJ5m+Qdsu/eUtJim5lhEHLNRqqm6IGOJ
	XYq0SgMpcvaovceQakm6T8RLVQpp/5Ordls32q2LlAdDFRjeNusTYolL3MhGXdL0UGdaxbx1Zty
	VH2xyarmOKH/LdbIc1d3zFgX/i2R+T2mE0sb9pT7zZWTC9TxSfvMZPfqL9dguqULxY7JiJBG+lN
	P36a7h0EaYUf/ZxMDtf+H4w2QU/DiuoHmSo08cGbaDs+HZJrMwB3TzdfeY1SaosqsRm7p0Visw8
	DIEYtzwbbB2OHtR+m1b4DVkCG0+aqHIQGS9GsSSG/eF5H88aPyY2Mel55U0Dx/aLdEojhLrTUUp
	Ir37lKdPSBPDYhwly0RUDXYAjaPJ0LjP/sr5N5Fn4jN2zeuAUBvhLFAlg1ffCk87bajx8=
X-Google-Smtp-Source: AGHT+IGrjdHYLASMYbj4DFkinxOr9sQVj8JTCBkjrw/HDfdX+C13Qjzk6gzmzWeoycxdnD971sg6TQ==
X-Received: by 2002:a05:6a00:4c13:b0:7e8:4471:ae6e with SMTP id d2e1a72fcca58-7ff67e5572emr23909929b3a.58.1767013033494;
        Mon, 29 Dec 2025 04:57:13 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48e1d6sm26816521b3a.53.2025.12.29.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 04:57:13 -0800 (PST)
Date: Mon, 29 Dec 2025 21:57:08 +0900 (JST)
Message-Id: <20251229.215708.171382176517857886.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 gary@garyguo.net, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 1/4] rust: helpers: Add i8/i16 atomic try_cmpxchg
 helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aVJuwRCnyF7r5ygF@tardis-2.local>
References: <20251227115951.1424458-1-fujita.tomonori@gmail.com>
	<20251227115951.1424458-2-fujita.tomonori@gmail.com>
	<aVJuwRCnyF7r5ygF@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 20:06:25 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sat, Dec 27, 2025 at 08:59:48PM +0900, FUJITA Tomonori wrote:
>> Add i8/i16 atomic try_cmpxchg helpers that call raw_try_cmpxchg()
>> macro implementing atomic try_cmpxchg using architecture-specific
>> instructions.
>> 
>> x86_64 implements try_cmpxchg() with full ordering.
>> 
>> On other architectures, try_cmpxchg() isn't implemented; so calling
>> try_cmpxchg() ends up using cmpxchg() implementation.
>> 
>> loongarch, arm64, and riscv implement cmpxchg with full ordering.
>> 
>> arm v7 only supports relaxed-ordering cmpxchg; __atomic_op_fence()
>> macro is used to add barriers before and after the relaxed cmpxchg.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
> 
> One more thing, we should add this to comments in atomic_ext.c as well:
> 
> diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
> index 10733bb4a75e..5ef81d2b47cf 100644
> --- a/rust/helpers/atomic_ext.c
> +++ b/rust/helpers/atomic_ext.c
> @@ -91,6 +91,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_relaxed(s16 *ptr, s16 new)
>         return raw_xchg_relaxed(ptr, new);
>  }
> 
> +/*
> + * try_cmpxchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
> + * architecture provding try_cmpxchg() support for i8 and i16.
> + *
> + * The architectures that currently support Rust (x86_64, armv7,
> + * arm64, riscv, and loongarch) satisfy these requirements.
> + */
>  __rust_helper bool rust_helper_atomic_i8_try_cmpxchg(s8 *ptr, s8 *old, s8 new)
>  {
>         return raw_try_cmpxchg(ptr, old, new);
> 
> I can add it myself if it works for you.

Thanks, please add it.


