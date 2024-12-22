Return-Path: <linux-arch+bounces-9459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFB39FA879
	for <lists+linux-arch@lfdr.de>; Sun, 22 Dec 2024 23:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A1A18864AD
	for <lists+linux-arch@lfdr.de>; Sun, 22 Dec 2024 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA2192B69;
	Sun, 22 Dec 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Y2jiF90J"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA718595F;
	Sun, 22 Dec 2024 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734907059; cv=none; b=Lys69K6t5LDPCn70ejSMoP0YipO6ruSihl3dy97CtbbojNdpk0iq7maFvjGO1p9AoXRLpUCmrcLJj/CuA7dHPOcxZDSqRkHG1LTMKeQH221AwZbPhyGQ6n+M+dUe875A8ExrDks2W84FOGpr9Wkq+pD5vYk8Q1rE/fo7nqilsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734907059; c=relaxed/simple;
	bh=Rh19iPPMPBJhGskWc6F9eD1LILQBPpAJ9LV7I1M+tNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LB3e8PyciuIKRdho/EG9m+GbW3yPnzYzoAJqzXNsl2AfeXRKbMv2pP+OlX1JiFIaV0RcQb65EtoDhN6DA/8J+ch5P3AqCU4cZN7cMjt2VmqGg7AKgPLe44yELDbeSbzeA6ldE+xbmQCwx1s1TtzRkoLzVRc2bKZi1tMTKs6vaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Y2jiF90J; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=so65VtRWU5T7qemOBw/z5lZFubTbWM0FfzA74/KrOzw=; t=1734907055; x=1735511855; 
	b=Y2jiF90JONj7HNwPS/2C1uYElDKp9zOm091Uv5bxlHpqINNaqbN/2XnMEycs65UaDxrC1s/Oit7
	599398O53RXyG/7HcXbjE+sZONfpNOnzSCybOIQwsWc1xJYCeRoVlK/m0NnVEKZPB4Tk4BtSRfvvd
	oTQFWgv9lTWRH7gnX4J4YBvJ0BikmyPyoRBK/oEXNTZmB5rcl0PcUduHOe7yyTTqqHDEDmwFfr3nr
	1Aku28dW/moi39LRlD402RIErQCngbWSlMlL5++QN+bYVneRnvkJBd4z66+EZkX9lNp47ZiPWo411
	RwhpA+BtIbI7vpIk6zQ3O5O2l0hCygDOhxFQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tPUWD-00000001lqc-0fcU; Sun, 22 Dec 2024 23:33:49 +0100
Received: from dynamic-078-054-162-203.78.54.pool.telefonica.de ([78.54.162.203] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tPUWC-00000000W6W-3zbs; Sun, 22 Dec 2024 23:33:49 +0100
Message-ID: <09c316ecff688e499bebee26aeb7364f1714c675.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: exports for delay.h
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-arch@vger.kernel.org
Date: Sun, 22 Dec 2024 23:33:48 +0100
In-Reply-To: <20241222222259.GF1977892@ZenIV>
References: <20241222222259.GF1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Al,

On Sun, 2024-12-22 at 22:22 +0000, Al Viro wrote:
> 	__delay() is either exported or exists as a static inline
> on all architectures - except sh.
>=20
> 	Add the missing export of __delay(), move the exports of
> the rest of that bunch from sh_ksyms32.c to the place where all
> of them are defined (i.e. arch/sh/lib/delay.c).
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
> index 5858936cb431..0b9b28144efe 100644
> --- a/arch/sh/kernel/sh_ksyms_32.c
> +++ b/arch/sh/kernel/sh_ksyms_32.c
> @@ -2,7 +2,6 @@
>  #include <linux/module.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> -#include <linux/delay.h>
>  #include <linux/mm.h>
>  #include <asm/checksum.h>
>  #include <asm/sections.h>
> @@ -12,9 +11,6 @@ EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memset);
>  EXPORT_SYMBOL(memmove);
>  EXPORT_SYMBOL(__copy_user);
> -EXPORT_SYMBOL(__udelay);
> -EXPORT_SYMBOL(__ndelay);
> -EXPORT_SYMBOL(__const_udelay);
>  EXPORT_SYMBOL(strlen);
>  EXPORT_SYMBOL(csum_partial);
>  EXPORT_SYMBOL(csum_partial_copy_generic);
> diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
> index dad8e6a54906..63cd32550b0c 100644
> --- a/arch/sh/lib/delay.c
> +++ b/arch/sh/lib/delay.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/sched.h>
>  #include <linux/delay.h>
> +#include <linux/export.h>
> =20
>  void __delay(unsigned long loops)
>  {
> @@ -29,6 +30,7 @@ void __delay(unsigned long loops)
>  		: "0" (loops)
>  		: "t");
>  }
> +EXPORT_SYMBOL(__delay);
> =20
>  inline void __const_udelay(unsigned long xloops)
>  {
> @@ -41,14 +43,16 @@ inline void __const_udelay(unsigned long xloops)
>  		: "macl", "mach");
>  	__delay(++xloops);
>  }
> +EXPORT_SYMBOL(__const_udelay);
> =20
>  void __udelay(unsigned long usecs)
>  {
>  	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
>  }
> +EXPORT_SYMBOL(__udelay);
> =20
>  void __ndelay(unsigned long nsecs)
>  {
>  	__const_udelay(nsecs * 0x00000005);
>  }
> -
> +EXPORT_SYMBOL(__ndelay);

Thanks, this looks good and I'll pick it up for sh-linux 6.14, although
I'm probably going to make the subject a little more descriptive ;-).

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

