Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C0F394F9F
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 06:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhE3E4C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 May 2021 00:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhE3Ez7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 May 2021 00:55:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86B9F61107;
        Sun, 30 May 2021 04:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622350462;
        bh=ld9Tfr3N3Uv38Fxhir93icz1umeDF3KkC8aAIxDQbwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOIfg7mlMFZ1nQjdb4dqKXiGjWv4ZyQCW5AnwlKX6jwR73kWxxyGvpdHy5IQzeaBD
         IEzoWQrCygRhksdK7aK5cMQKinDPutXSMAHrAwbkGOLxOeDx8/tb+dOmendeBqkkDZ
         ieD8GayYjH0sb0/1H7KbridiCWa01JtL9eb11ox3sQ8j4zIipLtZZaFy3SZHNB9rkR
         RIgRwDYwp0jpwcFYar1ima3HLNARvxAEv11BDw/T+2AToUFlgU6JupO+Dbm5fN+CRK
         zBAoP7A57auTr3bwrq6C3F2/udTLN6gxgnvtghKzPjKhZlVuUFmOIhmwpq0aI+ewnt
         qYKfgTpAJA5AA==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 1/2] riscv: Cleanup unused functions
Date:   Sun, 30 May 2021 04:53:27 +0000
Message-Id: <1622350408-44875-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622350408-44875-1-git-send-email-guoren@kernel.org>
References: <1622350408-44875-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

These functions haven't been used, so just remove them. The patch
has been tested with riscv.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/page.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 6a7761c..a1b888f 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -37,16 +37,6 @@
 
 #ifndef __ASSEMBLY__
 
-#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
-#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
-
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr, size)	_ALIGN_UP(addr, size)
-
 #define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
 #define copy_page(to, from)			memcpy((to), (from), PAGE_SIZE)
 
-- 
2.7.4

