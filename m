Return-Path: <linux-arch+bounces-12120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D18AC289A
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 19:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A87316918C
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41F2980CE;
	Fri, 23 May 2025 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki+P6v+k"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB522A1CD;
	Fri, 23 May 2025 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021287; cv=none; b=lXE4sMdYPE/UmT7N5Z/stxNBMPmM2XIvQgAzgU8akyk0s905NcqELvC4rvNrZwTNIEMR8qU7b1VBAvJCZxtUtsE/dASQ03fE+G4/WgdOxrP0EfmsMS9YmlbuOyyOtP1fDynMatfp1rVPQV5Y7VYqlAAAHzf0LzzRVLmoGzo0iP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021287; c=relaxed/simple;
	bh=j2WU0H54A7OYVi3lh9l/oBhzmxcOWkGCK+0LTKNRt7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiyLCrGJdkeLDHh0z6n1qcglyoT99tKw8x/DB0MWDwVDQJeJYml5b6fVeam94LKH4qSHaBhwNxDlUoZDuXqKFoyhC9MtZIS1NKvoDob73xLPs3Mqr+fM65ICoKh5dZqWOE/0fuM9ptk7AGF5kK6++yuPJsX8wUIgAOhjMhsME8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki+P6v+k; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so969508b3a.0;
        Fri, 23 May 2025 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748021285; x=1748626085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2WU0H54A7OYVi3lh9l/oBhzmxcOWkGCK+0LTKNRt7w=;
        b=ki+P6v+ko6L4HEGrO30Zs32/F2zZfxNIWDOHr4hsgXPZ7cxaQvUCOrpSm/PqDIFMZZ
         BbTGzvAZRFzEhcYDpkRzDfaD12i1zalSEf7UNrBDHWBrwTGVTCU3lInN5pMPkvcJetzJ
         tUmUyI7EVMsjFsWDFqqLRtKgz+dBtU7vfJ3Wds8l/bNsJquPETN2Mn3kfLcFp0VPhja1
         aanJroew46DR0O3dvhZGGOhj8Cvz73dJ5LqHhKyZY3LyLtmdgAhn28DsXf33+Gm5fUNf
         a5pg49TlQqvMGooeQ3er5ev+xn/DbDNUTKVlg8VCFRnkJOcjLcm2ER1u7jkJGK42qcRZ
         Vs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748021285; x=1748626085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2WU0H54A7OYVi3lh9l/oBhzmxcOWkGCK+0LTKNRt7w=;
        b=F4QwIl9Z0CYsX72Opjq4HmOO9MqguD3ZTW/QNWWDW8ecwnQkzurPufZJ57mEHsjWZD
         ussCz02yuWaaey28oJ1bjnCVA1U/U+eRUYmmPjw4NVeKutCXI+I3xgzV/JGyWiEV9F8Y
         pRkv/ofwpLop0KqnpbfTZ/Zfmmd9Y8o77+hvkE6R4V3Oe7RALyF7qXkWlFXStt2jmrZh
         dSTGL4UVQHf+repaDnLZSOFJaMhK5Iq8MCE7MFDNoTIldzh6EKwFpFxcpbuaa7PtFqbG
         pOb2QR0+4WRD/BMBD9iS7fjWnijl8KXNQCKdTiqqK9j3vROAnDvIos088trg9scZ8BuD
         LErg==
X-Forwarded-Encrypted: i=1; AJvYcCUi4liudXN07qAzm37ANpyjk5TxNdDzDD+LPDye09aM42Q1P0oPVgCHYrlc/MbQChRS7OaSqyOkKNbX7QkxxNf+@vger.kernel.org, AJvYcCV9D4x0XbShZrUgDIyCrZ9mQGkiIsAH2Yz01amoyhpu7bXP1O8s42nqUsnYahLJnIM/TCCEDx5gOBjDwHcD@vger.kernel.org, AJvYcCVNZ4u0yRxT6hsIFjwINGVv7pL+cKflrzuUV3Zku4u2iPLNNMI9Mfn8nBjJCNOq77aLGsZFq+J2jOrSxQ==@vger.kernel.org, AJvYcCX7EhgEDvv0auHRoriufWbZV+Lr5CcJgiIr+PZNnOiRIedgCtz7P3qmAEO2u9Xy0QtfZu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIY+GN+DG61EqGunsJd9M3JmCyZg2M8aum5yWjpnYTK7gupVW
	Itquwe93zqeMXZqyDB4qknvDLQO2hANA4fYkx3wBZeea7XW6N9XO/0aZnS/w3ZE4SnwqFrhTuYW
	ShSCcc1/TvrL5QzEoiitAVrqHL0smUW+0HhxsufQ=
X-Gm-Gg: ASbGncuTi8IKCsIXA123eRxguyb06fjjpd6O7kw0Ycx1lwwoGpQxO5isJkdNi1RgPpK
	v0/4lrfM0XEA4KB6/BB9SL9yAbo1gHHA54hxM9OIwiduviLszqLL66ril7+eH8NMIzU5qhJPf3C
	2kT63PCE+VC6f5HwwLDKIlVZdEE/cvEnzA8G6VAvAMmgnqEzI=
X-Google-Smtp-Source: AGHT+IFz1QZsmIjpTZUFz7Xrws4r2wUDVC2JHXdj4eF2fCDzKNlto2NXFJSHT+uSXx0tMibXSUkpgaHHSvvH2CqdlnQ=
X-Received: by 2002:a17:903:1666:b0:231:c9bb:60f8 with SMTP id
 d9443c01a7336-233f0669a7emr56775085ad.7.1748021284988; Fri, 23 May 2025
 10:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aC0OpCZCEziDXhwh@kodidev-ubuntu> <ace72324-6395-4e9b-8406-7d99d57018dd@oracle.com>
 <CAADnVQLAbQPWw_=F5WY_5-MY0GsSrnn5Ds_yE5BFC0=uuqnWug@mail.gmail.com>
