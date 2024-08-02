Return-Path: <linux-arch+bounces-5933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3AB945EB1
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 15:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF7A1C22214
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4CD1E484D;
	Fri,  2 Aug 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O0eJBHLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpnU6PAI"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A114B09F;
	Fri,  2 Aug 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605398; cv=none; b=OQEDMLkrju1SxAnTMvJoyKG5AMaY4EM4ezmhTgInTdGooYqhGUY+LbZXZIMZ0t9MtrLak+SldqLS2NVDem7BdP3uzN550MtTCisfqqU4u3pDe7H0rm5eF61ozzYzsZjXDFKZKkW1mzsr0XhnwoFPrO2R2M2NJbj8evqF3rtvQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605398; c=relaxed/simple;
	bh=jRv1DvDyVl2Rx0hY3D7Jbhv7BRiuPHZ3skHKRz5M5Tg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=t3Rnn2sDK49IqDfY1/ER79aiFD4L1uUd8I239RpB5ZLttgsl5/T4KdXKxQ+GXgNWE4q7gM6OzWG4X/3sMhr8WYa6Bmt20/VXfmpSNUz3onPXfrNPaoA6L4cGfnpmxItiejB0WtJGD0sLzeDNHfcMq8fD4H2/GMJFYocUBJ9ezbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O0eJBHLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpnU6PAI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2DC52114AA57;
	Fri,  2 Aug 2024 09:29:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 02 Aug 2024 09:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1722605395; x=1722691795; bh=uH
	K+LywJCuCvKhPEFLToXWjpdgANSgKtERRw5V+HZEg=; b=O0eJBHLYgvh24WLXu1
	Gq31mZAKlmdMYaNHR93crkS+6tn20Oj+Ak22c7T7QGuIkw8hYCDLgBm/wq7Kl/lG
	X0xySWuA616LOijgj12JeUa2XXON6brqxza/HaQ/01pJ7FdFN3two2IkzdUPcbsD
	xKr07pXVVi9AEaNrLc6vrpj7XsDQFOMOe4p15UHNEOA7il0Wvajl51jq9PAiawt1
	Sf1FCE0RvLeEM7XosBT/BWsB2h0pwvzXHTGQ7ZkjCTA8MdJBY4WOrNCViFkNWZTO
	WvIKaFLtZhjjPclr6UJxBb9gjijOWI/tn0HAGOlcxtw2rdVTyAmNzfaRav9mfPek
	52VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1722605395; x=1722691795; bh=uHK+LywJCuCvK
	hPEFLToXWjpdgANSgKtERRw5V+HZEg=; b=HpnU6PAIcz+lOxXWHTcCvPJoNM+Qi
	HoJizfGwIIDTXpGLcdxCsYuJjRgFwArCF6pHDEzG1pqNry9QhKMLwHA/kC1nDyLV
	xU7XfVTruZW5gaPbSnpI59KcVx3uD7p2yiPYzs+tJnhtaC1YjrBky8XUyYLge3X1
	drmNVu/lQoe+9WRrBu8WNhi/NbHkqY/9FTMcagqFOE48WCon79JdP+6tFof5vWV1
	opd5kT6vDnjRjbfKAbDOO2Rnzse0l0WBj0eevHAIU3B20uZF1fQrwe6DQfnJpU4c
	C9g0MJd9Bc1kdYVwj3o6lfOGGF1Qr5W86B4x4WXZ1GR3YzmhL5JqT5moQ==
X-ME-Sender: <xms:Ut-sZp5mCKWJsHL4XTozGB5uRSZyjGP66m6U3DwO7VXF8hzopc9XcQ>
    <xme:Ut-sZm7BY7bZ20IuXa9yH0MXm24szshImsanbARSuYA3mmshkoB4xTeUVazUnS4cu
    mruUpQxucW56W904MM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedtgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeduleeigeekveeugeettdejtddtleeghefhvdfhueehtefhudelffduvdeuleevteen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtoheptd
X-ME-Proxy: <xmx:U9-sZgeICvXQ6Nfki5qbv1zrJWHlwniGRR9Qv8irXyMEUBd9FFEFWg>
    <xmx:U9-sZiKhCYnDwcx_KR0FZKN2Quuw77E6cANE42Qiopg8F-3FudKGaQ>
    <xmx:U9-sZtLreUNZ5ksDiOZjOvt1D2WOTAUfezvAUS5RSR_6KuNq2txZBA>
    <xmx:U9-sZrywRkdp_NA-Na2rktG_oerituAqFkPSfX7UeJeOnK0_-QI7Jw>
    <xmx:U9-sZk-Al8ciI_3REpVqSiPkBMGMBU9sK5qBshLAroUkQ3iel6tgLP-B>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DA3EEB6008D; Fri,  2 Aug 2024 09:29:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Aug 2024 15:29:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, "Jiri Olsa" <jolsa@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 "Florian Weimer" <fweimer@redhat.com>, "Andreas Schwab" <schwab@suse.de>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-api@vger.kernel.org
Message-Id: <9a365229-9f76-47ac-87e2-fdeafe8550ab@app.fastmail.com>
Subject: [GIT PULL] asm-generic: fixes for 6.11
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.11-1

