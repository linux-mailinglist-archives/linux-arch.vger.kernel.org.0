Return-Path: <linux-arch+bounces-2930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E30E8788DE
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 20:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612341C2082C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD7C54F88;
	Mon, 11 Mar 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxbuNjla"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BC481C0
	for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185078; cv=none; b=u37yS0N4OWxrVxCdEt+89JLcdbHb/GQ/6mqpuZ2B1I/aq3vZrmgorrd/gfgwKjCmhv0yNPLLrY5hIopQh3V+Yqcof+tETrPID6ih657s59/GKi0R/PHITfIcrzDA163DgbGI8VI8L0pNXfaMOay/z8snj5NnGpmBmiep53I328o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185078; c=relaxed/simple;
	bh=DgLWHcwduAxqjCigbUNUqTye02EDECmbNSNBeiAjWj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoMh343jWjCFNF7jJfLdGkNS+ipgI2fN0lDe/FfDxwIVCopFhE2QRffBxxI1BqXbMVny49nCTdwZ+ZBc76Dje9RxhcPRwBxooTmRHW3n/x/Qrm5VJRreikTOl1ZvRmuN2ilW03IfKQ2BQ5F30I3foNufDBGsVJtM28zKQ1MouNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxbuNjla; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-366248b78d9so17495ab.1
        for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2024 12:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710185075; x=1710789875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPemlJM4Xz0k98wRrCIdoRJ/9LZG6WhrdONiHPBnMmw=;
        b=pxbuNjlaOnceYNWJHoUQQzhYjMPi130X9DGE9v72HGo8G2ovCj3Eyq640WR1ZIe1+A
         sYD4B9u6vxyLeIErXplk896HlLVI0sUgi/QVDCoq6VME612+J5pLJnEEIcXhokFK+P2U
         Nma8U98Prf+9nxVDUbGe8P0FGuAlfqC1HoT/LAUrRZD/rkskb07d49yHbfE9G0v4inZz
         IIC7Ija2Cak7EeP3EL+xMrpHrpdG+J9Q+QkUCsAlt14OGsMVngNp4UrGF+ogSRWbUTcR
         G17E/qzGa3/MDWceOIjZSJH04GccTuicpN3sMVxBhhiDsxWbf8Hw5tEdngiZ/qRCubZP
         iW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710185075; x=1710789875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPemlJM4Xz0k98wRrCIdoRJ/9LZG6WhrdONiHPBnMmw=;
        b=i6YZv8CaDwuu6HXpGqMHHHQ4nGQlWee9KoGhqZcziOs1sxQmkWb7qbt0aWP5r28E4x
         LO8tqPRyCooPK71Khbyc1ZFrcQRnnjtE4XUa6ZWve6IxeoM8k63FbW2PIR+uxsSBQtB4
         V/+kgymr62ZuSzOZFfeFwFZWxSPnlxGPWNk04AI1pD+kLfKKLMdCNAzRIdpGtkz5F75V
         D4AWgt5AtQrOjfUz9TLQwyhFacKiT97GeOAXTE9tyg0RnvFUsswjQiTb4DVCIZ20rquC
         HMfJP2waOzY56bMrF3o/QL/i1XoCBZ+MUm6qiQHT92E0jdjay4d/d92xrEEjSElCk+0A
         yQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCV53CYEGAXMxzw2oCgt+4WRdL+L96HrfmxhfPg3x+BNkwqr8wlDdwzstk409uu4Gg1vYQgi62wm3PhzEZe3nXNpYdtTRc2VZWrhcg==
X-Gm-Message-State: AOJu0YzAzkhvxtPWvQXpO8nxrFNvpfsQVl+kesXfhQuvub0CwcZfOxNI
	Nu6g0AGyJBi6Y5BFnwGoiln2MuG4Zkj2K6eZ7GhSoRv3yP6EccxYMvOYTuxgKqUZs/C8/nNfE9Z
	sW8O0H+ptrjcfnfTmKl0I5+m7/SPjf7R3cxqv
X-Google-Smtp-Source: AGHT+IHK6kjYuN+av2sRfyJ8pA7jWQvyzS6EkNDyOpNIDK07iRRVV0vswER0vA5L4Tl9BTd3XE1V8lLoEXKubRDEp18=
X-Received: by 2002:a05:6e02:1a43:b0:366:27e0:3425 with SMTP id
 u3-20020a056e021a4300b0036627e03425mr10947ilv.19.1710185075344; Mon, 11 Mar
 2024 12:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-13-irogers@google.com>
 <1ab20914-b6d2-fe39-7b14-c1ccebaa34f6@arm.com>
In-Reply-To: <1ab20914-b6d2-fe39-7b14-c1ccebaa34f6@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Mar 2024 12:24:24 -0700
Message-ID: <CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/13] tools headers: Sync compiler.h headers
To: James Clark <james.clark@arm.com>
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
	Nick Forrington <nick.forrington@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
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

On Mon, Mar 11, 2024 at 9:34=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 10/03/2024 02:05, Ian Rogers wrote:
> > compiler.h - synced from include/linux/compiler.h, guards were
> >  added to definitions to avoid redefinition of macros
> >  in libc. ftrace, CONFIG_OBJTOOL and kentry logic was removed as
> >  redundant.
> >
>
> Hi Ian,
>
> This commit breaks the Arm build (and cross compilation for Arm on x86):
>
>   $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-
>
> Something like this, but I won't paste the whole output because it's huge=
:
>
> tools/include/linux/ring_buffer.h: In function =E2=80=98ring_buffer_read_=
head=E2=80=99:
>
> tools/include/asm/../../arch/arm64/include/asm/barrier.h:72:35: error:
> =E2=80=98__u8_alias_t=E2=80=99 undeclared (first use in this function)
>    72 |                         : "=3Dr" (*(__u8_alias_t *)__u.__c)
>        \
>       |                                   ^~~~~~~~~~~~
> tools/include/linux/ring_buffer.h:59:16: note: in expansion of macro
> =E2=80=98smp_load_acquire=E2=80=99
>    59 |         return smp_load_acquire(&base->data_head);
>       |                ^~~~~~~~~~~~~~~~

Sorry for this James, I was rushing. I'll address the issues in v2 but
the one you highlight above doesn't look like a fun/simple issue to
resolve :-( Tbh, I'm not sure how much value tools/include has in its
current set up. It is weird the include order in perf prefers
tools/include/linux over tools/include/uapi. Current tools/include
seems to be trying to do a few different things:

1) provide headers like list.h so programs in tools can have linux
style lists, etc.
2) stuff that (1) drags in .. do we really want the asm barrier code
from arm? A sane user space program would be better using stdatomic.h,
plus that'd give the user space program an ability to get compiled on
to weirder targets like wasm. Plus we end up with weird type conflicts
like bool coming from linux/types.h rather than stdbool.h.
3) copies of kernel uapi headers that may be more up-to-date that
those in your system, thereby exposing constants that things like
libbpf depend upon.
4) headers with the same name as and that resemble kernel headers but
are really a reimplementation, like tools/include/linux/string.h
5) headers we have just so we can use shell scripts to scrape
constants for beautifying things in perf trace

For (1) and (2) it seems a separate library would be cleaner than
having the code in tools/include.
(3) feels like a legit use-case, so we should hold onto
tools/include/uapi, but do we want the asm directories?
(4) sounds like it should be in a library, perhaps with (1) and (2).
(5) feels like the headers should be alongside the shell scripts to
avoid polluting tools/include.
Not that I propose fixing any of this here.

Thanks,
Ian

> Thanks
> James

