Return-Path: <linux-arch+bounces-10383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6C5A4672A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785C93A540A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB5821C9E8;
	Wed, 26 Feb 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTSPOZJE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3D2904;
	Wed, 26 Feb 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589072; cv=none; b=RSlOVLkRQUqkc4YPz5ggEADbxGwUAtMjJquJJPbDGc/t0mgjqyWaPD5wxFAaEUVV/QuGc91mHLwWsQeE1vmS5/N17NHATKfVFdoqa1qWx60jCU8EtKKFq7Irt86CiPU32UEZHRazf2q3CG0W6dPsEqHkKJsmJ7zSoHQNHLjS5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589072; c=relaxed/simple;
	bh=oDzNzJQCQCpod+FlpG1cOpfLw0rTcV7/aHUCSfgM1II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cS0PDz6y02che7m7+TllDWExRxC1lsCtMaCy9jj0gjzUEfr+3yuMAHOv5RbpdP+laqalVEz/kNPA2zTdhpYqEJnQKNOQgZNwpm8KY8RzVPqWSRbdxWUfzjBBySjuN4GT9iqRfhcb1nEa+ouCFmtjYuqploz6TOVYRCLE6ne49AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTSPOZJE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22349bb8605so3197605ad.0;
        Wed, 26 Feb 2025 08:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740589071; x=1741193871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W00ofEXGknDTyL3Hozx7OoQOLaiK6RbK+sTUYcCUMas=;
        b=NTSPOZJEd9tcFYTkzQLYOXK/16bGm+lDHKOGkLZHwvek6tu/MupUipo+m31BrG4VSK
         HDN2/KDdYMlgSGZaS6ulu3knr4UoZEvCidJAovbW4xRV1lYjIgYwAX68Ga7d9it4q0GM
         iVmj615TE7XaACcGAF3UohhF7gScVP2l/HPxNltdyO/Clq/uHZSpuqFKZo9R5JV0n9Gq
         3Oy446H+UhzqI45+d6T2bsFtD5oRiFGxtWRZNVpm+NufF2gaM7VZ8Bi9tTR1UBqKBbU4
         AQ5ZcB4pEVDkzQLXWK6zIkki5UlElrcRbRC/WER9I5ReodIYYK0SoziN7+Xx7W1D8UDW
         LB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740589071; x=1741193871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W00ofEXGknDTyL3Hozx7OoQOLaiK6RbK+sTUYcCUMas=;
        b=o2fMoaHXM50qWaG0xqLbM9gbJz076QemUQfnB3TFKUrTePVTBQdfTAkHL3XaqD1Ajk
         wooPr8dgzgCVdmFispK23Jyy6jiuV/xJOZqjVA6u5XBy1NFcVK6wvj/SGt5nzJ+DOdMU
         0UwAP1vzxhgKDzRUUz368RFlNPFcuAY2mDBH5FJDv5z1QaEbuAyv6/7ZKTm7Dv35+NVi
         jyDebmDW9TulKIqWbKTnC2xiFC68glxs9VYfPnNWF48TJkMjhBPcHvINsX9vaT1tEcFV
         GVgWY+VsUVVAfTDcFa8LlhPZ6fTLcfyzCc4db0h9IbzlKHmcxpaPG0Ze759+Xi16Gnm0
         Z4ig==
X-Forwarded-Encrypted: i=1; AJvYcCUNy0WFPMEmNkkZlXHdqX3EuqdjI3kAWCfgW8A81zrapKLZLToMqwoelWH3c7KsDSoG5fEdeyzxKNZKJw==@vger.kernel.org, AJvYcCUUBq5I2XC8o/BaKGP7QhvK95iF1qgWO37f/1O+oN4+PN5CLZ+WXoIj5e3J2le+GvDDjpJxl6EMXl0a/wmx@vger.kernel.org, AJvYcCVVsTozvrKdcERnnlrjFFFvG5UUr0Z3jbXU6hPaBzyPNArogAjjvXDRUI2pg7j1e8hiaxc=@vger.kernel.org, AJvYcCVgb9ExtE73mwZ3JRdfL45SNLZbv/zo1/7r1dZzpBAxSsRt52SP/xRYrw1PffzTjQgNB0fNvKobb34Tv4GQTHLG@vger.kernel.org, AJvYcCW+oaawNeDPybFZ3MHASLieNUXPcV91FO/vNqMWoPxQCU8XDV1YaTHY6u8fKAcasC1I4wt2WDTsmOB9Ogwe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wwKs9hYYfooHoyhslLE8HRBhDh55jNbkeVbXOd1bm4ZsoLtx
	cNgjU9v91n9MoQnTP6I8dTEgv+bW/2qTmCkf4e/jw7XXX1NJdi205yDNLQ9wyZeXz7tb6/40I1d
	l4kIKd9PRTqye6DIN9MBhIBpbY+s=
