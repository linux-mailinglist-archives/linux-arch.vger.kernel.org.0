Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81825DBC26
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 06:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395184AbfJRE4l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 00:56:41 -0400
Received: from condef-04.nifty.com ([202.248.20.69]:50603 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389158AbfJRE4k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 00:56:40 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-04.nifty.com with ESMTP id x9I4WAKv004997;
        Fri, 18 Oct 2019 13:32:11 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x9I4Vnxp019790;
        Fri, 18 Oct 2019 13:31:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x9I4Vnxp019790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571373111;
        bh=Yyl1cS1eYVt+sVWWGmNXm8/lysOK1IQALljWjASqSwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mvf2/0meUo3qXcLS0yRxbLFLzQ+erxo70YfKJZmlA25fJDuP2VseTcvr9gJKHMupY
         QqSYjcZb2Fyu8qj6leuy+QIphDCaA5hnLxTZzZJ3/DshvKu2ahgdDY/Zkl123ZgE/K
         5AUFrRD51GbkMkU+poOBcA4Qm4BfzNctOY0AbDj6H8syd2hF2zP0Ah/Q7wKS0CyXrW
         NVsez3NL1L8tWcK5/FgfHqgEMsMVS9/LuI8lg0vtgKQAHW0WGswp7H5+gza4Xy0w6v
         DOMl4b1Og+CeoxULFShX2rsVw1pAoTBYLrZXYawP9qrhMYwLI+kqMeNd5jFVoL+wd9
         wMd1OJtAp+xww==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH 2/2] asm-generic/export.h: remove unneeded __kcrctab_* symbols
Date:   Fri, 18 Oct 2019 13:31:48 +0900
Message-Id: <20191018043148.6285-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018043148.6285-1-yamada.masahiro@socionext.com>
References: <20191018043148.6285-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

EXPORT_SYMBOL from assembly code produces an unused symbol __kcrctab_*.

kcrctab is used as a section name (prefixed with three underscores),
but never used as a symbol.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/export.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 80ef2dc0c8be..a3983e2ce0fd 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -43,7 +43,6 @@ __kstrtab_\name:
 #ifdef CONFIG_MODVERSIONS
 	.section ___kcrctab\sec+\name,"a"
 	.balign KCRC_ALIGN
-__kcrctab_\name:
 #if defined(CONFIG_MODULE_REL_CRCS)
 	.long __crc_\name - .
 #else
-- 
2.17.1

