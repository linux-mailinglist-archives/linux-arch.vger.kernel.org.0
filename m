Return-Path: <linux-arch+bounces-12085-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD16AC1984
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 03:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04511BC2EC2
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 01:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622CC204F8C;
	Fri, 23 May 2025 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONsmh6Bz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67220205AA1;
	Fri, 23 May 2025 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962275; cv=none; b=EQjkcdRVsn9SkFuMzMdpt2xA2+lEFHjzX4wLQTUpwL4vE+JYz2eypepko/TF23+KBvqS/TQ5CgJs07tBQcewci9eLyReTpwcqu4/PBtkyyI7WCX/w8RpIPgCejatICZr6zspAD9BLGA7hKtlhHeZUnTf39YnTrE2CncBSM7oegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962275; c=relaxed/simple;
	bh=978K8U1n9tIBFYOPzCxCuaqcjasHuJR7XqbgXac3qyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqdaVqarNc2zMpOmWAarOtwfv5YEmfPbzUl1n8uTihwII3M5gRS2tHjcr8BrjYft2rfOiNO1QovEs9elp0DEInI33hw1+MNdtP/stof6yBj7qni97MRgq8HjOFAV9MPOEJFfNW5Jh7H8VI9L5tSaYZUuFKvWeFP/qKALiukdtU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONsmh6Bz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4bdee0bf7so982417f8f.1;
        Thu, 22 May 2025 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747962271; x=1748567071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=978K8U1n9tIBFYOPzCxCuaqcjasHuJR7XqbgXac3qyQ=;
        b=ONsmh6BzGY+W4qQYMPS9QxD9Iam+ldGVPEPpCv0epZ/vKkZJbr7zyKDUS82uv1NH5D
         jz64XZ1/R6AnoFnQU+zeWthtr2cfMxYuLU9V1BuWFMxEAB6OqND0dF9MB9YRwQeXvceF
         aeS4Zc9aWve/k916KCnZXAccNWqom/YZSuJAmYEGa0VFAq7ND70C+sqpc3J0d8Aq3BY5
         3FbmiIDmxYGNVX2qWxST5ylqd9ZC3Gk828p9rKogmuKB3ZNtGGL0uqCVtrDRtnNesHN4
         lUWGagtD559PX6pEkXSrvx0+CopiwR7zFrf5SkzhbjcwG9xBBDkbTEEG3jIi4zE0aBAk
         9Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962271; x=1748567071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=978K8U1n9tIBFYOPzCxCuaqcjasHuJR7XqbgXac3qyQ=;
        b=CFt11bWpwg35J7MVF8dFH8KS6DDA5ePH6s3yIeoyKwkc0SH/ajo/KECuF/IgpVkHxr
         TOW+pVEvbcLfEop+gF1PaatUf7qSZ+pAEnDWh7U+q7+lXNHzhM+aVDbsRw0TsJdOSpU0
         2+s1OI9hKLjJUKBInLv4IGNAhHuGcUD/C7BX+F77XAemqYivn0nFqoE5cJ4EHqeKKT1W
         9y7jlnsj0Z0Cnpl7QDbPNo12S810eVAhAOn2ex6oXSVUOVGz/L5hejvKlpRzLncoydOe
         flWhKduk8GHALG89RfoE3xHgBnHzSplwjEzlKLhkUsKtszlCPp6/5kQ2ichE0qfsCVj1
         aIjw==
X-Forwarded-Encrypted: i=1; AJvYcCUMTVra36kPOVDrTsqiswZq1r0QgP1PmDy/+sMNgQXVowo3KV2SBOkFwWAyT67JFvOJaek=@vger.kernel.org, AJvYcCVXxOVeqfwuFPYmP5iM+rAkC+3DLi9u/uo3tDZgqoclRXeyrmD3Dp9kAqrkRdh2aQfVYax+E6BFjxB/PoGP@vger.kernel.org, AJvYcCW2qJdogwBtH2Dp3lhjUstGHRaT2VG0kYuhinMffg88ogrSxSpMEW+x9WD5G8mwwqFz00QzQoogd4QoFH9ubNL5@vger.kernel.org, AJvYcCX8RJ7rHMyYa+ndr/4tEl3uv/k5+Z+gJeI76+3wgb2JLBd9n7hlLUQPRAICk9YJLlMUVbfSDlKtkjtx9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Xt7ys2IK8BOM9FqXyx5Ha1IUs+nLbehQGOi+zaTxE3UFitm6
	Vo1X/JwcnEhp9XFeNLpO75LxltQqjP/H0yS7tytXGg0gT70mC0JGxGPz6mIsBCcpyltVVF2TGZr
	ReGTZYAbUlKHDFnt717IThYo11WzUwF8=
