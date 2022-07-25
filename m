Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B257F825
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jul 2022 04:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiGYCIM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jul 2022 22:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiGYCIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2022 22:08:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F32DF83;
        Sun, 24 Jul 2022 19:08:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q16so9090698pgq.6;
        Sun, 24 Jul 2022 19:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPqnXwXti1+G5tWXmkHTdMuVELnLmjzK9jn4d9GRpd0=;
        b=VDm5l9E+2HuSM1K5W3uvSA51dlS6VFJXblBSWOH2EKnXLZLKifshM9+cmkfKqXqAUb
         Lp01f6pGs2IG5th9y+gzAgnoZyOUTS457R7GeR7X3tNC+E+iXNQAXN0Qd4UuEi0U+3v0
         C+jiaAKkB7x7fMhMAIsdmN7ryNK/1kImmiv2hXwbRjrtoyn7K6C1IlmAFbJrokDljWbE
         BTPjtHcG50eFJHzfvIje0tKIPXFBn6nm8vJ/aQyGieEPQgHRJYtjDGexIk/pnZT99f8n
         xFR3vW/ENV7nyioVcn8fFeB9XyBq+F8rpBjvB+t0iVm4uXIjL50iPed1qZKZpi6JGHAC
         JHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPqnXwXti1+G5tWXmkHTdMuVELnLmjzK9jn4d9GRpd0=;
        b=1XIRkiJfCFu8o7XC9v2/lcUjq8FBQuT75FAykK9BprSIBlBb4FHjAYOYovfZSer0R4
         4lHJnXLtgAx3Y1ca0uJno/n2YKQa+ElQPtnCcRo4w2bRH6cz31KInxoJKmM21rjh6G8P
         CGsHsW2isqKW5SelcUU+kJjw8LvpKYFLLsP+n0p2Nwzpbc8OipziWMeYo0BvG1Cb3szu
         1EvOH+wdgVy9qgiygathR3C+GFEG6ls09CUB6QqUs1wv3y7er1MdjmdscEgn/tr5H9OF
         r1IB041JJqn+b80I7JThpaZ10oIx4Rlb7j2Wp32qnV9HawmcqlgEJEIKSld0P6/9RGFD
         cJeg==
X-Gm-Message-State: AJIora+WTH15FGuBuQ71nqz+e6+QgwmFIeKWQyVZUSyhFk0jcwy6leAf
        y37v+nw0iLrUvcdulifGCpzg2OG+u2jTlA==
X-Google-Smtp-Source: AGRyM1sv7D6TECjQbd7J6r840ZgNyxq3COsXrFclaRJu6HRQYwhr+T1u7cICzUR21mWnw3rw92Zopg==
X-Received: by 2002:a63:6c87:0:b0:419:b667:6622 with SMTP id h129-20020a636c87000000b00419b6676622mr8895996pgc.495.1658714889186;
        Sun, 24 Jul 2022 19:08:09 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b0016c740e53bbsm307815pla.79.2022.07.24.19.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 19:08:08 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stafford Horne <shorne@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 1/3] asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
Date:   Mon, 25 Jul 2022 11:07:35 +0900
Message-Id: <20220725020737.1221739-2-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725020737.1221739-1-shorne@gmail.com>
References: <20220725020737.1221739-1-shorne@gmail.com>
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

