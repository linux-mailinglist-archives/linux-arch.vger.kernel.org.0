Return-Path: <linux-arch+bounces-4334-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D48C34EB
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 05:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3166B1C20A37
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96560BE6C;
	Sun, 12 May 2024 03:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIdQ5QKN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341FBA55;
	Sun, 12 May 2024 03:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715483484; cv=none; b=YrkgWRQrNfydJotYjHEN2oD963qWfiAXoQzfAlmIh8VpYvl5kV1tG084eNbX0aFTNZTCu3+1jV8YCLcw87A/cHL5d1/SZ7fHU1StGSKV/NVtkztJzZkdviRoZN2Vn96KwaSe9tPkv7IUceQArFBQiIl7zlqsvo/BrDc6CnHuLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715483484; c=relaxed/simple;
	bh=GnE0N9IiKS/rZSXWZH1oKPV8RtXcCBleeY98LXa792w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe3m4S0BbENCgJb7OtKaVI6yr5s5P/FvpicT+HiWxx37EKzBS+PWYttLr0tqID4JbGSj8xgvrhu8Lf7kK+U6t0Yp0U3I8KPshdhJDRDXeUkHQMOPe43qnToL39Qv0989tfJih8UoCCqXqadrdfKJldTbEbhZ6yVp6qXbz8f4L7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIdQ5QKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51D3C4AF08;
	Sun, 12 May 2024 03:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715483483;
	bh=GnE0N9IiKS/rZSXWZH1oKPV8RtXcCBleeY98LXa792w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NIdQ5QKNZjoJkMPF2uCcTDfU83i8uPf2IpuUWEPg1hYUDatxUO8bgXZtr+tNUZBjO
	 K9BA1B+vRlGc01dHqDf+rGObGO/rtSMn16grHr+DfQQLu95SEqY7PEENsXG5zB/w69
	 I8QbuQjTr8iQD/R3ngocD+ABehzgyYQjqAtBftcIUaYz/H+ANEt2j+UEykmKmBQfad
	 q36dBnn9oNtA23mPXHNndrLzypfbjfaTyx7L0GCfd2i2JfJp+7CO7s7GKofmSyRoPi
	 uPNNvDNvmguzPw3G3IpGiT2bUdHSghjjq08pErpZIdvz4x8E3y2SnLZu5wU29cohao
	 OyyVRlEOLqiFQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso4226194e87.3;
        Sat, 11 May 2024 20:11:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXRLDeni0Nu9/DCVHhRP+clz6Hqhf73WoSSxZDdu+ksEwVzT6XKJ3IE86v7H73TPE0WnVWo+3lDAn6JTFHc62cyr20ltMnCDV7x8Ysy3BAaETZCmeML7bloI15zCHFUSQaTfvI3UlfS5rSlPGw+6IskZFAW7rHrFDcqQUN1ptTow==
X-Gm-Message-State: AOJu0YzGtuLjr06kpPJs80DmBY2YLWkCm/nAlLnW0MhklwtGHQhbGjfr
	dgTzJdU5HbRK3fS2F4YnB/rxS7MmBOEaPMhWgwdua2CI1UfvnHgcSVgq2tyyqse9SN+KkWnM8pw
	MbocXhCEcbI+HOlKuE5KiPbm3yCQ=
X-Google-Smtp-Source: AGHT+IF1HfRmR2om2m2YXEbvA0UfRg45ZcRiPADa6rYbMlyON2dmk3egmaCwmRglGobipizyfXagI057ltyyezW2eQ0=
X-Received: by 2002:a19:381e:0:b0:51c:c1a3:a4f9 with SMTP id
 2adb3069b0e04-5220ff72f76mr3513970e87.64.1715483482254; Sat, 11 May 2024
 20:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com> <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
In-Reply-To: <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 12 May 2024 11:11:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
Message-ID: <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 11:39=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Sat, May 11, 2024, at 16:28, Huacai Chen wrote:
> > On Sat, May 11, 2024 at 8:17=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>
> >> Importantly, we can't just add fstatat64() on riscv32 because
> >> there is no time64 version for it other than statx(), and I don't
> >> want the architectures to diverge more than necessary.
> >> I would not mind adding a variant of statx() that works for
> >> both riscv32 and loongarch64 though, if it gets added to all
> >> architectures.
> >
> > As far as I know, Ren Guo is trying to implement riscv64 kernel +
> > riscv32 userspace, so I think riscv32 kernel won't be widely used?
>
> I was talking about the ABI, so it doesn't actually matter
> what the kernel is: any userspace ABI without
> CONFIG_COMPAT_32BIT_TIME is equally affected here. On riscv32
> this is the only allowed configuration, while on others (arm32
> or x86-32 userland) you can turn off COMPAT_32BIT_TIME on
> both 32-bit kernel and on 64-bit kernels with compat mode.
I don't know too much detail, but I think riscv32 can do something
similar to arm32 and x86-32, or we can wait for Xuerui to improve
seccomp. But there is no much time for loongarch because the Debian
loong64 port is coming soon.

Huacai

>
>      Arnd
>

