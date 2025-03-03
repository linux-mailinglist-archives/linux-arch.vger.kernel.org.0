Return-Path: <linux-arch+bounces-10505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43E4A4BE08
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F8616A0E9
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5171FDE00;
	Mon,  3 Mar 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhBdyCjx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BMb3X3SY"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF51FC7E5;
	Mon,  3 Mar 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000282; cv=none; b=pqdvL7P5FrTYAlnBw6VQcpWg0UGXtVdk2WDIU4NXXqgM9N8AKt3YhfgJSZDN4ReLCytEZo9zKymBhbZjzdqiFdZu8eZTFrlkKRCC0CsXn0gQ39uXUA11Q1VgckvLWILFFN/RZRIsmvuZQco26uu6pCvZa/NyDTLh6nVqr6jlPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000282; c=relaxed/simple;
	bh=5ltcJb5ck+v1HPJ6+Nhh/UjH+dypvfglC/hoMlP4Jeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lF9A5QXL+yOAKQFnnY81jv/KrPtcCFHRxAaSr0NZwlyq0OTxKPJmcd9R2UZAddlP07jDhIPCWJaK6yDwR0FPHxe6LHiwV9pBgBs7a9/RaFlEYeS3yVGtWdEeFaKTrJHhd5ZIAT73dB+cYbysJxlPi4KpfM6mvSwbNQYaZTuSbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhBdyCjx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BMb3X3SY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgkXR8Ms7wQS05VGAhqJOHjZc2vDa+KQurvhzWf1zv4=;
	b=qhBdyCjxtiKLWvOc1plokn7HfcVzmwf+d4glPAKt3DEO52YztEmLk02vb7L3VZogzU2A+4
	kTs/E5ByKXP8uxQAXoDvY2FzGgDTE/UwbpxuKNixzQm5PoM/G7f8h9l/K3TWY8YtJv6qIE
	6zEkYZnS+jXRTBXgB/usq3SvKKk97lqoryzHUq0M63j6tngeCcCLtVeZAPDdVHBVuKnm+x
	GOK8rRB+IXVgo58Xt7K7XisPKf3Ikmf+bDcbXUTqt709HU9avzv7ceji+wiU9dlaSgDlpC
	rM9eQEz3o52fHaITdsZRgMUYFGF5zkCTogNt5Phtjl5yY1MgwrKjP+SarcanYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgkXR8Ms7wQS05VGAhqJOHjZc2vDa+KQurvhzWf1zv4=;
	b=BMb3X3SY4t1L7AJIV4rv6PFcxHgHInWR8mh99SkR1hwnPPvG4cImQh/oz7XKHSBifrGyMb
	AArbHGlpDvR3nyBg==
Date: Mon, 03 Mar 2025 12:11:20 +0100
Subject: [PATCH 18/19] vdso: Move arch related data before basetime
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-18-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=2232;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+5uVvlPBOccXpBrllKubuXiCPd0eBucGi0zbF33gT3U=;
 b=X+HQHN+N5jVKZbjCjgYkbSkIIE7aQboC/nbk/mfHTATXfKThuTtUk4+181IgylalZLiBJjY7y
 fSrOanqYWacAJNG8ttNOKFyoifVvtbJU3lYM7zULF1yjrqrrAfTAZQe
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

Architecture related vdso data is required in fastpath when acquiring
CLOCK_MONOTONIC or CLOCK_REALTIME. At the moment, this information is
located at the end of the vdso_time_data structure. The whole structure has
to be loaded into cache to be able to access this information.

To minimize the number of required cachelines, the architecture specific
vdso data struct is moved right before the basetime (basetime information
is required anyway). This change does not have an impact on architectures
with CONFIG_ARCH_HAS_VDSO_DATA=n. All other architectures could spare
reading unnecessary cachelines.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/datapage.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 1df22e8bb9b31153546b72b1e8b8c8aeaed7d9e3..bcd19c223783be7c22f90120330e7dddd0496f1a 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -70,6 +70,8 @@ struct vdso_timestamp {
 
 /**
  * struct vdso_time_data - vdso datapage representation
+ * @arch_data:		architecture specific data (optional, defaults
+ *			to an empty struct)
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -83,8 +85,6 @@ struct vdso_timestamp {
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
  * @__unused:		unused
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
  *
  * vdso_time_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
@@ -105,6 +105,8 @@ struct vdso_timestamp {
  * offset must be zero.
  */
 struct vdso_time_data {
+	struct arch_vdso_time_data arch_data;
+
 	u32			seq;
 
 	s32			clock_mode;
@@ -125,8 +127,6 @@ struct vdso_time_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
-
-	struct arch_vdso_time_data arch_data;
 } ____cacheline_aligned;
 
 #define vdso_clock vdso_time_data

-- 
2.48.1


