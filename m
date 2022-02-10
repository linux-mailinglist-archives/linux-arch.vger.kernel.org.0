Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7824B0330
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiBJCQD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:16:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBJCQC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:16:02 -0500
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A6264B;
        Wed,  9 Feb 2022 18:16:04 -0800 (PST)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-04.nifty.com with ESMTP id 21A2CEEn028502;
        Thu, 10 Feb 2022 11:12:14 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21A2BVH3030193;
        Thu, 10 Feb 2022 11:11:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21A2BVH3030193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644459095;
        bh=rkmmaG81+CGD7vgz9hJpVQO2/VXHXcuVX9wVZdpGLMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peI9or4mZVTEEKja0i7XgnT0TqcNSKKYLOhDMrCMg1c9sbDG3hV7YKKNlZGP/Q4n6
         ZYNRKdfeJJ5RskR+r9lT+qtzcCOhdBPq18jpgfpMGnNRL/rN4bRll3jmNQEm72yHyu
         6/hI4Mx7NQtvHvcPLEQjACqNXbfmkv5kXSSr6LsocAOhbIqtX78sEuUgOckK0MIr1v
         2zHM1AHhU/Gky6hJlaTSBkkVMJZaLKAkyQYaWXFqEwlFte+SJMo3ekDP+mII4Kr7xZ
         Pakouqkpi9yKrfDOkfWkMEMx/U6fQhNvjUVNgO5em9x7j7kf+jaeJ7K1EyBnVmuEO+
         FitV+3TMM/HSQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6/6] reiserfs_xattr.h: add linux/reiserfs_xattr.h to UAPI compile-test coverage
Date:   Thu, 10 Feb 2022 11:11:29 +0900
Message-Id: <20220210021129.3386083-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210021129.3386083-1-masahiroy@kernel.org>
References: <20220210021129.3386083-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

linux/reiserfs_xattr.h is currently excluded from the UAPI compile-test
because of the error like follows:

    HDRTEST usr/include/linux/reiserfs_xattr.h
  In file included from <command-line>:
  ./usr/include/linux/reiserfs_xattr.h:22:9: error: unknown type name ‘size_t’
     22 |         size_t length;
        |         ^~~~~~

The error can be fixed by replacing size_t with __kernel_size_t.

Then, remove the no-header-test entry from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/uapi/linux/reiserfs_xattr.h | 2 +-
 usr/include/Makefile                | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/reiserfs_xattr.h b/include/uapi/linux/reiserfs_xattr.h
index 28f10842f047..503ad018ce5b 100644
--- a/include/uapi/linux/reiserfs_xattr.h
+++ b/include/uapi/linux/reiserfs_xattr.h
@@ -19,7 +19,7 @@ struct reiserfs_xattr_header {
 struct reiserfs_security_handle {
 	const char *name;
 	void *value;
-	size_t length;
+	__kernel_size_t length;
 };
 
 #endif  /*  _LINUX_REISERFS_XATTR_H  */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 48bb789099d5..5e703af0f83c 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -36,7 +36,6 @@ no-header-test += linux/omap3isp.h
 no-header-test += linux/omapfb.h
 no-header-test += linux/patchkey.h
 no-header-test += linux/phonet.h
-no-header-test += linux/reiserfs_xattr.h
 no-header-test += linux/sctp.h
 no-header-test += linux/sysctl.h
 no-header-test += linux/usb/audio.h
-- 
2.32.0

