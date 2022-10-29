Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7561266B
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJ2XS6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJ2XSy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:54 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B12F01F;
        Sat, 29 Oct 2022 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=klpACccFtoarUhZmGjA/78+30p+ai2lgnRxPOatV6uo=; b=rZhwOnmMLug/lcPeuhHrVrEYmp
        50zfxE7UVHGkpfocNwlK7CjfvaoUP4jeHuwuWOcGyNT40TNVNf4pJ6nw31a4Yt8Kaj28U7GG+z5Dy
        56zhCCvjMDKjq9JgOyM8Znfoj358ljkrBoK9JyDobOH5okIEruLMVUQtXrwHRCG2cxYBspdRFF+70
        P4P3tT7HDvjtZx9kBDGQq4AiI+TxN0TTe5mG41APl+pY7WXF3TV4wq3pTpKt6exHsFWK9fzvXfnlc
        IYt+wx0L3zPhECGW+l+WOpJDFrmrU8egD7eVlxyhRYZCcf6N59klzXvOSTVTzMJSU0gbRbX8V9xCv
        cAYwHAkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6K-00FOKz-0i;
        Sat, 29 Oct 2022 23:18:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] [elf][non-regset] use elf_core_copy_task_regs() for dumper as well
Date:   Sun, 30 Oct 2022 00:18:48 +0100
Message-Id: <20221029231850.3668437-8-viro@zeniv.linux.org.uk>
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

elf_core_copy_regs() is equivalent to elf_core_copy_task_regs() of
current on all architectures.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index c3c5bd48361e..cb95e842c50f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2072,7 +2072,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	/* now collect the dump for the current */
 	memset(info->prstatus, 0, sizeof(*info->prstatus));
 	fill_prstatus(&info->prstatus->common, current, cprm->siginfo->si_signo);
-	elf_core_copy_regs(&info->prstatus->pr_reg, task_pt_regs(current));
+	elf_core_copy_task_regs(current, &info->prstatus->pr_reg);
 
 	/* Set up header */
 	fill_elf_header(elf, phdrs, ELF_ARCH, ELF_CORE_EFLAGS);
-- 
2.30.2

