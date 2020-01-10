Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1486137019
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 15:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgAJOyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 09:54:33 -0500
Received: from foss.arm.com ([217.140.110.172]:45806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgAJOyc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 09:54:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02DCD1063;
        Fri, 10 Jan 2020 06:54:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81E6F3F6C4;
        Fri, 10 Jan 2020 06:54:31 -0800 (PST)
From:   Mark Brown <broonie@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au, x86@kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 02/10] powerpc: Remove arch_has_random, arch_has_random_seed
Date:   Fri, 10 Jan 2020 14:54:14 +0000
Message-Id: <20200110145422.49141-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110145422.49141-1-broonie@kernel.org>
References: <20200110145422.49141-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Richard Henderson <richard.henderson@linaro.org>

These symbols are currently part of the generic archrandom.h
interface, but are currently unused and can be removed.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/powerpc/include/asm/archrandom.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index a09595f00cab..2fa7cdfbba24 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -34,16 +34,6 @@ static inline int arch_get_random_seed_int(unsigned int *v)
 
 	return rc;
 }
-
-static inline int arch_has_random(void)
-{
-	return 0;
-}
-
-static inline int arch_has_random_seed(void)
-{
-	return !!ppc_md.get_random_seed;
-}
 #endif /* CONFIG_ARCH_RANDOM */
 
 #ifdef CONFIG_PPC_POWERNV
-- 
2.20.1

