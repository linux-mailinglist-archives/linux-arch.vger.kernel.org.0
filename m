Return-Path: <linux-arch+bounces-2929-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543A4878863
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 19:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6F01F21B12
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011EB54BE4;
	Mon, 11 Mar 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xey65aa7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7325466E
	for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183286; cv=none; b=ceVpRx0LdP4EmaaGv6JvN8fLXG27EDy0RFVS68fYWiGaqu0JqI0kO5hZY6U+Wmu6kIQST+wVx0YTuS+kVF0cgN9sx1dVkTRqFgnmao7NF43WOOwhVGWTOMyj02uAXkh0H+t35BND/PMaAdUbguztxagD0TFS2ReIYC32yKxm6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183286; c=relaxed/simple;
	bh=sg1d/ANVhdMJVWpfU8bbvkMp+uD3nzj9x9rv9aGU7ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJqfQtHCTg9u5X4ZbBNnLngX6V90mv5ifGQ5RxAzH/WPpt3Ib+5UWTSVGNRRY5Q6cLuBRy/0gP5U6l4vPby3gRbYTWlwgMEmSx7g03klNAPjmpHm2tjj+gws5RYCmDYI5ErkF+CirtTqalqYecR3EvZt0wSLEFBoLKy+KNSeSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xey65aa7; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3663528c0a5so15455ab.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2024 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710183284; x=1710788084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EWPj2I4xpYoZRjyOYAm/kocZbdOlLT2RiNEmzadKaY=;
        b=xey65aa7VE1wIljt/ixV6xel+/R5udOqzmcbCiIrUaErlg1igTj+xHHwuQCYTzh9up
         gwX6SRiXKyFi/2K6SzwjHRVVhUiSb/E6H1m293SMrMno++CElm7lah0vjw0nbxBPCKF1
         1KggYhb+LqBJqmmZ+PjaihjMv1sfV3+JTNBadSbrM+lesNUkMK2Ws9704W07WK2+pPYc
         6yNgIhKkmJeGhuWAccjBZ+gNrzM1cQggQKYtv4DqDvtm1uRcSM2laMjrvR4ONMWaJcGI
         5Ebo4Df4MVwLcOu1UbbtZ/WX9SPh9X+w0fyq/yEgqaleOURfABAA6PjEc0YfhnymHV3M
         re1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183284; x=1710788084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EWPj2I4xpYoZRjyOYAm/kocZbdOlLT2RiNEmzadKaY=;
        b=JC9GvCtEnKvkOPMWRzG2nESRMmXUPn7CVFWwiIXpugi8qsaAsC2Qww6UXTPzuFCzGQ
         ZFB4LlOl1MAFmsP6Rue6k340otKXCw07UmIrDhA4p8akrH36NwiqtNgfbTgn75UQth6f
         0dKelDx3YL08zJDht1APadeoYuTlRQ4a4m3UgbH+eEIjSDGfpl1A+cas/qOtipMJdBxb
         SIvc5vz8fSG0S1faaCconc/iAztwloDUBU08L+dRnKz6e5lzlevxWi31Rcjt2ePacxb5
         J4qT4h9qFSzVM5NG5LHhcCI4d1+oMTBk+eK+0HmcdaXrdah/Z0oQp+ioKTfVagkzy1IP
         PGQA==
X-Forwarded-Encrypted: i=1; AJvYcCXiyB4N0o6TGOj22cpt1xvAMNo8+JRuYLxi8HvTU5/YcUmSkVJTyknXscpdoNNwTEVsJKMhApQIH7c5I1jCTYU/fhZszKZA/se/Bg==
X-Gm-Message-State: AOJu0YxPxUAKsiWve/Kl12mKe7T1NIQlkIigtUuomKsEMgppIAmD/igZ
	cPL7rpZ1ho36U/ZdWRsj6lG/4abGvGwjZDAPoiseD7R19X7tgToxGrvkCcIX7M9dFVFG5XGp2bv
	nnHwxF+dtJ0a2t4YhkKH2ChYkzulXijMG5Tya
X-Google-Smtp-Source: AGHT+IF9Y1AJY3TwC+yrKD+SLGX6DGVejGuk9zVLbhhSZF+Z1op/fddC1zPHT7AUjYPqnvQvkBSi2u31QCO6TEveBME=
X-Received: by 2002:a05:6e02:1648:b0:366:444b:82d6 with SMTP id
 v8-20020a056e02164800b00366444b82d6mr6714ilu.15.1710183283551; Mon, 11 Mar
 2024 11:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-3-irogers@google.com>
 <CAEf4BzYiH6xRRLFBdUAkjn0uJP=safZod4=1EmEwTTH9PDmVvQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYiH6xRRLFBdUAkjn0uJP=safZod4=1EmEwTTH9PDmVvQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Mar 2024 11:54:32 -0700
Message-ID: <CAP-5=fUQY=ho1OSk-wosw8=7Sjp8MB_kngggP00BXs+nVNj7Pg@mail.gmail.com>
Subject: Re: [PATCH v1 02/13] libbpf: Make __printf define conditional
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Mon, Mar 11, 2024 at 10:49=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Mar 9, 2024 at 6:05=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > libbpf depends upon linux/err.h which has a linux/compiler.h
> > dependency. In the kernel includes, as opposed to the tools version,
> > linux/compiler.h includes linux/compiler_attributes.h which defines
> > __printf. As the libbpf.c __printf definition isn't guarded by an
> > ifndef, this leads to a duplicate definition compilation error when
> > trying to update the tools/include/linux/compiler.h. Fix this by
> > adding the missing ifndef.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index afd09571c482..2152360b4b18 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -66,7 +66,9 @@
> >   */
> >  #pragma GCC diagnostic ignored "-Wformat-nonliteral"
> >
> > -#define __printf(a, b) __attribute__((format(printf, a, b)))
> > +#ifndef __printf
> > +# define __printf(a, b)        __attribute__((format(printf, a, b)))
>
> styling nit: don't add spaces between # and define, please
>
> overall LGTM
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Two questions, though.
>
> 1. It seems like just dropping #define __printf in libbpf.c compiles
> fine (I checked both building libbpf directly, and BPF selftest, and
> perf, and bpftool directly, all of them built fine). So we can
> probably just drop this. I'll need to add __printf on Github, but
> that's fine.
>
> 2. Logistics. Which tree should this patch go through? Can I land it
> in bpf-next or it's too much inconvenience for you?

Thanks Andrii,

dropping the #define (1) sgtm but the current compiler.h will fail to
build libbpf.c without the later compiler.h update in this series.
This causes another logistic issue for your point 2. Presumably if
this patch goes through bpf-next, the first patch "tools bpf:
Synchronize bpf.h with kernel uapi version" should also go through the
bpf-next.

Thanks,
Ian


> > +#endif
> >
> >  static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
> >  static bool prog_is_subprog(const struct bpf_object *obj, const struct=
 bpf_program *prog);
> > --
> > 2.44.0.278.ge034bb2e1d-goog
> >

