Return-Path: <linux-arch+bounces-13371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F211BB42F63
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 04:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D021BC779C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FC21F3B89;
	Thu,  4 Sep 2025 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="duW23UpP"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D41F1518;
	Thu,  4 Sep 2025 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951831; cv=none; b=Gh4JpBsozQtTO3s+Iaa7WKbt6KUU2uKEEhZu0QXPcnZlOCtXi8cUCai7h3BvjfvoFsT4jgYZhAq0nMN4M/9Gy0Z0oNBdp6zJ0bUsDcwjBJyN1hHm4/YpgdcBb2Cp9WgPmioXpGCx/sHejIu/GHt8P9Fa50EIYG+SdkRRLbNUTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951831; c=relaxed/simple;
	bh=A1mI0PqBDIPsJ1EVPTvicJP1aRklXS/m32f+z00pF8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duQ8vkp7lV6pJPOvzPVS0Kyed7YDNzkbkn2Zg4FIca6/GidDjL9ZaILcuxg49RzJtpLf7fLev3bx01jGM+PQVCMB24FOpMAi09YR/z0mYWoh8zYPdJZUdXeuvsvVVyQf5Ed7976Fw2LJ9ORLWOctjw1VNO2SPbxg/yPpCh6FuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=duW23UpP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id D1A062119CAA;
	Wed,  3 Sep 2025 19:10:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1A062119CAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756951824;
	bh=yxzYgFdF3NlcyOieH00YVZTotbWxn7dVvsILo5XM2kk=;
	h=From:To:Cc:Subject:Date:From;
	b=duW23UpPu13lfqXeurMt3CHj4NXcLzNELE+llwswEuNI0NwgEzRE2u2KPg6ljdT6v
	 ESW8tBkN/LOjG9Wm4aD+4NZPxtR9eIHYM+O3lKoSKS/n/+P9Sa3BDZJ3v1djM87Fbu
	 fHj0vcqKSZITwvzHg+vGbmPAU2Ub+PbjBq9Fu1pg=
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
Subject: [PATCH v0 0/6] Hyper-V: Implement hypervisor core collection
Date: Wed,  3 Sep 2025 19:10:11 -0700
Message-Id: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements hypervisor core collection when running
under linux as root (aka dom0). By default initial hypervisor ram is
already mapped into linux as reserved. Further any ram deposited comes
from linux direct map. The hypervisor locks all that ram to protect
it from dom0 or any other domains. At a high level, the methodology
involes devirtualizing the system on the fly upon either linux crash
or the hypervisor crash, then collecting ram as usual. This means 
hypervisor ram is automatically collected into the vmcore. 

Hypervisor pages are then accessible via crash command (using raw mem 
dump) or windbg which has the ability to read hypervisor symbol pdb
file.

Mukesh Rathor (6):
  x86/hyperv: Rename guest shutdown functions
  Hyper-V: Add two new hypercall numbers to guest ABI public header
  Hyper-V: Add definitions for hypervisor crash dump support
  x86/hyperv: Add trampoline asm code to transition from hypervisor
  x86/hyperv: Implement hypervisor ram collection into vmcore
  Hyper-V: Enable build of hypervisor crash collection files

 arch/x86/hyperv/Makefile        |   6 +
 arch/x86/hyperv/hv_crash.c      | 618 ++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c       |   2 +
 arch/x86/hyperv/hv_trampoline.S |  99 +++++
 arch/x86/kernel/cpu/mshyperv.c  |   5 +-
 include/asm-generic/mshyperv.h  |   9 +
 include/hyperv/hvgdk_mini.h     |   2 +
 include/hyperv/hvhdk_mini.h     |  55 +++
 8 files changed, 794 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_crash.c
 create mode 100644 arch/x86/hyperv/hv_trampoline.S

-- 
2.36.1.vfs.0.0


