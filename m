Return-Path: <linux-arch+bounces-9234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAA9DF9C7
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 05:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD06281717
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 04:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A72A1D1;
	Mon,  2 Dec 2024 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Kb4aDy0J"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68AEC4
	for <linux-arch@vger.kernel.org>; Mon,  2 Dec 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733112254; cv=none; b=RnzyKlRjYHc5lusqUWZzouVUxS64tMTIG211QUvBsNdz/HCS7IUiIUPCryAcwsETwM/Cu7KM1tHcgUh16QhSl3pyCikOG+/prQVama+eTcjFdE8nOHVlCEDvbHRsjTj/aRQOtPkgPxnhoffjgnfCsrIdo71UlRWk3TCauEMKZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733112254; c=relaxed/simple;
	bh=EwPe4jYvgPYzukCuD1+IUzWw/0U7iYlxP2mhIZJC/Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giKWV8dRDcCad+tWZz0zQk7TrTvI0NTZ3XT1amvq+Z/dz5/4gR6VJaItWM/kghi8x9NWbNSFu3foLCqSjJ1DT+t43+mLR79lf/az/yKsJRd1SjXk3Acz2BN/LF7rxw+wXEnPacp1NZNvR43q7OUDk444BjwJg/0l6uPphdIX+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Kb4aDy0J; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=//jd55U6GOV6bM+Vy9Mm6uYX28EYP/MNA/fX4H/tFA4=; b=Kb4aDy0J3FuVPjDtLAgx80wdt5
	jr+vX/kd8v+ncTMUPLe4VheZ3YS+G0QSDXPCSAYGF/99d4QG2ITzwfQMDIPWvAx5iGSR1rnS9C/ir
	BiNNUFwKeZF8wmLKKMOCb5Iq+ChqxiGekrbajoQVxLpqe4kMsCsP4tJ9s3BrGJTdC9nfblfpQlb7y
	qdIug35peEeb5dCn8ftlJ4MHmv3lUOCnwNczVXSJ5kuk+eI8e1KdgMfi3dJdusOS5VESJHh0EGnmv
	EFklmpIN4/rQuBbj//kIjatednIk4qC7Auj5bDMBlyVsv/tV+XFbW+yhd4lrsY0Z5c1jJIEvcDeU8
	agF6w8yw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tHxfK-00000003uoR-3tu9;
	Mon, 02 Dec 2024 04:04:06 +0000
Date: Mon, 2 Dec 2024 04:04:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] loongarch, um, xtensa: get rid of generated
 arch/$ARCH/include/asm/param.h
Message-ID: <20241202040406.GC933328@ZenIV>
References: <20241202040207.GM3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202040207.GM3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

For loongarch and xtensa that gets them to do what x86 et.al. are
doing - have asm/param.h resolve to uapi variant, which is generated
by mandatory-y += param.h and contains exact same include.

On um it will resolve to x86 uapi variant instead, which also contains
the same include (um doesn't have uapi headers, but it does build the
host ones).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/loongarch/include/asm/Kbuild | 1 -
 arch/um/include/asm/Kbuild        | 1 -
 arch/xtensa/include/asm/Kbuild    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 80ddb5edb845..b04d2cef935f 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -10,5 +10,4 @@ generic-y += user.h
 generic-y += ioctl.h
 generic-y += mmzone.h
 generic-y += statfs.h
-generic-y += param.h
 generic-y += text-patching.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 428f2c5158c2..2bd0cd046652 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -14,7 +14,6 @@ generic-y += kdebug.h
 generic-y += mcs_spinlock.h
 generic-y += mmiowb.h
 generic-y += module.lds.h
-generic-y += param.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index cc5dba738389..13fe45dea296 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -3,7 +3,6 @@ generated-y += syscall_table.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
-generic-y += param.h
 generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-- 
2.39.5


