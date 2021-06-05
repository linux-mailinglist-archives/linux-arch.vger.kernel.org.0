Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDFC39C4DF
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 03:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhFEBop (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 21:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhFEBoo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 21:44:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C28C061767;
        Fri,  4 Jun 2021 18:42:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o9so6401760pgd.2;
        Fri, 04 Jun 2021 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZkiKtXqsSUWsFPxoaMD52BWVXcB9txjh0r70N9gfwg=;
        b=WW4xgRVmullOrJwODXcaph9gCP7wl4/aB45NW6pjILZwERzHDpOslub+OyR7hv6vhX
         MQF6HrAFrzeiZgWNqLnh7i5L5IUeCDNz4A5ttNpDA19cMy9/mGXcEJT0WbPyaayBmVSB
         bVOuiJ/6Rsgfw8dJqWBlu/YAJYV8e3PSbOsa4f4K9eWKr2Xgo39e1CSlwj7VCjuDyqVY
         S0LwDvr6wJcda9KLJjMBlr2BLG4r6PfTk2tg/qAZCN5xG7q7k/UhBG0CDq4/lfxkpqkm
         0WECU+QAbnudJ7jXiUtvPGGgerN8eW0cwsDgFdV4SroQ2C6/rCsFRueDEuusyXuNkrHY
         BuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZkiKtXqsSUWsFPxoaMD52BWVXcB9txjh0r70N9gfwg=;
        b=SfzRrxmgYspHlMh9tq8R3vP8n6lfn1RFOGkSA5nTB6xJX9+cYzXWAi9pd8sfNyjEhX
         mqbAJejGYDZt4UN88WVwTnAiQwwUJ9Mky4bOEezw9TZs81IiKHRsprkmsIpKGy16dJ8U
         eLYqCHf5JwrLXDW0GICqMk8YS100sbmpZ8u6gz8ABsM1in8ujjVbGYzxi5pWA1b8TTv3
         0RWAhe3xCFJtMXt+YQSqfBO5nd5AHhaeuMRVjZqn30n7UryvhOx57AL/KmFdDqOPUTc6
         H+RqYKe2Wo0u+piF2llIBPJqLfBwUZBBdbKsdIg98osMuLkfUXF49nClr9BBs47m/vNB
         7yYA==
X-Gm-Message-State: AOAM532fRw1VCiNQo7nPswV06xJfpcvtoGXFFt5KE8imA9uKzboZ0sQk
        Mznqz9hBf50aAAmDDhy/xlE=
X-Google-Smtp-Source: ABdhPJyb9zARpDDElBpR8QCJlNYPOxW79PfjHchqfbuf/vsgpBZ0bkxI9OwGFQqJfm5GHitbPo8Vnw==
X-Received: by 2002:a62:3782:0:b029:2de:903d:8640 with SMTP id e124-20020a6237820000b02902de903d8640mr7135267pfa.40.1622857362398;
        Fri, 04 Jun 2021 18:42:42 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id q68sm5779056pjq.45.2021.06.04.18.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:42:42 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 4/4] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Date:   Sat,  5 Jun 2021 11:42:16 +1000
Message-Id: <20210605014216.446867-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210605014216.446867-1-npiggin@gmail.com>
References: <20210605014216.446867-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On a 16-socket 192-core POWER8 system, a context switching benchmark
with as many software threads as CPUs (so each switch will go in and
out of idle), upstream can achieve a rate of about 1 million context
switches per second. After this patch it goes up to 118 million.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 088dd2afcfe4..8a092eedc692 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -252,6 +252,7 @@ config PPC
 	select IRQ_FORCED_THREADING
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
 	select NEED_SG_DMA_LENGTH
-- 
2.23.0

