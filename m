Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB78C3806B3
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhENKEq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232897AbhENKEo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:04:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97846613BC;
        Fri, 14 May 2021 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986613;
        bh=/5Z2nTypaGPm1iUklcmpyCaywzQFUCDFz30ObBTQeAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuUEmv6zCsBFzinGG7k0oPndGjym5M6khrmucGBOZKerUkqGE/otWxORJW8gJzNPG
         F0UEFdyArRYsZxc0t6RxSk6QtsACfiRnlkmzlnctJZPV2VJMe/JWTMIK50H08gqGuS
         mHYpPfX6EkR/32ZcHHrKyVTg5pJHv45TDcNdgByX3DwXVnh0USAYj8SNY14C7l1Gct
         1RCyWf1e+HhXXSYMNKuvK4G8EjXESYqU+3u7H6xEUO6DtW/Cu4FnA2QzJcL8jqIwS5
         re5/z9SHw06Yf8Pamnpw21UDgJjiKpTKr1SN7KJkZ+iIxIC6ow67kT9Yx1Zgm3hgIY
         CSsXiDtxLwFrA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] powerpc: use linux/unaligned/le_struct.h on LE power7
Date:   Fri, 14 May 2021 12:00:53 +0200
Message-Id: <20210514100106.3404011-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Little-endian POWER7 kernels disable
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS because that is not supported on
the hardware, but the kernel still uses direct load/store for explicti
get_unaligned()/put_unaligned().

I assume this is a mistake that leads to power7 having to trap and fix
up all these unaligned accesses at a noticeable performance cost.

The fix is completely trivial, just remove the file and use the
generic version that gets it right.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/unaligned.h | 22 ----------------------
 1 file changed, 22 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/unaligned.h

diff --git a/arch/powerpc/include/asm/unaligned.h b/arch/powerpc/include/asm/unaligned.h
deleted file mode 100644
index ce69c5eff95e..000000000000
--- a/arch/powerpc/include/asm/unaligned.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_UNALIGNED_H
-#define _ASM_POWERPC_UNALIGNED_H
-
-#ifdef __KERNEL__
-
-/*
- * The PowerPC can do unaligned accesses itself based on its endian mode.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#ifdef __LITTLE_ENDIAN__
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
-#else
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-#endif
-
-#endif	/* __KERNEL__ */
-#endif	/* _ASM_POWERPC_UNALIGNED_H */
-- 
2.29.2

