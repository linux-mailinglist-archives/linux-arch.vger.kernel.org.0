Return-Path: <linux-arch+bounces-9583-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E54A013B0
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 10:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B60316343D
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F717B50F;
	Sat,  4 Jan 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="iCLX6xS8"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0116F271;
	Sat,  4 Jan 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735983713; cv=none; b=s8B2A/YiNTiq61yxkMsu4XNilQlu4C6RKSVupXylhdKYtFgfAxivjWZ1t0EKat9yjlDkRlVJxrnh2uTV0AR5OaseRLiq6rCO3EHCYsBSM6NF/mGHRzXFRG6UwidS+GkVW8Yyp4IoI2PByIPEhCLO+0GrVC7eNYWyT4GDti5OBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735983713; c=relaxed/simple;
	bh=A5b7UzYjSzEg+lubXOZ3LgEjbBkpRapYDrBmFUZOv2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kq2n8CmSv/WBs8CMY2w6Z4bpuPRKwU1TzNHPQzzcIWOCAMgSXDMPlYJhJBdvWTEd4K8avIIvOuIseBVU9Jw8ik+3FSSfbxZOba0fLme7roSd3TGUara/yf4p6AcgoUWWfes43amMbs+yfc7s2ds6EyL0rUSxBd8wzhGvBUVxmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=iCLX6xS8; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1735983112;
	bh=9/6HpxIAu3h6hDa3wEevWjSh+p8KNvlojj0zXGI2T28=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iCLX6xS8XvkQJ0lpgqLD9wwkgsMD1k7iIlODwiIDbBwGzY6GFpI3pgAUVKEfGEdhI
	 VkZps/XOzItQb/haquWwOyXYL05r0fHfwvxj8MAuajPqdV2XXN3MBAqBTi6CgpNLIq
	 wqiC1SQlZKtETfHLrfbF9MFR7ooUzRqzJWh2zheQ=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 4F61D6596C;
	Sat,  4 Jan 2025 04:31:50 -0500 (EST)
Message-ID: <3409b0608ba127c356e2a6d760c3ac2d446c9da7.camel@xry111.site>
Subject: Re: [PATCH 2/3] loongarch: Introduce sys_loongarch_flush_icache
 syscall
From: Xi Ruoyao <xry111@xry111.site>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen
 <chenhuacai@kernel.org>,  WANG Xuerui <kernel@xen0n.name>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Date: Sat, 04 Jan 2025 17:31:48 +0800
In-Reply-To: <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
	 <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-02 at 18:34 +0000, Jiaxun Yang wrote:

/* snip */

> Sadly many user space applications are assuming ICACHET support, we can't
> recall those binaries. So we'd better get UAPI for cacheflush ready sooni=
sh
> and encourage application to start using it.

To encourage the developers changing ibar to loongarch_flush_icache, we
should minimize the extra overhead on mainstream systems.  We can add an
vDSO layer so if the CPU has ICACHET:

int vdso_loongarch_flush_icache(...)
{
  asm ("ibar 0");
  return 0;
}

And otherwise the vDSO wrapper invokes the real syscall.  I've
implemented the boot-time alternative runtime patching for vDSO at
https://lore.kernel.org/loongarch/20240816110717.10249-3-xry111@xry111.site=
/.

> The syscall resolves to a ibar for now, it should be revised when we have
> actual non-ICACHET support in kernel.

/* snip */

> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/inc=
lude/asm/cacheflush.h
> index f8754d08a31ab07490717c31b9253871668b9a76..94f4a47f00860977db0b36096=
5a22ff0a461c098 100644
> --- a/arch/loongarch/include/asm/cacheflush.h
> +++ b/arch/loongarch/include/asm/cacheflush.h
> @@ -80,6 +80,12 @@ static inline void flush_cache_line(int leaf, unsigned=
 long addr)
>  	}
>  }
> =20
> +/*
> + * Bits in sys_loongarch_flush_icache()'s flags argument.
> + */
> +#define SYS_LOONGARCH_FLUSH_ICACHE_LOCAL 1UL
> +#define SYS_LOONGARCH_FLUSH_ICACHE_ALL   (SYS_LOONGARCH_FLUSH_ICACHE_LOC=
AL)

Not a UAPI header so not usable by the user?  How would they specify
flags then?

If you meant to add them for UAPI, it would be very problematic.  When a
new cache type emerges in the hardware implementations, we need to grow
SYS_LOONGARCH_FLUSH_ICACHE_ALL in the UAPI header, but we cannot change
the already compiled JIT applications.  Thus all JIT applications have
to be recompiled with the latest UAPI header.  This just seems an
unnecessary severe burden to the packagers.

Instead IMO it's better not to expose so much details to the userspace.
Just remove the flags argument and flush all the icaches the kernel
knows, so with a new cache type the user (and distro) just need to
update or patch their kernel, w/o recompiling all JIT apps.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

