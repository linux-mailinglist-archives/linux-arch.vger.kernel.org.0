Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18605766F5
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiGOS4C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGOS4B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 14:56:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EDC26110;
        Fri, 15 Jul 2022 11:56:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h132so5162113pgc.10;
        Fri, 15 Jul 2022 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txNDrk9pGz6uXD/rzBLEuIe+526tTagKyY+blkSYT/c=;
        b=hBa/KZV1VsmsfbAJShL0fRQke5T9Fodc9DS10V+7Js/uchvw/e4wuzdhgCl6IA7nXJ
         2E9328A+1VJgmwOprC5pNFDJ5IF1yz1qTZ01qwDBkW4W08+XKdc5qti8MXyAVSkOzN3J
         Npa8q8uXUwEMj01BRhYd8tUOXGMpuYchQewEKe3kPg2LcIivziFRLWpyC2VUyjrtlZ8O
         UJ6XE92l2X5IL1IKWGUOqKp8uTZVeK5bn4KFiSHb99OyyP1FgDHBkySEhsYoleR2NLdx
         JkZoVVCF+nQTvodv3wxWgbChzqnu30jtJnoSL/njjTukYGn717pNGnm3xieOpW/AhSWF
         gAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txNDrk9pGz6uXD/rzBLEuIe+526tTagKyY+blkSYT/c=;
        b=5gxzu3BIMY6RmCL59Kn4Pe587L+TYt2/qkfyTTUrJjGpPi8I7/dKHkt7HSDEnSB7p8
         nvc149a28j10onRruM6Twpc64GLdIpjDDPw5D6ps2GM6rp7Loa012Gh6a0FICGkI/+si
         zdUc4SukbHM0AUg5PzmmqqAGm7ady/fG+zjtyHPZEmupRLOGJv4BfnUMGpR2S4YT/VSy
         0Fvl2ZcvL+yglfC435J+YBA9NYjuwutIdmvNKGF6bflY6BbGme3MjNUh3+/5+pFqOXw2
         hiiicDgYBCizo76m22qYKcCcqEiR+ciAoy0u2fZVncf5PAY7CFd19NQpC3pQjEzqMHXv
         ZTew==
X-Gm-Message-State: AJIora+8SgNGL/BH4tBBLHXwgIX9rlZBm14no0EhsFs4hDiZ+/bynZ/0
        eOkv/54Rw2kup6cC+7rDTZ3mklL6utw=
X-Google-Smtp-Source: AGRyM1vqAMemFePL0Rs384dOpVs+hjs41yGbA+QMSgCOMDS0RVu8TMtfNQPELQKX7JiOmm9QekB6cQ==
X-Received: by 2002:a62:b514:0:b0:525:1ccd:4506 with SMTP id y20-20020a62b514000000b005251ccd4506mr15295958pfe.8.1657911360327;
        Fri, 15 Jul 2022 11:56:00 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b132-20020a621b8a000000b0052a75004c51sm4310943pfb.146.2022.07.15.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:55:59 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     hch@lst.de, nathan@kernel.org, naresh.kamboju@linaro.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        heiko@sntech.de, Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH] tools: Fixed MIPS builds due to struct flock re-definition
Date:   Fri, 15 Jul 2022 11:55:49 -0700
Message-Id: <20220715185551.3951955-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Building perf for MIPS failed after 9f79b8b72339 ("uapi: simplify
__ARCH_FLOCK{,64}_PAD a little") with the following error:

  CC
/home/fainelli/work/buildroot/output/bmips/build/linux-custom/tools/perf/trace/beauty/fcntl.o
In file included from
../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:77,
                 from ../include/uapi/linux/fcntl.h:5,
                 from trace/beauty/fcntl.c:10:
../include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of
'struct flock'
 struct flock {
        ^~~~~
In file included from ../include/uapi/linux/fcntl.h:5,
                 from trace/beauty/fcntl.c:10:
../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:63:8:
note: originally defined here
 struct flock {
        ^~~~~

This is due to the local copy under
tools/include/uapi/asm-generic/fcntl.h including the toolchain's kernel
headers which already define 'struct flock' and define
HAVE_ARCH_STRUCT_FLOCK to future inclusions make a decision as to
whether re-defining 'struct flock' is appropriate or not.

Make sure what do not re-define 'struct flock'
when HAVE_ARCH_STRUCT_FLOCK is already defined.

Fixes: 9f79b8b72339 ("uapi: simplify __ARCH_FLOCK{,64}_PAD a little")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/include/uapi/asm-generic/fcntl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index 0197042b7dfb..312881aa272b 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -185,6 +185,7 @@ struct f_owner_ex {
 
 #define F_LINUX_SPECIFIC_BASE	1024
 
+#ifndef HAVE_ARCH_STRUCT_FLOCK
 struct flock {
 	short	l_type;
 	short	l_whence;
@@ -209,5 +210,6 @@ struct flock64 {
 	__ARCH_FLOCK64_PAD
 #endif
 };
+#endif /* HAVE_ARCH_STRUCT_FLOCK */
 
 #endif /* _ASM_GENERIC_FCNTL_H */
-- 
2.25.1

