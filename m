Return-Path: <linux-arch+bounces-10273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165FDA3F1E6
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 11:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34A33BAFDC
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EFD20469D;
	Fri, 21 Feb 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="WtMABoZr"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D542202F7B;
	Fri, 21 Feb 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133396; cv=none; b=gWWpvUYQKfDW+Klrj0c4xZYN+kY5UgE5zGm5l3m3oYob3/oCD8pV8QAyF4UAGMuYxuILavi5KRul/LwUrFqRaJ9Q43JogTqvLB8UBj3vPFlQjQ3nBQtsf41eCWNONwdiyxsAu9QRDxDlO5iObP1L2xqt5JpFY+UqM2UbEGGUPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133396; c=relaxed/simple;
	bh=FAyrGqPrf8Jf0k72WyiBqChIuho3jLqkjBUtjpkLbso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=re1XtO9n3qU0LoMFKDQlKxXNE3b/caGmOcKNtMyeLax9SZ4oxTF/FsNM4nspOAyKG+EpPdS/2jeoDZlGUtUBYzKYkdcglFYC4KcIfNqIgkluz5ThSgoYI7VUpUOpas1u/trAiQNxzoDmyQsaAuG69FTpfSmVdVP2zurOFUtDPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=WtMABoZr; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1740133390;
	bh=UNb8a2gN3+1bqIY2UlUBT79h0w78rJrfN5H29nStXmA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WtMABoZrJ/YKP84/osWAcdY5B60fkN/JuxWW8xzNbjVy2h4F0XQ0zhJSSJ9Ku7A+K
	 6uan4Fj0VBrfWJYj4K/a9k5ayZKfjgHB9cE8hXP+mwZsup3bGuoNAtm2jOZ5/Rsb8y
	 6N+i35/XTLe1qKDunHFEB7/NIqsLRmY8V1h1WsYE=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 651B91A3F60;
	Fri, 21 Feb 2025 05:23:08 -0500 (EST)
Message-ID: <f0c15994e7a79f6cd0c82930c0dfebb50458c941.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: vDSO: Remove --hash-style=sysv
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, Guo Ren <guoren@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Fangrui Song <i@maskray.me>
Cc: WANG Xuerui <kernel@xen0n.name>, Masahiro Yamada <masahiroy@kernel.org>,
  Tiezhu Yang <yangtiezhu@loongson.cn>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-arch@vger.kernel.org
Date: Fri, 21 Feb 2025 18:23:07 +0800
In-Reply-To: <CAAhV-H5_bKtO2mAFmfcZvD0pn9RhTA+UPjv7K574uPKxZbxX=g@mail.gmail.com>
References: <20250221092523.85632-1-xry111@xry111.site>
	 <CAAhV-H5_bKtO2mAFmfcZvD0pn9RhTA+UPjv7K574uPKxZbxX=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-21 at 17:47 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> On Fri, Feb 21, 2025 at 5:25=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
> > far before the first LoongArch CPU was taped.=C2=A0 Using
> > --hash-style=3Dsysv might imply unaddressed issues and confuse readers.
> >=20
> > In the past we really had an unaddressed issue: the vdso selftests did
> > not know how to process .gnu.hash.=C2=A0 But it has been addressed by c=
ommit
> > e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH") now.
> >=20
> > Just drop the option and rely on the linker default, which is likely
> > "both" (AOSC) or "gnu" (Arch, Debian, Gentoo, LFS) on all LoongArch
> > distros.
> What about changing to "--hash-style=3Dboth" as most architectures do?

IMO we are more close to ARM64 for the aspect that there are no libc
(glibc or musl) releases lacking GNU hash support, so I prefer the ARM64
way.

Maybe this should be changed for some of other architectures (RISC-V and
C-SKY?) as well because I guess the only reason they used "both" was
"hey, without this the self tests don't work on Debian" but this is
resolved now.  Adding a few recipients and Cc for discussion.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

