Return-Path: <linux-arch+bounces-8873-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D99BDE94
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 07:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA381C23278
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0FC1922D8;
	Wed,  6 Nov 2024 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sedTJrYO"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED591191F99
	for <linux-arch@vger.kernel.org>; Wed,  6 Nov 2024 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873483; cv=none; b=uIVpRM36z3TmxzjY9m0sVaDBcAuAxqZoAfh9cp2tQuPV9aGxf6XjbZuk1PsQTlXRaFdrYasofR6gH5pGg0Ye5AJ6EO2R8KFKg+lspnYOos8b/40G6Sh8J5eDU88ey/5CFivTpg7wvpx994dSqWq96hEiaPf6fujP7d2rTgsUAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873483; c=relaxed/simple;
	bh=8RhXQ7RwjQjSEYu+rolOJvEdz+851uha1H5TwyDD3Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjtFfvQjPi6dIcVKLn+h7x7D9wXQpYDJJDhFp4YzsZNyjROCzgJ0dRBAN/GzC7qvfV8sUdBIxv7tLh3kfsEOKu3OK+jiuinGNjh3fEFYQym8DWql9p3fSvwvyBTgFmX/oJMB2BI5k9wJ+xyxBtgTKax/+LRHxbq2fXfJzqQJzDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sedTJrYO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n0w2dzNk4JLokroiuk2U8/IGaJrR6QakvF0pQZasf2w=; b=sedTJrYOThlzqNbU5I0MKQ36bR
	zkw0wW9xqD5PTdnxTEtWB7uU+AJX9FhAtfvv533itVYwVh1cc4uRbFqf+rzr4XWP1uHMgO0FxrTWV
	dRoPBgEYNXmBdoIheXWXRk6RueE51I3tkaUPuTH4HvMVH0ullePuzimykoDqgVL0AbaT9ZiU8IIXi
	tNkqXc1NQyKX5yuomC1f/Op078gt2RzwcKdh5pWTqeYuEGP0570TEQslniqibE42LTEfoeGwibP+q
	j1966UvE3cYavjigpnXh+OT3UeyHqHDCTa1u4L1hs4ObUCM7zmdmchXLJ6t47WUxONcIOr7lS1KuF
	5WDUY46A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZGB-0000000BX4W-15IG;
	Wed, 06 Nov 2024 06:11:19 +0000
Date: Wed, 6 Nov 2024 06:11:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/4] sparc: get rid of asm/vga.h
Message-ID: <20241106061119.GC2748615@ZenIV>
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

The only thing we are using it for on sparc is telling vt_buffer.h
to pick what it would pick by default anyway - we are not accessing
any VRAM here...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/vga.h | 44 ------------------------------------
 1 file changed, 44 deletions(-)
 delete mode 100644 arch/sparc/include/asm/vga.h

diff --git a/arch/sparc/include/asm/vga.h b/arch/sparc/include/asm/vga.h
deleted file mode 100644
index cc2bc60b4c8b..000000000000
--- a/arch/sparc/include/asm/vga.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *	Access to VGA videoram
- *
- *	(c) 1998 Martin Mares <mj@ucw.cz>
- */
-
-#ifndef _LINUX_ASM_VGA_H_
-#define _LINUX_ASM_VGA_H_
-
-#include <linux/bug.h>
-#include <linux/string.h>
-#include <asm/types.h>
-
-#define VT_BUF_HAVE_RW
-#define VT_BUF_HAVE_MEMSETW
-
-#undef scr_writew
-#undef scr_readw
-
-static inline void scr_writew(u16 val, u16 *addr)
-{
-	BUG_ON((long) addr >= 0);
-
-	*addr = val;
-}
-
-static inline u16 scr_readw(const u16 *addr)
-{
-	BUG_ON((long) addr >= 0);
-
-	return *addr;
-}
-
-static inline void scr_memsetw(u16 *p, u16 v, unsigned int n)
-{
-	BUG_ON((long) p >= 0);
-
-	memset16(p, cpu_to_le16(v), n / 2);
-}
-
-#define VGA_MAP_MEM(x,s) (x)
-
-#endif
-- 
2.39.5


