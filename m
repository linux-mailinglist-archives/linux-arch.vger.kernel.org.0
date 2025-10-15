Return-Path: <linux-arch+bounces-14110-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BAFBDCB11
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 08:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B9819A65CE
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 06:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836F3101A0;
	Wed, 15 Oct 2025 06:20:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054630FC01;
	Wed, 15 Oct 2025 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509233; cv=none; b=StuKh+r5YWT+eXfTnfcKOwNMNl+SuXVeelUo4iSj28Mc5x4M1gLDHqtwN2AsvXZyVGjjrgFQelNvQ8199mHoQnLgaDFKRicbweoxl1iHtcYAQMr+yPtJuhzaXpJ/ejiuMjJGQx+9C4DLvQtP7kZz6gi1X8348QUBedsgEzeXzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509233; c=relaxed/simple;
	bh=yg0cl6aq1zz78rp7BFHJOnp8Z3Ql5vpAFF/hmAMMfPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx2M9mGEqrKtnpiRyofGC0S1ERnet9PMTuH9ivMFOUEtAs9fgzYozd78e3fc2yUrAO3XNZHZBrVol/abeyM2KXVX9rEboy5KTAH5fcaEt5wxO7+v4XH+k7XenCXT0uVy86R36lMY6Vw2h44yz2td8d9dDF8/PpS2AD2Yr67/RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpgz10t1760509149tb52a1c72
X-QQ-Originating-IP: CKHnewHYWDo1Yrf4J42jLvNSa3NYNzjq2GE7A4/LC2k=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:19:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4224186876999705222
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 5/8] kconfig: add CONFIG_PUSHSECTION_WITH_RELOC for relocation support
Date: Wed, 15 Oct 2025 14:18:58 +0800
Message-ID: <31FE3D0D64425B42+b7172d7ef4e6fa3ee3ed543a44dbc5e467df4da4.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MkywfizRgtI7gl6IUHbV9gFmZd4DmX1fyKYw3bvZTZGFcLta7XLFnmuO
	luHsGcJmx4Rk4weyNjkWX32AFAjU8Mv+oRr5KuvhvRd4VjPuO9aJNDZVMXD/0FDoE7T9ieu
	ckqa/OlSFD2TzqCVgJw/SnD+5BLFzd1QbvApRWAOtAUEgsRNY+rK3ebyyj5Qj44fTObTcMg
	GVma8Rzyb3Dx2Y3feMtzAxDwyoPwY7dZWpr4CijAVQz1h3db6XkE2bF4gelqZ0vAR4QOkWW
	I3Yz03KEHq0NcqIrmr6rpVv5Iis0dZI3/pHwBtDpHe+n0FQd5yGNWshSHsTni5j+IRWOl6s
	kw88TMAp4kgW4oy0OcShTCnLCzxbVT+c4gWe7XT/9cviPBGr5vSe2tEY9YiZQvVKg9R8Z9S
	57IKuv9soTALxOMobxppWdTGz8d/fj+ixwWDLtcPgchOoyqFPp1IHW5EwDEaofoGsRIxX8X
	qJvCkXiiBImhukOr/cXk9aS7zR2C22BGzacPoQn5M3bGYOuwYmWrQqzKuGGz+ByYxxiF2j7
	LX3+4h3gEWyhpHlx36E0N4aJtgiXX3eUmf2IMdAeQQkobn5kBoN8DiC3Y7eQsE7FIcgrrJI
	VLMkfkGGV5xdlXYAh/B6ZAYnLjfGH58MR2JNC/tOI9WjMXNPeIFFmirMFDXIam/l0uyM7Qz
	OAQlOxcWCOoodiajGfGWu7uw1U1xkl1XDqlmnmkLMRdMt6N5ijoEUurHDCl4Eikr2zt/uG+
	db5Mk6l7/2+WKFge20r4xSZLeVxTJbEIbM2ch7vDBHF8JbGA/tLIFcETz6NoPDdU2l8TTwi
	cLVMzTg5mPtp4qM0JeiFRWLgTIUREHTqubySPmy+Ccavxdp43931halU6ne+Ri4fPyuG/A4
	jHR+tqw9EriRxrMcpzB9ey31nfMe18wpahEytpI/qSklrmUh0lyggtgiuHdSOTuQqO3Qvoc
	iylIE+xt06n1p7P/2N/foI36u5g++Ia1yjR8=
X-QQ-XMRINFO: OW8WShJdN8S2cMc/fs8JwkE=
X-QQ-RECHKSPAM: 0

If the assembler supports the '.reloc' directive with 'BFD_RELOC_NONE', we
can establish a reference between a section created by '.pushsection' and
its caller function by emitting a relocation in the caller.

Known toolchain minimums:
- GNU binutils (gas) >= 2.26
- LLVM integrated assembler (IAS) >= 13.0.0

All assemblers meeting the kernel's minimum toolchain requirements already
support it.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
---
 init/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 2c6f86c44d96..3d1cf32d5407 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1631,6 +1631,10 @@ config HAVE_PCSPKR_PLATFORM
 config HAVE_TRIM_UNUSED_SYSCALLS
 	bool
 
+config AS_HAS_BFD_RELOC_NONE
+	bool
+	def_bool $(as-instr,.reloc .$(comma) BFD_RELOC_NONE$(comma))
+
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
@@ -1965,6 +1969,18 @@ config USED_SYSCALLS
 
 	  If unsure, please disable TRIM_UNUSED_SYSCALLS.
 
+config PUSHSECTION_WITH_RELOC
+	bool "Trim more syscalls"
+	depends on TRIM_UNUSED_SYSCALLS && AS_HAS_BFD_RELOC_NONE
+	default y
+	help
+	  Enable building relocation-based references between sections created
+	  by '.pushsection' and their caller functions when the assembler
+	  supports the '.reloc' directive.
+
+	  This allows the linker to establish proper dependencies, remove the
+	  need for KEEP().
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
-- 
2.43.0


