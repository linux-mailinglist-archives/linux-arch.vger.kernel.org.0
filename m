Return-Path: <linux-arch+bounces-6001-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B22948319
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDED11F2188B
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E69714A087;
	Mon,  5 Aug 2024 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="XRXBgJFE"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF313CF86;
	Mon,  5 Aug 2024 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889090; cv=none; b=sfZYaP+LkpFb1iNm6glEDbrvFk2zazn45rEujxVxC6fcofoG9EHyI1+dX7ndDDuCnTIKqjYMZdor7pKCZcSXdeHnHde/yWsJtVRqtLNfeDgitijmUOJQgGUQISThS6mIF3D1PLmeeHuZGaCczPXzP78jgsZi/vh+CqwRTO8XpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889090; c=relaxed/simple;
	bh=SDA/8M+q9FbyrEYwKNsAdWuE7Tz5DAnogwofeMSSuwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJ0oJpJLFI5b9cU04jVM45CzmDao9ngQkXZgpMGc/jKSCH/KG8/fDZohmVKNEXgbBecCEymSlxrPkGEb9ghoWLbOkE1PLrI0jXWdEr6OOP/e80xyZDAfY4HAmSf5xxyKkjRSIJv3fEuWODwBrP10o9MWoHO1HAI/zqmRME/YNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=XRXBgJFE; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iizmzgk6nde+kNgm78UgLxyes+gJTtndfv7UsiQEdyk=; t=1722889086; x=1723493886; 
	b=XRXBgJFE7yE+MFdqd4XG8hmd0xn7xzRK+zfkvJv34ClvSV5uLQXDCyDQ5lOD7VenaN/9kpgT/vp
	Q4YPPGSnb9TZVIO1uvy5ZfzGcM5moxQ1kLXWQfmc2ORyy/0Wxij9l/D4oOxeaoW1H798xoV23Jid8
	Gv5a+3immdT4Ocj08J8015sJplvxFhQHota5qT3YcUIUGRODdxKE6hrRk7GdiMcrvLMLdPz5tEOSJ
	wzwDutBE8COaYF0bSv/hFUX4+usCHHnNJ+um7Ao4kmuHL5J6pYARyMxg4nXqW8hinTHWwjx8yARK6
	nCFQJ6NSXZ6XO+venWKWGzPViwP/W9kXT2pw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sb45L-000000010l0-3XFZ; Mon, 05 Aug 2024 22:13:39 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sb45L-00000000u2V-2Vas; Mon, 05 Aug 2024 22:13:39 +0200
Message-ID: <d36d1c197bed83f91299e5cf211ecc4169d3b7a1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH cmpxchg 3/3] sh: Emulate one-byte cmpxchg
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de, 
	peterz@infradead.org, torvalds@linux-foundation.org, arnd@arndb.de, 
	geert@linux-m68k.org, palmer@rivosinc.com, mhiramat@kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, Andi Shyti
	 <andi.shyti@linux.intel.com>
Date: Mon, 05 Aug 2024 22:13:38 +0200
In-Reply-To: <20240805192119.56816-3-paulmck@kernel.org>
References: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
	 <20240805192119.56816-3-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2024-08-05 at 12:21 -0700, Paul E. McKenney wrote:
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
> index 1aa3c4a0c5b27..e9103998cca91 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -14,6 +14,7 @@ config SUPERH
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

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

