Return-Path: <linux-arch+bounces-4128-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD288B93F5
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 06:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08DB1F21D74
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 04:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D971CA81;
	Thu,  2 May 2024 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="n5hAjaXl"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7D12E75;
	Thu,  2 May 2024 04:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625584; cv=none; b=k6w5ZRTjPFAFT/yOS+HErYONghVEEjSTiJQT1GPQnF7YRcOj5MXNfz63BzcHgr4gR0tpmAakVWcafWONA/zktPkEWV2bdVIspP5lkwat/CRbXRYXzAf8KHpg/H++yLHWKQGw+keDhnX0SRMqsrLBNsdp+sYnvdwNM88HpMIOTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625584; c=relaxed/simple;
	bh=Be1NO7/RwxW2Ftlfxne9kCWldkjf/e42obNSaNj/LAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EE+4j4HXsmSmLevpqWf3ruynf4cRagonnXvsbEOnEeZk4ByNk5OPgVpEeFXZX6UyXApFeMb9KGaYgfLVpzjIiydsMcRs8Rx05QH+R9O0dFH7U/lQh/mRTIoNoiUmSTZxfYqYyu7UkvF2Zu/edfHIwEJSGjddXEzwIyF3uC9zUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=n5hAjaXl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/eMsYhPVNNcz2vMoRM5ukXsDie/BKIKYyU9ZchLdKu4=; t=1714625580; x=1715230380; 
	b=n5hAjaXldDS8Ad9R+oAPVdPigwenDWreiKYyCJFdYbc6Fs8i03Y9X0SqUU9rmIlCRU5uShFztOv
	Rx/UzFjz18ak8237vsx9JCqspLhfuXxk5r8pfRieqeYE3plgf4vuvCV+PtzclkOSvwKYWUVsseVpV
	nPcXRQfNMmhjmvtTpxuW5zQFjEcYLHH7wz5/4mAtTrAah+BiZScjUtu5pg1xL+X3yzjpCxYeGqzw3
	L8I4nDJWUsCX32AFpjtqrSz7IQ7bUQ0wNSsHQjlWbAEteHjoFngZ0JtYEdmwnovjxdVv2hiHNfTzF
	lmEr7QpbJCvPvuWMR0q2V+AI1zlNvcm6+joQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2ORD-00000003upy-0WBi; Thu, 02 May 2024 06:52:55 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2ORC-00000003GON-3gV9; Thu, 02 May 2024 06:52:55 +0200
Message-ID: <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de, 
 peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
 arnd@arndb.de,  torvalds@linux-foundation.org, kernel-team@meta.com, Andi
 Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Date: Thu, 02 May 2024 06:52:53 +0200
In-Reply-To: <20240501230130.1111603-12-paulmck@kernel.org>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
	 <20240501230130.1111603-12-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Paul,

On Wed, 2024-05-01 at 16:01 -0700, Paul E. McKenney wrote:
> Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on sh.
>=20
> [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> [ paulmck: Apply feedback from Naresh Kamboju. ]
> [ Apply Geert Uytterhoeven feedback. ]
>=20
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-sh@vger.kernel.org>
> ---
>  arch/sh/Kconfig               | 1 +
>  arch/sh/include/asm/cmpxchg.h | 3 +++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 2ad3e29f0ebec..f47e9ccf4efd2 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -16,6 +16,7 @@ config SUPERH
>  	select ARCH_HIBERNATION_POSSIBLE if MMU
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_WANT_IPC_PARSE_VERSION
> +	select ARCH_NEED_CMPXCHG_1_EMU
>  	select CPU_NO_EFFICIENT_FFS
>  	select DMA_DECLARE_COHERENT
>  	select GENERIC_ATOMIC64
> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.=
h
> index 5d617b3ef78f7..1e5dc5ccf7bf5 100644
> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -9,6 +9,7 @@
> =20
>  #include <linux/compiler.h>
>  #include <linux/types.h>
> +#include <linux/cmpxchg-emu.h>
> =20
>  #if defined(CONFIG_GUSA_RB)
>  #include <asm/cmpxchg-grb.h>
> @@ -56,6 +57,8 @@ static inline unsigned long __cmpxchg(volatile void * p=
tr, unsigned long old,
>  		unsigned long new, int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return cmpxchg_emu_u8(ptr, old, new);
>  	case 4:
>  		return __cmpxchg_u32(ptr, old, new);
>  	}

Thanks for the patch. However, I don't quite understand its purpose.

There is already a case for 8-byte cmpxchg in the switch statement below:

        case 1:                                         \
                __xchg__res =3D xchg_u8(__xchg_ptr, x);   \
                break;

Does cmpxchg_emu_u8() have any advantages over the native xchg_u8()?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

