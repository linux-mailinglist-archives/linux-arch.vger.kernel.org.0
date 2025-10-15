Return-Path: <linux-arch+bounces-14108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F129FBDCAFF
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 08:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E56519A65B9
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485730FF09;
	Wed, 15 Oct 2025 06:20:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE230FC28;
	Wed, 15 Oct 2025 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509200; cv=none; b=FgVNBetfiFyMTTqgttdvVAszxtG/p4Ez3YPvVNICRh9y8zPW7jsTnEImf4tmp3OFF5XpXA3dal2fvixhuFNjeYOVntH7+edzjsp5zGqxsfR46RCewUViOBXhgbiSaeXzBVaaaAUAe+9Zr4m6bFvtPHz2bZ6qEswhNL/bYsb0aBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509200; c=relaxed/simple;
	bh=00vkzuLktB6wmqLHFAXh0IaPTK1wbG12G/QsgWkAQr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCbi+K4S/zZfg3NiKk8dlB/zv/pLyQ12isLHkiOYfLYOScOFB/3mKaISxC6T8V66rOMi34yJ0SrwKG0CLG4IRGxAKUqV6lLJSC4KG6n2cA3G5gSgte6Q+VHYmBRp4Ef6ecnWB1Yd82MkVdr1uc4ovJWgZbOgZ6wsLtiR+26cLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpgz13t1760509078t710fc538
X-QQ-Originating-IP: fKuI2SoLTPBzi9ZxhQ0J1CaSp3/phsZPssuIEn3Y994=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:17:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13976680870695852025
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
Subject: [PATCH v2 2/8] scripts/syscalltbl.sh: add optional --used-syscalls argument for syscall trimming
Date: Wed, 15 Oct 2025 14:17:49 +0800
Message-ID: <B120EFEBD27B9B67+6751ec7c12d04aafe1de79502b984ed65013f6cf.1760463245.git.tanyuan@tinylab.org>
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
X-QQ-XMAILINFO: Mp62enUr7azuivZrNzLe2z/QyVUzXCJedV2fP4VOoeilXfYsV4ZqRp1Q
	SD9ja5G7fhijZ4fBz6IPzGcx+/2/RN+fUXyu6RRM3+kwfSq8xVoQYEmKb42i/o6CEGmbl+z
	To0hGppWjxasmj0aOuYlQ94hFjwPtjp/8+PqLDWmQDk1ianxIuuosCgFrrcNXx5Hu5D0/se
	q8P4oKE6Cbsm+CHm3Vlh7flu4gHdyJAEUgTADZ5E23In/V6nNQHwIFUJl+zoj4QsDiTH9Pq
	Ixb64JmhoIjuZPxy4gaJ9BSTFZiHs9PxhbU3ynRhVWY0Yj0OL6mD4wyFOKMuGC9mtMTCLIb
	s50UTOrSJNlgGDBQUHQJ1gAOrmsaOnjip2hsaKz/mDsutm4GeKh4YD7AiDp55AIESY57cQ2
	OuM4SpL4gSLOHc+oxAzjn90bAjtBr+oAxkoavQ5/3XayUEN90Pjy4/T5ddFvT6aue81sMD+
	QcvEPJpCg2wbXdBP8nlnTQGMnCwGd1vKI3L86g3mUWdS4akteT3r9JvDodYFBbjOouRzue4
	jKcezTcwMnPEdvSEijmd6RbOu+r45pRe0LG58braY8sZX1p7TT+0bF/j/taEtIb9cBGQh/T
	1G1+HYBe0baM5A8Qrh9a2xJl/Ic9lE7cHlljMvdaA/Env701QztSxNQkmqQPBI8MR+EmlZI
	ZhTNpAEy2dq0sJzIZtbwNgYA7YXWE4fQdZtwbabZSKooos3qtt5xfaAPUObGoBazl0FKKxf
	QmmI4rPm/EOVDHTovWaXe+UPRxx43hsnrSknJMBA+w/3hFzeCbesQAqFhNydgeClc8dO+jt
	Mhv9lzHVDRa+Ovgvt8SY4AtgaA/XMvsRH0ZcYBFItl/1haX084VrS2zdc1GVncOHrzr3hTt
	NSzGZ9c8CQr2mwYa62pHLSyhXFYgQGy1TicC3b9zkOMDRkmWxO3HURU1GEyAyhEJ/9Kp+hZ
	FK3N6PEPP9bucFHDg775Nt2wlLa0ylEP2T84CXKHAkGpk2vrT0iDswE8zzm5laiYOpF0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

From: Yuhang Zheng <z1652074432@gmail.com>

Add support for an optional `--used-syscalls` argument to
scripts/syscalltbl.sh. When provided, the argument takes a comma-separated
list of syscall names that should remain enabled in the generated syscall
table. Any syscall not present in the list will be replaced with a
`__SYSCALL(nr, sys_ni_syscall)` entry.

This enables selective system call table generation when
CONFIG_TRIM_UNUSED_SYSCALLS is set.

Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 scripts/syscalltbl.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 6a903b87a7c2..27d8dfce5748 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -22,12 +22,14 @@ usage() {
 	echo >&2 "  OUTFILE   output header file"
 	echo >&2
 	echo >&2 "options:"
-	echo >&2 "  --abis ABIS        ABI(s) to handle (By default, all lines are handled)"
+	echo >&2 "  --abis ABIS                ABI(s) to handle (By default, all lines are handled)"
+	echo >&2 "  --used-syscalls SYSCALLS   Keep only the specified syscall; trim others"
 	exit 1
 }
 
 # default unless specified by options
 abis=
+used_syscalls=
 
 while [ $# -gt 0 ]
 do
@@ -35,6 +37,14 @@ do
 	--abis)
 		abis=$(echo "($2)" | tr ',' '|')
 		shift 2;;
+    --used-syscalls=*)
+        used_syscalls_raw=${1#--used-syscalls=}
+        if [ -z "$used_syscalls_raw" ]; then
+            used_syscalls='^$'
+        else
+            used_syscalls=$(echo "$used_syscalls_raw" | tr ',' '|')
+        fi
+        shift;;
 	-*)
 		echo "$1: unknown option" >&2
 		usage;;
@@ -52,6 +62,7 @@ outfile="$2"
 
 nxt=0
 
+
 grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 
 	while read nr abi name native compat noreturn; do
@@ -66,6 +77,12 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 			nxt=$((nxt + 1))
 		done
 
+		if [ -n "$used_syscalls" ] && ! echo "$name" | grep -qwE "$used_syscalls"; then
+			echo "__SYSCALL($nr, sys_ni_syscall)"
+			nxt=$((nr + 1))
+			continue
+		fi
+
 		if [ "$compat" = "-" ]; then
 			unset compat
 		fi
-- 
2.43.0


