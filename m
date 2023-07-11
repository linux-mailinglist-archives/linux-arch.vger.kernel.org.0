Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC174EF5D
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGKMvG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 08:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKMvF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 08:51:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0CB98;
        Tue, 11 Jul 2023 05:51:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6579F2232B;
        Tue, 11 Jul 2023 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689079863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nS/Yg6QEzXBrMLnDzymRUQ3/vdKmPN/jkAyJcBvJ29o=;
        b=p93uIXjeRBxJ68aujj1J5E2pAOpi/T4Yf+t/nq10zsj265N4q8ugZJUe9nmZkMcW6oK32w
        fFcro0PiyITrAK5w7vzSa/AZ+haqvRL5yTk9x/1KsK16zHOkdTcqwLXIIjEMttOwS3UmVF
        Eiue+dUnY4FPlORNmsS8A/nbMxFyDLY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 415671391C;
        Tue, 11 Jul 2023 12:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +rebDjdQrWRGRQAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Tue, 11 Jul 2023 12:51:03 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     arnd@arndb.de
Cc:     keescook@chromium.org, will@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] vmlinux.lds.h: Remove a reference to no longer used sections .text..refcount
Date:   Tue, 11 Jul 2023 14:50:54 +0200
Message-Id: <20230711125054.9000-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sections .text..refcount were previously used to hold an error path code
for fast refcount overflow protection on x86, see commit 7a46ec0e2f48
("locking/refcounts, x86/asm: Implement fast refcount overflow
protection") and commit 564c9cc84e2a ("locking/refcounts, x86/asm: Use
unique .text section for refcount exceptions").

The code was replaced and removed in commit fb041bb7c0a9
("locking/refcount: Consolidate implementations of refcount_t") and no
sections .text..refcount are present since then.

Remove then a relic referencing these sections from TEXT_TEXT to avoid
confusing people, like me. This is a non-functional change.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0587354ba678..9c59409104f6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -578,7 +578,6 @@
 		*(.text.unlikely .text.unlikely.*)			\
 		*(.text.unknown .text.unknown.*)			\
 		NOINSTR_TEXT						\
-		*(.text..refcount)					\
 		*(.ref.text)						\
 		*(.text.asan.* .text.tsan.*)				\
 	MEM_KEEP(init.text*)						\
-- 
2.35.3

