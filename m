Return-Path: <linux-arch+bounces-13372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63D9B42F65
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 04:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE2C1BC7C8A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 02:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A01F8728;
	Thu,  4 Sep 2025 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o5tSVvSf"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D51F2C45;
	Thu,  4 Sep 2025 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951832; cv=none; b=vD+KnIqd6vm2YdT6d5MysVVZTQNQ04LQIthI0SekK9tFHnzQ1J2JuD8kd7ATaMimUhGfu8Inp4a6SXCwgLiipvTi+qhowP6yNfR5LHz7lrVkoQvWR5e9oQXHsOarQDE+cmuThTYApE7S9NJxBpGmUV+etGhZSmolRsAc0Xj7CPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951832; c=relaxed/simple;
	bh=Usas84qN0i64WIRz1JYh8b/gPX3hK3md+em4AUn06Is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPE6M+ErxM3d9q5L39zpVeaTYlVNK47fo/qKirSL8M8/YNpG6mlaBHPgMJ8j978T4frXSpyGTeCYEhg1KflIRTaGc0euP+miq4OZpK02A/gOd8Id42//WQs3oOCR7TFJhNYPxiNtCJcBbj+4yQ4xb7Nyeffdec+P3IN+bVhCQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o5tSVvSf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DA80C211938F;
	Wed,  3 Sep 2025 19:10:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA80C211938F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756951825;
	bh=dvDH2vLHTb9J/++k5U1WW7uTQK6hyRnicuuDKZ/GlOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5tSVvSf/5Mwegv65JLnVaaaKuMhBOTp9J0+qWzdydFI87Z6pIffYJatyMgHtApIK
	 qSUOy3wKgYQ6G9RAk9u3FYCnlS40kLhKGyl4ZEGHl8ShdaEgpO/TPHhFI9a3nA6mSV
	 Lbymw7ICxjm9yyYSruufHu1yVeQfDJu4bk++3iDA=
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
Subject: [PATCH v0 1/6] x86/hyperv: Rename guest shutdown functions
Date: Wed,  3 Sep 2025 19:10:12 -0700
Message-Id: <20250904021017.1628993-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit renames hv_machine_crash_shutdown to more appropriate
hv_guest_crash_shutdown and makes it applicable to guests only. This
in preparation for the subsequent hypervisor root/dom0 crash support
patches.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b8caf78c4336..f5d76d854d39 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -237,7 +237,7 @@ static void hv_machine_shutdown(void)
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_CRASH_DUMP
-static void hv_machine_crash_shutdown(struct pt_regs *regs)
+static void hv_guest_crash_shutdown(struct pt_regs *regs)
 {
 	if (hv_crash_handler)
 		hv_crash_handler(regs);
@@ -824,7 +824,8 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.shutdown = hv_machine_shutdown;
 #endif
 #if defined(CONFIG_CRASH_DUMP)
-	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
+	if (!hv_root_partition)
+		machine_ops.crash_shutdown = hv_guest_crash_shutdown;
 #endif
 #endif
 	/*
-- 
2.36.1.vfs.0.0


