Return-Path: <linux-arch+bounces-10369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A466A44F41
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 22:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C614218AE
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFD320FA9E;
	Tue, 25 Feb 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce2SbEsp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C221171A;
	Tue, 25 Feb 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520365; cv=none; b=T3xyvvAUiTlMNFdSfN8TnidHYnQnNU+5g4QeJ1DJ3FrG5yfmIVC3BEYliwE/JwiCNHpsXBlHVnVpXAERCIOEcjy3fOyny5ij3yeBHp5onMkWR3gI33fWFrq188nKu57m0tYC7SdLw+MKjwMuXW4yy1pKHlglwqW86OA1qJQPWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520365; c=relaxed/simple;
	bh=8Y9rmuMcKl0zy+sdizyBBwu0pZypzvQMyyqv5Rrr5wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RP6Ai2mAncDIyDP/nX/7+CCw5IQltHO2d/lWHxHq8zaDXBQYsTKYXro1vJd8HDe+Pg/Y6qkqX8gbT8+BPcgIwoIX1VWTMYCd5sbzSSd0i/O7NLgCy+VpXh4Mn7mu7yfynFsSjH9MIk9nSqMNfcLBmOgl0ABQIjb+3kMKVVplZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce2SbEsp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso9080667a91.1;
        Tue, 25 Feb 2025 13:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520363; x=1741125163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB6oxdGmdWsniKQ7DCrH6iIic1TMC3/1oTlo14itLWw=;
        b=ce2SbEsp/QdQH/JpHXp1xvOydp2nu/y2qOcamvxuocd/FvsNUMhhiwgmBVgT7OqD4/
         N8/EEHYnQ+yEXO/8CMi6C5KMAZBGsM9qLB00oea2i+zRgmhdproMSxtoZeYqXGx8WOhD
         kW01pZ9P7ox+SRvekbn73c3HbXO80l1Hmlxezv0dKci7Y9sRmfdnCLlZzoFvaAp1x7o/
         94zV/Jq4EBZ965Se/9X6ZS2tHN+fXlk28lZklnCCeMVjV+lkTv14YbMGxkCSM+ymqODS
         w8rMS/uE4boqp2Ct+8SUKk7iifJbcPFjmLh3+WRw/BrqkvfSEmbE+nYLEqztaIpASRQW
         Q/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520363; x=1741125163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB6oxdGmdWsniKQ7DCrH6iIic1TMC3/1oTlo14itLWw=;
        b=IWU56jiSTK78i9UFNuY1kUJLpphWF7oz92mbpBbU18ZvOZMXfctfjULWR7wa+Uuwva
         zgR+U2SX4z8kWKmOZuV/fY0YnzKtwjeUnRWYyCdMbdAqeezZnCfPdgrKmgNtg6tjXY/W
         BYGtvKWzCGFcorids1xecAHfB4M/EQnBhr+qhh0dbE5DeVTPY7wuEZ+0c1TobSJd2t/P
         qFaey3IgerJTuKPdMPlPGXLfomVR2jaE/rsqa8UDhI5vfoQKqlZO1c4B8t0mu8SUuWlW
         OhFHzCsZG8/NTR8ZJ++o5/KS9sGpQSAHdhl/7rIS9Maj+dyt5l7a0fi+TrYnl+dmzphS
         QNNw==
X-Forwarded-Encrypted: i=1; AJvYcCU2tBcoWjdjyQV605szbQTGZA13JseVkyI6WB72wXui4yK9pPHTxZya52yqDSEmIe5tP6Y=@vger.kernel.org, AJvYcCUB1JaTbENCtFGFXNylSPOUikIN8qxL0ZAcbElIPk9KUgYE2v4nL/DPPx53fKuZzsbBin74quZB9WduKw==@vger.kernel.org, AJvYcCUKn8hk79Bbku9WHbBWJUt9u4cs+EnRQt+65nuq00ruXWHU6aQwd5+cPrRmBTb41/qSuDRmMH/OE3ymSxJWkfzT@vger.kernel.org, AJvYcCWZU6UoR+y0bgxSIbGgmTYjOMQtvda2JVOD9LeFy/RfUwHzofd48V328NjggsEGqkRYRxsdDojGrzVjzCZQ@vger.kernel.org, AJvYcCXrW0KqmFRvKwLROurFVxEdsIUV41Mw61K2Ifa/bvo4/dbd/zUjn98SKr0gEZXL45bT/8ovtKQHV3OO9VGu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa492i5zt88HJ3Iuj1wOgPz2qnkCwTKM8xwSgoAyG32gdslcP+
	T68xyr6M3vLsiEBIN7PfFrsQN8UPmiEr31VydrtzDzlow8L8HGjkfBSIZCQSXLlPGUpUGJ5CCTr
	sCn9r5JJcRdJfxLnCZh1832oeshs=
