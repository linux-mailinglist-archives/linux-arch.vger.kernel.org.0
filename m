Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880C159933F
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 05:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbiHSCzO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 22:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbiHSCzN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 22:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C85BD39B4;
        Thu, 18 Aug 2022 19:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F59B6149F;
        Fri, 19 Aug 2022 02:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25A2C433C1;
        Fri, 19 Aug 2022 02:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660877712;
        bh=+m/z9t7difm+T7Kf5VxuNeNPtaHK+1MlGIRm7crGn/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/KIBp6hGb/CV7ctjyoNlVNQctbDKqvWvOycBri2jc8hs9jUBTknd3RUQZctSwBLL
         yxSkFw0wSgftsks4Jezn7Vkx/H3bXALoSoIeBckdBjW9MMbGpWsWOjeRdf7u3z5SIU
         i6JkQUV3k0hBw1x10fSsb1DSNVGOVd6XnafE0lln8m68gdOiySWihoy1hal61YTPhL
         JVx1X0kgAnAr3Q3mh1rJwygcyxhoEyqMe//CRj+Au8ixgPCs3/lUYs5fY4Aaj3qp6R
         Y2aOOyquD6emEJypZunLgSQEEWmPr8Rt85PLL1Hrtdg4QeqLhKpPq/SjH/8sWci13v
         zeg/00VCA9i0Q==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de, guoren@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org
Subject: [PATCH V3 3/3] arch: crash: Remove duplicate declaration in smp.h
Date:   Thu, 18 Aug 2022 22:54:44 -0400
Message-Id: <20220819025444.2121315-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819025444.2121315-1-guoren@kernel.org>
References: <20220819025444.2121315-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove crash_smp_send_stop declarations in arm64, x86 asm/smp.h which
has been done in include/linux/smp.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: x86@kernel.org
---
 arch/arm64/include/asm/smp.h | 1 -
 arch/x86/include/asm/crash.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index fc55f5a57a06..a108ac93fd8f 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -141,7 +141,6 @@ static inline void cpu_panic_kernel(void)
  */
 bool cpus_are_stuck_in_kernel(void);
 
-extern void crash_smp_send_stop(void);
 extern bool smp_crash_stop_failed(void);
 extern void panic_smp_self_stop(void);
 
diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 8b6bd63530dc..6a9be4907c82 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -7,6 +7,5 @@ struct kimage;
 int crash_load_segments(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
-void crash_smp_send_stop(void);
 
 #endif /* _ASM_X86_CRASH_H */
-- 
2.36.1

