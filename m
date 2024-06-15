Return-Path: <linux-arch+bounces-4911-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3AB90973F
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C90284B7A
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0924B34;
	Sat, 15 Jun 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeRqYHqd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F10208D1;
	Sat, 15 Jun 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718443764; cv=none; b=rceUifBqq+4QKLKwU1xIvl6nkWCNFJ2zpcpQct88iydO+2wgorPByCBEO/cqKfXMQ1JXr/0UBqt51RGQnXxTv2Ocb1stZEKwfVqao6KRRnNjcU/9HU7A+RtuCgWR5MwWaXm5y8UsY78CdB6Ry9ORozHuDcTWG8wmrN5/EZoGKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718443764; c=relaxed/simple;
	bh=dODNvqGMI75Evnd4E0dnnJCUYrocpv9kYFTDYSbSQuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy593LslwoLNe2tIaprs+4d75eqP3f8C36N8rR16kJ0RsFdAnF668Tt0EXGWNm7drExAOlQhByReMi0+xbt65u3bENXss2syBhFgmS77gK4jmDiBwAJdV9qPA6t8IujXUUijKmDKS1k5ai8ZbEITq87osUd7+XK9QmX49Jd7nq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeRqYHqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBD1C4AF48;
	Sat, 15 Jun 2024 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718443763;
	bh=dODNvqGMI75Evnd4E0dnnJCUYrocpv9kYFTDYSbSQuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aeRqYHqdKMOYYr5uE9gUJ0y7LavT08QSTNDTJpU6iX6fQQqnU23igzVCrIO3uILfX
	 zSAtsbbMrTlXrnUcizk8XECs2HB6zNkNW07RXgsDch06RVUdeyQ292MJ5O8nA9eofd
	 gBlMFVavRHTYlKGVcKbi6d5wkwyODhrjXvQCV7KoPw2hrZFNjatrXWb59qAVoXxvHv
	 +Me5evZZ9XF4ZVMPu9VvWOTv2v5vrIupvfAjdzCvl/J3BxN7oagISdled2N+MQoihZ
	 F/LKeTxDkHKvy7n3Z7yvf2bFaB6LXOnema1Rj3n4plIFxhGZIx0awl03KaaSfSF+Kj
	 GvghNaclX4RyQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso4604690a12.3;
        Sat, 15 Jun 2024 02:29:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJYUxtTdXp8jnY6OXcaTuxp2SZfHWDaB6rQXF5J8zLbGA8uB7BW5i9EB7PccdA5GzKDzuURQz37ZmI3l+8quCs4ey3xEBrSqHoCam4OKD7iSjr+gHMHxocjGwnqb2yDaBbNGRJMDu+Sqde+5M/O5MHjYehse6KHkuHKm5efpObyw==
X-Gm-Message-State: AOJu0YwqdmjFW0hlC+A6xC6BdUYBphXZnYW/Do/gkLmsUxpMPFGVYIvi
	rfMapG/7WwNpzHBDNe0u/i7Ve2zlJS+H6/W2kmHHOPreGTNKM/aReejRACOYj9Bs2pLYnw0FBN4
	UOQl8Y6nyvKDuaOGSpfyAHEeqrbU=
X-Google-Smtp-Source: AGHT+IHb3G+qRGiTMYlQImkmM4nIpoBEshVh7kypolNAztY7wSkdQFcVgkGCm+LuUW1yirD4I1SEJrEX2B5QuHcIQY0=
X-Received: by 2002:a17:906:6a02:b0:a69:67e3:57f6 with SMTP id
 a640c23a62f3a-a6f60cefd5cmr441644266b.5.1718443762325; Sat, 15 Jun 2024
 02:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com> <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com> <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com> <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
 <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
In-Reply-To: <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 15 Jun 2024 17:29:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
Message-ID: <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
To: Xi Ruoyao <xry111@xry111.site>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 4:55=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Sat, 2024-06-15 at 16:52 +0800, Huacai Chen wrote:
> > Hi, Arnd,
> >
> > On Sun, May 12, 2024 at 3:53=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> > >
> > > On Sun, May 12, 2024, at 05:11, Huacai Chen wrote:
> > > > On Sat, May 11, 2024 at 11:39=E2=80=AFPM Arnd Bergmann <arnd@arndb.=
de> wrote:
> > > > > On Sat, May 11, 2024, at 16:28, Huacai Chen wrote:
> > > > > > On Sat, May 11, 2024 at 8:17=E2=80=AFPM Arnd Bergmann <arnd@arn=
db.de> wrote:
> > > > > CONFIG_COMPAT_32BIT_TIME is equally affected here. On riscv32
> > > > > this is the only allowed configuration, while on others (arm32
> > > > > or x86-32 userland) you can turn off COMPAT_32BIT_TIME on
> > > > > both 32-bit kernel and on 64-bit kernels with compat mode.
> > > > I don't know too much detail, but I think riscv32 can do something
> > > > similar to arm32 and x86-32, or we can wait for Xuerui to improve
> > > > seccomp. But there is no much time for loongarch because the Debian
> > > > loong64 port is coming soon.
> > >
> > > What I meant is that the other architectures only work by
> > > accident if COMPAT_32BIT_TIME is enabled and statx() gets
> > > blocked, but then they truncate the timestamps to the tim32
> > > range, which is not acceptable behavior. Actually mips64 is
> > > in the same situation because it also only supports 32-bit
> > > timestamps in newstatat(), despite being a 64-bit
> > > architecture with a 64-bit time_t in all other syscalls.
> > We can only wait for the seccomp side to be fixed now? Or we can get
> > this patch upstream for LoongArch64 at the moment, and wait for
> > seccomp to fix RISCV32 (and LoongArch32) in future?
>
> I'm wondering why not just introduce a new syscall or extend statx with
> a new flag, as we've discussed many times.  They have their own
> disadvantages but better than this, IMO.
We should move things forward, in any way. :)

Huacai

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

