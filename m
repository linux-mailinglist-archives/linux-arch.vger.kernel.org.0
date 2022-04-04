Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C944F0F36
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377443AbiDDGWf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357066AbiDDGWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:33 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3C03701E;
        Sun,  3 Apr 2022 23:20:29 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Bm008244;
        Mon, 4 Apr 2022 15:20:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Bm008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053204;
        bh=onG4O2hzMHEf6qaqVbfAftNHSCP2ymImYtDLBkce8BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XCo8+ynA3ZkPRPZ7e5rOjcfamztHNMENTk32k5hxLI+HMilH74Q0q/4DEMs8F1eW
         SqgpNq7yzHZXEwMUflVNuAdx2FUyIENfjDwDqU/yMmLGGMWWN0rA8eZvoVeZUz+y3b
         F7n/+MuasgOanikBN4CaUZPYL26svTCQWrH7ag+lbyJ9ZSl0eYAl/GkFXJojSE/Et4
         9JhOrQBJH0eW7tff++Y+vkbGMQFaSSsteMERZSvPHdkqRm+oCfXvkM0zJqjBO887JK
         HUdIKzFRTmTkjwaW3P6eZ5IReuBOS20jNpYmeG6XWKgxQPG1O5exOm92VPgJlwurR9
         QjtyMYXp0X8GA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/8] riscv: add linux/bpf_perf_event.h to UAPI compile-test coverage
Date:   Mon,  4 Apr 2022 15:19:43 +0900
Message-Id: <20220404061948.2111820-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404061948.2111820-1-masahiroy@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I can compile this for ARCH=riscv with CONFIG_UAPI_HEADER_TEST=y.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 usr/include/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 7740777b49f8..a1a8403896cf 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -74,10 +74,6 @@ no-header-test += asm/stat.h
 no-header-test += linux/bpf_perf_event.h
 endif
 
-ifeq ($(SRCARCH),riscv)
-no-header-test += linux/bpf_perf_event.h
-endif
-
 ifeq ($(SRCARCH),sparc)
 no-header-test += asm/stat.h
 no-header-test += asm/uctx.h
-- 
2.32.0

