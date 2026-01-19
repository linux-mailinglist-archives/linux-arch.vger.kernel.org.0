Return-Path: <linux-arch+bounces-15870-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57039D3AF34
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 418BA303C22B
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED138B983;
	Mon, 19 Jan 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SLjl4XZ9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA533659EE;
	Mon, 19 Jan 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836867; cv=none; b=kx2T5wG/qBsg16/EOMFJWDrCM+dCYlkdXE7PkhGAnOVh+5sy3uWQjRFyQR4Pggb1XuhWA00CttuEog8dCHjRQokjba63uxWZET7tZSD/v3dSUACFz3NarltZyDljXx3ZFfLBYqrPCi8Kpyi/Evh/Roy0zT/rAh6TJAcfK/1Vwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836867; c=relaxed/simple;
	bh=SDiJ9rMuEmGWqvdjE/PB6j+b+caslu3fWciRRhn6TH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7nCNhXb/1nsSVjf5WUkXLaqFDMrSBbQsSqfNaZ+pMKRaTHkJ5Lz1DnE69V05vifqfN2jma745uKgBJPn541yRDiZaMF7eWZxJhRxqr5C41FceMm6QYWEgL87YF0jDsjv9WWE/e12zCDrUVP4hN/45EYhKiSOIaeX1mSwDGm6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SLjl4XZ9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:13a:c452:d5de:4aa7] ([IPv6:2601:646:8081:9483:13a:c452:d5de:4aa7])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60JFXJwk2977448
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 19 Jan 2026 07:33:40 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60JFXJwk2977448
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768836825;
	bh=4Q/6//YPBVOKpSPOZmY02VBn1bxzR3+UZmeQXx3XeIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SLjl4XZ9zumSGJU28T9v0hnMf5V3RytVVSE4lu6QdUzevjKQBcT0N8cSS260zclCN
	 fLWAnb0bvL1FeX+gWbWdTMj6ergASYGssann0CtXMuyIqfDNhQCuqPVSQhBBb6GhlT
	 Qt9gvR21SW1xHmn0Wt+BEBKKVQax4cam/faOxh0hIcamIpS7RnBAxGuv+5FdzbBA1Q
	 rJgRnRX+BwyvoiwU301PCIe+JEWgzgdGAx0PgQk9QRxInWkdhzFp16vUyVq/6H88kC
	 Hu2oiAwRfHrzQisxbLucVbEEMd6iA99+DaWBSPvtk92qlJYUwaeoJvejYtQ+4AIP66
	 KEeGoEz+wsk9A==
Message-ID: <1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com>
Date: Mon, 19 Jan 2026 07:33:13 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-01-15 23:40, Thomas Weißschuh wrote:
> The value of __BITS_PER_LONG from architecture-specific logic should
> always match the generic one if that is available. It should also match
> the actual C type 'long'.
> 
> Mismatches can happen for example when building the compat vDSO. Either
> during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
> correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
> when mismatched CHECKFLAGS are inherited from the kernel build.
> 
> Add some consistency checks which detect such issues early and clearly.
> The tests are added to the UAPI header to make sure it is also used when
> building the vDSO as that is not supposed to use regular kernel headers.
> 
> The kernel-interal BITS_PER_LONG is not checked as it is derived from
> CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
> deactivated check in include/asm-generic/bitsperlong.h.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
> index fadb3f857f28..9d762097ae0c 100644
> --- a/include/uapi/asm-generic/bitsperlong.h
> +++ b/include/uapi/asm-generic/bitsperlong.h
> @@ -28,4 +28,18 @@
>  #define __BITS_PER_LONG_LONG 64
>  #endif
>  
> +/* Consistency checks */
> +#ifdef __KERNEL__
> +#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
> +#if __BITS_PER_LONG != (__CHAR_BIT__ * __SIZEOF_LONG__)
> +#error Inconsistent word size. Check uapi/asm/bitsperlong.h
> +#endif
> +#endif
> +
> +#ifndef __ASSEMBLER__
> +_Static_assert(sizeof(long) * 8 == __BITS_PER_LONG,
> +	       "Inconsistent word size. Check uapi/asm/bitsperlong.h");
> +#endif
> +#endif /* __KERNEL__ */
> +
>  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
> 

Do we actually support any compilers which *don't* define __SIZEOF_LONG__?

	-hpa


