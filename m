Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D407715B8
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHFPAZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Aug 2023 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHFPAX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2023 11:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC4AE50;
        Sun,  6 Aug 2023 08:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F456119F;
        Sun,  6 Aug 2023 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182C4C433CB;
        Sun,  6 Aug 2023 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691334021;
        bh=zp9PWcPVxpOcJmcsReL+HqdUVHEGtiKIJq4ggdAO5Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=argY63cORQE6+xGK6sjx5eJiJQFvlFSyLrPEpLdPnqgWfgmv7dNsLPd8Hoz7ax/2K
         HtpbafaiVSvpgZDMIaECdkbDNMFt0PPXMDuz/qC/vVRgKvqA+gxXsh22TIrKSyfS/d
         1T30zBWsVN3HMRm7eAsoLb4VUg9iyjk4d0OSNKAsSmOK9wv43igBnytRt7O/RGTUEC
         jHyQrPeVwHNI9h0eQDg91I7UQ9iDjhGQrR+9/UV5ehCBWbXWSHxI+UPj5ZkdX+jBvh
         pN1Cs4spqR8vHces47JvJWzpyk4FDvxzByd+DVZnX1CLQwQos6sx5jN/J1ZFj+b7wE
         fr5rbCMHp/Gig==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] x86: remove <asm/export.h>
Date:   Sun,  6 Aug 2023 23:59:57 +0900
Message-Id: <20230806145958.380314-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230806145958.380314-1-masahiroy@kernel.org>
References: <20230806145958.380314-1-masahiroy@kernel.org>
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

All *.S files under arch/x86/ have been converted to include
<linux/export.h> instead of <asm/export.h>.

Remove <asm/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 4f1ce5fc4e19..a192bdea69e2 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -10,5 +10,4 @@ generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
 generic-y += early_ioremap.h
-generic-y += export.h
 generic-y += mcs_spinlock.h
-- 
2.39.2

