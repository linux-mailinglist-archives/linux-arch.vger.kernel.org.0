Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD17715E1
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjHFPUw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Aug 2023 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHFPUp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2023 11:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0774CE50;
        Sun,  6 Aug 2023 08:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C36761198;
        Sun,  6 Aug 2023 15:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B36C433C8;
        Sun,  6 Aug 2023 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691335244;
        bh=QO0FufWh/KYEv0eLV0NRfCsakq0cm8beAU43tbYFAxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgCSoyi4DdRsHkDRPRUoQv8RGuUmb1Wp2JCOf93i7gHC7SOqDYkvjMQV2Ln2ACHBd
         dD/MBkmaKixcOXQHUi4bdagnv6/XI1fhC4LP7B2PncqVyIIgtWXaWVrrsrofepE5YJ
         XpDDrvU879NjK7CX5PJdiJl+xk5hT5M9zpYq5esYWoRFo6BsqlaCgCWF3JskhPvdFJ
         KDa9RZJmEORAJhVYSau6xtrTIPVcma/wXJHSdkvj6PSTwq9kmyW9K+e8wZtDlHQXue
         UAFhyE2EllBqgqv2Q7LhPYb8uZK8u3fTDhtwfTMwvwXhcAGpI89v2h4WLm2e/DGa0u
         5pFvMQW7z89zw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] s390: remove <asm/export.h>
Date:   Mon,  7 Aug 2023 00:16:40 +0900
Message-Id: <20230806151641.394720-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230806151641.394720-1-masahiroy@kernel.org>
References: <20230806151641.394720-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All *.S files under arch/s390/ have been converted to include
<linux/export.h> instead of <asm/export.h>.

Remove <asm/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 1a18d7b82f86..4b904110d27c 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -5,6 +5,5 @@ generated-y += syscall_table.h
 generated-y += unistd_nr.h
 
 generic-y += asm-offsets.h
-generic-y += export.h
 generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
-- 
2.39.2

