Return-Path: <linux-arch+bounces-13936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3973BBBFB49
	for <lists+linux-arch@lfdr.de>; Tue, 07 Oct 2025 00:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96CC3C0123
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 22:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2061F1302;
	Mon,  6 Oct 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DUlG9RIH"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0934BA5F;
	Mon,  6 Oct 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790536; cv=none; b=RyRndXDhUxD/4SpzbDIV4Ep8j8/fsYelsjR6c5cYTnWInK2UTufNZaBaoW4irujqunAKXmFm3SvWyeSa15RGGdLmReKKDi3TSwshxdEGlGk7ozhBcnUGYHbgb1BwHoKlPtY53YCJxCYkNFhhO2mmBGnqYbNaU+tWIWDc0j4mddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790536; c=relaxed/simple;
	bh=JC3PtmGSuHGNwX/n7XZ+q5TOo5+bg7eggD2SQKbmqw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oABRZm/vUXm/2ArRha6SmiWrUnEWct5VHNP7+iXqyyg7buusML9dt4wVPrUPU55Gs42xmPK65oHFj+PAyrGb+lzirylKosBg7GPE7Ihez04wPGUazJ1SvOrQICVc4egL+zIcXPGr1Xl3sy6Cs3SRK9ruSMz5XsR/6I0Xurug4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DUlG9RIH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED405211AF3F;
	Mon,  6 Oct 2025 15:42:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED405211AF3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759790534;
	bh=lfFnN2zSYZqHKaI+3lFIiwJexefKef7Xf1P2QYZKBOg=;
	h=From:To:Cc:Subject:Date:From;
	b=DUlG9RIH0xCXLrEZtI0q4utqVN+UxjGbH7F/V6YMFhAlo5DD7CcD+TlAbEOV9CLvf
	 +y9cW9oeyEQ2BSyvwa6c8h6a8PHJoAOAu65wr+WH2bu8A5MDDKGg0m3rtGRabionPP
	 /NBrhtLw0wpWHrlSQOInaZ73/fdqcAkE1t2R1TS4=
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
Subject: [PATCH v3 0/6] Hyper-V: Implement hypervisor core collection
Date: Mon,  6 Oct 2025 15:42:02 -0700
Message-Id: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements hypervisor core collection when running
under Linux as root. By default initial hypervisor RAM is already mapped
into Linux as reserved. Further any RAM deposited comes from Linux memory
heap. The hypervisor locks all that RAM to protect it from root or any
other domains. At a high level, the methodology involes devirtualizing
the system on the fly upon either Linux crash or the hypervisor crash,
then collecting core as usual. This means hypervisor RAM is automatically
collected into the vmcore.  Devirtualization is the process of disabling
the hypervisor and taking control of the system.

Hypervisor pages are then accessible via crash command (using raw mem
dump) or windbg which has the ability to read hypervisor pdb symbol
file.

V3:
 o remove usage of the word "dom0" as asked by maintainer
 o change hyp to hv in comment and ipi to IPI
 o rebase to:  hyperv-next: commit b595edcb2472

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
 arch/x86/hyperv/hv_crash.c      | 642 ++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c       |   1 +
 arch/x86/hyperv/hv_trampoline.S | 101 +++++
 arch/x86/include/asm/mshyperv.h |  13 +
 arch/x86/kernel/cpu/mshyperv.c  |   5 +-
 include/hyperv/hvgdk_mini.h     |   2 +
 include/hyperv/hvhdk_mini.h     |  55 +++
 8 files changed, 823 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_crash.c
 create mode 100644 arch/x86/hyperv/hv_trampoline.S

-- 
2.36.1.vfs.0.0


