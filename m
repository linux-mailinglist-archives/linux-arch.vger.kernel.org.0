Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4577B3EC9
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 09:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjI3HNp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 03:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjI3HNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 03:13:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A606C5;
        Sat, 30 Sep 2023 00:13:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F61C433C8;
        Sat, 30 Sep 2023 07:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696058022;
        bh=da5XLL0KlHEbcP6I4e6+L5xP6izUhZvtfIQid9CjoFw=;
        h=From:To:Cc:Subject:Date:From;
        b=Y8agDm7H5wOCMZt5cwXHwBWPo5fci23nU2A43QTjapo4NFnxzGJizr7/olbEuOczI
         B35CDvRjDkvU9g4Vx/WsXISAp3vOZoiQRYeDRRPvapwuxIzJ4QUCJH3ao6n5wSQeXb
         ll5Pxtx+p9mi3pzTKv89EwJT0Glz9JYjnBGxfhCzdrE8CAL1GkPuxfjmP5jX75hoJi
         AsMoc6MdM2NVx7h76OUqpgIS7VXSfsdKwbkfCkOmLopCZi/tDi+sElrTr36EZqA1wJ
         yaHz1FKVukHGtp+9S+VVcBHXQdDsbm+xoQp+OpaJdzz5UQZ2fERv2j4f+cyvcXw8dm
         KJ2q8Q/DIFPcQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH] vmlinux.lds.h: remove unused CPU_KEEP and CPU_DISCARD macros
Date:   Sat, 30 Sep 2023 16:13:35 +0900
Message-Id: <20230930071335.1224500-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove the left-over of commit e24f6628811e ("modpost: remove all
traces of cpuinit/cpuexit sections").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/vmlinux.lds.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9c59409104f6..67d8dd2f1bde 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -138,13 +138,6 @@
  * are handled as text/data or they can be discarded (which
  * often happens at runtime)
  */
-#ifdef CONFIG_HOTPLUG_CPU
-#define CPU_KEEP(sec)    *(.cpu##sec)
-#define CPU_DISCARD(sec)
-#else
-#define CPU_KEEP(sec)
-#define CPU_DISCARD(sec) *(.cpu##sec)
-#endif
 
 #if defined(CONFIG_MEMORY_HOTPLUG)
 #define MEM_KEEP(sec)    *(.mem##sec)
-- 
2.39.2

