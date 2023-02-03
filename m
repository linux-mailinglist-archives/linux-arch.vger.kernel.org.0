Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B836890AE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 08:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjBCHTl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 02:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjBCHTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 02:19:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6E719A8
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 23:19:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so4393896plr.10
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 23:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x14kRrZZe2kdSbgJ1PJqUMQQfgWflSMZWL5LFkwvByE=;
        b=h7nAnXYffJkXAeKtJ4+Pb47ZmdkwzoIxpzRgCBuRqFSEuDy+TP7MF7IO/iVxeE9h3P
         aG7Esd2gb18pAjYT42bsVp7oBg2AItWYJWILKrT1Rv1wljyPlzKVe3HEajToWCRcZVtL
         zy4qIqHGZ3aoBW3DgCSA/Vp7o+H66URuFiIddPmq0wydnig1tvUkwDog28Na9VCQmXCY
         VaSnJ2jOszZ6JD6S3Lt/kqQ/A4667tSOoYJbLAZ3Dg/8Mt+fnJ7poqcB8fdgDCdZgr9h
         DFZ/UDXahTH+Bf05/C7Y+Y3gm5kj6MbI54iJLvql0E7GMYErZm9nVGNUKj5tyaG4S5jq
         3YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x14kRrZZe2kdSbgJ1PJqUMQQfgWflSMZWL5LFkwvByE=;
        b=HVHPJwXOb02PbJNy7HJU9k0e3f7TTNHQdeZt6DFUjLQ8p0nTk+KjFgYiOEgqYGrugY
         9uMVEKvhOKTLXSMHJEqaAtsO44GflbivhCXP6ItNZseP3aULpzizZLovX/MkJ2fblj6Q
         b8Z6JxgVtQk1FASOqIyaFYRps+7f0RFdW/MFrbU2R6n1S1MTL2BTXEHVIX1cfhDx9GsW
         Johf73cRnlwow9+7yJns4S3rhaSlKetGYDmhrAb0S4v7bIXVTgV12/78506eflvus2Fc
         IoJSbmqKBr+IJ5SxUrHoEcz1kUc1t7BM6PpJQ5sUVv0r9kUr0Qx1XzD9RftGHgxz+XS5
         FPDg==
X-Gm-Message-State: AO0yUKUyAnKGvhCmWSRtOuzDzZd8khWcbKAGHQSket5ukeAZW3GWVgsH
        RuPyH6ykUp1Lc/hQmmDReh4=
X-Google-Smtp-Source: AK7set/pN1qkE5vW6sEUJPLmtT3NU/AerHL7q01jFwtmVHRhEkUBx1PKvOIigiSi96c+JcvQpUaLgA==
X-Received: by 2002:a17:90a:11:b0:22c:8dfe:d6a6 with SMTP id 17-20020a17090a001100b0022c8dfed6a6mr9294792pja.4.1675408762194;
        Thu, 02 Feb 2023 23:19:22 -0800 (PST)
Received: from bobo.ibm.com (193-116-117-77.tpgi.com.au. [193.116.117.77])
        by smtp.gmail.com with ESMTPSA id f20-20020a637554000000b004df4ba1ebfesm877558pgn.66.2023.02.02.23.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:19:21 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rik van Riel <riel@redhat.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 5/5] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Date:   Fri,  3 Feb 2023 17:18:37 +1000
Message-Id: <20230203071837.1136453-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203071837.1136453-1-npiggin@gmail.com>
References: <20230203071837.1136453-1-npiggin@gmail.com>
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

On a 16-socket 192-core POWER8 system, the context_switch1_threads
benchmark from will-it-scale (see earlier changelog), upstream can
achieve a rate of about 1 million context switches per second, due to
contention on the mm refcount.

64s meets the prerequisites for CONFIG_MMU_LAZY_TLB_SHOOTDOWN, so enable
the option. This increases the above benchmark to 118 million context
switches per second.

This generates 314 additional IPI interrupts on a 144 CPU system doing
a kernel compile, which is in the noise in terms of kernel cycles.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b8c4ac56bddc..600ace5a7f1a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -265,6 +265,7 @@ config PPC
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
+	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK	if PPC64
-- 
2.37.2

