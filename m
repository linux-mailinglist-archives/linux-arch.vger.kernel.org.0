Return-Path: <linux-arch+bounces-15828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D485D2D58F
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 363D23016AAD
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A234E751;
	Fri, 16 Jan 2026 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wN3Jic61";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wv82rY5o"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881933469D;
	Fri, 16 Jan 2026 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549255; cv=none; b=dPQ6NIEbOAEFT8+7GimBj0Izbz3i2Y4FLaXapqMBznpQUXYXewlRB7Vu/VqUxrtGuYwf5EBSnA+7D03cGUXTOdy3767hnaSm3MjCj3BU88SYPbXD2yuNCKKoewWmbXLGDM8f+I03/seVK2jb8sk5sSjWvVbrZiQZnAEFCmBbDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549255; c=relaxed/simple;
	bh=ZMUlth+kblN6NPXVUxOuSxnHAh5gAYx5wUWTtZVX5/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5q228vUk+C0lp5/G8+dxbg/gldkl919MB5OFQJiZNFAcx9sc+FKNNFlSaCHxGHb92gNF04QTGnWuLfYRHV4Tbx8YnU0UNmdp3HdEfZnUfhV+pfr+rRw51t+1iJGYKGzedKf4gbvs1jenTP6NUnJWT1o2UUt0R7na5JCUkkA6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wN3Jic61; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wv82rY5o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768549252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evDbMYS0g9UrvxuAXCAO/jHj3NYMiqhUUYHBfAdf3yA=;
	b=wN3Jic61NGPYHNyWsMPqfPU72UywCPHzh9QApGZD06eQ1SxXGb+aXvXlpYWsNIb/B/N9ax
	LkNRVYbomjwimT0Mm6DIGsgo3R7LKGW4UCXyL5VjSvPgcj9wvofyGmLuRj4nfk2Be8QYzB
	8rpQbhwdWNuNAoD4aWDlhczl847ac7NdcY55fywbHr8D1DECHWwN41EyqX3+0QYwRdbRyF
	mP8fvkmcokcZKZecUoCDsw2AiePyh+U2/UCPnzSSTeRsNenI0Elf3GnTic//zbUPYF4/H1
	m0DsXK1wxQXhtWQJ9S+Neh6ouIcPbvWpg1uNTHEuS7PCc8Dc2jmWD2YMZNSgWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768549252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evDbMYS0g9UrvxuAXCAO/jHj3NYMiqhUUYHBfAdf3yA=;
	b=Wv82rY5o7SKFGl2O1nq3RgAyVyi0ygj52Yhp8GGQwgaCEkIOxU533vwn6bXP6+XgyU4sZe
	DXG48CATI+9nMuAg==
Date: Fri, 16 Jan 2026 08:40:27 +0100
Subject: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
In-Reply-To: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768549244; l=1835;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZMUlth+kblN6NPXVUxOuSxnHAh5gAYx5wUWTtZVX5/E=;
 b=tG4PmK71uCx9cB0GXt050Qh4ar45wzLJrIEQq+bWRKq0qaioB2MenSYHXMJUcSA4vkDcrvRco
 qCcYPcs2eWnABNpMn3LYMImPjtMul73ZE/LwPs86N+3OuVUx2bdkohX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The value of __BITS_PER_LONG from architecture-specific logic should
always match the generic one if that is available. It should also match
the actual C type 'long'.

Mismatches can happen for example when building the compat vDSO. Either
during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
when mismatched CHECKFLAGS are inherited from the kernel build.

Add some consistency checks which detect such issues early and clearly.
The tests are added to the UAPI header to make sure it is also used when
building the vDSO as that is not supposed to use regular kernel headers.

The kernel-interal BITS_PER_LONG is not checked as it is derived from
CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
deactivated check in include/asm-generic/bitsperlong.h.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
index fadb3f857f28..9d762097ae0c 100644
--- a/include/uapi/asm-generic/bitsperlong.h
+++ b/include/uapi/asm-generic/bitsperlong.h
@@ -28,4 +28,18 @@
 #define __BITS_PER_LONG_LONG 64
 #endif
 
+/* Consistency checks */
+#ifdef __KERNEL__
+#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
+#if __BITS_PER_LONG != (__CHAR_BIT__ * __SIZEOF_LONG__)
+#error Inconsistent word size. Check uapi/asm/bitsperlong.h
+#endif
+#endif
+
+#ifndef __ASSEMBLER__
+_Static_assert(sizeof(long) * 8 == __BITS_PER_LONG,
+	       "Inconsistent word size. Check uapi/asm/bitsperlong.h");
+#endif
+#endif /* __KERNEL__ */
+
 #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */

-- 
2.52.0


