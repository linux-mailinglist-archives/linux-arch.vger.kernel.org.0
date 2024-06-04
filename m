Return-Path: <linux-arch+bounces-4683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B588E8FB9FF
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 19:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556731F27B92
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F9A1494CC;
	Tue,  4 Jun 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="D+tsgmfL"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241C146A7A;
	Tue,  4 Jun 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520967; cv=none; b=jX6tc2jMIDKqyD5+oMSDA52ERvaRMBAI25FL5xTZwiWANdhbdwv5ZujIdtZdAI+bVTxFoMimC6Ch5rf4lS0UIa63JjHL4Xo4on2itt8MDkHScqC79PEE8Q1sytD45zoJjJoS2f2x2xvuzV7rCmIgURwb4j/SI6d5G+LLhtBhhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520967; c=relaxed/simple;
	bh=Tmsnbn8947mPtgG/FP1if5b9r64LMS46HnX1FZOK5Xg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H0XBP+m3k3ZO/e5KHn7BDBnlFBGeZNI2WnxfRVfPVvLjpTmUFf0VTKRlZ5t83P8wb3J54pYIc78GHgRo+KliJ9qdVehu9UzCNYG8091m1DusLXHmTtNVPsOjhLbMNnFry66Cen3OefCQTBx2IEQr0CpD2hXu4tB4lummaeBf+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=D+tsgmfL; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xaf8913xcjDgYsoFANplIr5ZjcU89fgw4ngc6yfnaPI=; t=1717520963; x=1718125763; 
	b=D+tsgmfLZEn1sPGj0PImdVjtw1KRYCMwfC6mxUFXp1VIYcn4pHd2n3YFx+hJ0ryBpFZwmWtjkAk
	zmBZ0S3cGr/wFnRY+4ikO4dnSvILbsxWV1VSveNBIdHi60m0by/fRJ5iKlhOu/nVjLh9LoqaaCYUg
	DqUcuHQNnmmNNSwjX523LQhbUxu6fuopRkP3TS8+4mptPYTbniy40Njc0p2AQU2WEyyvByeanLn+Y
	+0khQYosr0Ig1ReiQMO3sv+bhhLrvQc+sLbNl8S0IDi6ZHfZMlNR6hpi+k/XwGDNULnvGOdWi+Gyh
	XJbB75hTGPMAi9z+r0bOAlDbxqBUGnLUtacA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sEXeq-00000000QKx-0xdT; Tue, 04 Jun 2024 19:09:12 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sEXep-00000002hUu-48I5; Tue, 04 Jun 2024 19:09:12 +0200
Message-ID: <c44890de1c3d54d93fbde09ada558e7cb4a7177c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 cmpxchg 2/4] sh: Emulate one-byte cmpxchg
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, elver@google.com, 
	akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, 
	dianders@chromium.org, pmladek@suse.com, torvalds@linux-foundation.org, 
	arnd@arndb.de, Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt
	 <palmer@rivosinc.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-sh@vger.kernel.org
Date: Tue, 04 Jun 2024 19:09:11 +0200
In-Reply-To: <20240604170437.2362545-2-paulmck@kernel.org>
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
	 <20240604170437.2362545-2-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello,

On Tue, 2024-06-04 at 10:04 -0700, Paul E. McKenney wrote:
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
> index 5e6a3ead51fb1..f723e2256c9c1 100644
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

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

I can pick this up through my SH tree unless someone insists this to
go through some other tree.

Adrian

PS: I'm a bit stumped that I'm not CC'ed as the SH maintainer.

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

