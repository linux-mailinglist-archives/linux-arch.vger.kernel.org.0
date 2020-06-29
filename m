Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E12920E47B
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgF2VZx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgF2Sms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64594C033C11;
        Mon, 29 Jun 2020 11:26:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002DtJ-3f; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 05/41] [ia64] teach elf_access_reg() to handle the missing range (r16..r31)
Date:   Mon, 29 Jun 2020 19:25:52 +0100
Message-Id: <20200629182628.529995-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Now it's easy to make elf_access_gpreg() handle the rest of global
registers (r16..r31).  That gets rid of the hole in the registers
elf_access_reg() can handle, which will allow to simplify its callers
later in the series.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/ptrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index b9d068903b98..37b5140d0dfe 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1273,12 +1273,14 @@ struct regset_getset {
 	int ret;
 };
 
-static const ptrdiff_t pt_offsets[16] =
+static const ptrdiff_t pt_offsets[32] =
 {
 #define R(n) offsetof(struct pt_regs, r##n)
 	[0] = -1, R(1), R(2), R(3),
 	[4] = -1, [5] = -1, [6] = -1, [7] = -1,
 	R(8), R(9), R(10), R(11), R(12), R(13), R(14), R(15),
+	R(16), R(17), R(18), R(19), R(20), R(21), R(22), R(23),
+	R(24), R(25), R(26), R(27), R(28), R(29), R(30), R(31),
 #undef R
 };
 
@@ -1479,7 +1481,7 @@ static int
 access_elf_reg(struct task_struct *target, struct unw_frame_info *info,
 		unsigned long addr, unsigned long *data, int write_access)
 {
-	if (addr >= ELF_GR_OFFSET(1) && addr <= ELF_GR_OFFSET(15))
+	if (addr >= ELF_GR_OFFSET(1) && addr <= ELF_GR_OFFSET(31))
 		return access_elf_gpreg(target, info, addr, data, write_access);
 	else if (addr >= ELF_BR_OFFSET(0) && addr <= ELF_BR_OFFSET(7))
 		return access_elf_breg(target, info, addr, data, write_access);
-- 
2.11.0

