Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD157DF6F
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGVKOl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 06:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiGVKOl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 06:14:41 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FDBF7694F;
        Fri, 22 Jul 2022 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iGxJH
        eW15nq7ddhpj1wydAbAAFx+DzDfhr9t9TXCZnk=; b=gXkaQJwCG0Qc6HWSu2y6K
        fKEvGPuS9SsSbRx55+jVD3FaslwEIciXBKvy1g/Ocw3JbW4R0hwt6vwSr9gYrYvD
        TtRFuDjP7yVx+feC3Wm3Tx3bAkAJR+H9REQGTRPIAWk2UuJUg9l1bcFqTNh0NT8B
        v+jf20qJdEYambFMqWKkYo=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp3 (Coremail) with SMTP id G9xpCgCnr6OJeNpiw+CXQg--.8100S2;
        Fri, 22 Jul 2022 18:14:35 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] uapi: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:14:32 +0800
Message-Id: <20220722101432.80814-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCnr6OJeNpiw+CXQg--.8100S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUJFW3Xw4DAF47GF4kWFg_yoW3KFb_C3
        98Jrs7Gw1xWFZrKwsFvan7Gr12gw48GrWjqa1aq342yrZ5Kr4kK3Z5Cay7Ar48WrsxurW8
        Ja40qFsYqw17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtxhlUUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAx1GZGB0LoUKFAAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 include/uapi/asm-generic/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index f13d37b60775..974629ba0c5a 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -143,7 +143,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
-- 
2.25.1

