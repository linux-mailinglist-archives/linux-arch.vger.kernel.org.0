Return-Path: <linux-arch+bounces-2920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA4A87763B
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9FC1C20B60
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ACA1EB52;
	Sun, 10 Mar 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra1kyVDS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07B1EA8A;
	Sun, 10 Mar 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710069913; cv=none; b=X7d6S2MyVHUpm5wnVUyIAE33NFyEDEkUjEjdH4CUmvgpdeptb2qfTeeNlKIOIvRgnRGvgV8gEu9n7Jet8baFuY3NQDtRle6pQpzkGc+EMxiP1FpLOYUZTc/mu25zsv0P3oI7Dz1WnT2PWTEE9wlCHFF/U5KkXc17y26Z/UC5k2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710069913; c=relaxed/simple;
	bh=VBF7ceh6Wlntn/A4CWCSAEFwD5jlbuVTv/NZRlllrR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI+DmQOJJF0K+InbHX8KBOMcirigkWYA6uRtBHuIx0sF5JofGkGXMxt7IAIEGjEOYJ0IR7kkj1WTFyeEne6iktutAU7QLDZxYsnQiDihI2D5ZefEiDi/Jzk7ago5OZ/aPVcrkn6KAWkT21esrJyPe7B6rJc82Qo2vE1mc8LTLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra1kyVDS; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c23a477b10so793429b6e.3;
        Sun, 10 Mar 2024 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710069911; x=1710674711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avm3XWtxN2Lye/3JBQf5W3p/Z1/Vl4Xh6t59AfJ6d/M=;
        b=Ra1kyVDSbxGSWI0JV8eptgxsrmvu4++SJsATQwUsDUCokWE9FwS42PmU71T9eoyYCe
         rMpgqjB4+weLt+kHXWef2SrNh5cPOz/RrYDL+DkHQH6Y3pHplxMBYRzMRlqrQ6FBHRx0
         bQk5dgBuYTfm1AzOV2hPkDZml9ogwEfwDYEXDfS2XUkn4a++kgPQep/j4++X5zsXDkPO
         qlEQpDs3e6zedm/sDRzn6xmW7vezZeAgXjJZaJ/R6GFl/lufkxj/WPprMA9UJ39VYWxL
         zUnrtwPuibyuFxSj8SSdeeeVxaosStLHXgYDbSbKlSOI324HL9KGo6TBkZtamBM/RFh6
         a0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710069911; x=1710674711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avm3XWtxN2Lye/3JBQf5W3p/Z1/Vl4Xh6t59AfJ6d/M=;
        b=wYKAIpEw6l3+uozF3tGfNJgt/PNJCf/muGTXa7xbfpo8m2NKS5f6AN5+3+ZBVmT8Pn
         gfV8Tz8B3EwsMh0EX+0yC6s2pQVtbQUlHvGD+6J18pzFWRt8Ys9QVP0AM/uFgOrzVDZp
         I40cRWSQThVDgJzcGWss84oSRYNM9criPmgDv4DcS4JuBCR1r8V54mjT3XD4RQG90DmR
         ecuEMJDFsgHwRLfqaKXudyKcwj/sKb0n3QK5jhxJ5DiELzqc5J02kme0qz3RjwwVgAE9
         G7xJAooc2z5cJgaSWk1lF9EAEW0c54s2ae1RN3gTRZpg5JxCXNSZkCLF6IdseuqidCh/
         Xngw==
X-Forwarded-Encrypted: i=1; AJvYcCVlcrbPzqcouiDBt9xRITsRmAnkIp96RTxOHtwaDqdCGd74oAkK+Ta/Hk8X2tkNsNsdeTEdtvzwWNCQ2J6O8LKGgU4YFsZ4eLUSPVHr34cRqQXS5nkc766J3XO0vSgQdPJam8gJDU8quWVpGcxkzlmBRaPt+n3TP4POdOrFOHvFqeqj5xYqs7OBL2OGOBOl9BVfoiSEkbQraF1YoxhXrnmZbZ6X5vYg97B01O5E/uTHaM1i5/CjvtQKzoWZSbqCp6bYUDZJqZLS/Djjim10CpHBMobfQr/a2MQEBLKXZmm8iRuWY2zpSuksCdUJu9gkpywD04uEfLs=
X-Gm-Message-State: AOJu0YyuTxfi3z2+0/Z8lspfBz7YejjimRFM3NLMgK1AtvI6/dv80CJY
	UXJ5D9Uu5fMzOvWpkbazhy5usbTL6GZ5c2gIn3PdekG/YrVzQWW+ERUzBfkQ7TkuAAfesIcko04
	2PDJTqMREeAZxJBxBHcr6RD+kuC8=
X-Google-Smtp-Source: AGHT+IHRwZqAtW6dN5aHOohpsFvhfbVT3D5XN/0uJW5CX5DEg34V+Etke50PKB8IcZncs9dx0y+ep2z+6siBNnLrohY=
X-Received: by 2002:a05:6808:1188:b0:3c2:31eb:d2c7 with SMTP id
 j8-20020a056808118800b003c231ebd2c7mr5425808oil.20.1710069910963; Sun, 10 Mar
 2024 04:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-14-irogers@google.com>
In-Reply-To: <20240310020509.647319-14-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 10 Mar 2024 12:24:58 +0100
Message-ID: <CANiq72=rgXk6oz65wb57ZP+jmSoD-a4SSVzU6s6SZLubV3cvBw@mail.gmail.com>
Subject: Re: [PATCH v1 13/13] tools headers: Rename noinline to __noinline
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
	llvm@lists.linux.dev, Christopher Di Bella <cjdb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 3:06=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> [1] https://clang.llvm.org/docs/AttributeReference.html#noinline
> Reported-by: Christopher Di Bella <cjdb@google.com>

Out of curiosity, was this due to the `[[gnu::noinline]]` or similar
in e.g. `src/string/memset_explicit.h`?

> -#define   noinline                      __attribute__((__noinline__))
> +#define   __noinline                      __attribute__((__noinline__))

I guess it does not matter since I don't see it used in `tools/`, but
should the one inside `__fix_address` be updated too? Or is the idea
to keep the diff as minimal as possible?

Cheers,
Miguel

