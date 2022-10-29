Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014B261266A
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJ2XS5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJ2XSy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:54 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD42F00C;
        Sat, 29 Oct 2022 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3I7amQwucLsr9EK3PRzzcIjUWVNxHOmGAMTyGQic/xs=; b=OK9IgIJTUA5Bn/JLGr/q/PnE7b
        qfPBRQZDcdEMgRa9OV2zbtFoK7zCO9Oa0JgGALwa7IwlbgTcl36O+QAYgRfXSKJMLwfweAe7IZC0b
        dntraq7P0590C3HCK+HAxyVHp61x0lVHrNe9j/BM0TOuIS9kFolmTQWMKCCtaxvWdm4kY6e3k1cB4
        cc4CQmbYSaQJAw3wakeRVehctJN37Ah9l9UjtX7VtNQoQqND/2UxvrCJr2Mjr5XKyq1YaY1x+1Dgu
        rvGtOBql67edIbabKP2bm6leLuHnuyyEdMNY9/SiO1qYVAznUXAqBvkTbI8U7ZR5WCcIQXoMM4mKW
        VwhoKUxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6J-00FOKe-1p;
        Sat, 29 Oct 2022 23:18:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] [elf][regset] clean fill_note_info() a bit
Date:   Sun, 30 Oct 2022 00:18:44 +0100
Message-Id: <20221029231850.3668437-4-viro@zeniv.linux.org.uk>
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

*info is already initialized...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 002fd713ac11..4190dafd2ec4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1833,24 +1833,17 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	struct elf_thread_core_info *t;
 	struct elf_prpsinfo *psinfo;
 	struct core_thread *ct;
-	unsigned int i;
-
-	info->size = 0;
-	info->thread = NULL;
 
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
-	if (psinfo == NULL) {
-		info->psinfo.data = NULL; /* So we don't free this wrongly */
+	if (!psinfo)
 		return 0;
-	}
-
 	fill_note(&info->psinfo, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
 
 	/*
 	 * Figure out how many notes we're going to need for each thread.
 	 */
 	info->thread_notes = 0;
-	for (i = 0; i < view->n; ++i)
+	for (int i = 0; i < view->n; ++i)
 		if (view->regsets[i].core_note_type != 0)
 			++info->thread_notes;
 
-- 
2.30.2

