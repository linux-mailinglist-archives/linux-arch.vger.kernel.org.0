Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5CE6365F4
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiKWQjZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 11:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiKWQjY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 11:39:24 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1FB9627
        for <linux-arch@vger.kernel.org>; Wed, 23 Nov 2022 08:39:23 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:881b:815b:474d:c3fd])
        by andre.telenet-ops.be with bizsmtp
        id nsfL2800749U0Rd01sfLjU; Wed, 23 Nov 2022 17:39:20 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxsmN-001SCs-Pe; Wed, 23 Nov 2022 17:39:19 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxsmM-001LzK-W0; Wed, 23 Nov 2022 17:39:19 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend] uapi: Add missing _UAPI prefix to <asm-generic/types.h> include guard
Date:   Wed, 23 Nov 2022 17:39:18 +0100
Message-Id: <075390e2b9c8b57b75b6e479f9d43e4ccd6fb47f.1669221371.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Still valid after 9 years ;-)

 include/uapi/asm-generic/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
index dfaa50d99d8f3f2b..7ad4dd01b8bf06ea 100644
--- a/include/uapi/asm-generic/types.h
+++ b/include/uapi/asm-generic/types.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_GENERIC_TYPES_H
-#define _ASM_GENERIC_TYPES_H
+#ifndef _UAPI_ASM_GENERIC_TYPES_H
+#define _UAPI_ASM_GENERIC_TYPES_H
 /*
  * int-ll64 is used everywhere now.
  */
 #include <asm-generic/int-ll64.h>
 
-#endif /* _ASM_GENERIC_TYPES_H */
+#endif /* _UAPI_ASM_GENERIC_TYPES_H */
-- 
2.25.1

