Return-Path: <linux-arch+bounces-8874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A12939BDE95
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 07:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D331F23325
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00602191F85;
	Wed,  6 Nov 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b4qer9j6"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861541EA84
	for <linux-arch@vger.kernel.org>; Wed,  6 Nov 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873510; cv=none; b=Bd/IGbXJEBanORwECV7y+zO+KcGxM1r5sPle4bNb3Vrs7oM+FSfjrcpMm72f5EkYKu59Q5BFeyZtH8LvChu58icYw5oGPqmIW/oy3qNZY1lLI1kOr57MXYvekVppJ7BpaI7WLF3+95hSyaLMDpIjH6QJYSrw6aV8RL+9tCQSIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873510; c=relaxed/simple;
	bh=CMkqMnapc36HI4K/FMD0ccov8hYvfddAfqM70RqV9fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzCBkCZ31KR+cVg+yWgX5W9WZvulhb3tbUZhMFhQkQBH8hcCwdBojRzjh1YBL71wcl+Kb8fiCXqYflO2ZAHscDHsp35bGHYG+UwhWs0sp/mfTR9CMaVGvNghaspy/OfK6wA0FZ487M6am9UNDtWq2G09+yo90TcDFo2FihK1pBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=b4qer9j6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GXuHdFyhVpLiu5d+jjIwT1IRiTAs57iNN5U36TEHZBQ=; b=b4qer9j6BcLXLveT54SrHtnX3k
	BLHFX6VNP+d+9YM5xqp2n+akUFu5tlxIBjl+eDB2EqgFHxM3b9cHFRVnSiprCkR7uGrhlZGBCX5CK
	7YymjasCb9ykrl7KDEjHz3hgCo7XXJm9x+S8HY+iA+A9mF8jL9WRWVc8NLxkY5qRoncD/G6VurXRE
	wBJ6DCEPkTRRfRNy2FI+GArdGYymvoYMrbBNa+iEozOLg6RU3SLGMIyaHGco8waxMZl9xphSnxWvr
	oSK6rVe6gUxM9YHZkfIdbBibY1tGTEYOe0ZSf0hLZDar7xG+VcSwNRrfWbFNZ5IfmdV4oMatM3Yi7
	7exkCczg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZGd-0000000BX57-06T9;
	Wed, 06 Nov 2024 06:11:47 +0000
Date: Wed, 6 Nov 2024 06:11:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: empty include/asm-generic/vga.h
Message-ID: <20241106061147.GD2748615@ZenIV>
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

all places that use anything defined in it (vgacon, mdacon and
vga16fb) are built only on architectures that have all that
stuff in their native asm/vga.h

allows to kill stub asm/vga.h on sh, while we are at it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sh/include/asm/vga.h |  7 -------
 include/asm-generic/vga.h | 23 +----------------------
 2 files changed, 1 insertion(+), 29 deletions(-)
 delete mode 100644 arch/sh/include/asm/vga.h

diff --git a/arch/sh/include/asm/vga.h b/arch/sh/include/asm/vga.h
deleted file mode 100644
index 089fbdc6c0b1..000000000000
--- a/arch/sh/include/asm/vga.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_VGA_H
-#define __ASM_SH_VGA_H
-
-/* Stupid drivers. */
-
-#endif /* __ASM_SH_VGA_H */
diff --git a/include/asm-generic/vga.h b/include/asm-generic/vga.h
index adf91a783b5c..5dcaf4ae904a 100644
--- a/include/asm-generic/vga.h
+++ b/include/asm-generic/vga.h
@@ -1,25 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- *	Access to VGA videoram
- *
- *	(c) 1998 Martin Mares <mj@ucw.cz>
- */
 #ifndef __ASM_GENERIC_VGA_H
 #define __ASM_GENERIC_VGA_H
-
-/*
- *	On most architectures that support VGA, we can just
- *	recalculate addresses and then access the videoram
- *	directly without any black magic.
- *
- *	Everyone else needs to ioremap the address and use
- *	proper I/O accesses.
- */
-#ifndef VGA_MAP_MEM
-#define VGA_MAP_MEM(x, s) (unsigned long)phys_to_virt(x)
-#endif
-
-#define vga_readb(x) (*(x))
-#define vga_writeb(x, y) (*(y) = (x))
-
-#endif /* _ASM_GENERIC_VGA_H */
+#endif /* __ASM_GENERIC_VGA_H */
-- 
2.39.5


