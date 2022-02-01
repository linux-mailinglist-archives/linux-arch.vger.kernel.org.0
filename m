Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56FA4A5F2C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 16:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiBAPGw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 10:06:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33784 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbiBAPGr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 10:06:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 296C861680;
        Tue,  1 Feb 2022 15:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EB5C340ED;
        Tue,  1 Feb 2022 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643728006;
        bh=6RCP1MbfY3qIKsgFkltTUZn3CISwR+fj5txYEFK2Mmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AHbMjDBVv5SoA0kqfKwHnT+GA6pcUpJ0Q4Ugk9+SwePY2+vPh7KeWveVpkgtbgi0+
         ShegbA6FaJVC9QlIqzaa4QirpW/76U5dzYirCWLTmmBlydHcyfeNwC7M1MQmCK8oWj
         eVcSLo6MN2nWtcydL9NBNOSC0kzsUsW7gM9aTik0ZR0c08FOWzThDWLAoE/AM+p48g
         8UgphfAK65nZJBas75e0LI3MNKH6zTdjCDdA6uVblGgyNW1GYNHJ/OJONPMgLolcXK
         bzBZi41RCtdSqWZzcZxpPDN1u13pC45dmx2qp0wBYjfBqG9VFvWRXt3ymC/vd0ssFy
         EOouSEvDv8sBg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 07/21] syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
Date:   Tue,  1 Feb 2022 23:05:31 +0800
Message-Id: <20220201150545.1512822-8-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201150545.1512822-1-guoren@kernel.org>
References: <20220201150545.1512822-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Make "uapi asm unistd.h" could be used for architectures' COMPAT
mode. The __SYSCALL_COMPAT is first used in riscv.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/asm-generic/unistd.h       | 4 ++--
 tools/include/uapi/asm-generic/unistd.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1c48b0ae3ba3..45fa180cc56a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -383,7 +383,7 @@ __SYSCALL(__NR_syslog, sys_syslog)
 
 /* kernel/ptrace.c */
 #define __NR_ptrace 117
-__SYSCALL(__NR_ptrace, sys_ptrace)
+__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
 
 /* kernel/sched/core.c */
 #define __NR_sched_setparam 118
@@ -779,7 +779,7 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
-#if __BITS_PER_LONG == 32
+#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
 #define __NR_clock_settime64 404
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 1c48b0ae3ba3..45fa180cc56a 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -383,7 +383,7 @@ __SYSCALL(__NR_syslog, sys_syslog)
 
 /* kernel/ptrace.c */
 #define __NR_ptrace 117
-__SYSCALL(__NR_ptrace, sys_ptrace)
+__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
 
 /* kernel/sched/core.c */
 #define __NR_sched_setparam 118
@@ -779,7 +779,7 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
-#if __BITS_PER_LONG == 32
+#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
 #define __NR_clock_settime64 404
-- 
2.25.1

