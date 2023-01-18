Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94F671678
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 09:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjARIrv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjARIpm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 03:45:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D290875
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k18so12073000pll.5
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrPiR9IjSMnA6UKTOp8OkTYk/Ghbyk4227JxOnG3eIc=;
        b=i4bw46JJNHRCls6t57srDxlnFl9Ixtn2MdZ/C1ywWOJAZ6c4MzBYu4pOZeTJcb/q7N
         UsxGeUe0RQcuI8CsYp+iwUQSUUwXzJJH/aoZLqbs8vXZiAVTsoNPzhMrgcJ56rVs7UyC
         3wO94DAvEHxcY8Wc7kErGUl9QIJzkStrhbVKKsW0tMVDhEBg0wBmovNzmHyWbXyE6NdP
         TYBWmk/p0jbSH5WF00hnqcEwOS109b2suq6lAXft0IQlzKGzp7MmKdgJLgQioXXYUHz4
         D6ia+/6u4/Dws5LDHKM6NQv/orJW01MoD44qPN/ZLK3HdidkLzBV8lr0dSmdnyYamY+9
         Kkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrPiR9IjSMnA6UKTOp8OkTYk/Ghbyk4227JxOnG3eIc=;
        b=b89aQoUAzIn7C5yJkQQF1OTfhR9lHPmjEKoWooPvl1awtCGuIqz4S/JDW0UmuryCqQ
         r4UpCdRd/DWqUkqlVYjlpR0jh95uQpDz2WaYke33IPzL6VA6LzqHNuBFpo9oX7leDu6Q
         Zk1PIVOe77whXOeJwUFrWRZf+8VCF1Lwz5EViaMNcsG0akBUz0QA8OIPO96FvpbYLhDi
         2XsLB19Qms0f2gV3V33ET0m+jVEzc2J6qvnU0ZH6btnx8YcYOHxwf5jombI54lXWps9G
         jOqlSsGvx24r9MoGKdjF6HN2lOK2BlSxUv01CB5FCtZpNIZz/7yNMVe7g786iOZE95Hq
         OWpQ==
X-Gm-Message-State: AFqh2kpy9nuVdohyK3n5MjFhKNks9vSj2Y/HwfRNt1jOOjEQHfiOt24B
        1OgBr1TXRpdii9NC1j58ZyM=
X-Google-Smtp-Source: AMrXdXtTl64G4cCab9NpNyGKytSh9JoZppnQQfip0s76mKtZrzwRQdlnqZiCFVAJ79+Rk/NIj37VRw==
X-Received: by 2002:a17:90a:e543:b0:229:a2:a265 with SMTP id ei3-20020a17090ae54300b0022900a2a265mr6031348pjb.3.1674028838309;
        Wed, 18 Jan 2023 00:00:38 -0800 (PST)
Received: from bobo.ibm.com (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a16c200b002272616d3e1sm738462pje.40.2023.01.18.00.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:00:37 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 4/5] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Date:   Wed, 18 Jan 2023 18:00:10 +1000
Message-Id: <20230118080011.2258375-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230118080011.2258375-1-npiggin@gmail.com>
References: <20230118080011.2258375-1-npiggin@gmail.com>
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

On a 16-socket 192-core POWER8 system, a context switching benchmark
with as many software threads as CPUs (so each switch will go in and
out of idle), upstream can achieve a rate of about 1 million context
switches per second, due to contention on the mm refcount.

64s meets the prerequisites for CONFIG_MMU_LAZY_TLB_SHOOTDOWN, so enable
the option. This increases the above benchmark to 118 million context
switches per second.

This generates 314 additional IPI interrupts on a 144 CPU system doing
a kernel compile, which is in the noise in terms of kernel cycles.

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

