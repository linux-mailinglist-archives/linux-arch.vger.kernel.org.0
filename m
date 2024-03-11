Return-Path: <linux-arch+bounces-2924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA328783D0
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C751C20F11
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AA3446C8;
	Mon, 11 Mar 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3GvtHSq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB743ABC
	for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171209; cv=none; b=Qc2nmlLSZitcCRsYrUczzl96AXmbLliRaSvSxyIYMWM49kVE3L+ofi8t/95A/0bEU+vJoNKev7F6+nWPHns7HnhJCRmQBWvFo3IO/gb+62ADcfq+1GBLjqSJoDvpZ8B2bCwCrOpUEMVtLbSivigzKVtfyPkuizJYz7o4WAXlszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171209; c=relaxed/simple;
	bh=BgmEJ3rVgpfdYftpb1oT1hFKBsa+dHuEMI7KFS3YKKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fybh6qJ3ethfKNW7mUPhERF2gCSZ2AnK2kBwsRANCv5VhRPuaDhvKCjqcgAHuyX5jjfaqu5raz9knugyfOTIg3733zkrYwN8obYk4JVQsf31368wNZ/eU4oVLBjigwKTU1t9WxGI6O9PUO/ZSmv8NzEh2wC9BuL8w54lpoqkG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3GvtHSq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e70d71756so2312042f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2024 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710171206; x=1710776006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgmEJ3rVgpfdYftpb1oT1hFKBsa+dHuEMI7KFS3YKKE=;
        b=x3GvtHSq0o7fqG7Js8UBDYyiGGmbvocSiat9Ce2dQlflT25D8h7ggz6S8+gASAuM0B
         ZcNxW7gGUOVAHN4yMSq63y+F16QTnDP3FUccCaH8FkRj/LeOysSud83iQawkCcPam07W
         9pfrThKEf4kFIKs8T5RoOYGkxT9TGmyp0FgeYQkCH/VilTVBUVi141DcdPWk/VbqOBCP
         mBtTfCXbvdRmTTgLT1xqdMQAN2KBxsgdLgQ5GfZHFCou5QYOaupFMGHF7m14yhvyw4XD
         mQG1UJm9T1tbfyRqvnecr48HAYdNZPG2tsPlOAd3NOT+NlM/F6RtR56tpLp1wZzvUFYz
         FvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171206; x=1710776006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgmEJ3rVgpfdYftpb1oT1hFKBsa+dHuEMI7KFS3YKKE=;
        b=TNNLQbhlW5QJtxCT/vtNDvquIwO5HDtu0SS/1hN7mtI6pu8R5tXl51IBg3SpwyyiYt
         2hOD255s+N+u6wqeh0+xFaWecHbpMTQ8O1cfY4I8OWrLXEHjhjNmLuwYGDimh0cnUkuP
         RsLyaBFxWwHpsqzcHaCwjaikDlNPWPzVWys2Llc96AQZrF1mRJc++TIlzAA1jV0JlJQk
         tth7P4A1x1GpyA1ylrLjOsEGqqJJaKWrfXLq7NH6KHrbMELVenblVP2kEgxP34lz7h0r
         yNMU4dY/xmta1oODNgzn/f7AeD04DAFc36IgEQ/dk09x7z6nVBm96P+GRkRT9v228K7I
         q+qg==
X-Forwarded-Encrypted: i=1; AJvYcCXg3edN03w8T7YUF/HJhuxjKY6FA9tfjJFS3J8neGi9y+lOBilxzyxiO3MpoRmOQHZrQflVI6QGL+/jxUGhlAr3Xf2LCu288AeWQA==
X-Gm-Message-State: AOJu0YywNPU6n/9gnVoiTydOb+HwAc+PSOWzYRJZWoeKHKPAOmUkFlkm
	OkPuldCB9QEj6FKkcYnsBdyJKNx+w2neGY7V2T51MFIsjh14zr2fy5uQyqN07RqzBO0CNFL9bnm
	mJ7F+uJu3Qy4r60ulTiREr1q82hdhtzRlEs2w
X-Google-Smtp-Source: AGHT+IE/th4Pg/GBs04QnTLC4gySgD/Ced3Hwsh9xlJGW37qnBqN80Ztb15KeaRy40uSPOSKwYSAYx2WXmVslFbnrPM=
X-Received: by 2002:a5d:6751:0:b0:33e:1f2b:8cc5 with SMTP id
 l17-20020a5d6751000000b0033e1f2b8cc5mr6816452wrw.0.1710171205375; Mon, 11 Mar
 2024 08:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-14-irogers@google.com>
 <CANiq72=rgXk6oz65wb57ZP+jmSoD-a4SSVzU6s6SZLubV3cvBw@mail.gmail.com>
In-Reply-To: <CANiq72=rgXk6oz65wb57ZP+jmSoD-a4SSVzU6s6SZLubV3cvBw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Mar 2024 08:33:10 -0700
Message-ID: <CAKwvOdkMYnYO2hyJEFj-M_iur6BneEZjPHvsodZAGw=b7PmmzA@mail.gmail.com>
Subject: Re: [PATCH v1 13/13] tools headers: Rename noinline to __noinline
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
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

On Sun, Mar 10, 2024 at 4:25=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Mar 10, 2024 at 3:06=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > [1] https://clang.llvm.org/docs/AttributeReference.html#noinline
> > Reported-by: Christopher Di Bella <cjdb@google.com>
>
> Out of curiosity, was this due to the `[[gnu::noinline]]` or similar
> in e.g. `src/string/memset_explicit.h`?

Yes, and in src/__support/threads/linux/thread.cpp's definition of
start_thread().

Thanks for the patch!

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

--=20
Thanks,
~Nick Desaulniers

