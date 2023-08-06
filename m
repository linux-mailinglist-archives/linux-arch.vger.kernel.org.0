Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB8E7715C5
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHFPKP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Aug 2023 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHFPKJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2023 11:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A7114;
        Sun,  6 Aug 2023 08:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F98C602DE;
        Sun,  6 Aug 2023 15:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1F7C433CA;
        Sun,  6 Aug 2023 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691334607;
        bh=XWcGPs3wlJLQMOkajZ5ap0aPtwZ0AG8zS8ewAKz4h5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/FIPO3InylhjF4O3HN9gZVSNXzwJ9cahwetd+dnCssUrzzS9XLsvbyg2xWTGMMlS
         g/4GL3XRJEAQbN2bVXVc7CNr/BytxauXZHAnzUf06iqzbriX3KWxHdjCvvLKOdIec9
         z4hlSoJhGBazr3tWsMjiQmKIyaT15LTxr64PSjs1N5WWLWLqaaH0NBzDNDUleBC0KR
         DtmkwXSNacaRidoD5G6HpeB0TienVDGnpiT69uZKEXHQ5kfLXYIrsonLDIh0LHJaX4
         fwaMAtLaeoGTPjR6/BuIwwQ0Nl/CHebMVRje561j+jFi2lSkYuGVTPkcondx9xClmn
         EXuEEnF8qLgaw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] powerpc: remove <asm/export.h>
Date:   Mon,  7 Aug 2023 00:09:54 +0900
Message-Id: <20230806150954.394189-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230806150954.394189-1-masahiroy@kernel.org>
References: <20230806150954.394189-1-masahiroy@kernel.org>
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

All *.S files under arch/powerpc/ have been converted to include
<linux/export.h> instead of <asm/export.h>.

Remove <asm/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 419319c4963c..61a8d5555cd7 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -3,7 +3,6 @@ generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generated-y += syscall_table_spu.h
 generic-y += agp.h
-generic-y += export.h
 generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
-- 
2.39.2

