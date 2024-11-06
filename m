Return-Path: <linux-arch+bounces-8872-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8DE9BDE90
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 07:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D77B23CEA
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D7D191F85;
	Wed,  6 Nov 2024 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FuMgsGfH"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672B190678
	for <linux-arch@vger.kernel.org>; Wed,  6 Nov 2024 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873454; cv=none; b=M/MW7UAPTVU0Dihj6GtV3JmiBr+5mIUR4s1r5QWHReo580r2Z1hgNrjfXOhrIYj92TJtfeav+PfJY8NOtbNnIfbBC7cu85lHBCo3WpYEhmuFf2OqEcVOGE3FvkYiVUHKfnP7aqDkItHFdxrTSDu0h3oOz7tFAy0CbWuJo1dtcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873454; c=relaxed/simple;
	bh=wRmPDf7LjdO/eUWEHnQKr+dXHznXYJlsXOTuv20wx4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhzaWPavsLN6TL6NLqNM3VSsImwitMtdjspCuWr/KdlD0n2MSQ2ZkvRH4HAROrsjEa36L01Gfha5HMQSXHSrzzKRnJxB907Mn7N3JrF1DoWQh9P7+IhNkdIyyVYxdPs6EyUEOXzQOuzN5VB5PypxtbAC/bRUxU8uptuzvIH5qQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FuMgsGfH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YBmmzqQio93ZSMAI0m/FlteC7dfzPIFWbvyYXjrk9AE=; b=FuMgsGfHXIfZw7I/bj5pdIrfZ/
	4oWGFQKLUVgos+oUoJqTqDj5vw0SqSE5nA8hf34mvu6KTHbA9pH5QUD+tQY2Mnz/wI8J1KWDxj5Gw
	kTjiF6+BpxsAWtqaUebTal3QzPN0cHnhBBKw8iQs+iHNM5cDDbDLpSYeqjt3GaLG1ZsigxsmH39AS
	O4Jx8bnEAlPV/lkq1IEtPvXPxuDcbIosX1ey6sM20SUuO/mR8UNnO2PufyVM+TR3/4yMfkGE/MhNa
	Pw3vctYOnHuqdaLyYDCazNHSPd91RYt3dPTKkqcy3LsDFEkXtvwmH6En2lQCiDCKNk0KM7QfrD9eH
	7tXwOhUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZFi-0000000BX3u-2Vlx;
	Wed, 06 Nov 2024 06:10:50 +0000
Date: Wed, 6 Nov 2024 06:10:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/4] asm/vga.h: don't bother with scr_mem{cpy,move}v() unless
 we need to
Message-ID: <20241106061050.GB2748615@ZenIV>
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

... if they are identical to fallbacks, just leave them alone.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/include/asm/vga.h    |  4 ----
 arch/powerpc/include/asm/vga.h |  5 -----
 arch/sparc/include/asm/vga.h   | 16 ----------------
 3 files changed, 25 deletions(-)

diff --git a/arch/mips/include/asm/vga.h b/arch/mips/include/asm/vga.h
index 0136e0366698..491c2b5aeb81 100644
--- a/arch/mips/include/asm/vga.h
+++ b/arch/mips/include/asm/vga.h
@@ -47,10 +47,6 @@ static inline void scr_memsetw(u16 *s, u16 v, unsigned int count)
 	memset16(s, cpu_to_le16(v), count / 2);
 }
 
-#define scr_memcpyw(d, s, c) memcpy(d, s, c)
-#define scr_memmovew(d, s, c) memmove(d, s, c)
-#define VT_BUF_HAVE_MEMCPYW
-#define VT_BUF_HAVE_MEMMOVEW
 #define VT_BUF_HAVE_MEMSETW
 
 #endif /* _ASM_VGA_H */
diff --git a/arch/powerpc/include/asm/vga.h b/arch/powerpc/include/asm/vga.h
index fcf721682a71..f2dc40e1c52a 100644
--- a/arch/powerpc/include/asm/vga.h
+++ b/arch/powerpc/include/asm/vga.h
@@ -40,11 +40,6 @@ static inline void scr_memsetw(u16 *s, u16 v, unsigned int n)
 	memset16(s, cpu_to_le16(v), n / 2);
 }
 
-#define VT_BUF_HAVE_MEMCPYW
-#define VT_BUF_HAVE_MEMMOVEW
-#define scr_memcpyw	memcpy
-#define scr_memmovew	memmove
-
 #endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
 
 #ifdef __powerpc64__
diff --git a/arch/sparc/include/asm/vga.h b/arch/sparc/include/asm/vga.h
index 2952d667d936..cc2bc60b4c8b 100644
--- a/arch/sparc/include/asm/vga.h
+++ b/arch/sparc/include/asm/vga.h
@@ -14,8 +14,6 @@
 
 #define VT_BUF_HAVE_RW
 #define VT_BUF_HAVE_MEMSETW
-#define VT_BUF_HAVE_MEMCPYW
-#define VT_BUF_HAVE_MEMMOVEW
 
 #undef scr_writew
 #undef scr_readw
@@ -41,20 +39,6 @@ static inline void scr_memsetw(u16 *p, u16 v, unsigned int n)
 	memset16(p, cpu_to_le16(v), n / 2);
 }
 
-static inline void scr_memcpyw(u16 *d, u16 *s, unsigned int n)
-{
-	BUG_ON((long) d >= 0);
-
-	memcpy(d, s, n);
-}
-
-static inline void scr_memmovew(u16 *d, u16 *s, unsigned int n)
-{
-	BUG_ON((long) d >= 0);
-
-	memmove(d, s, n);
-}
-
 #define VGA_MAP_MEM(x,s) (x)
 
 #endif
-- 
2.39.5


