Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB552781C07
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 04:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjHTCdu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 22:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjHTCdk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 22:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1939D88CFB;
        Sat, 19 Aug 2023 16:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A056061A77;
        Sat, 19 Aug 2023 23:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8378FC433C8;
        Sat, 19 Aug 2023 23:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692488047;
        bh=94swkMMWtMWXwlQ0MRgkdCnBJXEwx0etvzk4fEwCRDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsMv3/rggBxUAEy32zChNAPBOEk124vJgtFdFlqmhzojWGUfnGlmH6Dv0D7biSBGU
         MfhY7jR5WQoXC7RaHkedup9FAPC3Yp/FcJYsRDRtWZhGUxs6VKkJA0GulpwgYdTqt1
         glqQGzkihFlP0v7PsYiLUsEts+9sl2NbYYXwox5Gkjfd3G5Yig9l6GhGhUegCmEEIM
         lULmSruHs4a9z5EMqm8m6WOK94P5TolXC9oIFJewviheEF6XiezAxgZtoNjWlVB8nh
         NjOk2dED6IoyJT748l7aOqXD7gaTRXbi95OD0Lzq5QdJERcYSkX3l4JMndODHH/SBt
         hs5iKuiYFfJPw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] alpha: remove <asm/export.h>
Date:   Sun, 20 Aug 2023 08:33:53 +0900
Message-Id: <20230819233353.3683813-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819233353.3683813-1-masahiroy@kernel.org>
References: <20230819233353.3683813-1-masahiroy@kernel.org>
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

All *.S files under arch/alpha/ have been converted to include
<linux/export.h> instead of <asm/export.h>.

Remove <asm/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/alpha/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index dd31e97edae8..396caece6d6d 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -3,6 +3,5 @@
 generated-y += syscall_table.h
 generic-y += agp.h
 generic-y += asm-offsets.h
-generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
-- 
2.39.2