for you to fetch changes up to 343416f0c11c42bed07f6db03ca599f4f1771b17:

  syscalls: fix syscall macros for newfstat/newfstatat (2024-08-02 15:20:47 +0200)

----------------------------------------------------------------
asm-generic: fixes for 6.11

These are three important bug fixes for the cross-architecture tree,
fixing a regression with the new syscall.tbl file, the inconsistent
numbering for the new uretprobe syscall and a bug with iowrite64be
on alpha.

----------------------------------------------------------------
Arnd Bergmann (3):
      alpha: fix ioread64be()/iowrite64be() helpers
      uretprobe: change syscall number, again
      syscalls: fix syscall macros for newfstat/newfstatat

 arch/alpha/include/asm/io.h                             | 4 ++--
 arch/arm64/kernel/Makefile.syscalls                     | 2 +-
 arch/loongarch/kernel/Makefile.syscalls                 | 3 ++-
 arch/riscv/kernel/Makefile.syscalls                     | 2 +-
 arch/x86/entry/syscalls/syscall_64.tbl                  | 2 +-
 include/uapi/asm-generic/unistd.h                       | 5 +----
 scripts/syscall.tbl                                     | 5 ++---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
 8 files changed, 11 insertions(+), 14 deletions(-)
----------------------------------------------------------------
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 2bb8cbeedf91..b191d87f89c4 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -534,8 +534,10 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
 
 #define ioread16be(p) swab16(ioread16(p))
 #define ioread32be(p) swab32(ioread32(p))
+#define ioread64be(p) swab64(ioread64(p))
 #define iowrite16be(v,p) iowrite16(swab16(v), (p))
 #define iowrite32be(v,p) iowrite32(swab32(v), (p))
+#define iowrite64be(v,p) iowrite64(swab64(v), (p))
 
 #define inb_p		inb
 #define inw_p		inw
@@ -634,8 +636,6 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
  */
 #define ioread64 ioread64
 #define iowrite64 iowrite64
-#define ioread64be ioread64be
-#define iowrite64be iowrite64be
 #define ioread8_rep ioread8_rep
 #define ioread16_rep ioread16_rep
 #define ioread32_rep ioread32_rep
diff --git a/arch/arm64/kernel/Makefile.syscalls b/arch/arm64/kernel/Makefile.syscalls
index 3cfafd003b2d..0542a718871a 100644
--- a/arch/arm64/kernel/Makefile.syscalls
+++ b/arch/arm64/kernel/Makefile.syscalls
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 syscall_abis_32 +=
-syscall_abis_64 += renameat newstat rlimit memfd_secret
+syscall_abis_64 += renameat rlimit memfd_secret
 
 syscalltbl = arch/arm64/tools/syscall_%.tbl
diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
index 523bb411a3bc..ab7d9baa2915 100644
--- a/arch/loongarch/kernel/Makefile.syscalls
+++ b/arch/loongarch/kernel/Makefile.syscalls
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_64 += newstat
+# No special ABIs on loongarch so far
+syscall_abis_64 +=
diff --git a/arch/riscv/kernel/Makefile.syscalls b/arch/riscv/kernel/Makefile.syscalls
index 52087a023b3d..9668fd1faf60 100644
--- a/arch/riscv/kernel/Makefile.syscalls
+++ b/arch/riscv/kernel/Makefile.syscalls
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 syscall_abis_32 += riscv memfd_secret
-syscall_abis_64 += riscv newstat rlimit memfd_secret
+syscall_abis_64 += riscv rlimit memfd_secret
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 83073fa3c989..7093ee21c0d1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -344,6 +344,7 @@
 332	common	statx			sys_statx
 333	common	io_pgetevents		sys_io_pgetevents
 334	common	rseq			sys_rseq
+335	common	uretprobe		sys_uretprobe
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	sys_pidfd_send_signal
@@ -385,7 +386,6 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
-467	common	uretprobe		sys_uretprobe
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 985a262d0f9e..5bf6148cac2b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -841,11 +841,8 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
 
-#define __NR_uretprobe 463
-__SYSCALL(__NR_uretprobe, sys_uretprobe)
-
 #undef __NR_syscalls
-#define __NR_syscalls 464
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 591d85e8ca7e..4586a18dfe9b 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -98,9 +98,9 @@
 77	common	tee				sys_tee
 78	common	readlinkat			sys_readlinkat
 79	stat64	fstatat64			sys_fstatat64
-79	newstat	fstatat				sys_newfstatat
+79	64	newfstatat			sys_newfstatat
 80	stat64	fstat64				sys_fstat64
-80	newstat	fstat				sys_newfstat
+80	64	newfstat			sys_newfstat
 81	common	sync				sys_sync
 82	common	fsync				sys_fsync
 83	common	fdatasync			sys_fdatasync
@@ -402,4 +402,3 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
-467	common	uretprobe			sys_uretprobe
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index bd8c75b620c2..5f78edca6540 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
 }
 
 #ifndef __NR_uretprobe
-#define __NR_uretprobe 467
+#define __NR_uretprobe 335
 #endif
 
 __naked unsigned long uretprobe_syscall_call_1(void)

