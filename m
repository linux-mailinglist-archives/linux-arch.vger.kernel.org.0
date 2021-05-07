Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B7F376C22
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEGWLf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 18:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhEGWLd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 May 2021 18:11:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6537660BD3;
        Fri,  7 May 2021 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620425432;
        bh=oc9F9bd1TnpYAIb3VN/1qiEMkWJesRL8jfDTmWlWUGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nw6qquvufPX+k++Xk2t2woyJiC2pwb01FCvA/OeU4Z38RGNkkPeqvWFn7MXKSa3sD
         aJBf9NYU21ENmlvUbFB8kZ6DSfkz010goXTrlxlkfx/Mw0/dJe6MzGdXVFlOHKzJUf
         aRVl9AyXH9nOm+hMjV5Vwrl4B0y+VYXGYSDsii/GcUI/XF8CW7E5YgJDCAIh+SEl5t
         dIW7Pmxfpo/x+Dx2wChZLGb8zFxH4ypWRPfTA8RIbzDFiHpkPbW1h8Zi4qJt2kapVv
         rLGDVmIgVjsMjlDO9a3v7C2qudR/gqFY7Gnu5KG9xzfizNMjaYyebBf0rxZS9EcDOa
         lcuXHwD0Tkhiw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [RFC 04/12] m68k: select CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Date:   Sat,  8 May 2021 00:07:49 +0200
Message-Id: <20210507220813.365382-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210507220813.365382-1-arnd@kernel.org>
References: <20210507220813.365382-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All supported CPUs other than the old dragonball use the
include/linux/unaligned/access_ok.h implementation for accessing unaligned
variables, so presumably this works everywhere.

However, m68k never selects CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
so none of the other conditionals in the kernel get the optimized
implementation.

Select this based on CPU_HAS_NO_UNALIGNED to make the two settings
always match, and then use the generic version of the header.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/Kconfig                 |  1 +
 arch/m68k/include/asm/unaligned.h | 19 -------------------
 2 files changed, 1 insertion(+), 19 deletions(-)
 delete mode 100644 arch/m68k/include/asm/unaligned.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 5f1aafa7b2e2..9b586752807e 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -22,6 +22,7 @@ config M68K
 	select HAVE_AOUT if MMU
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
 	select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
 	select HAVE_IDE
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
diff --git a/arch/m68k/include/asm/unaligned.h b/arch/m68k/include/asm/unaligned.h
deleted file mode 100644
index 84e437337344..000000000000
--- a/arch/m68k/include/asm/unaligned.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_M68K_UNALIGNED_H
-#define _ASM_M68K_UNALIGNED_H
-
-#ifdef CONFIG_CPU_HAS_NO_UNALIGNED
-#include <asm-generic/unaligned.h>
-#else
-/*
- * The m68k can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
-#endif
-
-#endif /* _ASM_M68K_UNALIGNED_H */
-- 
2.29.2

