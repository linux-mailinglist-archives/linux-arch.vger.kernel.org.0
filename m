Return-Path: <linux-arch+bounces-11191-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF23BA75A06
	for <lists+linux-arch@lfdr.de>; Sun, 30 Mar 2025 14:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240F2188D789
	for <lists+linux-arch@lfdr.de>; Sun, 30 Mar 2025 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7E1D54D1;
	Sun, 30 Mar 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Ezlj5uz3"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92F1C5F39;
	Sun, 30 Mar 2025 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743337096; cv=none; b=qZ/o7wBSN2FazBNCzBJsMhmHLMa4WBtICoA5z2S1qfhJzLuMqRwKX6/ceXW5h8J1SqPP25qD0CUJRSsRD7S6pBphD+X/J50WZZaAqJ06OjlfhDQkRY56rWvRG8/F/LtC9AMaNjzDANhoo8NQojUnhm9dBXnkuTRnIwEtV0LQaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743337096; c=relaxed/simple;
	bh=UqhtKa70a5/2askHmDGMX26oUmyn54ientlmKEHX2lk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvbthteYtXI7tIUb8HFi0UYsbzrCLDlhbZIodIuZ7mpYMYgzWE8+WTcqRT4kAF2FkJ0R5Ej9XUeqUoekPmtqvecB3KJe9MRoZJZ3CYYtWjiq2lWksfmgW+hvVr+ajmszyf6KrQoLxI9eY9n2ruUhcDdLKSEDLJuyWBfwq6Ti0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Ezlj5uz3; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1743337086;
	bh=UqhtKa70a5/2askHmDGMX26oUmyn54ientlmKEHX2lk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ezlj5uz3KLCvLbixTDOfWM9JMvtSf6orMo8URoeZQs3kdZh4iirzBLX+p/eyrYfja
	 ++VOhAphiak2/zxRHBW/Gc97Xy9SPbqtRUV5C+DRojnIIrH5Sud+ZSTAwxS69XVtcK
	 RIAIedtBk6vzb9t1cyvyE3n3m0L/1kXqBjVx2+yw=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 428AE659C8;
	Sun, 30 Mar 2025 08:18:04 -0400 (EDT)
Message-ID: <42dc2fc95fc9d56abd68ec620b29602eef9aa742.camel@xry111.site>
Subject: Re: Ping: [PATCH 0/3] Drop explicit --hash-style= setting for new
From: Xi Ruoyao <xry111@xry111.site>
To: Guo Ren <guoren@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Fangrui Song <i@maskray.me>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, 	linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, 	linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sun, 30 Mar 2025 20:18:02 +0800
In-Reply-To: <CAJF2gTRXyMX+9C_aEDbxAsxWDD2rbnDWO775YDZ3EmrQ=QinfQ@mail.gmail.com>
References: <20250224112042.60282-1-xry111@xry111.site>
	 <91797ac4bbe27d7d60b89053050e429bcd630db3.camel@xry111.site>
	 <CAJF2gTRXyMX+9C_aEDbxAsxWDD2rbnDWO775YDZ3EmrQ=QinfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 10:13 +0800, Guo Ren wrote:
> On Wed, Mar 5, 2025 at 9:27=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
> >=20
> > Ping.
> >=20
> > On Mon, 2025-02-24 at 19:20 +0800, Xi Ruoyao wrote:
> > > For riscv, csky, and LoongArch, GNU hash had already become the de-
> > > facto
> > > standard when they borned, so there's no Glibc/Musl releases for them
> > > without GNU hash support, and the traditional SysV hash is just
> > > wasting
> > > space for them.
> > >=20
> > > Remove those settings and follow the distro toolchain default, which
> > > is
> > > likely --hash-style=3Dgnu.=C2=A0 In the past it could break vDSO self=
 tests,
> > > but now the issue has been addressed by commit
> > > e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH").
> > >=20
> > > Xi Ruoyao (3):
> > > =C2=A0 riscv: vDSO: Remove --hash-style=3Dboth
> The patch's comment is incorrect; when I removed --hash-style=3Dboth,
> the output still contained the HASH, and no space was saved.

The idea is following the distro toolchain default (which can be
configured building binutils).

If the distro toolchain default is gnu, we'll use gnu.

If the distro toolchain default is both, the distro is already wasting
space everywhere for (a) some bizarre applications depending on DT_HASH
for some bizzare reason; or (b) an oversight.

In the case of (a) the bizarre application may needs DT_HASH in vDSO as
well, and in the case of (b) it should be fixed for the entire distro,
not only vDSO, for example what we are doing for AOSC:
https://github.com/AOSC-Dev/aosc-os-abbs/pull/9531

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

