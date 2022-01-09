Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53898488B8B
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiAISQQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 13:16:16 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31210 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiAISQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 13:16:11 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 209IFWa3030890;
        Mon, 10 Jan 2022 03:15:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 209IFWa3030890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641752135;
        bh=Cu3YE2A7ALH4pSGxfiHg4KjbUfWBLKzo5JgyS2XgMEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqoPYuzkXzJa4Zt/6B7uxrVshmqnK0KwATcdFFXsvlEMc0BmnIpk0cNK5klHUxuLG
         yKiMbz1oVSxNzty2zc1RAY1sBBVxlU5CPtKZsFw8cTYMMO4D8Wk+xcnLpIIJZM34by
         iCrylWkBNHd59pgrGU2umnVpKMTBHxH7o4eAcxPfTXWxnvabfbQDLahBEIoIkIecyM
         v2rkhFPWjg/V9gHkYf8QUL2fKm4IsPDlqHGSgNhK1V6JeMZy02zFIEDJyysTPLrhxj
         HMkeloFcTmy/+UOH26p0dG4H7OKOsEJLMo0wp15VEj8W2jU/rRDrkb07SrAVboPa8j
         xz4BFWe4oqvEQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5/5] kbuild: add cmd_file_size
Date:   Mon, 10 Jan 2022 03:15:29 +0900
Message-Id: <20220109181529.351420-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220109181529.351420-1-masahiroy@kernel.org>
References: <20220109181529.351420-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some architectures support self-extracting kernel, which embeds the
compressed vmlinux.

It has 4 byte data at the end so the decompressor can know the vmlinux
size beforehand.

GZIP natively has it in the trailer, but for the other compression
algorithms, the hand-crafted trailer is added.

It is unneeded to generate such _corrupted_ compressed files because
it is possible to pass the size data separately.

For example, the assembly code:

     .incbin "compressed-vmlinux-with-size-data-appended"

can be transformed to:

     .incbin "compressed-vmlinux"
     .incbin "size-data"

My hope is, after some reworks of the decompressors, the macros
cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22} will go away.

This new macro, cmd_file_size, will be useful to generate a separate
size-data file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 4207a72d429f..05ca77706f6b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -394,6 +394,9 @@ printf "%08x\n" $$dec_size |						\
 	}								\
 )
 
+quiet_cmd_file_size = GEN     $@
+      cmd_file_size = $(size_append) > $@
+
 quiet_cmd_bzip2 = BZIP2   $@
       cmd_bzip2 = cat $(real-prereqs) | $(KBZIP2) -9 > $@
 
-- 
2.32.0

