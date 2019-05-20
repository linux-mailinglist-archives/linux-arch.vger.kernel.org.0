Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E785F22BA9
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfETGB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 May 2019 02:01:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbfETGB2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 02:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7XG0CR8rXFGKLDoAnf1Xhj1EcOKcWYxeNKVpLjEGuFk=; b=k9As9qmFWGprOKwcOoeRUyICjh
        VxG6v4+kZC3yNMXZ+iiB7uJI8f/kBGYSajtsD93hlgz6RGruFOahknKfoaTAuMMCI44FgVGVa4iw0
        5KViSMdMwOoC3rP6+qUfBIzAFcEupXzXZlOOVXORZokRn6D8xehQO4c+G0WqxUFSQ1RLmfIQH2Xy3
        cQh0VuOZi0wL2gC85uQZSpVF0Ly8kBE8bp166g0s+EltRpK9zhPTL/en3zR7x9hf5aygr0Ed87WLl
        thZ1ea4O6uwxfmwN+K3bGJbZL8BX49Dg09dE9kOTISsxbDx6Dkre7Vw54gHG4RUcMh9TrXywCAUQn
        vyGICxmA==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSbMP-0001dD-FP; Mon, 20 May 2019 06:01:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Date:   Mon, 20 May 2019 08:00:17 +0200
Message-Id: <20190520060018.25569-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520060018.25569-1-hch@lst.de>
References: <20190520060018.25569-1-hch@lst.de>
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
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/ptrace.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 8a7fc0cca2d1..e22816e865ca 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -98,7 +98,6 @@ struct cpuinfo_x86;
 struct task_struct;
 
 extern unsigned long profile_pc(struct pt_regs *regs);
-#define profile_pc profile_pc
 
 extern unsigned long
 convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
@@ -175,11 +174,32 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 }
 #endif
 
-#define GET_IP(regs) ((regs)->ip)
-#define GET_FP(regs) ((regs)->bp)
-#define GET_USP(regs) ((regs)->sp)
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->ip;
+}
+
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

