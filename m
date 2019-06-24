Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1E50168
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 07:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfFXFry (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 01:47:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFry (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 01:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cI5ESyw+Iq18O8e33ryH8TCCdHen6nuLvHUOfsxNyOI=; b=gCesECnIRfFXD9GuZknMwOvdeR
        TYvLB4zrxrJUBN/4Wp5/G4533FVQy9u+fOBOth2IMjO9h/G2Oe5H3TcoNddfWo3Zhgx7oPQfIxBbC
        gTxhFcwzzOZ9lFC3ITBdzIFz8OwFvhtP6I4EgUnRuw8knw1w+1x+gG7MUI8RSlShFhrmfEphZooYE
        5tudyHzG5fca51XbJcuHW8kcoZj7DjZ3to09ftF/MkQ3etAl6sMCqO1olLTodjeoIrjEqLEPyZMOD
        zNm97jYcmA4nwCIRIKxi5WqZRyMFpLv3/QlJrbenwLahGKcSs0twUb6BCaYlEi5k2FqMEuWU+0EDr
        x8CZ1zMA==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHpT-0000ac-NY; Mon, 24 Jun 2019 05:47:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] asm-generic: remove ptrace.h
Date:   Mon, 24 Jun 2019 07:47:28 +0200
Message-Id: <20190624054728.30966-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624054728.30966-1-hch@lst.de>
References: <20190624054728.30966-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No one is using this header anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
---
 MAINTAINERS                    |  1 -
 arch/mips/include/asm/ptrace.h |  5 ---
 include/asm-generic/ptrace.h   | 73 ----------------------------------
 3 files changed, 79 deletions(-)
 delete mode 100644 include/asm-generic/ptrace.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735994a5..43e5b6e215a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12778,7 +12778,6 @@ F:	include/linux/regset.h
 F:	include/linux/tracehook.h
 F:	include/uapi/linux/ptrace.h
 F:	include/uapi/linux/ptrace.h
-F:	include/asm-generic/ptrace.h
 F:	kernel/ptrace.c
 F:	arch/*/ptrace*.c
 F:	arch/*/*/ptrace*.c
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index b6578611dddb..1e76774b36dd 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -56,11 +56,6 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 	return regs->regs[31];
 }
 
-/*
- * Don't use asm-generic/ptrace.h it defines FP accessors that don't make
- * sense on MIPS.  We rather want an error if they get invoked.
- */
-
 static inline void instruction_pointer_set(struct pt_regs *regs,
                                            unsigned long val)
 {
diff --git a/include/asm-generic/ptrace.h b/include/asm-generic/ptrace.h
deleted file mode 100644
index ab16b6cb1028..000000000000
--- a/include/asm-generic/ptrace.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Common low level (register) ptrace helpers
- *
- * Copyright 2004-2011 Analog Devices Inc.
- */
-
-#ifndef __ASM_GENERIC_PTRACE_H__
-#define __ASM_GENERIC_PTRACE_H__
-
-#ifndef __ASSEMBLY__
-
-/* Helpers for working with the instruction pointer */
-#ifndef GET_IP
-#define GET_IP(regs) ((regs)->pc)
-#endif
-#ifndef SET_IP
-#define SET_IP(regs, val) (GET_IP(regs) = (val))
-#endif
-
-static inline unsigned long instruction_pointer(struct pt_regs *regs)
-{
-	return GET_IP(regs);
-}
-static inline void instruction_pointer_set(struct pt_regs *regs,
-                                           unsigned long val)
-{
-	SET_IP(regs, val);
-}
-
-#ifndef profile_pc
-#define profile_pc(regs) instruction_pointer(regs)
-#endif
-
-/* Helpers for working with the user stack pointer */
-#ifndef GET_USP
-#define GET_USP(regs) ((regs)->usp)
-#endif
-#ifndef SET_USP
-#define SET_USP(regs, val) (GET_USP(regs) = (val))
-#endif
-
-static inline unsigned long user_stack_pointer(struct pt_regs *regs)
-{
-	return GET_USP(regs);
-}
-static inline void user_stack_pointer_set(struct pt_regs *regs,
-                                          unsigned long val)
-{
-	SET_USP(regs, val);
-}
-
-/* Helpers for working with the frame pointer */
-#ifndef GET_FP
-#define GET_FP(regs) ((regs)->fp)
-#endif
-#ifndef SET_FP
-#define SET_FP(regs, val) (GET_FP(regs) = (val))
-#endif
-
-static inline unsigned long frame_pointer(struct pt_regs *regs)
-{
-	return GET_FP(regs);
-}
-static inline void frame_pointer_set(struct pt_regs *regs,
-                                     unsigned long val)
-{
-	SET_FP(regs, val);
-}
-
-#endif /* __ASSEMBLY__ */
-
-#endif
-- 
2.20.1

