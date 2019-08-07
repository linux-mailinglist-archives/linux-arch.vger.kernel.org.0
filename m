Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75185056
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2019 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbfHGPxa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Aug 2019 11:53:30 -0400
Received: from foss.arm.com ([217.140.110.172]:50680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388779AbfHGPxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Aug 2019 11:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B05C015A2;
        Wed,  7 Aug 2019 08:53:29 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D4823F706;
        Wed,  7 Aug 2019 08:53:28 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v7 2/2] arm64: Relax Documentation/arm64/tagged-pointers.rst
Date:   Wed,  7 Aug 2019 16:53:21 +0100
Message-Id: <20190807155321.9648-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
In-Reply-To: <20190807155321.9648-1-catalin.marinas@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
the userspace (EL0) is allowed to set a non-zero value in the
top byte but the resulting pointers are not allowed at the
user-kernel syscall ABI boundary.

With the relaxed ABI proposed in this set, it is now possible to pass
tagged pointers to the syscalls, when these pointers are in memory
ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().

Relax the requirements described in tagged-pointers.rst to be compliant
with the behaviours guaranteed by the ARM64 Tagged Address ABI.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
[catalin.marinas@arm.com: minor tweaks]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arm64/tagged-pointers.rst | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
index 2acdec3ebbeb..82a3eff71a70 100644
--- a/Documentation/arm64/tagged-pointers.rst
+++ b/Documentation/arm64/tagged-pointers.rst
@@ -20,7 +20,8 @@ Passing tagged addresses to the kernel
 --------------------------------------
 
 All interpretation of userspace memory addresses by the kernel assumes
-an address tag of 0x00.
+an address tag of 0x00, unless the application enables the AArch64
+Tagged Address ABI explicitly.
 
 This includes, but is not limited to, addresses found in:
 
@@ -33,18 +34,23 @@ This includes, but is not limited to, addresses found in:
  - the frame pointer (x29) and frame records, e.g. when interpreting
    them to generate a backtrace or call graph.
 
-Using non-zero address tags in any of these locations may result in an
-error code being returned, a (fatal) signal being raised, or other modes
-of failure.
+Using non-zero address tags in any of these locations when the
+userspace application did not enable the AArch64 Tagged Address ABI may
+result in an error code being returned, a (fatal) signal being raised,
+or other modes of failure.
 
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
-strongly discouraged.
+For these reasons, when the AArch64 Tagged Address ABI is disabled,
+passing non-zero address tags to the kernel via system calls is
+forbidden, and using a non-zero address tag for sp is strongly
+discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
 address tags may suffer impaired or inaccurate debug and profiling
 visibility.
 
+The AArch64 Tagged Address ABI description and the guarantees it
+provides can be found in: Documentation/arm64/tagged-address-abi.rst.
+
 
 Preserving tags
 ---------------
@@ -59,6 +65,9 @@ be preserved.
 The architecture prevents the use of a tagged PC, so the upper byte will
 be set to a sign-extension of bit 55 on exception return.
 
+This behaviour is preserved when the AArch64 Tagged Address ABI is
+enabled.
+
 
 Other considerations
 --------------------
