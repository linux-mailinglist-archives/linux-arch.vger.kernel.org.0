Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EE0234F2B
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgHABPZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgHABOy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:54 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428CF2245C;
        Sat,  1 Aug 2020 01:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244494;
        bh=eJnSwtcYG/GDRX+u074qA+9PbRSURvS8a3Kgpt9UQwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2NQO8Bxj8TdBaXxOzsyID06xvmq7bQeDwwHEX0dslTRVTtKxZgZ8aJSKr4MdmmcZi
         cLmwYxtnr/d49WCe1taKNwzsWqtUhGOFk+sltCNCrVozwJUjDJZRsvrOyxpw1SInaZ
         C2PsGrwMLNKiMwz+eSt9/nrf6LaZ0GacgMlzyuPY=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 09/13] csky: Set CONFIG_NR_CPU 4 as default
Date:   Sat,  1 Aug 2020 01:14:09 +0000
Message-Id: <1596244453-98575-10-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The C860 processors support 4 cores smp for maximum, so set NR_CPU
to 4 as default

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index fd92d73..ad98b93 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -279,7 +279,7 @@ config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
 	depends on SMP
-	default "2"
+	default "4"
 
 config HIGHMEM
 	bool "High Memory Support"
-- 
2.7.4

