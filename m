Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD082F39
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2019 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbfHFKBN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Aug 2019 06:01:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36097 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732583AbfHFKBM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 06:01:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id x67so29292231ywd.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Aug 2019 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1kq35amQF0eADWBqq2tRXGYPbvo4jnAQagrNi2mP5k=;
        b=ryN6Ug8NTpg6DdZSRbeCs9SgNy9VYtFjReXZvH386JZijbFKUzuZ1IjFN+pJi8xLPk
         LukM2OHMl1jpO+jAcXDzJzG1kaH2PnG+tcT5DoqbCGgCYAsjKehsHtqdpjk7TYaP+3CV
         HZ1GbOcghRxf92Hbf1SK5LK2/I8WDRR2FVLhSdgtj7ZW3y/uM0N3UDKoHjXcgpIcRbHD
         1AYRQOWT3JC1YJ6kRjEADY9+WyGfW67uyh8F5pYDNBg65QJ+un2Ii1vzMKBODmSrobuN
         Vw2Yd3mHVNb3h8K0DrfYubyUTL2jde6CpXbbokcZVLtq5/WG2hhHq4YewOfhnaY442nK
         tnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X1kq35amQF0eADWBqq2tRXGYPbvo4jnAQagrNi2mP5k=;
        b=eiEJ28/oVkJaZJUSFEkE0+7qWwIxkl71R3S9KAvF/pntiIvVOsuEbEwbKYpPFlHRvm
         qIQgvIJTAZn48URXwufhMmMDdvYoWXqmEn0tkdOkQb+FkOJpAkeRQxxAg4nLwv1Fxnru
         wCtJdD5bvh9LCn6Z42Si9TS60AJFdecBbB/FPMdVbDCoQyMyd3X+jpSfrxsL7ZfdegS8
         bO9mjVh3Sf9rIOi31gjxsDNLESutppZTVZr+q5cuNYr0bP9inaXYfdlREWiuMvGETh/R
         DASAxSFIbOKyIc+nMcWXlwUevDlme6AttdSBvg75aWHl1HIUq6x/SeqnrzJX8u0l6iqQ
         ivsw==
X-Gm-Message-State: APjAAAVJ8z8fA8cJCBY+P8uatjQjIX1ABnaOtpRPIPyIV3j3I0aKFpeo
        s9vKCZGe6R9OkkAKPwblTgRYtA==
X-Google-Smtp-Source: APXvYqwIma0HV1pnR7Z1+fYCWlNvk6seDzFUGYoiNt+a7UQALBxCkV/06ohxlMAH3c2ynUJgGkffCA==
X-Received: by 2002:a81:2545:: with SMTP id l66mr1596296ywl.489.1565085671977;
        Tue, 06 Aug 2019 03:01:11 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id h12sm18316685ywm.91.2019.08.06.03.01.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 03:01:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/3] arm64: Add support for function error injection
Date:   Tue,  6 Aug 2019 18:00:14 +0800
Message-Id: <20190806100015.11256-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806100015.11256-1-leo.yan@linaro.org>
References: <20190806100015.11256-1-leo.yan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Inspired by the commit 7cd01b08d35f ("powerpc: Add support for function
error injection"), this patch supports function error injection for
Arm64.

This patch mainly support two functions: one is regs_set_return_value()
which is used to overwrite the return value; the another function is
override_function_with_return() which is to override the probed
function returning and jump to its caller.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/ptrace.h |  5 +++++
 arch/arm64/lib/Makefile         |  2 ++
 arch/arm64/lib/error-inject.c   | 18 ++++++++++++++++++
 4 files changed, 26 insertions(+)
 create mode 100644 arch/arm64/lib/error-inject.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..b15803afb2a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -148,6 +148,7 @@ config ARM64
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index b1dd039023ef..891b9995cb4b 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -301,6 +301,11 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->regs[0];
 }
 
+static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
+{
+	regs->regs[0] = rc;
+}
+
 /**
  * regs_get_kernel_argument() - get Nth function argument in kernel
  * @regs:	pt_regs of that context
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 33c2a4abda04..f182ccb0438e 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -33,3 +33,5 @@ UBSAN_SANITIZE_atomic_ll_sc.o	:= n
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
 obj-$(CONFIG_CRC32) += crc32.o
+
+obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/arm64/lib/error-inject.c b/arch/arm64/lib/error-inject.c
new file mode 100644
index 000000000000..ed15021da3ed
--- /dev/null
+++ b/arch/arm64/lib/error-inject.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/error-injection.h>
+#include <linux/kprobes.h>
+
+void override_function_with_return(struct pt_regs *regs)
+{
+	/*
+	 * 'regs' represents the state on entry of a predefined function in
+	 * the kernel/module and which is captured on a kprobe.
+	 *
+	 * When kprobe returns back from exception it will override the end
+	 * of probed function and directly return to the predefined
+	 * function's caller.
+	 */
+	instruction_pointer_set(regs, procedure_link_pointer(regs));
+}
+NOKPROBE_SYMBOL(override_function_with_return);
-- 
2.17.1

