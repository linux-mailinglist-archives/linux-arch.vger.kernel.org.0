Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8F6F0B2F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Apr 2023 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbjD0RnI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Apr 2023 13:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244608AbjD0Rmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Apr 2023 13:42:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46D515FE5;
        Thu, 27 Apr 2023 10:42:33 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 590A721C33E1;
        Thu, 27 Apr 2023 10:42:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 590A721C33E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617352;
        bh=JzW52Omm51Pbk9wjpjdqd20u4BkUZE5fIgVHo4czr6g=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=Ndu3v4Nv6DdxwdMWwYXsIdVK+/OKKnSlFxnwYRe5+4vYuhKkWuJa3H3ajz/keSZhL
         D9a//NBRM2gcEk/I1HTmQkqamXjCSkcS5/SjaAspvmoXWzVWrxPI/s1rau7sJ/cw7J
         VsYOBppFTptB2s2cZoejMUuCHM/XbqmID3JzPnl8=
Subject: [PATCH 7/7] asm-generic/io.h: Expect immutable pointer in
 virt_to_phys
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 15 Apr 2023 04:17:59 -0700
Message-ID: <168155747955.13678.5648956145924030241.stgit@skinsburskii.localdomain>
In-Reply-To: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

These helper function - virt_to_phys - doesn't need the address pointer to be
mutable.

In the same time expecting it to be mutable leads to the following build
warning for constant pointers:

  warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: linux-arch@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/asm-generic/io.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 587e7e9b9a37..ee9d9584e05b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1000,7 +1000,7 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
  */
 #ifndef virt_to_phys
 #define virt_to_phys virt_to_phys
-static inline unsigned long virt_to_phys(volatile void *address)
+static inline unsigned long virt_to_phys(const volatile void *address)
 {
 	return __pa((unsigned long)address);
 }


