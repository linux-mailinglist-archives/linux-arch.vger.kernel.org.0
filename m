Return-Path: <linux-arch+bounces-14895-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FB7C6D421
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 08:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E514EA0B9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CFB2E0927;
	Wed, 19 Nov 2025 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbj0IDnu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4975326959
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538662; cv=none; b=pfFuZUGkv569SQ0gJsacjli8kbxdClhiq1obzHt6jCAAcBPXhYYhwCQBb8yDi6ho2YM/j6CYcKg+mAm/TDymCTqmT5G/7iQ/1Jgl0l/MbX65FJGGrWIiP/uDI+1X7oXcIX7mFzTbt0J74/1+2mf1bgy/6obMWe130pHp13otwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538662; c=relaxed/simple;
	bh=AIYAqmAbGjH/cKlRsqKK2HzmYq4EY/exLMH80H6lBns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ma+ptxNrwPYsiTZQthT5/hke3n3x89XtYKLPnxfK0QKMCZJGs+MB51Jq2WZc4JgC+hlsSdnFgwhXE0K6VaICky3tJlqVRqaaaf6B5QFeZ5CT8KIODPkcLC3b6ly0mCA/PGSwolLWeEwlKvCo/kS7WCVY5VIQvAp+4cELXM5sspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbj0IDnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C24C2BCAF
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763538662;
	bh=AIYAqmAbGjH/cKlRsqKK2HzmYq4EY/exLMH80H6lBns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tbj0IDnu+d9XXicvXdQmuk23J7SX72g+ReYpH7OkaFHx9PDc/hcq6DJP2SpUckoPc
	 BL2ikZoetWirObyyec/p1EFOnXngEfZEejaElre+8HpFhbds2dCQAdMZTT3CGiF9Xy
	 BLFg9wZix2uGyfCBWutfLnxVLzDNAAzH/itopEBlZCcyKqWdEDZWt5oXvkw0k3EIEZ
	 2pCTgmex6QBAafGYjUL7e26bUpZ2c8OfAq4X9oULVQFFrIXX/KbrRvXEaRHPMzf9ws
	 fh2nHacfUhTyPNF2RS5SEueL5eKj4zwS2GJlSiNY/daXppyS1sNjzbKX5MDyWxBaJJ
	 t7Egj5Q+ULO9g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so9568327a12.2
        for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 23:51:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXUgIBkeqz9dHx0Uhamoa/j/wtFTZDs94HOdRsOUmGV9yhYoHGPn03O8dBSGV5uoWvCPiwqwxrap0k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kI05eNVDZOWm00A3SfYvOjF0dJszu+kSzASzQcCSNlYt53RN
	zhb+1VilVVMpR5FKeQd7yX7/pe7o4KwPBRwIB2YeFWWpTjXZuaDYPSy0ZjVuRkWXbUDatbv+Ss4
	YJhchTKC+faMhwRc/u6pQ9cVjCP4Dl0o=
X-Google-Smtp-Source: AGHT+IHj0NbLKrDvqfxZamDidI0HGtwjF8TD5aehZ5tbu/BDIYakSDitOdrnPb+8E/FflHMOEcBOqD37e/SNyGIfGvY=
X-Received: by 2002:a17:906:fd8a:b0:b73:8639:cd96 with SMTP id
 a640c23a62f3a-b738639d1b4mr1572590166b.24.1763538659984; Tue, 18 Nov 2025
 23:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-5-chenhuacai@loongson.cn> <aRyoLBjD_8Hz91DV@pie>
 <CAAhV-H5uoDjBRYpK_e7Z+vrcqLAbLXhEbEQP_aJ9f3aTdA+-eQ@mail.gmail.com> <04b04b74-ef13-4dd0-a35a-d629acb617cb@app.fastmail.com>
In-Reply-To: <04b04b74-ef13-4dd0-a35a-d629acb617cb@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 19 Nov 2025 15:51:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6aM+nsK39iTDw1Fec25C7+D2UTh92X6FPf3gDouuyejQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmHjlasw2gFPJKi8Gs0tpjJw05fzIHIMgusc4BZFnRD2eUXHNqhyRXAths
Message-ID: <CAAhV-H6aM+nsK39iTDw1Fec25C7+D2UTh92X6FPf3gDouuyejQ@mail.gmail.com>
Subject: Re: [PATCH V2 04/14] LoongArch: Adjust boot & setup for 32BIT/64BIT
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	Arnd Bergmann <arnd@arndb.de>, f@disroot.org, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:03=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> On Wed, 19 Nov 2025, at 12:28 PM, Huacai Chen wrote:
> [...]
> >> Per the schema for LoongArch CPUs (loongarch/cpus.yaml), "clocks"
> >> property is also described as mandantory, thus I don't think such
> >> fallback makes sense.
> > Yes, "clocks" is mandatory in theory, but sometimes is missing in
> > practice, at least in QEMU. On the other hand, if "clocks" really
> > always exist, then the error checking in fdt_cpu_clk_init() can also
> > be removed. So the fallback makes sense.
>
> IMHO this should be fixed on QEMU side, but I recall QEMU do have clock
> supplied in generic fdt?
It is difficult to fix, you can have a try. :)
If without fallback, cpuinfo shows 0MHz now.

>
> >
> > Why pick 200MHz? That is because we assume the constant timer is
> > 100MHz (which is true for all real machines), 200MHz is the minimal
> > multiple of 100MHz, it is more reasonable than 0MHz.
>
> Maybe better panic here :-)
No, this is not a fatal error, we don't need to treat everything as
fatal. As you know, many "BUG_ON" have been replaced with "WARN_ON" in
kernel.

Huacai

>
> Thanks
> --
> - Jiaxun
>