X-Gm-Gg: ASbGncu7I2p+mwH4UI933zOI7/QeR6b5myswBzEqb1DoXkLwcPDr4ncssibX6nAPZMM
	nAoSSl4IkmRUD+SWvJxlZadMIJB+px41YKUkW4BUBmq+pLQhMo6A5cWP0QJutyUoUR2Wh2ttwAc
	OnZuJ67R3W4VJZvcMxQgEKPAI=
X-Google-Smtp-Source: AGHT+IEgGbTxa5fw9Tzi+zukInErP5tYADKg37pvA52HJFQbFmG6OY3lcDtNCZ78IPi05FLe6gVOZF5uM4bgca5k6Uw=
X-Received: by 2002:a17:90b:54c7:b0:2fc:a3b7:1099 with SMTP id
 98e67ed59e1d1-2fe68ac95e7mr12048949a91.4.1740589070678; Wed, 26 Feb 2025
 08:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-3-stephen.s.brennan@oracle.com> <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
 <83a42276-22cc-4642-8ce6-7ef16fa93d9c@oracle.com> <CAEf4BzYvFnqeZjNy_b_VP9DEpBaTMWuMAau8j6ZAWtgwcE5ysg@mail.gmail.com>
 <6c89777a-65dc-44da-83cd-005cb6c82430@oracle.com>
In-Reply-To: <6c89777a-65dc-44da-83cd-005cb6c82430@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Feb 2025 08:57:38 -0800
X-Gm-Features: AQ5f1JrDtsm8c0OwuLqeBst-uB_gQt0f_-0bBGt8FY0lP-kpDaIh-BvZG47lX_k
Message-ID: <CAEf4BzbyjuM8wXChRejxkYFSm0o=+udr7uGink-5Wo1Ayb6M_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf: Add the option to include global variable types
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	linux-arch <linux-arch@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:20=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 25/02/2025 21:52, Andrii Nakryiko wrote:
> > On Tue, Feb 25, 2025 at 2:02=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 07/02/2025 23:50, Alexei Starovoitov wrote:
> >>> On Thu, Feb 6, 2025 at 5:21=E2=80=AFPM Stephen Brennan
> >>> <stephen.s.brennan@oracle.com> wrote:
> >>>> When the feature was implemented in pahole, my measurements indicate=
d
> >>>> that vmlinux BTF size increased by about 25.8%, and module BTF size
> >>>> increased by 53.2%. Due to these increases, the feature is implement=
ed
> >>>> behind a new config option, allowing users sensitive to increased me=
mory
> >>>> usage to disable it.
> >>>>
> >>>
> >>> ...
> >>>> +config DEBUG_INFO_BTF_GLOBAL_VARS
> >>>> +       bool "Generate BTF type information for all global variables=
"
> >>>> +       default y
> >>>> +       depends on DEBUG_INFO_BTF && PAHOLE_VERSION >=3D 128
> >>>> +       help
> >>>> +         Include type information for all global variables in the B=
TF. This
> >>>> +         increases the size of the BTF information, which increases=
 memory
