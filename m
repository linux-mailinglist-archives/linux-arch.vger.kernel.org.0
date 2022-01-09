Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C37488B84
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiAISQK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 13:16:10 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31187 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiAISQJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 13:16:09 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 209IFWa0030890;
        Mon, 10 Jan 2022 03:15:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 209IFWa0030890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641752133;
        bh=BZ3qIKu57D8pRZHuFfM9UpnlJfsK2QYlIGz0shtBiGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xvo2l/iruGPUnO+b/eNRSKmS8gWyftSAayhOmNIl2DhQbXO4j6+vx6smmvO/joSBE
         kM0KMFNJMrrxFvzQ0gEIzYytsu+W4QlnkoXv5wOJleARRAfv0h2og7OuMUCPQY39Pq
         jkIuyfmJBcrKmr+o+n5ywlXQyFc+K2jzCxb+92zhhFcgGRP47Oh07A3uJ2GXgahAGk
         eVdwNGUOPqOci4TeQby9yl0AWlxUa0upHxl2yzXq3Lvl72k5y0BJFHZ1Nn5aSaQ6CT
         gZiGvOSlJxfaLactaFaj1CljEsN73DiRq4VT8QbfEHaP+GdXnbyDPaXljSankmZmYD
         g3+xFKvwQfvVA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/5] kbuild: drop $(size_append) from cmd_zstd
Date:   Mon, 10 Jan 2022 03:15:26 +0900
Message-Id: <20220109181529.351420-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220109181529.351420-1-masahiroy@kernel.org>
References: <20220109181529.351420-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The appended file size is only used by the decompressors, which some
architectures support.

As the comment "zstd22 is used for kernel compression" says, cmd_zstd22
is used in arch/{mips,s390,x86}/boot/compressed/Makefile.

On the other hand, there is no good reason to append the file size to
cmd_zstd since it is used for other purposes.

Actually cmd_zstd is only used in usr/Makefile, where the appended file
size is rather harmful.

The initramfs with its file size appended is considered as corrupted
data, so commit 65e00e04e5ae ("initramfs: refactor the initramfs build
rules") added 'override size_append := :' to make it no-op.

As a conclusion, this $(size_append) should not exist here.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d1f865b8c0cb..5366466ea0e4 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -473,7 +473,7 @@ quiet_cmd_xzmisc = XZMISC  $@
 # be used because it would require zstd to allocate a 128 MB buffer.
 
 quiet_cmd_zstd = ZSTD    $@
-      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) -19; $(size_append); } > $@
+      cmd_zstd = cat $(real-prereqs) | $(ZSTD) -19 > $@
 
 quiet_cmd_zstd22 = ZSTD22  $@
       cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
-- 
2.32.0