X-Gm-Gg: ASbGnctoXzsrVTkp4Bp7oiewCqiV/MoZNy0e602hnoGKkk2DXtEG7+tlSXVetcFZC7E
	0P9Lgp/LGW8lfpf2Dgy3fbcYZcFz6FnxLv7m7y7Rs7qFNCPd55ohh+b+JqR0gROfeKgYtEiFOKr
	h49ep9q3c2BG+Xd0Z+iYQq08A=
X-Google-Smtp-Source: AGHT+IGRomNE8qud7Uu+5mcp3y45cfmiKLTBWoGo5gkppuz16rT0/tPr1Y4UqBxU2B1PV6obQyISvJoYI/p5wMgzZFs=
X-Received: by 2002:a17:90b:5202:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-2fce7b04f9bmr30219633a91.27.1740520362970; Tue, 25 Feb 2025
 13:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-3-stephen.s.brennan@oracle.com> <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
 <83a42276-22cc-4642-8ce6-7ef16fa93d9c@oracle.com>
In-Reply-To: <83a42276-22cc-4642-8ce6-7ef16fa93d9c@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 13:52:30 -0800
X-Gm-Features: AWEUYZnYhl-iPxCkwOD_3RmI5SjMUyi3IqiNvLAQBYwML34ZoIPnPey0X-PqGl8
Message-ID: <CAEf4BzYvFnqeZjNy_b_VP9DEpBaTMWuMAau8j6ZAWtgwcE5ysg@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 2:02=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 07/02/2025 23:50, Alexei Starovoitov wrote:
> > On Thu, Feb 6, 2025 at 5:21=E2=80=AFPM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >> When the feature was implemented in pahole, my measurements indicated
> >> that vmlinux BTF size increased by about 25.8%, and module BTF size
> >> increased by 53.2%. Due to these increases, the feature is implemented
> >> behind a new config option, allowing users sensitive to increased memo=
ry
> >> usage to disable it.
> >>
> >
> > ...
> >> +config DEBUG_INFO_BTF_GLOBAL_VARS
> >> +       bool "Generate BTF type information for all global variables"
> >> +       default y
> >> +       depends on DEBUG_INFO_BTF && PAHOLE_VERSION >=3D 128
> >> +       help
> >> +         Include type information for all global variables in the BTF=
. This
> >> +         increases the size of the BTF information, which increases m=
emory
> >> +         usage at runtime. With global variable types available, runt=
ime
> >> +         debugging and tracers may be able to provide more detail.
> >
> > This is not a solution.
> > Even if it's changed to 'default n' distros will enable it
> > like they enable everything and will suffer a regression.
> >
> > We need to add a new module like vmlinux_btf.ko that will contain
> > this additional BTF data. For global vars and everything else we might =
need.
> >
>
> In this area, I've been exploring adding support for
> CONFIG_DEBUG_INFO_BTF=3Dm , so that the BTF info for vmlinux is delivered
> via a module. From the consumer side, everything looks identical
> (/sys/kernel/btf/vmlinux is there etc), it is just that the .BTF section
> is delivered via btf_vmlinux.ko instead. The original need for this was
> that embedded folks noted that because in the current situation BTF data
> is in vmlinux, they cannot enable BTF because such small-footprint
> systems do not support a large vmlinux binary. However they could
> potentially use kernel BTF if it was delivered via a module. The other
> nice thing about module delivery in the general case is we can make use
> of module compression. In experiments I see a 5.8Mb vmlinux BTF reduce
> to a 1.8Mb btf_vmlinux.ko.gz module on-disk.
>
> The challenge in delivering vmlinux BTF in a module is that on module
> load during boot other modules expect vmlinux BTF to be there when
> adding their own BTF to /sys/kernel/btf. And kfunc registration from
> kernel and modules expects this also. So support for deferred BTF module
> load/kfunc registration is required too. I've implemented the former and
> now am working on the latter. Hope to have some RFC patches ready soon,
> but it looks feasible at this point.

Lazy btf_vmlinux.ko loading when BTF is actually needed (i.e., when
user reads /sys/kernel/btf/vmlinux for the first time; or when BPF
program is validated and needs kernel BTF) would be great. Curious too
see how all that fits together!

>
> Assuming such an option was available to small-footprint systems, should
> we consider adding global variables to core vmlinux BTF along with
> per-cpu variables? Then vmlinux BTF extras could be used for some of the
> additional optional representations like function site-specific data
> (inlines etc)? Or are there other factors other than on-disk footprint
> that we need to consider? Thanks!

I'd keep BTF for variables separate from "core" vmlinux BTF. We can
have /sys/kernel/btf/vmlinux.vars, which would depend on
/sys/kernel/btf/vmlinux as a base BTF. Separately, we could eventually
have /sys/kernel/btf/vmlinux.inlines which would also have
/sys/kernel/btf/vmlinux as base BTF. If no one needs vmlinux.vars on
the system, we won't need to waste memory on it. Seems more modular
and extensible.

>
> Alan
>
> > pw-bot: cr
> >
>