> >>>> +         usage at runtime. With global variable types available, ru=
ntime
> >>>> +         debugging and tracers may be able to provide more detail.
> >>>
> >>> This is not a solution.
> >>> Even if it's changed to 'default n' distros will enable it
> >>> like they enable everything and will suffer a regression.
> >>>
> >>> We need to add a new module like vmlinux_btf.ko that will contain
> >>> this additional BTF data. For global vars and everything else we migh=
t need.
> >>>
> >>
> >> In this area, I've been exploring adding support for
> >> CONFIG_DEBUG_INFO_BTF=3Dm , so that the BTF info for vmlinux is delive=
red
> >> via a module. From the consumer side, everything looks identical
> >> (/sys/kernel/btf/vmlinux is there etc), it is just that the .BTF secti=
on
> >> is delivered via btf_vmlinux.ko instead. The original need for this wa=
s
> >> that embedded folks noted that because in the current situation BTF da=
ta
> >> is in vmlinux, they cannot enable BTF because such small-footprint
> >> systems do not support a large vmlinux binary. However they could
> >> potentially use kernel BTF if it was delivered via a module. The other
> >> nice thing about module delivery in the general case is we can make us=
e
> >> of module compression. In experiments I see a 5.8Mb vmlinux BTF reduce
> >> to a 1.8Mb btf_vmlinux.ko.gz module on-disk.
> >>
> >> The challenge in delivering vmlinux BTF in a module is that on module
> >> load during boot other modules expect vmlinux BTF to be there when
> >> adding their own BTF to /sys/kernel/btf. And kfunc registration from
> >> kernel and modules expects this also. So support for deferred BTF modu=
le
> >> load/kfunc registration is required too. I've implemented the former a=
nd
> >> now am working on the latter. Hope to have some RFC patches ready soon=
,
> >> but it looks feasible at this point.
> >
> > Lazy btf_vmlinux.ko loading when BTF is actually needed (i.e., when
> > user reads /sys/kernel/btf/vmlinux for the first time; or when BPF
> > program is validated and needs kernel BTF) would be great. Curious too
> > see how all that fits together!
> >
> >>
> >> Assuming such an option was available to small-footprint systems, shou=
ld
> >> we consider adding global variables to core vmlinux BTF along with
> >> per-cpu variables? Then vmlinux BTF extras could be used for some of t=
he
> >> additional optional representations like function site-specific data
> >> (inlines etc)? Or are there other factors other than on-disk footprint
> >> that we need to consider? Thanks!
> >
> > I'd keep BTF for variables separate from "core" vmlinux BTF. We can
> > have /sys/kernel/btf/vmlinux.vars, which would depend on
> > /sys/kernel/btf/vmlinux as a base BTF. Separately, we could eventually
> > have /sys/kernel/btf/vmlinux.inlines which would also have
> > /sys/kernel/btf/vmlinux as base BTF. If no one needs vmlinux.vars on
> > the system, we won't need to waste memory on it. Seems more modular
> > and extensible.
> >
>
> Sounds good. So thinking about how this fits with
> CONFIG_DEBUG_INFO_BTF=3Dm, perhaps the approach would be to use
> btf_vmlinux.ko for all such extensible /sys/kernel/btf/vmlinux.vars,
> vmlinux.inlines etc. Each of these is derived from .BTF.vars ,
> .BTF.inlines sections in btf_vmlinux.ko. These are optionally included
> via CONFIG_DEBUG_INFO_BTF_EXTRAS list. If CONFIG_DEBUG_INFO_BTF=3Dy the
> core vmlinux section stays in vmlinux itself and the extras are
> delivered via btf_vmlinux.ko, but if CONFIG_DEBUG_INFO_BTF=3Dm, the
> vmlinux .BTF section is delivered in btf_vmlinux.ko too.
>
> If this makes sense, I'll try and put together the
> CONFIG_DEBUG_INFO_BTF=3Dm support first, and that will give us a
> btf_vmlinux.ko to work with for delivery of extras. Thanks!

I'd keep our options open as to whether btf_vmlinux.ko contains all
vmlinux BTFs (core BTF, inlines, variables) or we have a separate
module for some subsets. E.g., variables, while a useful thing,
probably won't be used all that frequently (i.e., only while debugging
with drgn), so co-locating it with vmlinux BTF itself might be a waste
in most cases.

But other than that makes sense.

>
> Alan
>
> >>
> >> Alan
> >>
> >>> pw-bot: cr
> >>>
> >>
>

