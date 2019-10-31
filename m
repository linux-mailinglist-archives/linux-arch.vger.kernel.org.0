Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD9EA836
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2019 01:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfJaAcJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 20:32:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJaAcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id v3so5398352wmh.1
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nviaR21RiU1nk2LZ5kFcjxEatw3WuqbBoBTo8fSflGU=;
        b=P8q6ecGkOH1cz6KavvYnvhkldy2tb8GnfywHDNOSmTJurUs0VpLx+KuDDNh7MPM44L
         5e0MnvX5DsJLANeS+IemAzatJQb4T0LUS6sA2On5F0pFAuLI6/uos7sX+kGwmdNe2rhz
         ZoQU3hea1E0m/TW45ofs64T/Ul8kX5U8MdK/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nviaR21RiU1nk2LZ5kFcjxEatw3WuqbBoBTo8fSflGU=;
        b=O7D3XcgoLEQlyY5tZWoaZ/Sj2TFWQa+xRJb+2TSELo4DzC9Vg7mcTZXLpJpz3XBIpE
         q2UMeolHfhqtCkECBvpILAIs5hvcXl01dpHg2wdm74EQAi6w1p2bdqzb+HjOr9bqS+cH
         TRrxgLw3fBEA4l1nuX0ppMB883oXrHR8yBU5EiOK/hTISkuf2KmK+Qrj2gxeFDpdoyKL
         sysonM3sqprYxxULULHBeqOjgVDWZAWWUAZupB6Z1SME1kHpyv9wCp+c7vK7nxinznen
         VH5uVIlFHRvymcYQaXa/oVYRcCn5w33sXvKDukJNrXd3xwBo14BsCDEmcX53bPI1bF+V
         7otw==
X-Gm-Message-State: APjAAAWxIV4IZg7Pr84xULL3FMpnZ9aTphn/WHALsWqekl0JzA7s6q0u
        5s/DZ0EVGSou5eCwY72q10mNbZgDbrJI5MmX
X-Google-Smtp-Source: APXvYqw3+GGNKPWfeYgL+Q1AJ6aouq9nqy+A5TiFT/Z3iyOgjPBzEBNst1ROKUpNxsiK1ff/4oXKsA==
X-Received: by 2002:a1c:558a:: with SMTP id j132mr2103148wmb.21.1572481921871;
        Wed, 30 Oct 2019 17:32:01 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:01 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 1/5] asm-generic: move pcu_iounmap from iomap.h to pci_iomap.h
Date:   Thu, 31 Oct 2019 01:31:50 +0100
Message-Id: <20191031003154.21969-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

pci_iounmap seems misplaced in iomap.h. Move it to where its cousins
live. Since iomap.h includes pci_iomap.h, anybody relying on getting
the declaration through iomap.h will still get it.

It would be natural to put the static inline version inside the

#elif defined(CONFIG_GENERIC_PCI_IOMAP)

Since GENERIC_IOMAP selects GENERIC_PCI_IOMAP, that would be ok for
those who select GENERIC_IOMAP. However, I fear there are some that
select GENERIC_PCI_IOMAP without GENERIC_IOMAP, and which perhaps have
their own pci_iounmap stub definition somewhere. So for now at least,
define the static inline version under the same conditions as it were
in iomap.h.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/iomap.h     | 10 ----------
 include/asm-generic/pci_iomap.h |  7 +++++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index a008f504a2d0..5f8321e8fea9 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -101,16 +101,6 @@ extern void ioport_unmap(void __iomem *);
 #define ioremap_wt ioremap_nocache
 #endif
 
-#ifdef CONFIG_PCI
-/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
-struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
-#elif defined(CONFIG_GENERIC_IOMAP)
-struct pci_dev;
-static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{ }
-#endif
-
 #include <asm-generic/pci_iomap.h>
 
 #endif
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index d4f16dcc2ed7..c2f78db2420e 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -18,6 +18,8 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
+/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
@@ -52,4 +54,9 @@ static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 }
 #endif
 
+#if !defined(CONFIG_PCI) && defined(CONFIG_GENERIC_IOMAP)
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{ }
+#endif
+
 #endif /* __ASM_GENERIC_IO_H */
-- 
2.23.0

