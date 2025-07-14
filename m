Return-Path: <linux-arch+bounces-12758-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F027BB04A2D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EC74A1381
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E962797AF;
	Mon, 14 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g03Sv0/3"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92757269CE8;
	Mon, 14 Jul 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531350; cv=none; b=D/iXQtFlIf+jScUHsmxv1K+G48c4E8XEm2KBSbnBDUhkz++OcYAvulXiFBj79KfZuC0pcWYBxZJm85Ix5kVuUzwq6esteYVuREIhjcCCiYdgA102PuVhiISAAwkmxPnpEmIBGuhF7QdRQuegYP8/W6bXcCGwoEKbxJYACJE2gAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531350; c=relaxed/simple;
	bh=vpFbeaUJfpR1IiORx7GUhHCnaglF4Old7yjW4KUTkcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm6TtJQesvIb22mmijBTLJWhtMzPwhj+yhdDjtM5VuBM0pemQ7e2QtjLqt5624BRmqcGFeF0Ke+tvYexfSwr8ThiGTI7crz45ofzDm8fNnOaYCP6TOznoybHEq6fmn/oS7Ug0kx0RgunNuIC0F9iM+sQn10IDJ3GVo4QSszQ6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g03Sv0/3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0BF332016580;
	Mon, 14 Jul 2025 15:15:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0BF332016580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531348;
	bh=Dd110x/i0AygnNthp2uprww/BsLAD70bjtAflO6nwyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g03Sv0/3uqPRINoVW/B+4iS9ql7YAbhiAfO8+BHedN3Z2EovnWsc9kkoonlwZn/V7
	 6IClbgjd8NVhU+lXngdUbVovF+VuHu8oBW7gb0yVvCcgJk8GqL9NeQeZox59lrqCFa
	 eXTlzeCxOYPQtwqGnMJjtYqMsWqO0PnsSsSiMT4k=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mhklinux@outlook.com,
	mingo@redhat.com,
	rdunlap@infradead.org,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 04/16] arch/x86: mshyperv: Trap on access for some synthetic MSRs
Date: Mon, 14 Jul 2025 15:15:33 -0700
Message-ID: <20250714221545.5615-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714221545.5615-1-romank@linux.microsoft.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hv_set_non_nested_msr() has special handling for SINT MSRs
when a paravisor is present. In addition to updating the MSR on the
host, the mirror MSR in the paravisor is updated, including with the
proxy bit. But with Confidential VMBus, the proxy bit must not be
used, so add a special case to skip it.

Update the hv_set_non_nested_msr() function as well as
vmbus_signal_eom() to trap on access for some synthetic MSRs.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 07c60231d0d8..6c5a0a779c02 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -28,6 +28,7 @@
 #include <asm/apic.h>
 #include <asm/timer.h>
 #include <asm/reboot.h>
+#include <asm/msr.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/msr.h>
@@ -79,13 +80,21 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
 void hv_set_non_nested_msr(unsigned int reg, u64 value)
 {
 	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
+		/* The hypervisor will get the intercept. */
 		hv_ivm_msr_write(reg, value);
 
-		/* Write proxy bit via wrmsl instruction */
-		if (hv_is_sint_msr(reg))
-			wrmsrq(reg, value | 1 << 20);
+		if (hv_is_sint_msr(reg)) {
+			/*
+			 * Write proxy bit in the case of non-confidential VMBus.
+			 * Using wrmsrq instruction so the following goes to the paravisor.
+			 */
+			u32 proxy = vmbus_is_confidential() ? 0 : 1;
+
+			value |= (proxy << 20);
+			native_wrmsrq(reg, value);
+		}
 	} else {
-		wrmsrq(reg, value);
+		native_wrmsrq(reg, value);
 	}
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
-- 
2.43.0


