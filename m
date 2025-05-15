Return-Path: <linux-arch+bounces-11957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F541AB8722
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04446188F49D
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E712989B3;
	Thu, 15 May 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="NKbjC4UT"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31893295DB8;
	Thu, 15 May 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313795; cv=none; b=lWOGM9+n+mL/SDunT8K4ukQsYCWJ1lmA1SJAE7E+6BY0RrCWj6+2EBO1FUX9DM2tyPhmrji/VhKQa+HBAK81HpgJt8WJVSF7EFJpFjYkRbTv8lyAWeoQgQ2rtbl7YLZWzE6bqRR7Cdj4WdVLfk3jclMxSdEblpa49bgIi3eKeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313795; c=relaxed/simple;
	bh=JQQmCigDTGGR3Yhow6axIFhvc3Eoa8D0gOt7/pasBOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VH9PPxQqW9o9or2MpFGrLdjazoBrgJ1MiMwf31H0yOANul4LYmB31AlgNKY03zfInzDhhzU12xeZ7glyvRZMMalh8R9UaxUYo+RJwuCscwpQnojDzCmLTE1kJ3xvfj4VH39cOJeKcioCV2HpxKPcptmGnqswcM/FErUEWEJz2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=NKbjC4UT; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n4nOOBXE7v6odPR/BwwmCDAbwuJ53Fu89h6EfppGY7A=; t=1747313792; x=1747918592; 
	b=NKbjC4UTCSNu7sntJ7D8MuFHWwWLPr4AoyEE85HRbgXyp21Utqp+6HMezmZBbWjc8zcTnWf1vG5
	t/EUIRq/jiD7dvmzv42TxSFDF0dppptlDzAorEdk0P8R4V+JK8iwQwddIMEoYBRACxjX+QPCZmGf8
	VW6P64aK62IMDJFiPS/k/KaE9ACerkiLN5FcLAaeTV8b4MiOKUsLXFPj+yfz9Po9apFYV7dBznAu/
	SPvveyDif8JADCmc2V9z3d5w3xvYuhYTsvrncxVSqH5k0hPcYp1y4eF5J5FT90l77AF+raJeL6mqI
	e9FVfT4yxgs1ppwNGwKNSofifUykOXy4e4CA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uFY8S-00000002b5K-2MpM; Thu, 15 May 2025 14:56:28 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uFY8S-00000000y68-1RYs; Thu, 15 May 2025 14:56:28 +0200
Message-ID: <ba1e1ae6824f47bcb49387ae4f2c70dfd45209bc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 14/15] bugs/sh: Concatenate 'cond_str' with '__FILE__'
 in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
	 <peterz@infradead.org>, linux-arch@vger.kernel.org, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Date: Thu, 15 May 2025 14:56:27 +0200
In-Reply-To: <20250515124644.2958810-15-mingo@kernel.org>
References: <20250515124644.2958810-1-mingo@kernel.org>
	 <20250515124644.2958810-15-mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ingo,

On Thu, 2025-05-15 at 14:46 +0200, Ingo Molnar wrote:
> Extend WARN_ON and BUG_ON style output from:
>=20
>   WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x41=
0
>=20
> to:
>=20
>   WARNING: CPU: 0 PID: 0 at [idx < 0 && ptr] kernel/sched/core.c:8511 sch=
ed_init+0x20/0x410
>=20
> Note that the output will be further reorganized later in this series.
>=20
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: <linux-arch@vger.kernel.org>
> ---
>  arch/sh/include/asm/bug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
> index 834c621ab249..891276687355 100644
> --- a/arch/sh/include/asm/bug.h
> +++ b/arch/sh/include/asm/bug.h
> @@ -59,7 +59,7 @@ do {							\
>  		 _EMIT_BUG_ENTRY			\
>  		 :					\
>  		 : "n" (TRAPA_BUG_OPCODE),		\
> -		   "i" (__FILE__),			\
> +		   "i" (WARN_CONDITION_STR(cond_str) __FILE__),	\
>  		   "i" (__LINE__),			\
>  		   "i" (BUGFLAG_WARNING|(flags)),	\
>  		   "i" (sizeof(struct bug_entry)));	\

Looks good to me, however I'm not happy with the summary line.

It's too long and the prefix "bugs/sh:" is very confusing. I usually just
use "sh:" to mark anything that affects arch/sh.

Can I pick this patch for my sh-linux tree?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

