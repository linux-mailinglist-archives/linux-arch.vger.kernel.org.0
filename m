Return-Path: <linux-arch+bounces-14106-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C38BDCADA
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 08:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4EC3C85C7
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 06:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3527467D;
	Wed, 15 Oct 2025 06:19:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45229AAFA;
	Wed, 15 Oct 2025 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509148; cv=none; b=EREMCcBhjQbsiaoUJKtA07v7IygBqAlZOsNBjN0pvDaXp2g2nRGVgqLqUVPEqayT9nVw7KB18+8spvaB506VaBEa/Ac7foAjNdpIIu+28/98lGrfTNBUvhgCfHmJ0Nl4ALETxziFIZIV3BaEA+ZN/one4GHPndgn0t2ucvRVk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509148; c=relaxed/simple;
	bh=qHIAcV7644KkxRItnhTf8hr6+x1EXJ8W3AYi5AH6LnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mjw/vja/I6nMWW89nJhEdZIvdpQ2PnWMknKWjGxKLnImc69pUskrJpmJFmitOPTKMm0JethlErqC/XYISBGK1iZHsH/l83Cbpn5mzUl8ahTjCsC/zDjrOCkSE4IfCso4FMOCNUqZzv7eRNqtLGc1tb7mmJgJ3MWo35PTTdDyFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpsz19t1760509050tc3cbbd60
X-QQ-Originating-IP: OMyBGcrdGYXGNiCpjXkWErWKjJoDpPvFbLpMaIvQg3w=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:17:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8967269725279754813
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
Subject: [PATCH v2 1/8] init/Kconfig: add CONFIG_TRIM_UNUSED_SYSCALLS and related options
Date: Wed, 15 Oct 2025 14:17:17 +0800
Message-ID: <553D6FEA67820FC7+34b9da95a06acd3ee5ce0e9cc16cb60aa1aaad2f.1760463245.git.tanyuan@tinylab.org>
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
Feedback-ID: esmtpsz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MwqrwaLzgdebc4eFLZ6JfFgrQnWkcajKpO9BhenYELx6L5uzjl+WvOkp
	VASyUjaqrspE991aid9zJN+IHkYsuVIpc3kkpIwXuxFSWbMPKa17OWizV6WW0Epx/MUgQrj
	DW8U/ovriWdP3lav4uc2ncpvKH9kYlzkBy52ty7Upr+6fgvU+NdCF9LJmEJwRpg+pBYuHgc
	8XoK4TaHbn+kFF0c2OcEdg/maCBwWis9okoG996xsP8STURASjsoMa1byOqe6hA/cZPaoIP
	FpvUQikgjuGGE2bNi2vEf/kbwnYsKXYSj/1bmxpY/7zHHs9lRCdEYblHjPwn2Z5MLSY+U/f
	G6dsP3wN5F08KFbChZ59AnlPlS+hv0at23MASUtwHfVb2mp1r1lUXREytZJPj8VYFUPPjGb
	OwgnqDHyW2mqSdYhqmw9gCTF2aP3GthtRsH4507OB5t553CFwlYmnPf2/2qCGWwbSMtzavA
	zPR7OlePzYm3ciJtWUJcWqsUvzNZYq2tAgJ0tWnihtic/t2LI8ZKkc2ZPeOXFswzY+IHcZA
	bmp10xeSly7EDRbi9qqsukTfznP9xxEnAVC6m9+esgqBMWVK9+NHHL+EDABGIrh8bMwoM7N
	ik3o9HgE3NrcDINe7ZGRE21W+gxAjVmpOEoeVqlIVPsrk+vYKiIjMUfnIw45zmunCfMNrXu
	jxVc1qd3cqf0QARUrxzeHvMVW6AQqw4pu7fvwbIBCUfkRph7OkJI5QJ/+G49nvhMlUE6Yem
	zolPrcINcCa0jj2tj/Rl09g4TLZ1s1CAybmgO7vVZa1jvTQH80sq7m+tcWyCI2JALWv4XCA
	bwLDcq6npUmNr+UfRoa9bRlYDo53i27pkiY5Ab0wUpHiOpZyFaiPI7EgjwKw7GN7m2kSSM5
	5QH67xcNRXGoeePiYkNL1FmtVYTXPL5QSVjcAMb6FI8HemotADcuXmUaVC3PBk/kUQPXGLh
	ef1lKO4hudTSGyD3W96GgGcx8K3rNEzDEudUc//CVUZs2S7jqRwA2BYvi/V4Rm5BX+07kRi
	JQjSs9ClAQoFbj7y2nVr9TdLrV8J7QfnGE2LObRVdbFGQZPS7D
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

From: Yuhang Zheng <z1652074432@gmail.com>

Introduce configuration options to enable dead code/data elimination for
unused system calls.

This change adds the following Kconfig symbols:
 - TRIM_UNUSED_SYSCALLS: user option to enable trimming of unused system
   calls
 - HAVE_TRIM_UNUSED_SYSCALLS: architecture capability symbol
 - USED_SYSCALLS: string list of system calls to keep(separated by spaces)

These options integrate with scripts/Makefile.asm-headers and syscalltbl.sh
to generate syscall tables only for selected entries. The feature depends
on LD_DEAD_CODE_DATA_ELIMINATION and on architectures that use
syscalltbl.sh to generate their syscall tables.

Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 init/Kconfig | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..2c6f86c44d96 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1628,6 +1628,9 @@ config SYSFS_SYSCALL
 config HAVE_PCSPKR_PLATFORM
 	bool
 
+config HAVE_TRIM_UNUSED_SYSCALLS
+	bool
+
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
@@ -1932,6 +1935,36 @@ config CACHESTAT_SYSCALL
 
 	  If unsure say Y here.
 
+config TRIM_UNUSED_SYSCALLS
+	bool "Trim unused syscalls" if EXPERT
+	default n
+	depends on HAVE_TRIM_UNUSED_SYSCALLS
+	depends on LD_DEAD_CODE_DATA_ELIMINATION
+	help
+	  Enable this option to trim unused system calls from the final kernel
+	  image. Only the syscalls explicitly listed in CONFIG_USED_SYSCALLS
+	  will be kept.
+
+	  Note that some unused syscalls may still be retained if their sections
+	  are forcibly kept by other sections created with .pushsection and
+	  preserved via KEEP() in the linker script.
+
+	  If unsure, say N.
+
+config USED_SYSCALLS
+	string "Configure used syscalls" if EXPERT
+	depends on TRIM_UNUSED_SYSCALLS
+	default ""
+	help
+	  Specify a list of system calls that should be kept when
+	  TRIM_UNUSED_SYSCALLS is enabled.
+
+	  The system calls should be listed one by one, separated by spaces.
+	  For example, set CONFIG_USED_SYSCALLS="write exit reboot". If left
+	  empty, all syscalls will be trimmed.
+
+	  If unsure, please disable TRIM_UNUSED_SYSCALLS.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
-- 
2.43.0


