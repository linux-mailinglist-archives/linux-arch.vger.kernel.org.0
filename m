Return-Path: <linux-arch+bounces-13738-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4CCB97989
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 23:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619764A4C65
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B175E26C3B0;
	Tue, 23 Sep 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s9zgRHtF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324DB21348;
	Tue, 23 Sep 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663981; cv=none; b=OOCjZ2qysNNHzgx53MTQJFZ9IFHMOWkm/Wv48ahVGq6TUuHLrvXX+qfJfzIDhWD0KHWj+Fnpbm/kKk7JlFp9G6HsF/+vb012gPycWmfpeARqTmP4crzDrrZFXLp5V2h4CcMexpKNzwLFD8QgYb917Oih448vYwWO98OxJ4McSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663981; c=relaxed/simple;
	bh=+fzUxG4uJBGIobzZMn6pHnBeU7pVdq1x4ZUKJZUCh/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HXRtdAjUG508R9cPQCH96lbBeb75eJoGR1Tdn/R8OFU2llv2RGhp+7DAufBRVx9l/p12cmwUkYOBnP+mTRQDunr7eeyHfZsaJOC3zjxwLint3ymdRPtIJwsl9MCcgd6qASas8ZP5SliLRxCVEMysWNr+8AUxoJFccJtQil3DYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s9zgRHtF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 187EB20154E0;
	Tue, 23 Sep 2025 14:46:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 187EB20154E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758663974;
	bh=zZjvijBXtw8zxOJAkrAm76lPjMrrZLDQmYMRv/Zsmo8=;
	h=From:To:Cc:Subject:Date:From;
	b=s9zgRHtFPOddCD0xjjx/pyEuxwFepu9xQ7vK40QYVzn6a1qzsouZcgD5l2wkm81IX
	 1X9vZ5UiTy+rNsWkGfHZ+ZEqBa9urynpZjOZIPY7ROj3UEN2TLHyGE+dK4BM2JRB19
	 tijrXkwAGLNzvEBDbqcP8Rkgr3MG4JILr3MXqOsk=
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
Subject: [PATCH v2 0/6] Hyper-V: Implement hypervisor core collection
Date: Tue, 23 Sep 2025 14:46:03 -0700
Message-Id: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements hypervisor core collection when running
under Linux as root (aka dom0). By default initial hypervisor RAM is
already mapped into Linux as reserved. Further any RAM deposited comes
from Linux memory heap. The hypervisor locks all that RAM to protect
it from dom0 or any other domains. At a high level, the methodology
involes devirtualizing the system on the fly upon either Linux crash
or the hypervisor crash, then collecting core as usual. This means
hypervisor RAM is automatically collected into the vmcore.
Devirtualization is the process of disabling the hypervisor and 
taking control of the system.

Hypervisor pages are then accessible via crash command (using raw mem
dump) or windbg which has the ability to read hypervisor pdb symbol
file.

V2:
 o change few comments and commit-messages
 o add support for panic_timeout for better support if kdump kernel
   is not loaded.
 o some other minor changes, like change devirt_cr3arg to devirt_arg,
   int to bool. 

V1:
 o Describe changes in imperative mood. Remove "This commit"
 o Remove pr_emerg: causing unnecessary review noise
 o Add missing kexec_crash_loaded()
 o Remove leftover unnecessary memcpy in hv_crash_setup_trampdata
 o Address objtool warnings via annotations

Mukesh Rathor (6):
  x86/hyperv: Rename guest crash shutdown function
  hyperv: Add two new hypercall numbers to guest ABI public header
  hyperv: Add definitions for hypervisor crash dump support
  x86/hyperv: Add trampoline asm code to transition from hypervisor
  x86/hyperv: Implement hypervisor RAM collection into vmcore
  x86/hyperv: Enable build of hypervisor crashdump collection files

 arch/x86/hyperv/Makefile        |   6 +
 arch/x86/hyperv/hv_crash.c      | 647 ++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c       |   1 +
 arch/x86/hyperv/hv_trampoline.S | 101 +++++
 arch/x86/include/asm/mshyperv.h |  13 +
 arch/x86/kernel/cpu/mshyperv.c  |   5 +-
 include/asm-generic/mshyperv.h  |   1 -
 include/hyperv/hvgdk_mini.h     |   2 +
 include/hyperv/hvhdk_mini.h     |  55 +++
 9 files changed, 828 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_crash.c
 create mode 100644 arch/x86/hyperv/hv_trampoline.S

-- 
2.36.1.vfs.0.0