X-Gm-Gg: ASbGncsM+ugu7eYfDxJc8vNIbINuC8xFAI4Rw8tfKLeapoXjD6xBVMgXCFQFilbfd6d
	2iAzZtkdEg/2tdcxX925Y3PloQzn14L5tCTnkOstFsMnjRcKUocCWBB7hKHmRYjK5iAXf05EHam
	fOZbsdCFkhdkAoH78LJfJLu1CfA3AZSqngC97uAdMqLfwKJhBOUd+rleFLfm0Kmg==
X-Google-Smtp-Source: AGHT+IFZk27hkNu0+18YoPz58Q5KAjuzSO0azY0OgPHi/bundufXfcPAPiJ3pLgxn4Sp9tgcWmwMyWwmU06DAC8uLUg=
X-Received: by 2002:a05:6000:2304:b0:3a0:b521:9525 with SMTP id
 ffacd0b85a97d-3a35fe65fb8mr22038630f8f.1.1747962270432; Thu, 22 May 2025
 18:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aC0OpCZCEziDXhwh@kodidev-ubuntu> <ace72324-6395-4e9b-8406-7d99d57018dd@oracle.com>
In-Reply-To: <ace72324-6395-4e9b-8406-7d99d57018dd@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 May 2025 18:04:19 -0700
X-Gm-Features: AX0GCFvp9TUqv6GBHpeVPtAcmdIclMupfBQ3UD7BhiT3zZfKXxtnW83n5TtUF6Q
Message-ID: <CAADnVQLAbQPWw_=F5WY_5-MY0GsSrnn5Ds_yE5BFC0=uuqnWug@mail.gmail.com>
Subject: Re: vmlinux BTF as a module (was Re: [PATCH bpf-next v4 0/3] Allow
 mmap of /sys/kernel/btf/vmlinux)
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Lorenz Bauer <lmb@isovalent.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 8:00=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> > Hi Alan,
> >
> > Thanks for taking a look at this. I've been following your related effo=
rt
> > to allow /sys/kernel/btf/vmlinux as a module in support of small system=
s
> > with kernel-size constraints, and wondered how this series might affect
> > that work? Such support would be well-received in the embedded space wh=
en
> > it happens, so am keen to understand.
> >
> > Thanks,
> > Tony
>
> hi Tony
>
> I had something nearly working a few months back but there are a bunch
> of complications that made it a bit trickier than I'd first anticipated.
> One challenge for example is that we want /sys/kernel/btf to behave just
> as it would if vmlinux BTF was not a module. My original hope was to
> just have the vmlinux BTF module forceload early, but the request module
> approach won't work since the vmlinux_btf.ko module would have to be
> part of the initrd image. A question for you on this - I presume that's
> what you want to avoid, right? So I'm assuming that we need to extract
> the .BTF section out of the vmlinu[xz] binary and out of initrd into a
> later-loading vmlinux_btf.ko module for small-footprint systems. Is that
> correct?
>
> The reason I ask is having a later-loading vmlinux_btf.ko is a bit of a
> pain since we need to walk the set of kernel modules and load their BTF,
> relocate it and do kfunc registration. If we can simplify things via a
> shared module dependency on vmlinux_btf.ko that would be great, but I'd
> like to better understand the constraints from the small system
> perspective first. Thanks!

We cannot require other modules to depend on vmlinux_btf.ko.
Some of them might load during the boot. So adding to the dependency
will defeat the point of vmlinux_btf.ko.
The only option I see is to let modules load and ignore their BTFs
and vmlinux BTF is not present.
Later vmlinux_btf.ko can be loaded and modules loaded after that
time will succeed in loading their BTFs too.
So some modules will have their BTF and some don't.
I don't think it's an issue.

If an admin loads a module with kfuncs and vmlixnu_btf.ko is not loaded yet
the kfunc registration will fail, of course. It's an issue,
but I don't think we need to fix it right now by messing with depmod.

The bigger issue is how to split vmlinux_btf.ko itself.
The kernel has a bunch of kfuncs and they need BTF ids for protos
and for all types they reference, so vmlinux BTF cannot be empty.
minimize_btf() can probably help.
So before we proceed with vmlinux_btf.ko we need to see the data
how big the mandatory part of vmlinux BTF will be vs
the rest of BTF in vmlinux_btf.ko.

