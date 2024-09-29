Return-Path: <linux-arch+bounces-7482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8239893B6
	for <lists+linux-arch@lfdr.de>; Sun, 29 Sep 2024 10:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181A51F21230
	for <lists+linux-arch@lfdr.de>; Sun, 29 Sep 2024 08:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8913A88A;
	Sun, 29 Sep 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="az8tEgoO"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664513635F;
	Sun, 29 Sep 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727597964; cv=none; b=O5OBqNBJ+A6cGf2K3S5wyZV9+ZxlqzMp5/eA9/YTjwpuzhib8zQRrGPmJDY1qFkoECTBFbtLb4tMKZqiVWPZzj5jEpR5SCaXgQBuvpXh/gm7Hqew/XtdGEMp8EFr7z8k6kMGu6z5bS+jWOsCs9i2+9eTlUTMgzYg88J6quNptQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727597964; c=relaxed/simple;
	bh=cnhloMqw0YF6ToVDxEGJW10wSajal1rzWAvAuR6UIqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwmN87BfBtQ1l8REFK8/FQpoEvHGTFSyFtuH4R6RY5kLKVLOM3bwnzsffhfrGovlQ6bumbHEJrVP+UZU9FKMhMs0mcqdhcqEw/3W57gB+KRoyCqXlPxatMNcMJyC9JDTVHwd8px86OmdxUJ9VAZTXFgH1/qQ0z4vx6peeWsn9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=az8tEgoO; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1727597954;
	bh=WPPtQ5yDugA9LY+gtCKLFK+aPbUmYYdCZ2ipS0rcb4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=az8tEgoOTJVe/T1XdSuNR3acTUMsj1MCTHq6JruKGkaHXqb7AswsWzwzwOtAorKej
	 Cm8jo1+RrUKsESddLCR5jSbepPRVJA3RFmO1B8Z5hmbPWkECMJTkMbOFlMq96nchhs
	 apGsxM+R0ADGsVQIe+cy1Z6mBVH99Fwr9kqLUbnw=
Received: from [IPv6:240e:358:11fd:c900:dc73:854d:832e:6] (unknown [IPv6:240e:358:11fd:c900:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7E9AB1A4038;
	Sun, 29 Sep 2024 04:19:08 -0400 (EDT)
Message-ID: <8fb18e4166be8ef59ed0ccb7fa2f79844220aec2.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Set correct size for VDSO code mapping
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-arch@vger.kernel.org, Xuefeng Li
	 <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, Xuerui Wang
	 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date: Sun, 29 Sep 2024 16:19:03 +0800
In-Reply-To: <20240929074944.3540514-1-chenhuacai@loongson.cn>
References: <20240929074944.3540514-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-29 at 15:49 +0800, Huacai Chen wrote:
> The current size of VDSO code mapping is hardcoded to PAGE_SIZE. This
> cannot work for 4KB page size after commit 18efd0b10e0fd77 ("LoongArch:
> vDSO: Wire up getrandom() vDSO implementation") because the code size
> increases to 8KB. Thus set the code mapping size to its real size, i.e.
> PAGE_ALIGN(vdso_end - vdso_start).

I get:

$ size vdso.so
   text	   data	    bss	    dec	  =20
hex	filename
   3716	    328	      0	   4044	  =20
fcc	vdso.so

So it "just" fits in 4 KiB, and of course it may exceed 4 KiB with a
different compiler or some kernel configuration affecting code
generation like CONFIG_INIT_STACK_ALL_ZERO or
CONFIG_ZERO_CALL_USED_REGS).

I remember I've checked `size vdso.so` before but I cannot remember why
I didn't realize a problem here.  Sorry for the stupidity.

Reviewed-by: Xi Ruoyao <xry111@xry111.site>

>=20
> Fixes: 18efd0b10e0fd77 ("LoongArch: vDSO: Wire up getrandom() vDSO implem=
entation")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> =C2=A0arch/loongarch/kernel/vdso.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
> index f6fcc52aefae..7e0cc7f5e1ed 100644
> --- a/arch/loongarch/kernel/vdso.c
> +++ b/arch/loongarch/kernel/vdso.c
> @@ -85,7 +85,6 @@ static vm_fault_t vvar_fault(const struct vm_special_ma=
pping *sm,
> =C2=A0
> =C2=A0struct loongarch_vdso_info vdso_info =3D {
> =C2=A0	.vdso =3D vdso_start,
> -	.size =3D PAGE_SIZE,
> =C2=A0	.code_mapping =3D {
> =C2=A0		.name =3D "[vdso]",
> =C2=A0		.pages =3D vdso_pages,
> @@ -103,7 +102,7 @@ static int __init init_vdso(void)
> =C2=A0	unsigned long i, cpu, pfn;
> =C2=A0
> =C2=A0	BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
> -	BUG_ON(!PAGE_ALIGNED(vdso_info.size));
> +	vdso_info.size =3D PAGE_ALIGN(vdso_end - vdso_start);
> =C2=A0
> =C2=A0	for_each_possible_cpu(cpu)
> =C2=A0		vdso_pdata[cpu].node =3D cpu_to_node(cpu);

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

