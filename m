Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B12EA83C
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2019 01:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfJaAcJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 20:32:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55990 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfJaAcH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so4061053wmh.5
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDHh+OVXKEM0h+uKC7EIERstcizYBjZxP2HUDdfEVt8=;
        b=Dn8/QAVbq0JfM6dbr7uT/LDSjMsuYs4CxFf+CS82fAkPePNSAGzb5Y0MnIf2ipZiHx
         POfZhnEE3UHOkJ9d/P4volBMryXP1/aujGfSYCD7vqeNMrU++oR+psgTkC/v689cAwcu
         FJP2RLuVzWiYM8UlzeEvwu9SX0Et8qvWQXB88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDHh+OVXKEM0h+uKC7EIERstcizYBjZxP2HUDdfEVt8=;
        b=q/lmCJVIHvtAKhkZ3m/h042XdLdbTEmBIbjykK0ILZGAVY3UOtEN3F4cvgcDRBnXSe
         ddeYOpYhitondZAMk5HYLT83Frv/feUHPwUcMUZXBIVOi9F2epRfC94WOLjF/Xs0P6c1
         eIJxDGoFV6L/oxj/J+NPIkqs+P/fyU3d3Va/LnvCYbaVpKkzNrm3acG4zHqnDADf/6gt
         RaKvgTjSQSTReZaHOR5YKS7egI0bM5pS6/VrF6rrmv8fy3kM1mvIXZFMu8LiuUG/rMhU
         BJlx/qETvgQBW/NnvT35KTWFKkpYEyUaCv3lh/ramMnCzORN9/h02k93XLTmXMVt8PO6
         V/fQ==
X-Gm-Message-State: APjAAAWsLG06OXcRanR8nHVDaqnRyUJN/d9W9FRH9TuHo8JgG5FoYs5f
        TUoNlsBwBYHq4WP7kKCJ+c1li745Rl9ERRgH
X-Google-Smtp-Source: APXvYqz3VwKmyFrg0snFjZE++GwOdD4oDrvjFS6yyK5iarkJGuhLRfN5MmMf7SAZIOqcSO0W8SJCNw==
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr2165585wmb.45.1572481924905;
        Wed, 30 Oct 2019 17:32:04 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:04 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 4/5] powerpc: make pcibios_vaddr_is_ioport() static
Date:   Thu, 31 Oct 2019 01:31:53 +0100
Message-Id: <20191031003154.21969-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The only caller of pcibios_vaddr_is_ioport() is in pci-common.c, so we
can make it static and move it into the same #ifndef block as its
caller.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/include/asm/pci-bridge.h | 9 ---------
 arch/powerpc/kernel/pci-common.c      | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ea6ec65970ef..deb29a1c9708 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -283,14 +283,5 @@ extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
 extern void pcibios_free_controller_deferred(struct pci_host_bridge *bridge);
 
-#ifdef CONFIG_PCI
-extern int pcibios_vaddr_is_ioport(void __iomem *address);
-#else
-static inline int pcibios_vaddr_is_ioport(void __iomem *address)
-{
-	return 0;
-}
-#endif	/* CONFIG_PCI */
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d89a2426b405..928d7576c6c2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -277,7 +277,8 @@ static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 #endif
 }
 
-int pcibios_vaddr_is_ioport(void __iomem *address)
+#ifndef CONFIG_PPC_INDIRECT_PIO
+static int pcibios_vaddr_is_ioport(void __iomem *address)
 {
 	int ret = 0;
 	struct pci_controller *hose;
@@ -296,7 +297,6 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
 	return ret;
 }
 
-#ifndef CONFIG_PPC_INDIRECT_PIO
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	if (isa_vaddr_is_ioport(addr))
-- 
2.23.0

