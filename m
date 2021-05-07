Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F0376C24
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhEGWLl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 18:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhEGWLk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 May 2021 18:11:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 808A260BD3;
        Fri,  7 May 2021 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620425440;
        bh=/5Z2nTypaGPm1iUklcmpyCaywzQFUCDFz30ObBTQeAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gb8JLH6PnPCyUuTjt1zravgHEauccOMo//1gm4Ob+XzgibOh2sZwvcFPjbOBr3KLH
         Hr8Kg5SPDDvXO1eDoc76mzoMI0DmJZ5bauY1FOtJ9Y+VQgoUxIbjjWFhUqWtm0ZE6U
         ccrgFVWUJH2I6z4ByC/VgauJEc4z8U4C5DUol4HvhxuyWw6DePMNZyjXwT2UhEK5dl
         JR0tzl941Va7JqTmikcPsN2NF2Pwr2w3XAbYyu9skFzFhyqZRwbs9IVsZdHNNdwGg3
         TXdxlS/2t6ZEjHmmAlX6xMmrB99X9yY15pd7fjNbJ7D46GJ8NsvgQbIGg0M5H1eQlm
         j+OrtSAeUv7jw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC 05/12] powerpc: use linux/unaligned/le_struct.h on LE power7
Date:   Sat,  8 May 2021 00:07:50 +0200
Message-Id: <20210507220813.365382-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210507220813.365382-1-arnd@kernel.org>
References: <20210507220813.365382-1-arnd@kernel.org>
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

