Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EBB234F30
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgHABOs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbgHABOr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:47 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB95B21744;
        Sat,  1 Aug 2020 01:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244487;
        bh=2ty6n7QxjZO+RmKE+I+2VlQamclByiPMf022/oscKwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAvjULSqtDE9oz8ZW0uNCAPUguRnnRAk6gVgt1fW0w4HMeJpFqi6IUZM8tNLYzHLR
         iDJ6le3RqR1+SUmxxlVeEyv3VdgHqivwuQY1x3vpHwN4QwMi5ea3xjmyNAKE3NCxhO
         Yh3uZHJ7I+uWq1VoDDKqyFvpkRWFNrjLNN8OEfVM=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 05/13] csky: Fixup kprobes handler couldn't change pc
Date:   Sat,  1 Aug 2020 01:14:05 +0000
Message-Id: <1596244453-98575-6-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The "Changing Execution Path" section in the Documentation/kprobes.txt
said:

Since kprobes can probe into a running kernel code, it can change the
register set, including instruction pointer.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv2/mcount.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/csky/abiv2/mcount.S b/arch/csky/abiv2/mcount.S
index 911512b..d745e10 100644
--- a/arch/csky/abiv2/mcount.S
+++ b/arch/csky/abiv2/mcount.S
@@ -55,7 +55,9 @@
 
 .macro mcount_exit_regs
 	RESTORE_REGS_FTRACE
-	ldw	t1, (sp, 0)
+	subi	sp, 152
+	ldw	t1, (sp, 4)
+	addi	sp, 152
 	ldw	r8, (sp, 4)
 	ldw	lr, (sp, 8)
 	addi	sp, 12
-- 
2.7.4

