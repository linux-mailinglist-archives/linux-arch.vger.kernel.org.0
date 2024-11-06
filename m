Return-Path: <linux-arch+bounces-8871-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C771E9BDE8F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 07:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE68285811
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 06:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B2191F8C;
	Wed,  6 Nov 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hxJhZMGC"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10708190678
	for <linux-arch@vger.kernel.org>; Wed,  6 Nov 2024 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873423; cv=none; b=ApI9gNDtzusuiT6POxngPvdXkR1woEQ4nl4dJuAlyFZ7/vjXOlH25gMMbJXueQ6VU3HSfePjLFqqs5UfrdBAv39TVx73DUAkfglE2p7VoGw6R5fXuq9EUtEGIOKhAACmftjbf1mbDGPJ6LSLHkrsaL9opYH3mYUsOA/X5iPeRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873423; c=relaxed/simple;
	bh=GVj6LC89E9A6lYj2dz6voLxfU24pggQ/RebIUKIQkXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjxJymGaa25bVIF7XoGzyfYLEJh2RHIFQzuFX8P8wGBUGc87wgKcskV9RJ5beRH5WiI97QWojVmZSLrftunlAZBsq1Qq74xr1+ROAfnqdVQMT/2BTD45zV7hsWcKtRnQeofsWG3yz//oYkVhc4EkWRLxyk/Me3tKsDCPB5sylMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hxJhZMGC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ch0ZLfNV87MYWS8VhCAxiZeK1OHZIzIGcd9P0pm4/as=; b=hxJhZMGCy4K9hiNTGJOw1mGY62
	ck6lkq5Uw5WUGdrr/H5quHDe4Bv6ekzGZ4c+ID0vfCJQ2lGzdKw0bx2dVEA15J0G8yQ7sTVzJQ/O8
	u+iJ/Mocv2JmC0qjlt6QvrOWmUL7RHIqt/7E4L3h5674xIvJ1gTUJdWiByJMn1XOZA1GAZuAvUWp2
	K38l0+YhCt5BTglQ1nyx7HGb42H2BCx6IQQshBmSkOOSOx7VmDNOyDbxNOSnVrbqwj9236MkxsvVG
	Mwp4lw29J4WK3npnKnMGFK1EdRNFCaKmuOtq091UYdOGeXKxOkArBOkJ5zFJozyNaREDar6Ijiiu7
	GXJKqzGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZFD-0000000BX33-22qC;
	Wed, 06 Nov 2024 06:10:19 +0000
Date: Wed, 6 Nov 2024 06:10:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/4] vt_buffer.h: get rid of dead code in default scr_...()
 instances
Message-ID: <20241106061019.GA2748615@ZenIV>
References: <20241106060938.GW1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106060938.GW1350452@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Only 4 architectures define VT_BUF_HAVE_RW (alpha, mips, powerpc, sparc)
and all of them define VT_BUF_HAVE_MEM{SET,CPY,MOVE}W.  In other
words, the code under #ifdef VT_BUF_HAVE_RW in default scr_mem...w()
instances won't be compiled anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/vt_buffer.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index 919d999a8c1d..b6eeb8cb6070 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -28,45 +28,21 @@
 #ifndef VT_BUF_HAVE_MEMSETW
 static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
 {
-#ifdef VT_BUF_HAVE_RW
-	count /= 2;
-	while (count--)
-		scr_writew(c, s++);
-#else
 	memset16(s, c, count / 2);
-#endif
 }
 #endif
 
 #ifndef VT_BUF_HAVE_MEMCPYW
 static inline void scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
 {
-#ifdef VT_BUF_HAVE_RW
-	count /= 2;
-	while (count--)
-		scr_writew(scr_readw(s++), d++);
-#else
 	memcpy(d, s, count);
-#endif
 }
 #endif
 
 #ifndef VT_BUF_HAVE_MEMMOVEW
 static inline void scr_memmovew(u16 *d, const u16 *s, unsigned int count)
 {
-#ifdef VT_BUF_HAVE_RW
-	if (d < s)
-		scr_memcpyw(d, s, count);
-	else {
-		count /= 2;
-		d += count;
-		s += count;
-		while (count--)
-			scr_writew(scr_readw(--s), --d);
-	}
-#else
 	memmove(d, s, count);
-#endif
 }
 #endif
 
-- 
2.39.5


