Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B146D4F0F39
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377466AbiDDGWk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377432AbiDDGWe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:34 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A937A38;
        Sun,  3 Apr 2022 23:20:34 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Bl008244;
        Mon, 4 Apr 2022 15:20:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Bl008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053203;
        bh=evk6/aYPuF2OY3xkmu3cNWpVgpoeGt39vDeD/Q5in9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qN8rma96BAx4qoBdu4TnTxvEqbo++kPrCIAYSURH3m+VD4ye6kWp4TOPDWkN6jIeR
         2RQzITJQ0Ej5T3duadfncDESM66XaGPayX8VZD5iFApNjWUqrj8Kbl3cYzanZ7R6iD
         OnHFIMXPiwHTRziYWG5WVafQlzU/RBZgPDY5mIXYt8mjFfvk4v6WIxJvq077XT0+3+
         LT3IyOny5PRlMyW3yGfuNI0sEYPdQNMd1aGMfPeeWnmSaHL9iAEWqdR8A3GkOUwBvh
         zxvo6vsPB/pluueOhqDf9pgvXQUBR5wcAlMKsnsZoAZ1pIAVJDL9LhBPDHvOkzBvS8
         4TjAEecDSY3Rg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/8] kbuild: prevent exported headers from including <stdlib.h>, <stdbool.h>
Date:   Mon,  4 Apr 2022 15:19:42 +0900
Message-Id: <20220404061948.2111820-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404061948.2111820-1-masahiroy@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some UAPI headers included <stdlib.h>, like this:

  #ifndef __KERNEL__
  #include <stdlib.h>
  #endif

As it turned out, they just included it for no good reason.

After some fixes, now I can compile-test UAPI headers
(CONFIG_UAPI_HEADER_TEST=y) without including <stdlib.h> from the
system header search paths.

To avoid somebody getting it back again, this commit adds the dummy
header, usr/dummy-include/stdlib.h

I added $(srctree)/usr/dummy-include to the header search paths.
Because it is searched before the system directories, if someone
tries to include <stdlib.h>, they will see the error message.

While I am here, I also replaced $(objtree)/usr/include with $(obj),
but it has no functional change.

If we can make kernel headers self-contained (that is, none of exported
kernel headers includes system headers), we will be able to add the
-nostdinc flag, but that is much far from where we stand now.

As a realistic solution, we can ban header inclusion individually by
putting a dummy header into usr/dummy-include/.

Currently, no header include <stdbool.h>. I put it as well before somebody
attempts to use it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 usr/dummy-include/stdbool.h | 7 +++++++
 usr/dummy-include/stdlib.h  | 7 +++++++
 usr/include/Makefile        | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 usr/dummy-include/stdbool.h
 create mode 100644 usr/dummy-include/stdlib.h

diff --git a/usr/dummy-include/stdbool.h b/usr/dummy-include/stdbool.h
new file mode 100644
index 000000000000..54ff9e9c90ac
--- /dev/null
+++ b/usr/dummy-include/stdbool.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _STDBOOL_H
+#define _STDBOOL_H
+
+#error "Please do not include <stdbool.h> from exported headers"
+
+#endif /* _STDBOOL_H */
diff --git a/usr/dummy-include/stdlib.h b/usr/dummy-include/stdlib.h
new file mode 100644
index 000000000000..e8c21888e371
--- /dev/null
+++ b/usr/dummy-include/stdlib.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _STDLIB_H
+#define _STDLIB_H
+
+#error "Please do not include <stdlib.h> from exported headers"
+
+#endif /* _STDLIB_H */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index fa9819e022b7..7740777b49f8 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -15,7 +15,7 @@ UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
 # USERCFLAGS might contain sysroot location for CC.
 UAPI_CFLAGS += $(USERCFLAGS)
 
-override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
+override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I $(obj) -I $(srctree)/usr/dummy-include
 
 # The following are excluded for now because they fail to build.
 #
-- 
2.32.0

