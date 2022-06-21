Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE6552DEF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348575AbiFUJHu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 05:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348086AbiFUJHt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 05:07:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E08186D0;
        Tue, 21 Jun 2022 02:07:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 055391FADF;
        Tue, 21 Jun 2022 09:07:47 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D895613A88;
        Tue, 21 Jun 2022 09:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOaSMmKKsWKFHAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Tue, 21 Jun 2022 09:07:46 +0000
From:   Cyril Hrubis <metan@ucw.cz>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, arnd@arndb.de, ltp@lists.linux.it,
        David.Laight@aculab.com, zack@owlfolio.org, dhowells@redhat.com,
        Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH v2] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Date:   Tue, 21 Jun 2022 11:09:51 +0200
Message-Id: <20220621090951.29911-1-metan@ucw.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Cyril Hrubis <chrubis@suse.cz>

This changes the __u64 and __s64 in userspace on 64bit platforms from
long long (unsigned) int to just long (unsigned) int in order to match
the uint64_t and int64_t size in userspace.

This allows us to use the kernel structure definitions in userspace.

For example we can use PRIu64 and PRId64 modifiers in printf() to print
structure membere. Morever with this there would be no need to redefine
these structures in an libc implementations as it is done now.

Consider for example the newly added statx() syscall. If we use the
header from uapi we will get warnings when attempting to print it's
members as:

	printf("%" PRIu64 "\n", stx.stx_size);

We get:

	warning: format '%lu' expects argument of type 'long unsigned int',
	         but argument 5 has type '__u64' {aka 'long long unsigned int'}

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/uapi/asm-generic/types.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

v2: Make sure we do not break C++ applications

diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
index dfaa50d99d8f..11e468a39d1e 100644
--- a/include/uapi/asm-generic/types.h
+++ b/include/uapi/asm-generic/types.h
@@ -1,9 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_GENERIC_TYPES_H
 #define _ASM_GENERIC_TYPES_H
+
+#include <asm/bitsperlong.h>
+
 /*
- * int-ll64 is used everywhere now.
+ * int-ll64 is used everywhere in kernel now.
  */
-#include <asm-generic/int-ll64.h>
+#if !defined(__KERNEL__) && !defined(__cplusplus) && __BITSPERLONG == 64
+# include <asm-generic/int-l64.h>
+#else
+# include <asm-generic/int-ll64.h>
+#endif
 
 #endif /* _ASM_GENERIC_TYPES_H */
-- 
2.35.1

