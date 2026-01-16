Return-Path: <linux-arch+bounces-15827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01197D2D5BC
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AABB23074A50
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576B334C9AD;
	Fri, 16 Jan 2026 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ciqSo+X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sVjuZmgA"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8E2ED84C;
	Fri, 16 Jan 2026 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549254; cv=none; b=jmmrsgIUsZi69aF8BscLUGhCxvMbQfAq22LK7SzcdiLha4uvcMu0hAxhylGHrxb5FEwSjqhdifUeNNtNUiBURJXQ/WfoVtqgVsNeXmKBjnEzoNZ08/k/oEHZ6OoSqfJ64HhuUBwdRjJMa7LzU5iEhSr6eQYBMET6YiY7nhNLWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549254; c=relaxed/simple;
	bh=jDKXGIaHSXmKwFavO2zuQUucrccQopH1XvLa3LHnaNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GL+deBVcEmKAuQEVANY2CFGBo/TuHqdWJLWY1WDNHqVzZPCa8aDR78p8lMOmNGEFJUK0M1TeLy1tginLEri/s3X5woAmFN/QrSjW69z7j8Iq3tuxabMROn42ap3t4a4W51LPfrcKSsoqYAFoqBd7hQLDHrdWOmbpzLHOOkWWWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ciqSo+X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sVjuZmgA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768549251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=629a2D2m6hH8crJSEFdPQCXMW6yyZzypvSaYKarHFYA=;
	b=0ciqSo+XIEsTWIJz4h0T2A8vUS9TrqoWZ17izTHsY+0TTHAEfmGr/ANh8KIW73aY2GYuCg
	TJRp17I1uCqbLWEF7YGo9nZ7PDVE3U8rHJBcxgYVcW5y9pDQ+2fPusRk6moiNEpB4/QTok
	3JsI5TJvgQH1YEdsKC0LO/9qtpHTHgF9iKiQIHnMIjFY1K+2MRf/7sPKjKTcJ1JLCVyR1Z
	EtQ6FNONqSpaEj1Whl1wV/gKyvbhDFgGzEHQLLz8SvBtadpveaaneZQ5s4Bp2Dg8/TykjJ
	oK/ooUZAWNXwO/i+xhmRJkbohBFJB9woyrqHMDp0mA2j1HrbprE9V3M9rS8z8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768549251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=629a2D2m6hH8crJSEFdPQCXMW6yyZzypvSaYKarHFYA=;
	b=sVjuZmgA0GxBOs66OZZEp1Kxg4iZ8JEySwWF5/DSg8W0EJZYFoQ2ZgXH2qqoASAEWtQ5vx
	olyQoRF7W6DarODA==
Date: Fri, 16 Jan 2026 08:40:26 +0100
Subject: [PATCH 3/4] s390/vdso: Trim includes in linker script
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260116-vdso-compat-checkflags-v1-3-4a83b4fbb0d3@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768549244; l=1076;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jDKXGIaHSXmKwFavO2zuQUucrccQopH1XvLa3LHnaNY=;
 b=HRoll0lE3aGyyzORr3jDwHsehY+oH94EhXQRGkwkbQJq7eIVZ5bcSOSV+M4f/bJKyOL5KWcl0
 hTFq9NFN7SOAGTePGJWTWxUqF4zYKyPfhJPWquEFcPOb2BS7VePGvZ4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some of the included files are unnecessary or too broad.

This is a preparation for a new validation step to validate the
consistency of __BITS_PER_LONG. vdso.lds.S may be preprocessed with a
32-bit compiler, but __BITS_PER_LONG is always 64.

Trim the includes to the necessary ones.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
There are other ways to solve this issue, for example using
KBUILD_CPPFLAGS += -m64.
---
 arch/s390/kernel/vdso/vdso.lds.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
index 7bec4de0e8e0..c8abd00799be 100644
--- a/arch/s390/kernel/vdso/vdso.lds.S
+++ b/arch/s390/kernel/vdso/vdso.lds.S
@@ -4,11 +4,10 @@
  * library
  */
 
-#include <asm/vdso/vsyscall.h>
-#include <asm/page.h>
 #include <asm/vdso.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <vdso/datapage.h>
+#include <vdso/page.h>
 
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
 OUTPUT_ARCH(s390:64-bit)

-- 
2.52.0


