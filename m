Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB2EBF55
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 09:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKAIkQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Nov 2019 04:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfKAIkP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Nov 2019 04:40:15 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6683217F9;
        Fri,  1 Nov 2019 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572597615;
        bh=oG08x38Bw8t//MmcsXiMwfmG8dPNjLcnVisdmtiKgLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkCucn3uHqnMfCDvIzd0rw4B5nODD/Bpkp+sk228WySb2t9n3AXfH9+hmzqbAM7tb
         hhdQo7gWfnmZ3TCiDmqgdnYqXHvzfp8U6W43WtlMzmnZWLfgHczyLqnSNKlGlxychs
         2K3/FD28seYDl7iR26xnae/zqVrGkoiF37jRQcvQ=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 02/13] arm: nommu: use pgtable-nopud instead of 4level-fixup
Date:   Fri,  1 Nov 2019 10:39:33 +0200
Message-Id: <1572597584-6390-3-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572597584-6390-1-git-send-email-rppt@kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The generic nommu implementation of page table manipulation takes care of
folding of the upper levels and does not require fixups.

Simply replace of include/asm-generic/4level-fixup.h with
include/asm-generic/pgtable-nopud.h.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 3ae120c..eabcb48 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -12,7 +12,7 @@
 
 #ifndef CONFIG_MMU
 
-#include <asm-generic/4level-fixup.h>
+#include <asm-generic/pgtable-nopud.h>
 #include <asm/pgtable-nommu.h>
 
 #else
-- 
2.7.4

