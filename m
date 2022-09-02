Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9D5AA511
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 03:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiIBB3O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 21:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiIBB3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 21:29:11 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3F679605;
        Thu,  1 Sep 2022 18:29:06 -0700 (PDT)
X-QQ-mid: bizesmtp68t1662082135tqjicsrj
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Sep 2022 09:28:54 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: 8eavv92r+YlmjxAEJjodkwBTVHnfVczq5UHUdO0tQNmImGvjEl6ZhqUYPFFj8
        UkeHsw2mQdIVNU0naJS7cZ/x9EWOetFII3qQ8ois3rczrB0LiXD/ydopBJRxNOU76pVRNRC
        505as5pByuosIbGzIskbGsSZgh7MtM6zIMftxaRwshy14XbUf6Bat+CtNS7CRbZ5oJRP0NS
        NL4A12Wg9iSTe8TvC9uN23VBWLPSNP5O6YCsJzhrUPMxjFgqFV8etUvr28nvdKQZ6h7d3Ze
        yVo3HtDY5NN5kDsrELcc1bXifl1NZemSWfSV2hKrtlYzXDrHp96RVVNXpmRj7zI/YtbBYH4
        suf+l0pKkbEQ/GRFkIGQaMUo6MhEw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] uapi: fix repeated words in comments
Date:   Fri,  2 Sep 2022 09:28:48 +0800
Message-Id: <20220902012848.65432-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 include/uapi/asm-generic/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 1ecdb911add8..b02c8e0f4057 100644
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
2.36.1

