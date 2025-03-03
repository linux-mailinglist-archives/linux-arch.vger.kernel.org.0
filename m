Return-Path: <linux-arch+bounces-10490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3DCA4BE0D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B1A3BE823
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBCD1F4282;
	Mon,  3 Mar 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gxa5GXG1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xuensp3P"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AF1F1908;
	Mon,  3 Mar 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000274; cv=none; b=lWuOgypqMg5kwUw/AwaM9Ub2WM7Tts8/1kdADELro68RdHXf75aJxz0w41bFkGoWTwjMifai5udvdeaF7FPofDz8bMMvn3Kd4BDnC2t2+7/4Nsg2ODYb0t5bOml1uHWvsCKgSX44i2NYGTJXvgk6Rj6WHiM3i62qsO/563tOyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000274; c=relaxed/simple;
	bh=dLiHrDonqH1928MyPpR3YqNz3bmJPKr1P6UdvUoWJjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IccPy3fUu4zhRmmOngYkt47pfLsLL3KwsxVShmf5NVn3SykBTblqIXrpDx5gEdrxkcJHqhPJ8Pz0BGD6T2BeQvormW/2MiW0Lbe8D0uZTgZcDNDueAhxK3z7xILjeMJ+SdxA1gYeeBHHkJfmJs8XSkWWW3a3BwbrYpwXZMgqLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gxa5GXG1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuensp3P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xj+izrhaOcxy+xihfquH+xNLp8A7/ytMiHjX9X2ba9M=;
	b=Gxa5GXG1996oaCjjYl/Z6sgMF1KOjoNvxpBXX6w6eKXnxd6/0bfYOFDRsivWanOVtA+9ZS
	BBwK+7G458P2Js+w8bvhlXENVl5k+2TIZXozC+NmmvNazvxFNgIk+1zOETFD/uugMTBBNl
	B8Sxwq3Z+dwoi4PBPaC/yr+sruV7ytzkG44m5fG7jEU76o6VjSPGkYFLJb2OWiTIlwv5bp
	vY2yEkOXk8/iMBBnMHPoYEDip2ucsdf/Q8NEoc8VK8ZY63A+XBuuQjmxEw5Gj+HK0Ha3WU
	ky3nR1pqfPdC4avJQxL3yuhN/Pg3YEKdEWmHhSG6XD/KJ37oGU+Pi0rsHxUxfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xj+izrhaOcxy+xihfquH+xNLp8A7/ytMiHjX9X2ba9M=;
	b=xuensp3Pa9Pm0DfWFv6ec0Nb8Q78eETUCr5ghIogZLmzP2K+5tv9Q5qn7Km2/eZ0HMuvAZ
	V25m6gork9ijLVAQ==
Date: Mon, 03 Mar 2025 12:11:05 +0100
Subject: [PATCH 03/19] vdso: Make vdso_time_data cacheline aligned
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-3-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
In-Reply-To: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=1329;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+SD6yGnIFUmAVcH8siXM+pCjZMZm4i05faOszoaQfnQ=;
 b=3rnVtk2piKjEr1OX2HGOUwEZO6XTwkuvMBS8Th4Zl1Fyez4RcpeNoVQ+iQsPawv+KjUBtwrnC
 bR+EZ/DXucmA32/wVjS994HjsSLCu3iMbAMPCOkUa8SH8VgkE3QrxuF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

vdso_time_data is not cacheline aligned at the moment. When instantiating
an array, the start of the second array member is not cache line aligned.
This increases the number of the required cache lines which needs to be
read when handling e.g. CLOCK_MONOTONIC_RAW, because the data spawns an
extra cache line if the previous data does not end at a cache line
boundary.

Therefore make struct vdso_time_data cacheline aligned.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/datapage.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index ed4fb4c06e3ee6423fe68ccb476565213f234863..dfd98f969f151eca3c551c3e90f69af9ee8f22bb 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -11,6 +11,7 @@
 
 #include <vdso/align.h>
 #include <vdso/bits.h>
+#include <vdso/cache.h>
 #include <vdso/clocksource.h>
 #include <vdso/ktime.h>
 #include <vdso/limits.h>
@@ -126,7 +127,7 @@ struct vdso_time_data {
 	u32			__unused;
 
 	struct arch_vdso_time_data arch_data;
-};
+} ____cacheline_aligned;
 
 /**
  * struct vdso_rng_data - vdso RNG state information

-- 
2.48.1


