Return-Path: <linux-arch+bounces-15826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 098AED2D584
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17345302E3F0
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA06B34253A;
	Fri, 16 Jan 2026 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NVgWoqCk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9SA5UQ28"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247A2EB87B;
	Fri, 16 Jan 2026 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549253; cv=none; b=c2losmR5gePv8ca9oyiB0sVEmHVwOJvv1LJm9nFXboxmTStA77hWlZtCtHNtrPgdCVwLFiZ7/qkWzOoImO/JQslYF/kF5BSjVZ/snMLbvSfWdmTK+bfP1Ox8IsYB3OFaRAUxaUCfBqW5hrt7C/QNsOpd3TUtqeajRH48Rt4KkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549253; c=relaxed/simple;
	bh=lqXvxP+gCfaptsVzNWLlgWlWjUdHwQ8wW8T0HKnCg3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7DMZT0hn17SfNM96dPtes9I50uvI6rn88g7O0m4IJ/crZBWz34jU/kjUhPGIgm+5rqhnvodHGq+arncivbFZDv0SypkRKRkZnfqffiqARM/QLGI+Wh6EX6rnzuAsL69IQB2IyCDG0QQA49OflCf5NFZQ4hb3UvoHS6z0dvYbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NVgWoqCk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9SA5UQ28; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768549251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3kzEEwBQs6AOSErqsf9I2P8aQVakryJpsMKuhd3a5c=;
	b=NVgWoqCk5HZazPDGJmNUMLRc9EO6EbSC9nS/7PGhVmMfAxSHJrk3K1rx3lOSoLeICHrKOp
	xPemFewG91xl0X6Jg+qHq3owIdr7UOA6CLP6tad0bN9uzxitabNDZcPzvyu7nOx4nC0k/k
	VsrTJqBjm75PO3nwn1Pu855A3vUS8wNoSK214SmKbflWnnWAtTq1s87xv4ulAyTDAET793
	b0v52bKFmD5HigGJGzNYT+BNgh5jiYtsY16SPGS3pof0r8Bek/g626H8nkE8jQapQKw1OG
	h0mO9HpXwGVfMVi+PznXYttjQrS11M7oO4u8HgJJ5eBJoqleL77E0hv6o/KTxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768549251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3kzEEwBQs6AOSErqsf9I2P8aQVakryJpsMKuhd3a5c=;
	b=9SA5UQ28WjshB0EWN+0u855HS3n06VYZlRvxU7ZqhrtxYi7UA1iy61kXFKpTxpL3YvmylQ
	KGcZDVC50W8f0YAg==
Date: Fri, 16 Jan 2026 08:40:25 +0100
Subject: [PATCH 2/4] x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Sun Jian <sun.jian.kdev@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768549244; l=1162;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lqXvxP+gCfaptsVzNWLlgWlWjUdHwQ8wW8T0HKnCg3s=;
 b=2vBvZqq+rjB7qvEWCRHzJ7kyBYkI8/FqHuqMN9zTJBwaQ6ZRIB+VoeIrntiXvyH2nZrpn+K6J
 ZaMl64/uVZ9AumbXz2NR6vZWNpILR4EW9qXZrIkK+WDnZBEa8EBF7HM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
are used. These are combined with the 32-bit CFLAGS. This confuses
sparse, producing false-positive warnings or potentially missing
real issues.

Manually override the CHECKFLAGS for the compat vDSO with the correct
32-bit configuration.

Reported-by: Sun Jian <sun.jian.kdev@gmail.com>
Closes: https://lore.kernel.org/lkml/20260114084529.1676356-1-sun.jian.kdev@gmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index f247f5f5cb44..ab571ad9b9ac 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -142,7 +142,10 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
+CHECKFLAGS_32 := $(CHECKFLAGS) -U__x86_64__ -D__i386__ -m32
+
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
+$(obj)/vdso32.so.dbg: CHECKFLAGS = $(CHECKFLAGS_32)
 
 $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso_and_check)

-- 
2.52.0


