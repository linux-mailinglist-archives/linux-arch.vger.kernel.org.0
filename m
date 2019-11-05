Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23D2EF602
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 08:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfKEHQT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 02:16:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387754AbfKEHQS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 02:16:18 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE63C21A4A;
        Tue,  5 Nov 2019 07:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572938178;
        bh=p11JZ/878S75pE68Mq2TwTFjvlVsPceSwhIak764zRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIjOW76kqg0bbZMlBKplrKUeF7C5oqmYI7BFZNMka/tnwTF3W7X/eVzjZL7ApKqUD
         bd4ykNr8yzMPnkgwUz4shN6ipOJ6zbEEHlkuN6pY2ToR8WIWQujtmyaev2+JGI9ahN
         BzTjnfH3EGfr345FQ7+A06ZsRVKnIJCgVQx0Gfs4=
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
Subject: [PATCH v4 03/13] c6x: use pgtable-nopud instead of 4level-fixup
Date:   Tue,  5 Nov 2019 09:15:25 +0200
Message-Id: <1572938135-31886-4-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572938135-31886-1-git-send-email-rppt@kernel.org>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

c6x is a nommu architecture and does not require fixup for upper layers of
the page tables because it is already handled by the generic nommu
implementation.

Replace usage of include/asm-generic/4level-fixup.h with
include/asm-generic/pgtable-nopud.h

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/c6x/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/c6x/include/asm/pgtable.h b/arch/c6x/include/asm/pgtable.h
index 0b6919c..197c473 100644
--- a/arch/c6x/include/asm/pgtable.h
+++ b/arch/c6x/include/asm/pgtable.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_C6X_PGTABLE_H
 #define _ASM_C6X_PGTABLE_H
 
-#include <asm-generic/4level-fixup.h>
+#include <asm-generic/pgtable-nopud.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
-- 
2.7.4

