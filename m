Return-Path: <linux-arch+bounces-10527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7DFA5008A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Mar 2025 14:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C6E3A369A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Mar 2025 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D572459F4;
	Wed,  5 Mar 2025 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="gzOp9btd"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C61E531;
	Wed,  5 Mar 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181239; cv=none; b=NuvYumnpRFmhC48h5/3x6mvy08CF+PODkdyNbji7uFHtcZcq/E+psGzklO/e0wJOj/WNKeH95d7bt1I0utlGQN7zkpwK51UEq2Q1OjTxb7U4e9iaRkHAdV2qgxQ+76AVgawnVYPcvqRtCRK93t15OpHIDeLeMtrQs5M6D/ITF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181239; c=relaxed/simple;
	bh=cB1DxsX8g+WgYZpFQF3xzyK6n2FY/ODCE60uSgp0XO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/73sMzyNpIylG5lzux9jJW+oJBfCf/Q9AjWK1Bcf5poaBdboI0AGOTnBa7M+kzHmpuEowzjhLm/U/HeQcDejKcGiIsx/WHovAseB2KzZZu1Y7hA7J6SjrlsRREUaNLTyfUHRDDQZJZdReuai58p7XfGqdwZ1G56zoFQV1s6UWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=gzOp9btd; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1741181228;
	bh=cB1DxsX8g+WgYZpFQF3xzyK6n2FY/ODCE60uSgp0XO8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gzOp9btd675nz7oHVq1TNOboLUEF3CpNFjY2HnMRh/CFxbVp+UUV1zpMNIeuVrIJV
	 2NQtinq7RTEwKbYykS7zcKl/+SqOfSoGa1qUkNLZpDQiBmmthTgOL8sFunEleETm3k
	 OUHea7Ij4e5FyjDxJcJV+rZLYptOEKXJd2bfJSAg=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A784866DBD;
	Wed,  5 Mar 2025 08:27:06 -0500 (EST)
Message-ID: <91797ac4bbe27d7d60b89053050e429bcd630db3.camel@xry111.site>
Subject: Ping: [PATCH 0/3] Drop explicit --hash-style= setting for new
From: Xi Ruoyao <xry111@xry111.site>
To: Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Palmer Dabbelt <palmer@dabbelt.com>, Fangrui
 Song <i@maskray.me>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, linux-csky@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Mar 2025 21:27:04 +0800
In-Reply-To: <20250224112042.60282-1-xry111@xry111.site>
References: <20250224112042.60282-1-xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ping.

On Mon, 2025-02-24 at 19:20 +0800, Xi Ruoyao wrote:
> For riscv, csky, and LoongArch, GNU hash had already become the de-
> facto
> standard when they borned, so there's no Glibc/Musl releases for them
> without GNU hash support, and the traditional SysV hash is just
> wasting
> space for them.
>=20
> Remove those settings and follow the distro toolchain default, which
> is
> likely --hash-style=3Dgnu.=C2=A0 In the past it could break vDSO self tes=
ts,
> but now the issue has been addressed by commit
> e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH").
>=20
> Xi Ruoyao (3):
> =C2=A0 riscv: vDSO: Remove --hash-style=3Dboth
> =C2=A0 csky: vDSO: Remove --hash-style=3Dboth
> =C2=A0 LoongArch: vDSO: Remove --hash-style=3Dsysv
>=20
> =C2=A0arch/csky/kernel/vdso/Makefile=C2=A0 | 2 +-
> =C2=A0arch/loongarch/vdso/Makefile=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/riscv/kernel/vdso/Makefile | 2 +-
> =C2=A03 files changed, 3 insertions(+), 3 deletions(-)
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

