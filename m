Return-Path: <linux-arch+bounces-13739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C76B9798D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 23:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D141AE051D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C830CDBA;
	Tue, 23 Sep 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RGtnmFg/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A0252900;
	Tue, 23 Sep 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663982; cv=none; b=VBptWIsbrjS5KqEwsxvKj0LQgbV4SL8vnIvklhGcaOUCtonL5i5ceSvLuaMWajSeXA0ZOwvdxRmOnZcW/hyJL/Vxz1rlpH3KT2bAozAzkJ0jfVt0YoFKPPThc7bvTkRaC23lqMJi3WcHnvx8XXKEQB1ufm6cGeljoCzDjp5XiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663982; c=relaxed/simple;
	bh=dr/Q1R6Sn+NyHksBWDSvfG6vvZgaRg3D12hynJ+ENu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AhV0RRl5lSyCqR6YAKudZ8vLMp4nMuLiO0piK9Z4tl8/lzXNns3JsiZO5qrYXPHzK4xMMUFgTZU8FwdfnQ6X9dRmLEc8FNOAoIHNfDX3umviO3DlNYHlxdjDbWZiC4PtqnLtgP+Pg6jeVzSgzl5LbbjXkZLdLHfkL86sa9kFA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RGtnmFg/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id D0F562018E4C;
	Tue, 23 Sep 2025 14:46:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0F562018E4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758663980;
	bh=Xm2o4yAUkdFB50MsmJ1IE0HmIZbMwVma/u6kOisVDyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGtnmFg/JEqvoa1aq0CipJQ6esdLIPIV71r5fn3N5ApvxvQsANiQ/1lQgSEQygbRA
	 9zH/qfDYWk9Z04NCGkC7rcMQNVHhFLIr/8t4wccOff3cGMbUS7kVnWyQ6LcW22ssxT
	 PN5JtGhZGJVEasQmueXXVDyp8+lrP9PIvEmHBgYI=
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
Subject: [PATCH v2 1/6] x86/hyperv: Rename guest crash shutdown function
Date: Tue, 23 Sep 2025 14:46:04 -0700
Message-Id: <20250923214609.4101554-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
References: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename hv_machine_crash_shutdown to more appropriate
hv_guest_crash_shutdown and make it applicable to guests only. This
in preparation for the subsequent hypervisor root/dom0 crash support
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


