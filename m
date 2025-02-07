Return-Path: <linux-arch+bounces-10061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0513DA2D1C7
	for <lists+linux-arch@lfdr.de>; Sat,  8 Feb 2025 00:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215363AD442
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1CF1D07BA;
	Fri,  7 Feb 2025 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7Zyw6rK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985118FDAE;
	Fri,  7 Feb 2025 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972246; cv=none; b=qAiNt1AENWKl+231ZaDbFpljbM1GzhCg7fTl1WzqCq3fJmWjhKLmZEMduZTbwYr6c2lBdlTPnAmcqfzFMcb7BhhroIuPdR/udtGLoIJYkenA7z5FysQJOenqd3DX1WdyPE+cEDe4SUJCFyLZa0YMxyJpNq/Cr3b3scOEiucnjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972246; c=relaxed/simple;
	bh=CYB3FSNwFShTpdPawetKpiJWckc8LHuMIECqtzbzRuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6qRm/xna1Ll1YZsrnx3Vt394WlEHaQDEPE7N5ptZoW0pdVELzRyVEm7egITs0RsNp8o9dY/jSBEJUBO9GgpUNnzs9OTFbNIU7LS8gOlp8YDjslrEOEnsdthfoZNIPM8FMIn1FsO/Y0vRLZiX26OTVyUiU1kXHLqx/96Nt6tjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7Zyw6rK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dc6d55ebaso918466f8f.1;
        Fri, 07 Feb 2025 15:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738972242; x=1739577042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USgMOjHrfaLirLOT5WzrXhmwlLjtY2e3GvXtshzzQDE=;
        b=c7Zyw6rK1Lzqm4hzIYaSpqj4hgXLU2DimUsrbrNZ71qd57zMBowm0Y4A+3scX+fAq2
         MwEyA+CWGuYQSw3ZuH6MgMrzrZvVafX+TfM3BRL3yAJMU9BxOw+Q94sAFW/qP2YHZxl2
         seUswpuFiuWr3BDJV16MwR7IxGpcgrOR6e9T6qbE5Yokt2uBt+Kf2j9LeoSZ/dDgESjq
         CE/NX0DuuP1vE6RNdmKiv7KxICtciiiGYbytk0eux8eMfMa4KUW/0cEJC5dpOY0o7Ynt
         p2WCAu7fySol75OSiO1WxrFud2Ld+M7jyLo0NmwIOT2nSAFGrcO8/Y+FCnJGS8Vg5Dtg
         hBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738972242; x=1739577042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USgMOjHrfaLirLOT5WzrXhmwlLjtY2e3GvXtshzzQDE=;
        b=obuQgRcUcgjO/cSUpxhY6y7T0tlkJ+oaI8dPMfZ3mKGCJDzN9n7mRD71uoQ6grucM4
         J0V+HLYz8Yw1uHOb4bJzJ+d7l2pzl45pLmB3US5qnV0tTtbq0uL4St5YHyYJ8BrZXX98
         cH/VetV60beG4X1dFx0DXEK/tg43loYHklWG5PU7mYAWgVVkawBw6PmrME2pnbR1XM7l
         32g5SG22vOrwWboHFu7EKgIaIk7UJhGN4rnB4UOqYXo9+RXoQ9PlezLIixJs/DpGxzoF
         Ng44vMnT9x+OYdWmrJSh+sjwh6JhDXPg+hRkXG/KJL3mw0QmnaS2w81I7NJB5CraVRxo
         +SIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJnnGlUd5zYTyKQp8QDwssZkdWozw5k1jW6yMLjsKtjZQaZU5fNPic+99pGIBC08bVJy7i6vICEx8iTBju@vger.kernel.org, AJvYcCVAJHZU1bH+C7IAV8KCwF8d1y4eR4C7CSoFHQzTts6mGh2f7G52W8TajqLEYcM0xzDVEcV3FZqfZdAq5lYx@vger.kernel.org, AJvYcCVsLvsiQ/ap+750f8zGVeiZx3gdhctlyBkgVQ53xlphmfT3vaCYhb1zre3jUqR/k/QinX4JNKYhhidTHw==@vger.kernel.org, AJvYcCX2hPF8lq3zyy7ODfO+lpa8WYnkaM3VwglU7WIfBG44jMF3bZfKIR9eJbf7BAR+NaDPnGIFrxm86VKbOKQuqjVh@vger.kernel.org, AJvYcCXkPUxSaNxjeJ8ZSeHYyZZkq88iD2eeZtzAfSzwVxICAknBDI+08XHRs2NTjlL6oM/ULHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvUb6DbfPl5n+yGWkWum+uT3nnZmbklg6IyfPcUY4ArhyR2wL
	NIi00J/6GsynPUzihJ0YWZA6bWiQaJJaa5FmVYop13kXxrDY3QvSwrCQNLhrMZDwVObo6pkA5yA
	E+mkCpyBGirrt/7rWu58Il4Ys+OQ=
X-Gm-Gg: ASbGncvQrjZWg7pBiwFvt1dU/9YKESrsoIZu5biw0bqINe8WVgblcmo2xTYSLyUI3U4
	ncwYrNitYPx7ObQ8p8hn/VVL/npQ27xSb+MthLBCKGXAOl+E3naSoSQue+ntgPRRS8fmnKYxQFY
	8s0nmm1Tgv+di+6YF0cpfPvA741MY4
X-Google-Smtp-Source: AGHT+IGdgzDpsGso08/WhacNlqhvHR4fHBB/5Nz0HBLIhyrzc3k6+vYm1v3vC1IFWO2rgyWwA0J32kxp6cJzNPaPo+I=
X-Received: by 2002:a05:6000:1865:b0:38d:c0c0:b410 with SMTP id
 ffacd0b85a97d-38dc960e4d7mr3988849f8f.0.1738972242115; Fri, 07 Feb 2025
 15:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com> <20250207012045.2129841-3-stephen.s.brennan@oracle.com>
In-Reply-To: <20250207012045.2129841-3-stephen.s.brennan@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 15:50:31 -0800
X-Gm-Features: AWEUYZkFsykde3fyEMInELSdBVAKmObvfOG_wL5GI8Zt-4AF2wq8l2htXaP5ptM
Message-ID: <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf: Add the option to include global variable types
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Sami Tolvanen <samitolvanen@google.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jann Horn <jannh@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 5:21=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
> When the feature was implemented in pahole, my measurements indicated
> that vmlinux BTF size increased by about 25.8%, and module BTF size
> increased by 53.2%. Due to these increases, the feature is implemented
> behind a new config option, allowing users sensitive to increased memory
> usage to disable it.
>

...
> +config DEBUG_INFO_BTF_GLOBAL_VARS
> +       bool "Generate BTF type information for all global variables"
> +       default y
> +       depends on DEBUG_INFO_BTF && PAHOLE_VERSION >=3D 128
> +       help
> +         Include type information for all global variables in the BTF. T=
his
> +         increases the size of the BTF information, which increases memo=
ry
> +         usage at runtime. With global variable types available, runtime
> +         debugging and tracers may be able to provide more detail.

This is not a solution.
Even if it's changed to 'default n' distros will enable it
like they enable everything and will suffer a regression.

We need to add a new module like vmlinux_btf.ko that will contain
this additional BTF data. For global vars and everything else we might need=
.

pw-bot: cr

