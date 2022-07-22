Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3FD57E8D3
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiGVVXB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiGVVXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 17:23:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089BDB557E;
        Fri, 22 Jul 2022 14:23:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id g17so5577523plh.2;
        Fri, 22 Jul 2022 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MV6bZZly8mOT2/4/4JHcc8Sq2+4f3+j6Egt563TRyaI=;
        b=bbHXormzqx8VGEyg9/LBMPt4jBzyLdJN1cJEoKNNYuiLPrwtQfPFKTE5rPnUN+k3xh
         9t32mYEtcE+ERFesxfu6b0mgz6O/dyhjrn7pWaYrtYRKvM34/lAf+nRHA3xIJsMXODpU
         0EuLivSP0iRnXJjEuVFZZo+SUxJDYKyMnEJIf/LDw/6UN0Z74ZvOS20Yw3i/2yJRALH8
         8L55K/TflCNEk+WPjcARwYl/bq16s6alqXj4d1Kw43cZu73HywZ1F5i07bqN58YnHRM8
         I91PQfGG2q3jabQKPHEgSROErPVSP5FYMwArDFToCJYyUuw7m6tanXNfaELrBJDybyvQ
         eKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MV6bZZly8mOT2/4/4JHcc8Sq2+4f3+j6Egt563TRyaI=;
        b=AShkW19mXkBZBwelNRualxcJ0O3J1J7CitBUd9piV8A2PwBQm9JL3C79TfEyzdMVqw
         NXUDKS8UF1zTnH+oIaddl8cfe7lFLdECdxUtL6dfdnIsc6nkHadJBWKf7RqwLcY2geYR
         8cVCRqvt5GSD9yk+cGxig1xWf3BJOEykoXo7YsB5cgflUMe0lIKpJY68nZrNkkanmZ6t
         aAZUYgEX5KFluCw6tjMWbZr6+mTkASWoymjwa9pWf1bJEduEF3IMLYNS8U7o9fFK2Kjv
         B1iL71Q6kucLA/n5Q+qaS4771V6Bb8NIef6eKo0hkNWTjA+hW9on1P4JlhbQVqDA5qM4
         vn/g==
X-Gm-Message-State: AJIora/OKNFTg2b7z9tq5SH3a4Gwba23mMxr6cdxeAbkdgvnAMM2dj9S
        bUviFH0sB4PquZoZW6/MaWwQXINyXOPz2w==
X-Google-Smtp-Source: AGRyM1ubxjWQgx5tLsdkLlvfVP4rzwkEW2eyjW22nNOMOnyrXenv3nK8uvEY/NAHqnzEodng8XbWqg==
X-Received: by 2002:a17:90a:bf0f:b0:1f1:fd66:755a with SMTP id c15-20020a17090abf0f00b001f1fd66755amr19392220pjs.214.1658524979094;
        Fri, 22 Jul 2022 14:22:59 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id lb14-20020a17090b4a4e00b001f1f5e812e9sm4037709pjb.20.2022.07.22.14.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:22:58 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
Date:   Sat, 23 Jul 2022 06:22:48 +0900
Message-Id: <20220722212248.802500-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
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

When building OpenRISC PCI which has no ioport_map we get the following build
error.

    lib/pci_iomap.c: In function 'pci_iomap_range':
      CC      drivers/i2c/i2c-core-base.o
    ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
       29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
          |                                         ^~~~~~~~~~
    lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
       44 |                 return __pci_ioport_map(dev, start, len);
          |                        ^~~~~~~~~~~~~~~~

This patch adds a NULL definition of __pci_ioport_map for architetures
which do not support ioport_map.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
The Kconfig I am using to test this is here:
  https://github.com/stffrdhrn/linux/commits/or1k-virt-4

 include/asm-generic/pci_iomap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index 5a2f9bf53384..8fbb0a55545d 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -25,6 +25,8 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 #ifdef CONFIG_NO_GENERIC_PCI_IOPORT_MAP
 extern void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
 				      unsigned int nr);
+#elif !defined(CONFIG_HAS_IOPORT_MAP)
+#define __pci_ioport_map(dev, port, nr) NULL
 #else
 #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
 #endif
-- 
2.36.1

