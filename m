Return-Path: <linux-arch+bounces-2932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAAA8789B7
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 21:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C6A1F213FE
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BA550260;
	Mon, 11 Mar 2024 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hARHJHvt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2243AAC;
	Mon, 11 Mar 2024 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190325; cv=none; b=NnvQJoB1EbU+fzwNSALBjvELsu8qv9VO+SxlYdYDRly6V/3L/GsxWxkwlsos/CUz6Cd0QE0aUtS1k9hIdtjf2XyieJ97Sz7t5yK6ea+fwtrWR1WitOU3/t0qS9FUYJQ6j8MbzdoP6tcTtBPiMP1SVizq8YD7KyQ2SSNjmrSrex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190325; c=relaxed/simple;
	bh=ByUIPZ47pKYggMFQ2m6tctWjj7DYdv9nhhKxwYcw3UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrIoCnnSUBKYCIwPjxjs4ushdVrJXNFEEsd6G0b4lEHTBC03YcxUEbJPjOfqsbLpq5WjnyUJ378asCLmSqVzdbEhDaB0fyYmOYaC5BxajdZC0Ec2ViaQfLf0KttWu5ZppQieXLOnICTaDfas7bq2dJ+LYYw8tZEo1mhCllJUVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hARHJHvt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29aa91e173dso3332025a91.0;
        Mon, 11 Mar 2024 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710190322; x=1710795122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd981U9xN2VeJ5yKqoYAGms3X6oq3hxLcufVnnlsh9s=;
        b=hARHJHvtO737bqTwyz5cg0hA6e4j2p8yu7kDcJCBs4t+YWcppX0ASRrMknh4fV7Y6Z
         Dss5OEVuHQ8WZ1mR3Yjf4rDuK3aQmjKKIqhshXXm4LJcmA+2r1eruvwGKCGBTPSc6VLj
         Bv8aW/0Mo7TW792qRJu3WUR8fDcrUFv2gqinqU6Wl8AC6q4tOHFbhvKnoMHMq+X5ePVE
         BA11BRQjlrpd/9rdIb09X44q6y6jBXZWS/7/7kGVz6x7fHn7tEbrT3tI3BU47AKhMLqT
         y9HZq0n25TyObQvIXQMvT+nR4gBwUHcZSEirDJX8/u8YxTWJlNojXtW9DX3nzGYiUyZW
         Q0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710190322; x=1710795122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dd981U9xN2VeJ5yKqoYAGms3X6oq3hxLcufVnnlsh9s=;
        b=NbhijlJZd2ZU4E0sFDIPllG42CvxZdrXgm/u+glXLpgsX1nRWbdgTz/UNLwbjzPvBX
         NY210+hm30TQ50jCU/v1b0DAkp6YOWAObT8GcjIUNxLBvm00nZ8VR1qfOZOvM6ggUuAe
         TUfz3desXGtkkkz/aYsxIWvNfHVI108kypWYowK2aczu90ay5+AtaT9+QsM9BA1FclfI
         a27rORLAcsZe/asASTunQos6w0+s7cWHmPHsn5hOEruD4WUcRE42B1NvjaHBfgyC6iRm
         3jMOprw2ELmtFPljpVfsisFwSbCPvzbny9fxQkswLEUEu4bYKLwwJFhYL4QOOR5Pm/8t
         dATA==
X-Forwarded-Encrypted: i=1; AJvYcCWc6Y2UhhcH4A1sw02tIt4uD7jMjnBQqXu3R4KYrPVN43SLPRBafZKCJ/xGKjpkLUQRu8S91sh0aGEpEbWbYdB/DE68JHlQWLTTrn3kWw6FMTOa6jzsdVp7OQSguqPWZM3kQiZX5hZcLrn489Bt5ExpzsTq+YYl1JY0q1ALdFKC2STCdVKv+q7nu/DbFh21tKXWqcsGGEmFJCQCOspQ81KP63cu/0p53sGe88uXwnMCxyqe1HrqJIQX2NfXM1fejwwb0uIPfE8MgeSCC2HNAZMYo0CXHyVT+OasV/8m7tedV4nKTqwRyc1CnEaLfZ+8gUdbH7KVbcc=
X-Gm-Message-State: AOJu0YwThJrmvk04hJJZhgs5DVjAbJGNS0aS1MyxZGtLfpKLGvJwL9uR
	yHmUlm9A4HWKIj3ve+K7GaTw2/bbcEH2vzy3x5m40cgkOyT6VO8CJuWkACmDtyQNuZMnLL02KM7
	9MiPypxLF1BX7fxLTLYrc6LSIafI=
