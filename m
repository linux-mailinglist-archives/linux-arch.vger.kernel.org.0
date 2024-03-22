Return-Path: <linux-arch+bounces-3104-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63338886814
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 09:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9462A1C23CE0
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C028171C9;
	Fri, 22 Mar 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="JuGtM0tf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0362171BA;
	Fri, 22 Mar 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095424; cv=none; b=qAWAgvdleKkszq7DCs4KOkSIvCrGv2+LGWUsEFWECEgw8oYA9ty6TlYsGIF6dGQge06moiUGjRq6T/uXHGFXgTG9EVjUOCySpB95vNjZyRMshyRHC/Hp3GaYnz6GN4mrMCxslqoiKvPRtdDfLq106kIAzc5rovomm5Qfg9h5iIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095424; c=relaxed/simple;
	bh=G7RBzwIgb5QiL9kTtpqRRxwj3m/Y/RELefnFYmC61xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fG6rCTrUJ9utzzq9gZKYm04POCK2KZA3ZeAoVDGSaYdqAm0COfs9H43o2EcPZuSmIeTkZ4we3C4PmzznS1BriggF042pfRpDTOSezLxtEDS7oNAH1CpNX4ljgVMDFCN211s6XoHFOnMLUUlj+9qUGO2HfmwDWtZgNCtx5jWpWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JuGtM0tf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42M8GG9e3346191
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 22 Mar 2024 01:16:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42M8GG9e3346191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1711095381;
	bh=k7eKfOcnuljC+WdHZ/WvG4Vv4XD7QPRuthF5whrgwF8=;
	h=From:To:Cc:Subject:Date:From;
	b=JuGtM0tfu2fMqhIFFArB2uZWF+01NrS3nd8DhPk1sXKePwN4vKwJm70aIdLap8sMt
	 bkSNerFhQQ257nyuye8Hd7DP+r2vcORa1bihR1bPrvDALT+J0KqxlXfg3hMFq3O4Fn
	 t1ynGTKCsGGFMh9bW0TCO/Q/8aeRhcN8ukr86ksHcMHFWq5eCvQVbXSDmR6tc8AjDE
	 TvuAclOnO93GMlohYvihnxb4fYZGdocn71wWdH6CqZXO9bISwZKIueiEhP33jCXTI/
	 bYTu7XZjgnuBvcECdB72tegow3CsDLVhb47IYC65XMLvkT7rYAX6zhyjMzNhuM8DP4
	 gh3QA90BSWvWA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, arnd@arndb.de
Subject: [PATCH v3 1/1] x86: Rename __{start,end}_init_task to __{start,end}_init_stack
Date: Fri, 22 Mar 2024 01:16:16 -0700
Message-ID: <20240322081616.3346181-1-xin@zytor.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The stack of a task has been separated from the memory of a task_struct
struture for a long time on x86, as a result __{start,end}_init_task no
longer mark the start and end of the init_task structure, but its stack
only.

Rename __{start,end}_init_task to __{start,end}_init_stack.

Note other architectures are not affected because __{start,end}_init_task
are used on x86 only.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change since v2:
* Rebase to the latest tip master branch.

Change since v1:
* Revert an accident insane change, init_task to init_stack (Jürgen Groß).
---
 arch/x86/kernel/vmlinux.lds.S     | 2 +-
 include/asm-generic/vmlinux.lds.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d430880175f2..3509afc6a672 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -168,7 +168,7 @@ SECTIONS
 		INIT_TASK_DATA(THREAD_SIZE)
 
 		/* equivalent to task_pt_regs(&init_task) */
-		__top_init_kernel_stack = __end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
+		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
 
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cb46306d8305..9752eb420ffa 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -399,13 +399,13 @@
 
 #define INIT_TASK_DATA(align)						\
 	. = ALIGN(align);						\
-	__start_init_task = .;						\
+	__start_init_stack = .;						\
 	init_thread_union = .;						\
 	init_stack = .;							\
 	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
-	. = __start_init_task + THREAD_SIZE;				\
-	__end_init_task = .;
+	. = __start_init_stack + THREAD_SIZE;				\
+	__end_init_stack = .;
 
 #define JUMP_TABLE_DATA							\
 	. = ALIGN(8);							\

base-commit: 93387dba36cc9033724d8b874a5cf6779ef084ab
-- 
2.44.0


