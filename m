Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663B0459343
	for <lists+linux-arch@lfdr.de>; Mon, 22 Nov 2021 17:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbhKVQpG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Nov 2021 11:45:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46068 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhKVQpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Nov 2021 11:45:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB67E1FD49;
        Mon, 22 Nov 2021 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637599317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=1woxrA4xZsptnquer4Gd0ugpmny7b62MqMTzjlRKhrs=;
        b=D9QD+7iDWjdfAk65X8/3PTFr/OHdtPtlpvfV0tZR9xcTgh5lTUluNMBjucbRbgSRWhk2jf
        LQlsZMlWX2aUb3Gic2XA8WnBuShvspt99dFN3fw720k+GmZ2QRafuLH8UU40R5iGDqWWID
        GpvqB2B5Bwz3k4qqdyQfae5L0wiZSY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637599317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=1woxrA4xZsptnquer4Gd0ugpmny7b62MqMTzjlRKhrs=;
        b=3FteXPHki4q4uD48zVbf3yuog6NKkm53zGV0HFAWyCo8kWIA1sH+rV7nGrGQPr7IQr/KEY
        tQq0zRK/ob9G4pBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAB2413B44;
        Mon, 22 Nov 2021 16:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pZdDKFXIm2GHNwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 22 Nov 2021 16:41:57 +0000
Date:   Mon, 22 Nov 2021 17:43:03 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, ltp@lists.linux.it,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        arnd@arndb.de
Subject: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Message-ID: <YZvIlz7J6vOEY+Xu@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This changes the __u64 and __s64 in userspace on 64bit platforms from
long long (unsigned) int to just long (unsigned) int in order to match
the uint64_t and int64_t size in userspace.

This allows us to use the kernel structure definitions in userspace. For
example we can use PRIu64 and PRId64 modifiers in printf() to print
structure members. Morever with this there would be no need to redefine
these structures in libc implementations as it is done now.

Consider for example the newly added statx() syscall. If we use the
header from uapi we will get warnings when attempting to print it's
members as:

	printf("%" PRIu64 "\n", stx.stx_size);

We get:

	warning: format '%lu' expects argument of type 'long unsigned int',
	         but argument 5 has type '__u64' {aka 'long long unsigned int'}

After this patch the types match and no warnings are generated.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/uapi/asm-generic/types.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
index dfaa50d99d8f..ae748a3678a4 100644
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
+#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
+# include <asm-generic/int-l64.h>
+#else
+# include <asm-generic/int-ll64.h>
+#endif
 
 #endif /* _ASM_GENERIC_TYPES_H */
-- 
2.32.0


-- 
Cyril Hrubis
chrubis@suse.cz
