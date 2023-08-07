Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87446772945
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjHGPc5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjHGPcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 11:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86899;
        Mon,  7 Aug 2023 08:32:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 993D461D9A;
        Mon,  7 Aug 2023 15:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D557BC433C7;
        Mon,  7 Aug 2023 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691422373;
        bh=vOf1XqgmYLSwrx6KzBjR0fMHLia73ppzcL8DVn7baw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPjrcJ5CcPuV83asiURhBN0ARRksVqvPAdrxHCXdlNGpSG1wyTQusM9cnn1gLaFKS
         swlzncvfKpAIC5ftFmJIppPA3Eh30LUBZBx97usk8zftSJ6mTp+9Xc93dVASQxC2kF
         x0cZstAa57lJjhY0459IIdl3OLAWXJyP/6xVSMd9DikIu49J4BmaLWpMnOIPesvK9V
         v+WJngSxZ0r4cAyzV43ezWJF1kSOa8ke444XJlDYsgkr51QqbqCa/tpufnLCWXj9NU
         9YtzhusR9z9r7jt24q85EhSKYCoVBsoeymGnTso9tXVeLXjFljzFC53jsMqxY0u8Et
         NQTxmLnrLTYdA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] mips: remove <asm/export.h>
Date:   Tue,  8 Aug 2023 00:32:43 +0900
Message-Id: <20230807153243.996262-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807153243.996262-1-masahiroy@kernel.org>
References: <20230807153243.996262-1-masahiroy@kernel.org>
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

All *.S files under arch/mips/ have been converted to include
<linux/export.h> instead of <asm/export.h>.

Remove <asm/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index dee172716581..7ba67a0d6c97 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -7,7 +7,6 @@ generated-y += unistd_nr_n32.h
 generated-y += unistd_nr_n64.h
 generated-y += unistd_nr_o32.h
 
-generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
-- 
2.39.2