X-Google-Smtp-Source: AGHT+IEgfLgZ9vcdFhZoSO6fknZCxb89NjyC+7Z+5uVV9Zl7CWKCYHTODpZc68UrZGzW1EcTqjEdltk5w4Wxjqea6SM=
X-Received: by 2002:a17:90a:390c:b0:29b:a509:30aa with SMTP id
 y12-20020a17090a390c00b0029ba50930aamr112253pjb.14.1710190321684; Mon, 11 Mar
 2024 13:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-3-irogers@google.com>
 <CAEf4BzYiH6xRRLFBdUAkjn0uJP=safZod4=1EmEwTTH9PDmVvQ@mail.gmail.com> <CAP-5=fUQY=ho1OSk-wosw8=7Sjp8MB_kngggP00BXs+nVNj7Pg@mail.gmail.com>
In-Reply-To: <CAP-5=fUQY=ho1OSk-wosw8=7Sjp8MB_kngggP00BXs+nVNj7Pg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 13:51:49 -0700
Message-ID: <CAEf4BzZ+4WAaySJVGArk3epJ-u92ULkcoXTr2HnRXshGx8fPDw@mail.gmail.com>
Subject: Re: [PATCH v1 02/13] libbpf: Make __printf define conditional
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

On Mon, Mar 11, 2024 at 11:54=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Mar 11, 2024 at 10:49=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Mar 9, 2024 at 6:05=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > libbpf depends upon linux/err.h which has a linux/compiler.h
> > > dependency. In the kernel includes, as opposed to the tools version,
> > > linux/compiler.h includes linux/compiler_attributes.h which defines
> > > __printf. As the libbpf.c __printf definition isn't guarded by an
> > > ifndef, this leads to a duplicate definition compilation error when
> > > trying to update the tools/include/linux/compiler.h. Fix this by
> > > adding the missing ifndef.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index afd09571c482..2152360b4b18 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -66,7 +66,9 @@
> > >   */
> > >  #pragma GCC diagnostic ignored "-Wformat-nonliteral"
> > >
> > > -#define __printf(a, b) __attribute__((format(printf, a, b)))
> > > +#ifndef __printf
> > > +# define __printf(a, b)        __attribute__((format(printf, a, b)))
> >
> > styling nit: don't add spaces between # and define, please
> >
> > overall LGTM
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Two questions, though.
> >
> > 1. It seems like just dropping #define __printf in libbpf.c compiles
> > fine (I checked both building libbpf directly, and BPF selftest, and
> > perf, and bpftool directly, all of them built fine). So we can
> > probably just drop this. I'll need to add __printf on Github, but
> > that's fine.
> >
> > 2. Logistics. Which tree should this patch go through? Can I land it
> > in bpf-next or it's too much inconvenience for you?
>
> Thanks Andrii,
>
> dropping the #define (1) sgtm but the current compiler.h will fail to
> build libbpf.c without the later compiler.h update in this series.
> This causes another logistic issue for your point 2. Presumably if
> this patch goes through bpf-next, the first patch "tools bpf:
> Synchronize bpf.h with kernel uapi version" should also go through the
> bpf-next.
>

That's what I'm saying, it seems to work without your patches already.
At least on bpf-next/master. But it's ok, let's keep it and just add
#ifndef guard, that will make my life easier when syncing to Github
later one. Then the patch can go through other trees and eventually
make it into bpf-next and then Github. So please keep my ack for
#ifndef version, thanks.

> Thanks,
> Ian
>
>
> > > +#endif
> > >
> > >  static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
> > >  static bool prog_is_subprog(const struct bpf_object *obj, const stru=
ct bpf_program *prog);
> > > --
> > > 2.44.0.278.ge034bb2e1d-goog
> > >

