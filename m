Return-Path: <linux-arch+bounces-13460-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512CFB5098F
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 02:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C447A56D0
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 00:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE628F7D;
	Wed, 10 Sep 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J7uxB8LO"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DF533D8;
	Wed, 10 Sep 2025 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463031; cv=none; b=PkAGr9xkO0sV2nyArNFUDXMqlvt+r2noNWybrNns5xQGQu4wn6+GWHb0l+l2QAVQL5j8u3CXHqQEskwv3XQcGwcqL3Z+7DsTOjv7Ro4s3IM6cJTcnW+MxkljHgs2mFawg47lJ8zQxW8bcQ4tgmmU8lyzwdi+oJ85Th7QYVVRflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463031; c=relaxed/simple;
	bh=v+XwwYjaCKwKmCzqPuPwPUlkXDMjSnKRqcKnO1v5T30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2xCouLc3wj/McZpy3zHvJQwGWWtulH3s+MDzNruRDN/FpQEtyswSbVhHjuFsGd+yv5DrpR0giQ31YgxiXF5Td7PbaxCSmbVrAGQjprRbac11GQpLMNSXkSHCfKjwDq2jEmyRuWxvcciLnwGK1p/p/DrgPPv8AIwx7GmWxQA/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J7uxB8LO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 71F572018E45;
	Tue,  9 Sep 2025 17:10:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71F572018E45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757463028;
	bh=+a5fs37jsW/++xb/vpujvsFmRh+v83z/FhyFtY41Skg=;
	h=From:To:Cc:Subject:Date:From;
	b=J7uxB8LOt9kTNj0SO0EBEN7f/9i5HA+cL1w+z3Ww6lh1g//OpkBstIixQzpo8bmg4
	 YhW+2rqLUUrXa9yCF/hhb2pv6QUXrpjjg2ZJBVDnBzTwsH/1Fr1RuHqIKILAe1GSor
	 MPmv1IZAFI2uFzXZ58VvB0SfrcmOrY44qIGMPgQ0=
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
Subject: [PATCH v1 0/6] Hyper-V: Implement hypervisor core collection
Date: Tue,  9 Sep 2025 17:10:03 -0700
Message-Id: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
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
from linux memory heap. The hypervisor locks all that ram to protect
it from dom0 or any other domains. At a high level, the methodology
involes devirtualizing the system on the fly upon either linux crash
or the hypervisor crash, then collecting ram as usual. This means
hypervisor ram is automatically collected into the vmcore.

Hypervisor pages are then accessible via crash command (using raw mem
dump) or windbg which has the ability to read hypervisor pdb symbol
file.

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
  x86/hyperv: Implement hypervisor ram collection into vmcore
  x86/hyperv: Enable build of hypervisor crashdump collection files

 arch/x86/hyperv/Makefile        |   6 +
 arch/x86/hyperv/hv_crash.c      | 622 ++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c       |   1 +
 arch/x86/hyperv/hv_trampoline.S | 105 ++++++
 arch/x86/kernel/cpu/mshyperv.c  |   5 +-
 include/asm-generic/mshyperv.h  |   9 +
 include/hyperv/hvgdk_mini.h     |   2 +
 include/hyperv/hvhdk_mini.h     |  55 +++
 8 files changed, 803 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_crash.c
 create mode 100644 arch/x86/hyperv/hv_trampoline.S

-- 
2.36.1.vfs.0.0


