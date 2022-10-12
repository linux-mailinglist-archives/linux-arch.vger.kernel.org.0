Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1515FCEF7
	for <lists+linux-arch@lfdr.de>; Thu, 13 Oct 2022 01:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJLXfV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 19:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJLXfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 19:35:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F05D88DFD;
        Wed, 12 Oct 2022 16:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B539B81CB1;
        Wed, 12 Oct 2022 23:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799E1C433D6;
        Wed, 12 Oct 2022 23:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665617716;
        bh=z+puzTE7jxUB6aSp/LwcBK6+VqRF8OLBHC3UUJqCOj0=;
        h=From:To:Cc:Subject:Date:From;
        b=Mu0+fQlDDhK2NXj36y+0zU6A9Ki247MdvpqQ3eRGIDsIk2+IYxOnT9K385AKyx0Ou
         L7qhT/k4CIhXFP9JYDbfDUuatjgMZ4SyZXc5Cu2uoNZ6Zbep3yiTMrZJ/30U5rgap/
         OKUG1gvSpacXzJ7HlxVLqdxGcWG/hGjwXP3wZPzzMLH2FX+df+zZm6CoSkRBuDlGLT
         +hUhIY+Zc+SWDwQgOdty8t9tdzb0lnX59m3mHP4ZstM7RF9aJrY0NcNUPBwUNhZfMO
         ywcj4wtPuMZ9KTUxqCj9bgR7RyCTG4W2LOIBUJxR7E/RwYqV1Co2Fcw4YNtupXvQgd
         u0R11g1m5qVtg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: remove special treatment for the link order of head.o
Date:   Thu, 13 Oct 2022 08:35:00 +0900
Message-Id: <20221012233500.156764-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the previous discussion (see the Link tag), Ard pointed out that
arm/arm64/kernel/head.o does not need any special treatment - the only
piece that must appear right at the start of the binary image is the
image header which is emitted into .head.text.

The linker script does the right thing to do. The build system does
not need to manipulate the link order of head.o.

Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com/
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/head-object-list.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index b16326a92c45..f226e45e3b7b 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -15,7 +15,6 @@ arch/alpha/kernel/head.o
 arch/arc/kernel/head.o
 arch/arm/kernel/head-nommu.o
 arch/arm/kernel/head.o
-arch/arm64/kernel/head.o
 arch/csky/kernel/head.o
 arch/hexagon/kernel/head.o
 arch/ia64/kernel/head.o
-- 
2.34.1

