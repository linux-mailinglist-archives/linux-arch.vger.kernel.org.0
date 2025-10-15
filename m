Return-Path: <linux-arch+bounces-14107-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D1BBDCAED
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 08:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE433C86D7
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 06:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7E30F813;
	Wed, 15 Oct 2025 06:19:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACD30EF6C;
	Wed, 15 Oct 2025 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509177; cv=none; b=uttuIZtAbB0BS7RnFiD97y1yU90XQOBfZQXIJJSCL0AlWCTa4K7y66w/G/Gti3DHLT16FB66Ai0QWr0w7OstUNTlZ6z7Foe8WpFdQrj1G8DInuC4jLioWExIyKW17plEcc7BtNtpqaUfwam4+WXvass9bfPBzoywUTPY8lPD1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509177; c=relaxed/simple;
	bh=705FMne12sNVVpkKOQNwNhUxtOYw4Hwl9fBY8WkD2NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCYewPhtYr3oNrhcpNw+woCclWMfXn+rDSht9GfDkCkChohXjUVfLe4CiOImu/5RHEQSj2ugnzLmfjeGMBNHSzMEvA4Is196ta8KvPJbMTsViH0aDo+et8Vd4JV6WzZFzRLwKfsuQ21i+G/GRzqbAfMnAa0UzaDMgC4wBKXyGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpsz20t1760509100tc191fae6
X-QQ-Originating-IP: AGYyXmsCBRc5yqg5sROqL2InOJpb5Xugb1zpPXUPvFI=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:18:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 715155269882244565
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
Subject: [PATCH v2 3/8] scripts/Makefile.asm-headers: pass USED_SYSCALLS to syscalltbl.sh
Date: Wed, 15 Oct 2025 14:18:08 +0800
Message-ID: <C997B2D86EB526D5+4bc4efa1739f38c14463918474e8bfb3d8071041.1760463245.git.tanyuan@tinylab.org>
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
X-QQ-XMAILINFO: MN7J+qOXnZ1LpZYwKidf3Gnb83k4SfJRp4UnTaf4xQKBqQ843xSjSHx4
	fbgQ0wzdK3EpKTf3GtIMU5Wr/HNkvioktxPY7ciWGEUM2IMje3AFOBB4tjR4iWQXtljZOSK
	Kl8l8OYMUDH9KfGD+SBwM2bboN3QcfuMIL7FRa2FaHsd9o6W7ezlwk+KFhaLR9zPxf3JimC
	2grKf+klY/i0n/BZ96ZcI6K938tqjrNJ0EJmvqvOxg6sTY3fM8tR6490SFce6LQoDGEUhCq
	hQ9GFjba6dl0Ar6+yNHzFyN5GbkF9ufBt3qdcyneLWL9x2N+yHews7lvv0+JNnot4yVBs26
	UOd2V9iGylIv92DsMsddNJvlqNta6KDMIQj0vghl2SCy1sqLIOVfCrl5OaCZhqTUbRai4Me
	SmNk1MnQ714ZjKQ+aiP2E3kA7E2inECn9XA9JxMFDAVrk+ceQBq0j8KERYxm95QP7Iu/I4X
	rVV9fKXVUf49AmH7FWbuxK7oj8Jmt1cAE/6vktjjPwaJcp+Y5nCjoMz8Wj/JpX9K+VkHvis
	pWkwqShvGRPwFM3+aH2rDwTVHJD8VSc+/CnGPuRmG6p9jj3gpD2iQPQCXcYT+Hv6VQOCj/l
	KDK63HG0508JRtpR3xYpQB51ZkFHrUgSaILuXqqvJGrHSzPId9RiDUeFCEGgtVdiiaDPIc+
	/ckVEnXDDe9bLD2RuRSAnFyIah2dxCyRLGigjDUlwTZjKoYHKMZPDO1Ou67j0phgxhVFa5U
	uHZe7JShwmEMWkWGigbajEiGXQTNmOsexp/kPNCmNUWWrzs4r3JL/jSFFBjMKlLVHU8TMKx
	nvQPhvlxsPtboTo0iXscEPx614EHc2/A39CWmu/4G0NjbFZsltyjItmF2IKSt+rw+bh054l
	u7LE/fbOBwTKVKVCgiYi9doQkmC6u6k24UX4yLfna/4dw5b859Bg0k3Hav13h44vBkKKmsy
	zlKhGrG4FnQjN/rlr0tRhzV3LgaAaBLlXVAgi7qvnTCRvcDqf4SDcdk0906ZMQwZB/mLoz3
	o1l4Ys9NE3aRScZYPnyU02N+P84ZnaHkG9Utz8iA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

From: Yuhang Zheng <z1652074432@gmail.com>

Include auto.conf in asm-headers and pass CONFIG_USED_SYSCALLS to
syscalltbl.sh when CONFIG_TRIM_UNUSED_SYSCALLS is enabled.

Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 scripts/Makefile.asm-headers | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
index 8a4856e74180..0ae82c6a2a15 100644
--- a/scripts/Makefile.asm-headers
+++ b/scripts/Makefile.asm-headers
@@ -13,6 +13,8 @@
 PHONY := all
 all:
 
+include $(objtree)/include/config/auto.conf
+
 src := $(srctree)/$(subst /generated,,$(obj))
 
 syscall_abis_32  += common,32
@@ -68,6 +70,8 @@ quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) $(systbl) \
 		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
 		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
+		   $(if $(CONFIG_TRIM_UNUSED_SYSCALLS), \
+		   --used-syscalls=$(subst $(space),$(comma),$(strip $(CONFIG_USED_SYSCALLS)))) \
 		   $< $@
 
 all: $(generic-y) $(syscall-y)
-- 
2.43.0


