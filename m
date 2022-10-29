Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1C612667
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJ2XSz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJ2XSx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FC82F011;
        Sat, 29 Oct 2022 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XABRwD0Dyw5mFhzCOmG2KtL+WfkI3Jd1NdqWLQIk8Ko=; b=gCeN+XLatIOia5i1hSzX2biUtQ
        U4pkgdXmEQN7z/32uyZ9hwU5EWGO6vdvU1eJR03k1kp1CIcFURJI+WFUa35vrTCeCucpE4UFKn4Jj
        s0ZWSa0bObs0950PZt/lc79l01FrCBw1Z3IxBlzD9dGi5viKVPGNQNATquzexFpTPW/cjw24MVd+H
        hjOYOslREJc5soNIAnLiFXMm9qLaIrRIY7kSvAM4relve0JL08SqK6uYGgZEfI3+xcrW0tW3QKgGo
        lVyKeHCIB1uFnIdmU2j1YMi2i6qD+dh5atOPslS2YBk3cyOYGTqcXOgEQEMeGD5LRBv+9VkBbirfw
        OT9MapqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6J-00FOKo-39;
        Sat, 29 Oct 2022 23:18:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] elf_core_copy_task_regs(): task_pt_regs is defined everywhere
Date:   Sun, 30 Oct 2022 00:18:46 +0100
Message-Id: <20221029231850.3668437-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221029231850.3668437-1-viro@zeniv.linux.org.uk>
References: <Y120X8dWqe15FPPG@ZenIV>
 <20221029231850.3668437-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Had been since 2011 for all live architectures, ever since 2013
for all architectures, period.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/elfcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 346a8b56cdc8..fcf58e16d1e3 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -88,7 +88,7 @@ static inline int elf_core_copy_task_regs(struct task_struct *t, elf_gregset_t*
 {
 #if defined (ELF_CORE_COPY_TASK_REGS)
 	return ELF_CORE_COPY_TASK_REGS(t, elfregs);
-#elif defined (task_pt_regs)
+#else
 	elf_core_copy_regs(elfregs, task_pt_regs(t));
 #endif
 	return 0;
-- 
2.30.2