In-Reply-To: <CAADnVQLAbQPWw_=F5WY_5-MY0GsSrnn5Ds_yE5BFC0=uuqnWug@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 May 2025 10:27:52 -0700
X-Gm-Features: AX0GCFvVaHH9czT2NTjtlaHd578qhQO7h04Ft5rL8joiwPj8PfXm7_Nil1_SobI
Message-ID: <CAEf4BzY+_+r9gyRCKhROPqEKtQ=f0CycRgv9c6b2zisV9XHO7Q@mail.gmail.com>
Subject: Re: vmlinux BTF as a module (was Re: [PATCH bpf-next v4 0/3] Allow
 mmap of /sys/kernel/btf/vmlinux)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Lorenz Bauer <lmb@isovalent.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 6:04=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 21, 2025 at 8:00=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > > Hi Alan,
> > >
> > > Thanks for taking a look at this. I've been following your related ef=
fort
> > > to allow /sys/kernel/btf/vmlinux as a module in support of small syst=
ems
> > > with kernel-size constraints, and wondered how this series might affe=
ct
> > > that work? Such support would be well-received in the embedded space =
when
> > > it happens, so am keen to understand.
> > >
> > > Thanks,
> > > Tony
> >
> > hi Tony
> >
> > I had something nearly working a few months back but there are a bunch
> > of complications that made it a bit trickier than I'd first anticipated=
.
> > One challenge for example is that we want /sys/kernel/btf to behave jus=
t
> > as it would if vmlinux BTF was not a module. My original hope was to
> > just have the vmlinux BTF module forceload early, but the request modul=
e
> > approach won't work since the vmlinux_btf.ko module would have to be
> > part of the initrd image. A question for you on this - I presume that's
> > what you want to avoid, right? So I'm assuming that we need to extract
> > the .BTF section out of the vmlinu[xz] binary and out of initrd into a
> > later-loading vmlinux_btf.ko module for small-footprint systems. Is tha=
t
> > correct?
> >
> > The reason I ask is having a later-loading vmlinux_btf.ko is a bit of a
> > pain since we need to walk the set of kernel modules and load their BTF=
,
> > relocate it and do kfunc registration. If we can simplify things via a
> > shared module dependency on vmlinux_btf.ko that would be great, but I'd
> > like to better understand the constraints from the small system
> > perspective first. Thanks!
>
> We cannot require other modules to depend on vmlinux_btf.ko.
> Some of them might load during the boot. So adding to the dependency
> will defeat the point of vmlinux_btf.ko.
> The only option I see is to let modules load and ignore their BTFs
> and vmlinux BTF is not present.
> Later vmlinux_btf.ko can be loaded and modules loaded after that
> time will succeed in loading their BTFs too.
> So some modules will have their BTF and some don't.
> I don't think it's an issue.
>
> If an admin loads a module with kfuncs and vmlixnu_btf.ko is not loaded y=
et
> the kfunc registration will fail, of course. It's an issue,
> but I don't think we need to fix it right now by messing with depmod.
>
> The bigger issue is how to split vmlinux_btf.ko itself.
> The kernel has a bunch of kfuncs and they need BTF ids for protos
> and for all types they reference, so vmlinux BTF cannot be empty.
> minimize_btf() can probably help.
> So before we proceed with vmlinux_btf.ko we need to see the data
> how big the mandatory part of vmlinux BTF will be vs
> the rest of BTF in vmlinux_btf.ko.

I think there is a way to avoid all these problems by switching kfunc
registration to a lazy validation model. I'll explain what I mean.

1) vmlinux_btf.ko isn't loaded by default, but kernel is aware that
there is vmlinux BTF available, if necessary.
2) when user-space tries to access /sys/kernel/btf/vmlinux, we
automatically try to load vmlinux_btf.ko; similarly, if kernel
internally needs vmlinux BTF information, we provided that
transparently through automatic loading of vmlinux_btf.ko
3a) if kernel module is loaded and it needs to register kfuncs, we
allow that, but instead of eagerly validating kfunc's associated BTF
information for correctness, we just record the fact that there is a
kfunc registered, with name ABC and associated BTF ID XYZ.
3b) when user tries to verify BPF program that needs to use kfunc ABC
from that module, that's the time when we load vmlinux_btf.ko and
validate kfunc's BTF information for correctness. If that information
is broken, report error, maybe log dmesg. If not, we are golden (and
that's the expected outcome) and we proceed with verification just
like today.

The key observation here is that with BTF there is no direct pointer
involved. It's all just stable integer IDs, so it doesn't really
matter whether we have instantiated BTF information at the kernel
module loading time or not. We can always (later) access this data
through BTF ID.

The biggest change is handling of kernel modules with broken kfuncs.
Right now we'll reject the load, because registration will fail. In
the new lazy model, this will be delayed until the very first use of
that kfunc. And if no one ever use that kfunc, it, technically,
doesn't matter. It's basically the same approach as with BPF CO-RE and
dead code elimination in verifier: if there is unknown/unsupported
code, but it's guaranteed to never execute, it's OK from the
verifier's POV.

I think that's an acceptable tradeoff, because really it's not an
expected typical situation to have such a broken module. On the other
hand, we don't need to complicate and extend BTF itself to accommodate
this, it all will works as is and will keep working in the future.

P.S. And of course all this can/should be cached, so we don't redo all
this validation, but that's just an optimization.

