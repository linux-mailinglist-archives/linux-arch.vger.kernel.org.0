Return-Path: <linux-arch+bounces-15825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BAED2D575
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54D2130365B7
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A815261B98;
	Fri, 16 Jan 2026 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BXgnMOdN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wrdQk5I9"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B52E03EA;
	Fri, 16 Jan 2026 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549253; cv=none; b=JUzntmsXQXzy/Nfkwy4orKsAYNoWCpnNN/aTQ9ft2TcDCPdMnNz+tn1y0akOVVmOegxVnJZRSWIeswIlyUUb2G7zf0YO/o8MjdShX+c/V4dcuYfntIKshXYY82uiKuFf2RUPcb7gXMEIcquHVl4j73sLDaKap3+azzKmX/VUS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549253; c=relaxed/simple;
	bh=7teLdiabr9gzZFxBT7yVIs+xm2LR+TxpwbFKw+jdnMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjbbBAGWcB3qrS7RAhmSa1TjLW4EvLD1WpttdpF7cy350WMpye/Njg28olQMFz2nwgDjoigu+esDnic1+yGYiI1zr8J7m3XhScdu1ZFf4yZCHPyekzkUca0v/n6eR6WV22aUPfxclXxYxMDHMIZ6HAkCmzqI+DFZ/w+hoo3t5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BXgnMOdN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wrdQk5I9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768549250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGlcXRYVBwExM0rRQdy6sucMiGtLR0ho2JhjSoimGCA=;
	b=BXgnMOdN3l9jc59a9PBJ1BoA9MW1BpgySWr09Uw+HCmurprL7Oruyt6EHOD4u0b1KTScbM
	LSOcien52VWAr4xSUhBFlsIaZ2fBU6hirkG/HP11kdXi6TSu8EIhUFyOffu7Cx6nI9oIAy
	wWARItgIcT6orlNKffa4kNwol2OEwzGgxH6JEGvlYbzoNz/JQrMHP+PzI+lQ8sYah6pdrH
	XfQ10Lxn8keQYrnecJhs0842Lfcs2quRLzOvdvlKbxEpf4Kd5Nhx/JW0ACQSG6cee5sMAX
	/4uXH9FJ8e0Pqfp8qj72u1ULkUd27kSwRui8WU0hQDeRGwI2OcG3lfztun3W6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768549250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGlcXRYVBwExM0rRQdy6sucMiGtLR0ho2JhjSoimGCA=;
	b=wrdQk5I9bnKTvYheXpWDYN1R5f8N+BhbQdqYBmzxtIFB+cHkpkP9zmUbkuFCbyQ4LurL4+
	e1bAdWzXtetkO1AQ==
Date: Fri, 16 Jan 2026 08:40:24 +0100
Subject: [PATCH 1/4] sparc64: vdso: Use 32-bit CHECKFLAGS for compat vDSO
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260116-vdso-compat-checkflags-v1-1-4a83b4fbb0d3@linutronix.de>
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
 kernel test robot <lkp@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768549244; l=1394;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=7teLdiabr9gzZFxBT7yVIs+xm2LR+TxpwbFKw+jdnMQ=;
 b=TqIQrqyBly5afX0eQk3+j16jTKkGeKkqE8As+HS8Q0nOgHv1xwdMKphg2R2xoi5V0pR8m4hoH
 7glHPBHxJZwC3sagFe926hfBk/np1GUUls+nkgHZtnDlm1Jq9Vo6qNm
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
are used. These are combined with the 32-bit CFLAGS. This confuses
sparse, producing false-positive warnings or potentially missing
real issues.

Manually override the CHECKFLAGS for the compat vDSO with the correct
32-bit configuration.

Reported-by: From: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202511030021.9v1mIgts-lkp@intel.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
The actual false-positive is only reported when SPARC is converted over
to the generic vDSO library. However the issue is already present.
To avoid dependencies between different patch queues, I have this patch
in this one.
---
 arch/sparc/vdso/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 13f1d7be00f1..945d917b0058 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -90,6 +90,9 @@ KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS_32 += -mv8plus
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
+CHECKFLAGS_32 := $(CHECKFLAGS) -U__sparc_v9__ -U__arch64__ -m32
+$(obj)/vdso32.so.dbg: CHECKFLAGS = $(CHECKFLAGS_32)
+
 $(obj)/vdso32.so.dbg: FORCE \
 			$(obj)/vdso32/vdso32.lds \
 			$(obj)/vdso32/vclock_gettime.o \

-- 
2.52.0


