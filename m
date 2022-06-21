Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0555318F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 14:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349291AbiFUMCF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 08:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFUMCE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 08:02:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667BD2B1B1;
        Tue, 21 Jun 2022 05:02:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2140D1F8A3;
        Tue, 21 Jun 2022 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655812922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uU2jiNk6Ug60ZbuSPO6zGopTbMqjO7aR6mTRO4CzwJg=;
        b=j60xuo3mlUkeVlZ0C46eHEJwpKdE9M7ag0GKfxhoJoPWEyBl/IshNczI8+QXPnbalYIc48
        64gC+gHfpUNhd9KaS/SD44DIvReFkLqiBFPURtWLpvOsJGmD5Q+je1k5KwCVkRHUJaG2t1
        RJMTSTGe4/Qcc/hPG4fSXKvTJCsRnvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655812922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uU2jiNk6Ug60ZbuSPO6zGopTbMqjO7aR6mTRO4CzwJg=;
        b=l6PIt3b/6fWF1z3LBUP/Ez7zJNMHL1V2ZccxhDw7dVRnN2O8rKAH9kHDoeExpdUPSTHM8m
        ZcBq+h5bHnXNZuDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 046E913638;
        Tue, 21 Jun 2022 12:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vTmVOjmzsWJ7ewAAMHmgww
        (envelope-from <chrubis@suse.cz>); Tue, 21 Jun 2022 12:02:01 +0000
From:   Cyril Hrubis <chrubis@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, arnd@arndb.de, ltp@lists.linux.it,
        David.Laight@aculab.com, zack@owlfolio.org, dhowells@redhat.com,
        Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH v3] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Date:   Tue, 21 Jun 2022 14:03:55 +0200
Message-Id: <20220621120355.2903-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This changes the __u64 and __s64 in userspace on 64bit platforms from
long long (unsigned) int to just long (unsigned) int in order to match
the uint64_t and int64_t size in userspace for C code.

We cannot make the change for C++ since that would be non-backwards
compatible change and may cause possible regressions and even
compilation failures, e.g. overloaded function may no longer find a
correct match.

This allows us to use the kernel structure definitions in userspace in C
code. For example we can use PRIu64 and PRId64 modifiers in printf() to
print structure membere. Morever with this there would be no need to
redefine these structures in an libc implementations as it is done now.

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
v3: Update commit message to explain C++ exclusion

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

