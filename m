Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F96FE298
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjEJQfj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjEJQf1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 12:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370183FF;
        Wed, 10 May 2023 09:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C27E4649EF;
        Wed, 10 May 2023 16:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B1EC433D2;
        Wed, 10 May 2023 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683736521;
        bh=g7XPNarzH/wqmr6jhG8yJoDzEIyJ6X2782gc+T1vwWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCemHidxkEx6i5wrALhCiB1N0fHoOy8JS21FwUzqiktdz70tFZZ/3G4V+LmeDhyCg
         3BbgC3OUBY8ApUQWdlTKT1qZuq9oCWDpBcyFXMag77sWFKMbhqUXntGuT5PkcCr3h1
         vpOVnlTDW7Y77cVA01MxS6o0pIy3LvCaboxMsWdGfAYKtLHU8FbA6J/3BUOf5H53rb
         1xYq93qM1j+0U23ySNHGAVLcuIJYAnmDxXunzoYjzXBjktG39OMo5LR2L8nj4q30cC
         aWEQ4yoi9B60GvVyy1vBbz0gA3ly8xvvW89KqttSsxAFcq2rw9QMj7FB3fZGKi0s3o
         2emM8Elpu7nFw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Schaffner Tobias <tobias.schaffner@siemens.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH RT 3/3] riscv: Allow to enable RT
Date:   Thu, 11 May 2023 00:24:06 +0800
Message-Id: <20230510162406.1955-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510162406.1955-1-jszhang@kernel.org>
References: <20230510162406.1955-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now, it's ready to enable RT on riscv.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 89e9d9fb35c4..622561d1e388 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -42,6 +42,7 @@ config RISCV
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
-- 
2.40.1

