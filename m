Return-Path: <linux-arch+bounces-13461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDECB50991
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 02:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85495620FA
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0697BF9EC;
	Wed, 10 Sep 2025 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pXxVcJLw"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995F633F6;
	Wed, 10 Sep 2025 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463031; cv=none; b=SE02AvaHafOr524p9cPvb6ENSc7QM5xuV18K6KGcGqx9jy9u6X2M8L1xLxSDLXsiTy8fCBm1kAC2RJWirXub1vC1UuZKjOrKutIqgGHH9QyxIrnFnHH15shw+qWL4r/3c1fd2td0e7R6YZO2gSzVQAkZ2JQH8YANRk2G+XomrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463031; c=relaxed/simple;
	bh=dr/Q1R6Sn+NyHksBWDSvfG6vvZgaRg3D12hynJ+ENu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pahk0C9zMpQoJcCC0wg8TgVngxvcGbI27qzysTBRtmiHmSRvpw5YbdakRw5YlptEY+WoCNZL8JzmVcvWa1KxF3ZJzywyyyiXSH5nreZSH63Re9tGkD5xvhsYZYDPqQyhL382SWXDeOKhQNX3AqD1p5wyA8WEHHeRcYkRKTCLiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pXxVcJLw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A4AE52018E53;
	Tue,  9 Sep 2025 17:10:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4AE52018E53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757463030;
	bh=Xm2o4yAUkdFB50MsmJ1IE0HmIZbMwVma/u6kOisVDyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXxVcJLwUPksW8Xz1Ia8nui7u/VrSQ9UvE/mVPE9YcFTroU6ESG/YaJEUHizXRM93
	 70nX+pWtbDkZ1piF9YPx1eftRMOfPBFcQAEUBcYtH7piWOrKbZVU/wiOiH3BdVK8yM
	 LRsFwAKxY8lYvhsa+2e4Ti9o4CZlEtxl3GBFM9Kg=
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
Subject: [PATCH v1 1/6] x86/hyperv: Rename guest crash shutdown function
Date: Tue,  9 Sep 2025 17:10:04 -0700
Message-Id: <20250910001009.2651481-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
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


