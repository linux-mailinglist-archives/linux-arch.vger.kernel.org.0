Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923E210C30
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 19:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfEARke (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 13:40:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARkc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 13:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pOou/ppKBZsG8Fa0cGZSx5FVIYbiCMVXa/R+x+Q63f0=; b=XrWeMdcYvqlERkMYm3QhMrYDqy
        /gr6kOiJkfoUzUYFzZ3WoIF4DqnqysFqXEjQgnj/tPIqW52/JQrluvxUPeAxx1QTqgaLZ/aZBYBQf
        QHVhmew11rUsSSgj5lOGSQaFHeEIls8M3G8yt5ScY8cuIv7OWclvxcWMAlhK8yqAM7CG1iaAExSYS
        R4wBbM/SPB2XJ4XuEmge4mYLG05NFWR8IkIri7iC4tGmztyC0OUp/yKKPREOQksWBafKFC1U4+eJf
        exFO0d/CiGk9t8mUvNTM4CeXdbvBzHkr4jYmptYWSvH8/s1ezJtepuBcXige3corKe2cFFWwrmWEu
        SRXXeiOg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLtDY-0005yl-1B; Wed, 01 May 2019 17:40:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Date:   Wed,  1 May 2019 13:39:42 -0400
Message-Id: <20190501173943.5688-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501173943.5688-1-hch@lst.de>
References: <20190501173943.5688-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Doing the indirection through macros for the regs accessors just
makes them harder to read, so implement the helpers directly.

Note that only the helpers actually used are implemented now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/ptrace.h | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 8a7fc0cca2d1..9b81ef539eb3 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -98,7 +98,6 @@ struct cpuinfo_x86;
 struct task_struct;
 
 extern unsigned long profile_pc(struct pt_regs *regs);
-#define profile_pc profile_pc
 
 extern unsigned long
 convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
@@ -175,11 +174,31 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 }
 #endif
 
-#define GET_IP(regs) ((regs)->ip)
-#define GET_FP(regs) ((regs)->bp)
-#define GET_USP(regs) ((regs)->sp)
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->ip;
+}
+static inline void instruction_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->ip = val;
+}
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return regs->bp;
+}
 
-#include <asm-generic/ptrace.h>
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->sp;
+}
+
+static inline void user_stack_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->sp = val;
+}
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
-- 
2.20.1

