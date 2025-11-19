Return-Path: <linux-arch+bounces-14917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3666C6F66E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0401A2EFE3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43DB357733;
	Wed, 19 Nov 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShIH5B0I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40F34E749
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563425; cv=none; b=slV8kxDBLVMUdBrzMd9oKdpQTT9hKi0usthH+Cb2jeLFLWI/i3apPMN9MbNUh7ngqPoCY3unquSG1hM7arOrwqUDXm+uMODd48jnYYNdN6SzpFRyQ+JBu08vZhrciHfbHP5v6uI9LyzQFdST/77ECbwDSAaL2xm+6Rij4Swl/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563425; c=relaxed/simple;
	bh=2z064nicPkbhvbFdk3DNaYzeBT79ucpWGtEQFNcD5MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnFmve6i296p4Q3MuLAK8sf+JarLl6gg///8EP4ycQEfnviyUWAT9iZ/qmnps6t92pJ3B+TtMoPHUMB5fMlehX6OQulXFpVVtKwKG+0pwgVjB7UD5JKvjXf7fjF3CtaipJ+TQdWbXCTLleSIz0EKpfJv+PxAbquFYY3MxZQc0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShIH5B0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B4EC4DDE2
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763563422;
	bh=2z064nicPkbhvbFdk3DNaYzeBT79ucpWGtEQFNcD5MA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ShIH5B0I/V6gvkPYJR8zeouz1EjZ1K3VtPCmJjR7YxpFXSCMfIR5Z9AL/MJBwmfw5
	 rDduV1PjE6joLWKSK7OfxK0U3qdVtqP1Xm1ly9Yu0Bnc9eWOnBcnmUB1PupE3bsYm1
	 2/bBFD90wDPGzyAwIU6f2SeefM9WC1yJK4En0P+Xahv2l0Vk3mkGnkDMSU7Hzo18qq
	 NI2ZdoYeXCG+7zalRznvP9+4WMYz77+uosKOhuYCAXp4SOnyNszsprP3jLEWvmmjEb
	 UHtMf6o8w4exZoNaMqfQ6wAF9Ci+WXeKTulBv+ptdW9arGcUKsrJf9i5xgcaTq7ugy
	 ENGfiO8GXNv0Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b713c7096f9so899200266b.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 06:43:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPCgMJyl9P4s17GWQ/WTNzL4W1SSPXXoXfggf1YLHU5BtoWJUVkoUrquf3J0wHqeEOTdvTmrDa/vS1@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5qfxd2Q8FLxnp06/F5e3F4a57EhBAP6uqfTz5U8sViw5z2As
	Yc3juz6OP/ubj1QetB4H0y0rVQMWOEaKyfEnJt7hecnRVyO3vegNHhJXq5MBBDo5xL5w9UCz6/L
	fQkkARlv6rLe2ewrpBCItc+I7QxZe9T4=
X-Google-Smtp-Source: AGHT+IGRRbE/yMt+CJhBJTjAeoFPwPJ7dbuG54h0FPb6G8ICb8kkGh3gMrGA7KjvSvQ3F+5qslNF7zZ9Tnjwa4bLlUM=
X-Received: by 2002:a17:907:3c82:b0:b73:16fc:d469 with SMTP id
 a640c23a62f3a-b736793dcdcmr2085515866b.51.1763563415202; Wed, 19 Nov 2025
 06:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-5-chenhuacai@loongson.cn> <aRyoLBjD_8Hz91DV@pie>
 <CAAhV-H5uoDjBRYpK_e7Z+vrcqLAbLXhEbEQP_aJ9f3aTdA+-eQ@mail.gmail.com>
 <04b04b74-ef13-4dd0-a35a-d629acb617cb@app.fastmail.com> <CAAhV-H6aM+nsK39iTDw1Fec25C7+D2UTh92X6FPf3gDouuyejQ@mail.gmail.com>
 <aR3UGUlqGFvo5aX5@pie>
In-Reply-To: <aR3UGUlqGFvo5aX5@pie>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 19 Nov 2025 22:43:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7OFnEjen0B6JbBvjrcgNDnOsXqKV1wp7KaRxKjkRYfrg@mail.gmail.com>
X-Gm-Features: AWmQ_bkYanL2Vm4yxrUlXAat1BQPYrTDWEB8jFTLIria9RLYEuQHx6SD870O10I
Message-ID: <CAAhV-H7OFnEjen0B6JbBvjrcgNDnOsXqKV1wp7KaRxKjkRYfrg@mail.gmail.com>
Subject: Re: [PATCH V2 04/14] LoongArch: Adjust boot & setup for 32BIT/64BIT
To: Yao Zi <ziyao@disroot.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Arnd Bergmann <arnd@arndb.de>, f@disroot.org, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:29=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> On Wed, Nov 19, 2025 at 03:51:01PM +0800, Huacai Chen wrote:
> > On Wed, Nov 19, 2025 at 2:03=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoa=
t.com> wrote:
> > >
> > >
> > >
> > > On Wed, 19 Nov 2025, at 12:28 PM, Huacai Chen wrote:
> > > [...]
> > > >> Per the schema for LoongArch CPUs (loongarch/cpus.yaml), "clocks"
> > > >> property is also described as mandantory, thus I don't think such
> > > >> fallback makes sense.
> > > > Yes, "clocks" is mandatory in theory, but sometimes is missing in
> > > > practice, at least in QEMU. On the other hand, if "clocks" really
> > > > always exist, then the error checking in fdt_cpu_clk_init() can als=
o
> > > > be removed. So the fallback makes sense.
> > >
> > > IMHO this should be fixed on QEMU side, but I recall QEMU do have clo=
ck
> > > supplied in generic fdt?
> > It is difficult to fix, you can have a try. :)
> > If without fallback, cpuinfo shows 0MHz now.
>
> A fake "200MHz" output sounds much worse than obviously wrong "0MHz":
> the latter informs the user something bad happened here, while a
> mysterious "200MHz" output only makes it more confusing since no one has
> specified so in the failing case.
All CPU freq in QEMU TCG is fake, even if it is provided by DTS. But
if someone fixes QEMU, I'm happy to remove this part.

>
> > >
> > > >
> > > > Why pick 200MHz? That is because we assume the constant timer is
> > > > 100MHz (which is true for all real machines), 200MHz is the minimal
> > > > multiple of 100MHz, it is more reasonable than 0MHz.
> > >
> > > Maybe better panic here :-)
> > No, this is not a fatal error, we don't need to treat everything as
> > fatal. As you know, many "BUG_ON" have been replaced with "WARN_ON" in
> > kernel.
>
> But it is an error and shouldn't be ignored. I agree that panic is too
> serious for this, but at least a warning should be issued.
Yes, it is better to add a warning.


Huacai
>
> > Huacai
>
> Regards,
> Yao Zi
>
>
> > >
> > > Thanks
> > > --
> > > - Jiaxun
> > >
>

