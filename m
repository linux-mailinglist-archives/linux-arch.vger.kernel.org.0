Return-Path: <linux-arch+bounces-13937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114BFBBFB4F
	for <lists+linux-arch@lfdr.de>; Tue, 07 Oct 2025 00:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14F43C0268
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 22:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4694420010A;
	Mon,  6 Oct 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bN0VxL1R"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D744613AF2;
	Mon,  6 Oct 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790537; cv=none; b=Pd0e3J0ftp/zvZHGaa8thTlNB/xSAAPe45oUCFqkY996uR9X8/SyFHM/7GL7nexortLJw5j0PJVs1mp+aGe+wDfzUlzZoHYLK7iLZSK+b0Qkv3Pwz05FCzZ4Il0KEiQmQfUBCiQIDn23rb7MZyuIArWoXOivCSnip8hpTYn8gHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790537; c=relaxed/simple;
	bh=S2seYnSBWNpUZZfe1+SRlqlrUngJ9CIbdmWjkV9Ucqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0skLf8Y9hxw1thZl+jwty7NBwKOfpYt02bfT7hdRZfEigtLGlsI05JwjqQJz26twRe9mmQfK6rM7b98AqwSGII+yXJjS60mLa+mcWmxArHtnzLB1rLRTBuCwDl8px1slp7ixwfgOOEoFDV1KNFAkqlu2P+xVzRLsIotuGO7NS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bN0VxL1R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id D60AC211CDE5;
	Mon,  6 Oct 2025 15:42:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D60AC211CDE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759790535;
	bh=GPke4Hp9X16mRfC52IJ74wQ9iqM8BxN3GRbqd3x/cU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bN0VxL1RwCjo04fIkG18we1sograwR1sEpujqz+Tbed3uo9rCRlNG0wmL6d1D1IYX
	 FUyu8fTsIfiZLnllTSPpl3IdmxkpEYSi07420L3xpFGkDWjOSHbATE0FkX6pjRmKxL
	 Op+kLyBJxWZTWzUb7Av+25IwGMuOaNkOTui+y2LU=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Subject: [PATCH v3 1/6] x86/hyperv: Rename guest crash shutdown function
Date: Mon,  6 Oct 2025 15:42:03 -0700
Message-Id: <20251006224208.1060990-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename hv_machine_crash_shutdown to more appropriate
hv_guest_crash_shutdown and make it applicable to guests only. This
in preparation for the subsequent hypervisor root crash support
patches.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 25773af116bc..1c6ec9b6107f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -219,7 +219,7 @@ static void hv_machine_shutdown(void)
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_CRASH_DUMP
-static void hv_machine_crash_shutdown(struct pt_regs *regs)
+static void hv_guest_crash_shutdown(struct pt_regs *regs)
 {
 	if (hv_crash_handler)
 		hv_crash_handler(regs);
@@ -562,7 +562,8 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.shutdown = hv_machine_shutdown;
 #endif
 #if defined(CONFIG_CRASH_DUMP)
-	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
+	if (!hv_root_partition())
+		machine_ops.crash_shutdown = hv_guest_crash_shutdown;
 #endif
 #endif
 	/*
-- 
2.36.1.vfs.0.0


