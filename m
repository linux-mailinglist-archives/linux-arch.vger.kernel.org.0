Return-Path: <linux-arch+bounces-2921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3F87766C
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC31F213B0
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A2B200DA;
	Sun, 10 Mar 2024 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRGVgfe3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E381D1F958;
	Sun, 10 Mar 2024 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710071157; cv=none; b=LBarGsUsphPM11NtcZN4mwB4IWmh/baSHx5n/rtLAJhgXkLm540SjMTL5+GzhfC2O/YyGTOw2ODqfBeu+4vwzhFt+FlNry7PNYcTFHJmqwYLvBYQ4afk1YzxRomqr5ujWKLCJHKLTFNdbRmUNil6eqWRdcvudWvIDg6Wh0nzPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710071157; c=relaxed/simple;
	bh=x4szjyNUt9dEAUQ7bswBMhPwjeuMoSBrMur9XPZXXjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwH1Na2FSPF5yGBrGuU1N75D+EP537dPweb8v+7UvwkbZ5B2TIwY3e817MQSzv4PVdSo6/xIKS1/595vI17w/GW4whRHHzZgUmpGE8Deb2qyR6PiXHJY7SxSeLgf2+o3pP2uO8GNxqOOi+LpP1AOuk1qp2PwRLTF9OidZW/+Vmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRGVgfe3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29bfc3ca816so2652a91.0;
        Sun, 10 Mar 2024 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710071155; x=1710675955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APdbC4WVW8bbq3Ji/1h5l4Whb2mua5InxmZI64nd8Ms=;
        b=iRGVgfe3PUY3WM7M9Kmd42qfBq7UphZl9qeOmNZYCwlmsG3Hb2Ew0MxoOjs/omvieC
         V8Bj4yAYeku3ibpWlNpreJPuNFdUkwE5K7sX3LAFpNAEB3h7yG2CbS/34uKcfur1d5fB
         EbvCHU9TX7XO2xSTx7ywCQG2q7her5P5QLhm8z88prW9fKJTXNb8UZfKYnHv7dX7xNFO
         q/Yv93biu7tEdRE9q/VvcQxCZFW+hi5DT1Swzj2ZMCLMnTWSigckGQR23vA9DOqnA0/P
         1fztKSwLsGGkL6MBxPKJ2OQS4CIApADjkb5eQGtiqBi1ZYSs/YtwQwdB3NHSAIe82zvN
         cyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710071155; x=1710675955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APdbC4WVW8bbq3Ji/1h5l4Whb2mua5InxmZI64nd8Ms=;
        b=hZSVx5RyGqbtctFFGHlycoZfZP01IDWjUS65CNusWaGYwJR9lLmRInxG8lx6j1HQfl
         BUE+RX6NZy08dG8HUiCx6r2pHWldk07ztSM9I+XN33EeA/zzLsMaWoUTLiD4PH/1S5q8
         cuOxpsWfZG7UpywOfctZT02Pbr3myEPT2nhVxACh6fQHVtqz6EBs0RkWwy8cYen2d7/d
         Dx9hQeCNLvU5j9qtthiDwj4E989JNN6+VvKg7TiTrHOsjV53gYZum3l5HG+AwJDRz7o8
         grjNnveiBxS138cvrmSgdF23JujLuYT1ijh24USdq6H5EOTjjprp7j/wQAxk+VwenV7v
         Hmbw==
X-Forwarded-Encrypted: i=1; AJvYcCUPHDxOhvQDKT9Nu+H8jiOKi3WhMF7FyhvMhL6/h41yhQNcQM2zg3iP2NkxPBfm4/ylmhNHtxvq4KkTFbjGpPxR6KV9wqZjxUemxCG7q3nn3+LibRSluu/c40/sKVSmVTUX+6g/rHNPmAj8RU68T2WMinL1qJ+GRvm2vujPNC6e9H+rVcG+niZ7zkVB2PDIii5LBGYKtbqwCKcRTIxc3MoQztlm7RtfDaZIGU/s18d4TF/KlwxZ/X4i+F8o2cG/WqkJjRPRUn+3FwtU54iwj0qCQBMAcfVv3s0M0Os2hK22tJNbrKHYJ/72I1ycZlPvx5sDDNLkPGw=
X-Gm-Message-State: AOJu0YxjZEEiM4bhznA2nN7GGD0ithWvosiPDts4aHEwif7QxyQd6wt2
	j0rUUDh8j9e4bi4eLtxuXgnCisVXsvfs/ZKBUdGzEFhd2EW9A/vw3m1uRFbgZobLhcAJOrIbUMP
	cEheeYWSYun/XSTYpKBakZ5Ete9I=
X-Google-Smtp-Source: AGHT+IFg5QyD7zzPSiIxq5ayVbCopyYxmimvVxbYpEQvBBTN/IY5s/u1gydEhZLQBPQOnhaZIkoB9B3RWeU16yrH+hI=
X-Received: by 2002:a17:90a:43a2:b0:29b:90d7:36dc with SMTP id
 r31-20020a17090a43a200b0029b90d736dcmr2619352pjg.19.1710071154965; Sun, 10
 Mar 2024 04:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-13-irogers@google.com>
In-Reply-To: <20240310020509.647319-13-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 10 Mar 2024 12:45:42 +0100
Message-ID: <CANiq72=YJEpyk_uGo1skK-K7AUBdtUkuVqoBD0WCyifE-xbHQA@mail.gmail.com>
Subject: Re: [PATCH v1 12/13] tools headers: Sync compiler.h headers
To: Ian Rogers <irogers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@aculab.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 3:06=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> compiler_attributes.h - added from
>  include/linux/compiler_attributes.h,
>  guards were added to definitions to avoid redefinition of macros
>  in libc.

Do you have an example for context?

Thanks!

Cheers,
Miguel

