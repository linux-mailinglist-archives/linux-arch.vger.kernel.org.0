Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E982AEA837
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2019 01:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfJaAcK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 20:32:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38690 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfJaAcI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so4125099wms.3
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYhACg+zO53SUeLC5iAmeJtmmamitSVr5JjCgBatEmk=;
        b=Xo2jF187UE1MGGGjZ8wN0vNAH7wPPEVfI4ZvaURxYjN1pWSFx+8HdyvTcP3FzTn987
         08YzzHq6OGkCXz6Im4EZfJbwBJNjKtnt3kBbs0JwsG41sI9SdnEErK9HVKIuV5ytBAAd
         jnU/gdaLBryLQcmiUDOmHH8SzYQxepk523nE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYhACg+zO53SUeLC5iAmeJtmmamitSVr5JjCgBatEmk=;
        b=h97qLZViEkLeVZhzvgXla9SNYGftQx1o68NKjYmpSl49AISXsTGXv8o2VYwZK5xzhv
         2Sznz2oVcOV3OD8dA3UU0tyHXZqkmhUhfi2dZVBUHeyT70unGwLFRh7bF5W/qjV6qQCJ
         YCquLnKUXosBJEhpADWfXaBVlS/0uPFIw7e+zKHWTmLoDdH7+uWSsGtpORF39pllaclJ
         Wk+rm7A8OxFSDOEyRz6yIbd5lomI4cpVcGj7Bii1LmjXHgv8a25JSmKMqQWUpkGt7U2D
         fRlU99QHpMXdKzrNEdtxez4g5xors0DQihvcvBv+PTUIy/ogIqPvM3xXt/AYC9Yy78qc
         lGcw==
X-Gm-Message-State: APjAAAWJJPmAlsA0kcvRqB4tMgLaisNlVE0HivZOl3fyzFpqS1o+rl7r
        rxWiUbFXS84tl+kdaxmlRUnDjqIDp1K1hNnf
X-Google-Smtp-Source: APXvYqwpa/vkgm/Kk2t0MioAGkOHz3mAV7KnDHWGDzc5LpYTw6AEGiA6IRzxyLwSWzDsy21QG8gMPw==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr2099609wmm.133.1572481923964;
        Wed, 30 Oct 2019 17:32:03 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:03 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 3/5] powerpc: move pci_iounmap() from iomap.c to pci-common.c
Date:   Thu, 31 Oct 2019 01:31:52 +0100
Message-Id: <20191031003154.21969-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As preparation for making iowrite32 and friends static inlines, move
the definition of pci_iounmap() from iomap.c to pci-common.c. This
definition of pci_iounmap() is compiled in when
!CONFIG_PPC_INDIRECT_PIO && CONFIG_PCI - we're just interchanging
which condition is in the Kbuild logic and which is in the .c file.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/kernel/iomap.c      | 13 -------------
 arch/powerpc/kernel/pci-common.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 5ac84efc6ede..b22fa8db5068 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -182,16 +182,3 @@ void ioport_unmap(void __iomem *addr)
 }
 EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
-
-#ifdef CONFIG_PCI
-void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{
-	if (isa_vaddr_is_ioport(addr))
-		return;
-	if (pcibios_vaddr_is_ioport(addr))
-		return;
-	iounmap(addr);
-}
-
-EXPORT_SYMBOL(pci_iounmap);
-#endif /* CONFIG_PCI */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 1c448cf25506..d89a2426b405 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -34,6 +34,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/isa-bridge.h>
 #include <asm/byteorder.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
@@ -295,6 +296,18 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
 	return ret;
 }
 
+#ifndef CONFIG_PPC_INDIRECT_PIO
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	if (isa_vaddr_is_ioport(addr))
+		return;
+	if (pcibios_vaddr_is_ioport(addr))
+		return;
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iounmap);
+#endif /* CONFIG_PPC_INDIRECT_PIO */
+
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
 	struct pci_controller *hose;
-- 
2.23.0

