Return-Path: <linux-arch+bounces-3049-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6458881007
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00AECB23A7C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 10:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5C2770B;
	Wed, 20 Mar 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="msLXyRZm"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9932032C;
	Wed, 20 Mar 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931052; cv=none; b=dDYO3E7ZzYNzylQe7m8dmO1s4LOFrDYTZ3vw7L2ri1Ikipa0/yN2KdCc28hJekJSRsLUALknqb5/TAfhA1ztajnSVYCyhEfIDGpDvHrCP8NAjY7GBC4u48uqSwPFPwXPHTN+l2p3pxt8Vjt2jwu4h+K9O2O8IsR+rhsD+kqD4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931052; c=relaxed/simple;
	bh=oMcExfi3dY3kbb1sQnyyDLt0+nzIomwQcaxWzI7t2qk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVpJpu5utDksS04uOkdWvE0oyr2gsOE5PR5Dc+1HGvNmgBBPxjse8wn5Eka9VEWZp/rkTZ+8DLjRwyW5fVhxnWHy/T0BgwQrmyDZAr8fUsSkZ6QHqy0/MCN3eGQFLp6o06/UTlQqu3KUW9sCAnRYzCjYFj4o+BaP4CCu2IHx+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=msLXyRZm; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1710930453;
	bh=oMcExfi3dY3kbb1sQnyyDLt0+nzIomwQcaxWzI7t2qk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=msLXyRZm3wWEhspe6etI170C6ugUOpgwoo8GpmrfFo1ZjZF8f9/yIqcpwlFXcxrtB
	 7HMDws+TdWu9+7nRVYJvQQTCs60XeR+sJz48ZZ9tq+rCl7FFqgA2SEUjRSoLs3YY8O
	 Drz1d2aFmIEOv1ZwQQIe7zrq6fMdn68HgV3URCmc=
Received: from [192.168.124.9] (unknown [113.140.11.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D09D166F79;
	Wed, 20 Mar 2024 06:27:29 -0400 (EDT)
Message-ID: <e8c4062df63f3e8bc8bb2d7209fa2a2a44bd7ed3.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Change __my_cpu_offset definition to avoid
 mis-optimization
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-arch@vger.kernel.org, Xuefeng Li
	 <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, Xuerui Wang
	 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn, 
	stable@vger.kernel.org, Xiaotian Wu <wuxiaotian@loongson.cn>, Miao Wang
	 <shankerwangmiao@gmail.com>, Xing Li <lixing@loongson.cn>, Hongchen Zhang
	 <zhanghongchen@loongson.cn>, Rui Wang <wangrui@loongson.cn>
Date: Wed, 20 Mar 2024 18:27:26 +0800
In-Reply-To: <20240315024526.394772-1-chenhuacai@loongson.cn>
References: <20240315024526.394772-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-15 at 10:45 +0800, Huacai Chen wrote:
> From GCC commit 3f13154553f8546a ("df-scan: remove ad-hoc handling of
> global regs in asms"), global registers will no longer be forced to add
> to the def-use chain. Then current_thread_info(), current_stack_pointer
> and __my_cpu_offset may be lifted out of the loop because they are no
> longer treated as "volatile variables".

Ooops...  I'm wondering why this issue has not blown up our systems
before.  The referred GCC commit is far before LoongArch CPUs are taped.

> This optimization is still correct for the current_thread_info() and
> current_stack_pointer usages because they are associated to a thread.
> However it is wrong for __my_cpu_offset because it is associated to a
> CPU rather than a thread: if the thread migrates to a different CPU in
> the loop, __my_cpu_offset should be changed.
>=20
> Change __my_cpu_offset definition to treat it as a "volatile variable",
> in order to avoid such a mis-optimization.
>=20
> Cc: stable@vger.kernel.org

I suppose we should add Fixes: 5b0b14e550a0 ("LoongArch: Add
atomic/locking header") here.

> Reported-by: Xiaotian Wu <wuxiaotian@loongson.cn>
> Reported-by: Miao Wang <shankerwangmiao@gmail.com>
> Signed-off-by: Xing Li <lixing@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Rui Wang <wangrui@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> =C2=A0arch/loongarch/include/asm/percpu.h | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include=
/asm/percpu.h
> index 9b36ac003f89..03b98491d301 100644
> --- a/arch/loongarch/include/asm/percpu.h
> +++ b/arch/loongarch/include/asm/percpu.h
> @@ -29,7 +29,12 @@ static inline void set_my_cpu_offset(unsigned long off=
)
> =C2=A0	__my_cpu_offset =3D off;
> =C2=A0	csr_write64(off, PERCPU_BASE_KS);
> =C2=A0}
> -#define __my_cpu_offset __my_cpu_offset
> +
> +#define __my_cpu_offset					\
> +({							\
> +	__asm__ __volatile__("":"+r"(__my_cpu_offset));	\
> +	__my_cpu_offset;				\
> +})
> =C2=A0
> =C2=A0#define PERCPU_OP(op, asm_op, c_op)					\
> =C2=A0static __always_inline unsigned long __percpu_##op(void *ptr,		\

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

