Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3343E9C
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbfFMPv7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:51:59 -0400
Received: from foss.arm.com ([217.140.110.172]:43874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389906AbfFMPv6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 11:51:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B8E0A78;
        Thu, 13 Jun 2019 08:51:57 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1748E3F246;
        Thu, 13 Jun 2019 08:51:55 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v5 2/2] arm64: Relax Documentation/arm64/tagged-pointers.txt
Date:   Thu, 13 Jun 2019 16:51:37 +0100
Message-Id: <20190613155137.47675-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613155137.47675-1-vincenzo.frascino@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190613155137.47675-1-vincenzo.frascino@arm.com>
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

With the relaxed ABI proposed in this set, it is now possible to pass
tagged pointers to the syscalls, when these pointers are in memory
ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().

Relax the requirements described in tagged-pointers.txt to be compliant
with the behaviours guaranteed by the ARM64 Tagged Address ABI.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
CC: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/arm64/tagged-pointers.txt | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..e33af14478e3 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -18,7 +18,8 @@ Passing tagged addresses to the kernel
 --------------------------------------
 
 All interpretation of userspace memory addresses by the kernel assumes
-an address tag of 0x00.
+an address tag of 0x00, unless the userspace opts-in the ARM64 Tagged
+Address ABI via the PR_SET_TAGGED_ADDR_CTRL prctl().
 
 This includes, but is not limited to, addresses found in:
 
@@ -31,18 +32,23 @@ This includes, but is not limited to, addresses found in:
  - the frame pointer (x29) and frame records, e.g. when interpreting
    them to generate a backtrace or call graph.
 
-Using non-zero address tags in any of these locations may result in an
-error code being returned, a (fatal) signal being raised, or other modes
-of failure.
+Using non-zero address tags in any of these locations when the
+userspace application did not opt-in to the ARM64 Tagged Address ABI
+may result in an error code being returned, a (fatal) signal being raised,
+or other modes of failure.
 
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
-strongly discouraged.
+For these reasons, when the userspace application did not opt-in, passing
+non-zero address tags to the kernel via system calls is forbidden, and using
+a non-zero address tag for sp is strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
 address tags may suffer impaired or inaccurate debug and profiling
 visibility.
 
+A definition of the meaning of ARM64 Tagged Address ABI and of the
+guarantees that the ABI provides when the userspace opts-in via prctl()
+can be found in: Documentation/arm64/tagged-address-abi.txt.
+
 
 Preserving tags
 ---------------
@@ -57,6 +63,9 @@ be preserved.
 The architecture prevents the use of a tagged PC, so the upper byte will
 be set to a sign-extension of bit 55 on exception return.
 
+These behaviours are preserved even when the userspace opts-in to the ARM64
+Tagged Address ABI via the PR_SET_TAGGED_ADDR_CTRL prctl().
+
 
 Other considerations
 --------------------
-- 
2.21.0

