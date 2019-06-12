Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B528428B2
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2019 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409285AbfFLOV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jun 2019 10:21:28 -0400
Received: from foss.arm.com ([217.140.110.172]:53922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409269AbfFLOV2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 10:21:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C827337;
        Wed, 12 Jun 2019 07:21:27 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 184D13F557;
        Wed, 12 Jun 2019 07:21:25 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 1/2] arm64: Define Documentation/arm64/tagged-address-abi.txt
Date:   Wed, 12 Jun 2019 15:21:10 +0100
Message-Id: <20190612142111.28161-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612142111.28161-1-vincenzo.frascino@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
the userspace (EL0) is allowed to set a non-zero value in the
top byte but the resulting pointers are not allowed at the
user-kernel syscall ABI boundary.

With the relaxed ABI proposed through this document, it is now possible
to pass tagged pointers to the syscalls, when these pointers are in
memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().

This change in the ABI requires a mechanism to requires the userspace
to opt-in to such an option.

Specify and document the way in which sysctl and prctl() can be used
in combination to allow the userspace to opt-in this feature.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
CC: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/arm64/tagged-address-abi.txt | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/arm64/tagged-address-abi.txt

diff --git a/Documentation/arm64/tagged-address-abi.txt b/Documentation/arm64/tagged-address-abi.txt
new file mode 100644
index 000000000000..96e149e2c55c
--- /dev/null
+++ b/Documentation/arm64/tagged-address-abi.txt
@@ -0,0 +1,111 @@
+ARM64 TAGGED ADDRESS ABI
+========================
+
+This document describes the usage and semantics of the Tagged Address
+ABI on arm64.
+
+1. Introduction
+---------------
+
+On arm64 the TCR_EL1.TBI0 bit has been always enabled on the arm64 kernel,
+hence the userspace (EL0) is allowed to set a non-zero value in the top
+byte but the resulting pointers are not allowed at the user-kernel syscall
+ABI boundary.
+
+This document describes a relaxation of the ABI with which it is possible
+to pass tagged tagged pointers to the syscalls, when these pointers are in
+memory ranges obtained as described in paragraph 2.
+
+Since it is not desirable to relax the ABI to allow tagged user addresses
+into the kernel indiscriminately, arm64 provides a new sysctl interface
+(/proc/sys/abi/tagged_addr) that is used to prevent the applications from
+enabling the relaxed ABI and a new prctl() interface that can be used to
+enable or disable the relaxed ABI.
+
+The sysctl is meant also for testing purposes in order to provide a simple
+way for the userspace to verify the return error checking of the prctl()
+command without having to reconfigure the kernel.
+
+The ABI properties are inherited by threads of the same application and
+fork()'ed children but cleared when a new process is spawn (execve()).
+
+2. ARM64 Tagged Address ABI
+---------------------------
+
+From the kernel syscall interface prospective, we define, for the purposes
+of this document, a "valid tagged pointer" as a pointer that either it has
+a zero value set in the top byte or it has a non-zero value, it is in memory
+ranges privately owned by a userspace process and it is obtained in one of
+the following ways:
+  - mmap() done by the process itself, where either:
+    * flags = MAP_PRIVATE | MAP_ANONYMOUS
+    * flags = MAP_PRIVATE and the file descriptor refers to a regular
+      file or "/dev/zero"
+  - a mapping below sbrk(0) done by the process itself
+  - any memory mapped by the kernel in the process's address space during
+    creation and following the restrictions presented above (i.e. data, bss,
+    stack).
+
+The ARM64 Tagged Address ABI is an opt-in feature, and an application can
+control it using the following prctl()s:
+  - PR_SET_TAGGED_ADDR_CTRL: can be used to enable the Tagged Address ABI.
+  - PR_GET_TAGGED_ADDR_CTRL: can be used to check the status of the Tagged
+                             Address ABI.
+
+As a consequence of invoking PR_SET_TAGGED_ADDR_CTRL prctl() by an applications,
+the ABI guarantees the following behaviours:
+
+  - Every current or newly introduced syscall can accept any valid tagged
+    pointers.
+
+  - If a non valid tagged pointer is passed to a syscall then the behaviour
+    is undefined.
+
+  - Every valid tagged pointer is expected to work as an untagged one.
+
+  - The kernel preserves any valid tagged pointers and returns them to the
+    userspace unchanged in all the cases except the ones documented in the
+    "Preserving tags" paragraph of tagged-pointers.txt.
+
+A definition of the meaning of tagged pointers on arm64 can be found in:
+Documentation/arm64/tagged-pointers.txt.
+
+3. ARM64 Tagged Address ABI Exceptions
+--------------------------------------
+
+The behaviours described in paragraph 2, with particular reference to the
+acceptance by the syscalls of any valid tagged pointer are not applicable
+to the following cases:
+  - mmap() addr parameter.
+  - mremap() new_address parameter.
+  - prctl_set_mm() struct prctl_map fields.
+  - prctl_set_mm_map() struct prctl_map fields.
+
+4. Example of correct usage
+---------------------------
+
+void main(void)
+{
+	static int tbi_enabled = 0;
+	unsigned long tag = 0;
+
+	char *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			 MAP_ANONYMOUS, -1, 0);
+
+	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
+		  0, 0, 0) == 0)
+		tbi_enabled = 1;
+
+	if (!ptr)
+		return -1;
+
+	if (tbi_enabled)
+		tag = rand() & 0xff;
+
+	ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
+
+	*ptr = 'a';
+
+	...
+}
+
-- 
2.21.0

