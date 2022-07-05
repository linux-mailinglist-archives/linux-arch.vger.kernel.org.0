Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B6566391
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 09:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiGEG7L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 02:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGEG7K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 02:59:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C5FD1;
        Mon,  4 Jul 2022 23:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01A46B81619;
        Tue,  5 Jul 2022 06:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9875FC341C7;
        Tue,  5 Jul 2022 06:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657004347;
        bh=5mc5mkoiYA0RBfy80fWjo0JRbDo6VMAXS1ak+LDdGLg=;
        h=From:To:Cc:Subject:Date:From;
        b=RUjyCo6ZEn336ceRZ2nv9raBxENOJ3GEtTd7+Gs+sgNH3Q+GuH0340ks1UBl44Ehn
         /sanDql/CDY+vOviPCCBXXiCsAn2gNaSginwiJ4ZfoMDSP6roZYj1BwiatyCJimNGz
         Y/41KuwYu+kDHC7IUvJFSwoVS+iQ1TOvdkWFE2YAhLwHxFSp6O/Ii3tZmoovsuPyQB
         TOa7vD9tpwzNFc6lZjzleWwr8lcK1LYq3YfIgVvuCOQrSWBrQUq4/j6UfJwArzBztn
         s7Qt8Uys++YGxZXP6mt5wRqDOko08K22Itg2FqY6D7lIici9mmFxR7/7B+8csGuXDb
         Fead5tWUC02Ag==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, deller@gmx.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Move HEAD_TEXT_SECTION out of __init_begin-end
Date:   Tue,  5 Jul 2022 02:59:01 -0400
Message-Id: <20220705065901.1172871-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Prevent HEAD_TEXT_SECTION back into the buddy system.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/kernel/vmlinux.lds.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index 163a8cd8b9a6..68c980d08482 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -23,13 +23,8 @@ SECTIONS
 	. = PAGE_OFFSET + PHYS_OFFSET_OFFSET;
 
 	_start = .;
-	__init_begin = .;
 	HEAD_TEXT_SECTION
-	INIT_TEXT_SECTION(PAGE_SIZE)
-	INIT_DATA_SECTION(PAGE_SIZE)
-	PERCPU_SECTION(L1_CACHE_BYTES)
 	. = ALIGN(PAGE_SIZE);
-	__init_end = .;
 
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		_text = .;
@@ -49,7 +44,12 @@ SECTIONS
 
 	/* __init_begin __init_end must be page aligned for free_initmem */
 	. = ALIGN(PAGE_SIZE);
-
+	__init_begin = .;
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(PAGE_SIZE)
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	. = ALIGN(PAGE_SIZE);
+	__init_end = .;
 
 	_sdata = .;
 	RO_DATA(PAGE_SIZE)
-- 
2.36.1

