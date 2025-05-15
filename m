Return-Path: <linux-arch+bounces-11959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8178AB8834
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 15:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1647E1894885
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485019CC0E;
	Thu, 15 May 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="mJwAAXQZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231364A98;
	Thu, 15 May 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316165; cv=none; b=i2R9RciQmIJvqgUv0tNbOVjf4fYDE/2g7Rwi41IaibO1OlP9yX2Upc3qN7Mwk4vJS32vj28i+ZUFVTLwSBf8UP9W9rtonc6ly8dxzm1hKF+tOtrn95T+SzbNGKM3mDKKzP4mOvG96WRsnzTgRpzNd+VPuRUWP2Mdy/z3VBPGyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316165; c=relaxed/simple;
	bh=KaBzi8GlO0ydrK58TdXSHZV40FFlwy0hZ5i+G89tUIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsST7dtLM6UbqBEi4AqnFnI6j2dfhTchE+c84OzAJe6ZyOYkC8iLtl5BlPoxInTnxoqVfwk1bvZrUmyQ6VkyYT9ZFuGFs3B3QN/I7h8ZWjrJ39QVS0TnTjRJ/uImvw103eHSm2Nyxuie94lHikcdZPhd7/rDthiMTweRggH1u24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=mJwAAXQZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LxU48+H4Hfyu4/QZlEGDNTeaj6+P5jUaE2mhOPfHXmk=; t=1747316161; x=1747920961; 
	b=mJwAAXQZJ1xsRSSGCYtdywW9RZ7shW6oa56HUMwgYWPP0rxBXm0s2iKliauJVsQloJ7Yf9BpV3T
	fEABFu79LhXcVeqxC4ysw2ekXO0y4UiynjJOErBXB/a+kgXXdaa1VMiW/ifPJa1az7CtCxFxXuIDG
	22YYzK6Yk4U9j/VXQViOH6xoQscHM1YsgDxXtga0YKkZbOyA6KQgQ9XHQt04lTXCjHej9cnlLE1ye
	zXguFWcNrHFyq20nlGyk+vCPOo3B3wdkknTEVTeUn9cedZyu5BFjq5uGvTBQGjhjzXPELom4/R0mL
	WJkyPUEUv0rAgap+02l79DzG2xrHKr9jtAAw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uFYkg-00000003IlY-3zCZ; Thu, 15 May 2025 15:35:58 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uFYkg-00000001DsV-307F; Thu, 15 May 2025 15:35:58 +0200
Message-ID: <bb170eb0524d04de13cb5b2a1cca9467bc2def87.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 14/15] bugs/sh: Concatenate 'cond_str' with '__FILE__'
 in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>,  Peter Zijlstra <peterz@infradead.org>,
 linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date: Thu, 15 May 2025 15:35:57 +0200
In-Reply-To: <aCXtGRr5pSLKoKg8@gmail.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
	 <20250515124644.2958810-15-mingo@kernel.org>
	 <ba1e1ae6824f47bcb49387ae4f2c70dfd45209bc.camel@physik.fu-berlin.de>
	 <aCXtGRr5pSLKoKg8@gmail.com>
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

On Thu, 2025-05-15 at 15:33 +0200, Ingo Molnar wrote:
> > It's too long and the prefix "bugs/sh:" is very confusing. I usually ju=
st
> > use "sh:" to mark anything that affects arch/sh.
>=20
> Fair enough, I've changed the title to and pushed out the new tree:
>=20
>   sh: Concatenate 'cond_str' with '__FILE__' in __WARN_FLAGS(), to extend=
 WARN_ON/BUG_ON output

Thanks! Minor nitpick: I think that comma is wrong and should be removed
(I'm not a native speaker though ;-)).

> > Can I pick this patch for my sh-linux tree?
>=20
> So since it depends on the previous patches, in isolation this would=20
> break the build.
>=20
> Can I add your Reviewed-by or Acked-by?

Yes, sure.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

