Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A713032B4AC
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350740AbhCCFYz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:24:55 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:15489 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1580133AbhCBRa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 12:30:28 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DqkXw1XPpz9v1C4;
        Tue,  2 Mar 2021 18:25:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LhQkvn-K5PGS; Tue,  2 Mar 2021 18:25:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DqkXw0jTRz9v1Bx;
        Tue,  2 Mar 2021 18:25:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D8B9B8B7B5;
        Tue,  2 Mar 2021 18:25:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id huFmz8x1Abk4; Tue,  2 Mar 2021 18:25:21 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FD0C8B75F;
        Tue,  2 Mar 2021 18:25:21 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 5934E674A2; Tue,  2 Mar 2021 17:25:21 +0000 (UTC)
Message-Id: <54fd814a0c7aad690fa3aceaab5f35cb930c681a.1614705851.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614705851.git.christophe.leroy@csgroup.eu>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 5/7] powerpc: add capability to prepend default command
 line
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Date:   Tue,  2 Mar 2021 17:25:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch activates the capability to prepend default
arguments to the command line.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 386ae12d8523..0ab406f14513 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -912,6 +912,12 @@ config CMDLINE_EXTEND
 	  The command-line arguments provided by the boot loader will be
 	  appended to the default kernel command string.
 
+config CMDLINE_PREPEND
+	bool "Prepend bootloader kernel arguments"
+	help
+	  The default kernel command string will be prepend to the
+	  command-line arguments provided during boot.
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	help
-- 
2.25.0

