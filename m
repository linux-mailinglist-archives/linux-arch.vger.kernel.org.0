Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9DD61266E
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ2XS7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJ2XSy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:54 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE572F007;
        Sat, 29 Oct 2022 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WhbUv9HBxQIPXWwFYMtnUUjJ/kZ/8c6XmqS5a0sNtkc=; b=rQCFH1SCYQTChP+jdlWCMmd6Jm
        YH+4xQ4FeuldtfDjL2HIdNvtPTyRdo1XiVCFq1gNbQLKk1T4n9NyhPrGXaOKI6NmqOs56ggr/Ew5M
        vUCugji4OPCXfpKVd8efw36D+akpEiseI5l0DV+ixe/R7cCDenDVHX9LVa+1hzLtIlQout2DCSIgN
        yA2Qn7Wcjyoze3YtV+5VzBBFUBiwrQNcgZEPsmKpcMaAULPDzH/u2a09Lgf/MOqC4r5ij1qNQQH6e
        cVdwLBh/sxmd0B2rsbEJo/fSItkPq7GYIQ+fgBRvlid2kbFPfGarfxWKceOVrOB69HtzCVicw+SUC
        L3j1NgKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6K-00FOLB-2F;
        Sat, 29 Oct 2022 23:18:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] [elf] get rid of get_note_info_size()
Date:   Sun, 30 Oct 2022 00:18:50 +0100
Message-Id: <20221029231850.3668437-10-viro@zeniv.linux.org.uk>
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

it's trivial now...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 3758a617c9d8..65d2d2ba4d9e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1946,11 +1946,6 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	return 1;
 }
 
-static size_t get_note_info_size(struct elf_note_info *info)
-{
-	return info->size;
-}
-
 /*
  * Write all the notes for each thread.  When writing the first thread, the
  * process-wide notes are interleaved after the first thread-specific note.
@@ -2068,7 +2063,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	/* Write notes phdr entry */
 	{
-		size_t sz = get_note_info_size(&info);
+		size_t sz = info.size;
 
 		/* For cell spufs */
 		sz += elf_coredump_extra_notes_size();
-- 
2.30.2

