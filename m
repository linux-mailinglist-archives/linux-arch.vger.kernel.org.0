Return-Path: <linux-arch+bounces-5261-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110C9278E4
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AAE1C20DCF
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD1D1B3741;
	Thu,  4 Jul 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cApuf/Ch"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C761B1218;
	Thu,  4 Jul 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103906; cv=none; b=rDLF1t+w7xQLR5fNn54v4UZr72fDFXIazW+U/07bn7WEvjgwdbotaMWZ6JtUosaQIgwIBobho/KNW0oWLU6yknCqbOiXC7P+WJUzj90kt9XTbtlFLOyx/jP1bgKDy0r00M8EHbb6nu7gprF9anuaUDB1LU30QUQWkcUvp8Jw6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103906; c=relaxed/simple;
	bh=RlwUoPa6usH7GUZMKOc08+J1UN1kqcfKaKnNDtJsta0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tyxb4u81IUJVsutfg4ER58u1bsDLCSyL078hrn1OU/+7ioYIyTHmzVSVsClKu5QindTI2oFACS3lY+YlZHoY96qZ2xxTnArqjmGCL+jvzT6cIvXbJgzMGpkLfxAfskGfgQC5xWvreDpRXiWcnm5Ru0LbCwDsFbKw+/7LBJ+/5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cApuf/Ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130D2C32781;
	Thu,  4 Jul 2024 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103906;
	bh=RlwUoPa6usH7GUZMKOc08+J1UN1kqcfKaKnNDtJsta0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cApuf/CheQFpFENORhWm//pVQ8ai15IgR4LmKNMzOuR16rr2RdCAaLpfrLZuyt6zz
	 zhrlgVC11NJvEly/GNXXXyhizXOEKheltXb35IvFY5YSyAOhpfwJj7qp3dNZYnYboe
	 KUE62IOzp2IjOe1XOd33qxxM5loN1/7ZgycI0Dq3LB1orXI7cs4mbwZiUsw+a+rRyv
	 MW9KSZhWOcx8SxaP+CC8PSQRrubMf8UACbdAeMh6w2NbuEk2ghlGqJmmfohmCI0yXb
	 xk1kxeIRQchSDylYC+6WDONdvFncErEs8PXpv9IUV8fQqwcns4tXjKoBVfmLTm69rT
	 1DfhcTD8tWmGg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 14/17] loongarch: convert to generic syscall table
Date: Thu,  4 Jul 2024 16:36:08 +0200
Message-Id: <20240704143611.2979589-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
References: <20240704143611.2979589-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The uapi/asm/unistd_64.h and asm/syscall_table_64.h headers can now be
generated from scripts/syscall.tbl, which makes this consistent with
the other architectures that have their own syscall.tbl.

Unlike the other architectures using the asm-generic header, loongarch
uses none of the deprecated system calls at the moment.

Both the user visible side of asm/unistd.h and the internal syscall
table in the kernel should have the same effective contents after this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/loongarch/include/asm/Kbuild        | 1 +
 arch/loongarch/include/asm/unistd.h      | 2 ++
 arch/loongarch/include/uapi/asm/Kbuild   | 2 ++
 arch/loongarch/include/uapi/asm/unistd.h | 3 +--
 arch/loongarch/kernel/Makefile.syscalls  | 4 ++++
 arch/loongarch/kernel/syscall.c          | 3 ++-
 6 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 arch/loongarch/kernel/Makefile.syscalls

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 0db5ad14f014..2bb3676429c0 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += syscall_table_64.h
 generated-y += orc_hash.h
 
 generic-y += mcs_spinlock.h
diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include/asm/unistd.h
index cfddb0116a8c..fc0a481a7416 100644
--- a/arch/loongarch/include/asm/unistd.h
+++ b/arch/loongarch/include/asm/unistd.h
@@ -8,4 +8,6 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __ARCH_WANT_SYS_CLONE
+
 #define NR_syscalls (__NR_syscalls)
diff --git a/arch/loongarch/include/uapi/asm/Kbuild b/arch/loongarch/include/uapi/asm/Kbuild
index 4aa680ca2e5f..c6d141d7b7d7 100644
--- a/arch/loongarch/include/uapi/asm/Kbuild
+++ b/arch/loongarch/include/uapi/asm/Kbuild
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += unistd_64.h
+
 generic-y += kvm_para.h
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index 191614b9b207..1f01980f9c94 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -1,4 +1,3 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#define __ARCH_WANT_SYS_CLONE
 
-#include <asm-generic/unistd.h>
+#include <asm/unistd_64.h>
diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
new file mode 100644
index 000000000000..ab7d9baa2915
--- /dev/null
+++ b/arch/loongarch/kernel/Makefile.syscalls
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# No special ABIs on loongarch so far
+syscall_abis_64 +=
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index 8801611143ab..ec17cd5163b7 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -20,6 +20,7 @@
 
 #undef __SYSCALL
 #define __SYSCALL(nr, call)	[nr] = (call),
+#define __SYSCALL_WITH_COMPAT(nr, native, compat) __SYSCALL(nr, native)
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long,
 		prot, unsigned long, flags, unsigned long, fd, unsigned long, offset)
@@ -32,7 +33,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long,
 
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
-#include <asm/unistd.h>
+#include <asm/syscall_table_64.h>
 };
 
 typedef long (*sys_call_fn)(unsigned long, unsigned long,
-- 
2.39.2


