Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BBF7715DF
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHFPUo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Aug 2023 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjHFPUn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2023 11:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A106114;
        Sun,  6 Aug 2023 08:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E469611AD;
        Sun,  6 Aug 2023 15:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4B3C433C9;
        Sun,  6 Aug 2023 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691335241;
        bh=tFtug/Z14ZsgjINk3Kvukol3O04uENQCeu8Z3YczElM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nI+ckSKo+3FM/sR4BEKqExqFwAeK6Yp4zq65yVGwyeTbrtSopzv+dPt4bQa+pYsqL
         vvu2EG0cbxhv76MA6irynZ73eb2Swl2ZjFNEsS3S2UQakIXKi3TE1l/2MGaT7Hnecx
         75cX2iKm0Ni0BfNk+JrLXGq1BhIuOUGkI9rC+4rFJrhmUcfloOSDPwb1841CzYpx/V
         jfcsWXDpoHVbwpKxS3GChEUJBA3qw9IUOxOWkBRgIc6EkeqWMdwSQFsTysiMyxU16B
         5v0XCC6SAmrplGAETjidOghSTlZ4roJZiMsuVyV0D+TLWLmdtVDvCcWVgr0BTcbwb8
         BA2T/YnXkIg1g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] s390: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Mon,  7 Aug 2023 00:16:39 +0900
Message-Id: <20230806151641.394720-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230806151641.394720-1-masahiroy@kernel.org>
References: <20230806151641.394720-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.

Replace #include <asm/export.h> with #include <linux/export.h>.

After all the <asm/export.h> lines are converted, <asm/export.h> and
<asm-generic/export.h> will be removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/kernel/entry.S | 2 +-
 arch/s390/lib/mem.S      | 2 +-
 arch/s390/lib/tishift.S  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index a660f4b6d654..49a11f6dd7ae 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -8,6 +8,7 @@
  *		 Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
  */
 
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/asm-extable.h>
@@ -26,7 +27,6 @@
 #include <asm/vx-insn.h>
 #include <asm/setup.h>
 #include <asm/nmi.h>
-#include <asm/export.h>
 #include <asm/nospec-insn.h>
 
 _LPP_OFFSET	= __LC_LPP
diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
index 5a9a55de2e10..08f60a42b9a6 100644
--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -5,8 +5,8 @@
  * Copyright IBM Corp. 2012
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 #include <asm/nospec-insn.h>
 
 	GEN_BR_THUNK %r14
diff --git a/arch/s390/lib/tishift.S b/arch/s390/lib/tishift.S
index de33cf02cfd2..96214f51f49b 100644
--- a/arch/s390/lib/tishift.S
+++ b/arch/s390/lib/tishift.S
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/nospec-insn.h>
-#include <asm/export.h>
 
 	.section .noinstr.text, "ax"
 
-- 
2.39.2

