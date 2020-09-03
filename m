Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593DC25BE4A
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgICJSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgICJR7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:17:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EBDC061245
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:17:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b12so1891818edz.11
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnlRtG/CWSkZI4NVeKIKEydnJw+LdVFZjKE2XgTifuQ=;
        b=hUF/wWznrhIV4kD0nNa5LDuTyvYBcRJqJRT4AjaF0cV0Cm85jlZhKS8Ka8OrV/1IAb
         3ShKef+kcOd+ghf91meHp8twmWmMTmr4i5li7S6u7jJW6COg/KwmunepQBEEG8a5QFIu
         1S2h+XyMXH330ZazXmjmCzIWyT2Qywoc6aqRJCEVxaYU4ilpOuUylSu269/RPYD7X8bP
         NjDFh5AJcfRDgrzcsJvPmljNBjZqDVaWRNQ/lIcy0aO4vsDvRiJzYGI3BUma+LFFGV1K
         2wy6oRw6OCKcrv6ifEqMw0FCTMubNFMKgTFfLp2vzTIloUIxgJ9boRrWrZ6ZZz5qUzG+
         xdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnlRtG/CWSkZI4NVeKIKEydnJw+LdVFZjKE2XgTifuQ=;
        b=c1gc0ZbxlZOdpEFWSuuGPb7EED25qahikUAjPWX3U0vfQP8cZQ7pJuNycRayGHzUrt
         IwJF2Kv5Pi1mKWXqwG9sdkWASZIyWKanxbeWBNOZcxm7g3UUAB7cpcA/JCNIliYN992Z
         P3NH5b3xYCSidl9Xqn/niFO6lsK4Fpng3RrxVstdAnLHzvk1BOnR8xFYncKsIJnm4V5P
         5x5eKpJFU50SHubDMWkd60N3qgeSPWL9vuJmqN1k5NzAkGfn0ejdBJnRJWYL/v8dvtmA
         4Nh3ZCgegacBX5rTx3uqIyQt7gMEopSe70Rm7NB0F/0yvvp8InpRDi2bY+fe9+ly/xlq
         /GRA==
X-Gm-Message-State: AOAM531QEfbSyDYs2fkIlInmuX2s4ReUe2TyxqO7I+oNjwheJ2lOh4bf
        yV9wcF5Wb1Vr5BEW5JxzRilA3g==
X-Google-Smtp-Source: ABdhPJyT2Eil9AjKw8R/4nwj3PA9MLb8SnTJe5Rd8N1txrd2cT5Dl89hJVcJvGxtWZCvckgjsovWlA==
X-Received: by 2002:aa7:dc16:: with SMTP id b22mr2013761edu.252.1599124675844;
        Thu, 03 Sep 2020 02:17:55 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id v13sm2714856edl.9.2020.09.03.02.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:17:55 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 08/10] kvm: arm64: Mark hyp stack pages reserved
Date:   Thu,  3 Sep 2020 11:17:10 +0200
Message-Id: <20200903091712.46456-9-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
stack using new helpers which automatically mark the pages reserved.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d437052c5481..8a1fcf4dffca 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1453,13 +1453,58 @@ static int init_subsystems(void)
 	return err;
 }
 
+/*
+ * Alloc pages and mark them reserved so the kernel never tries to
+ * take them away from the hypervisor.
+ */
+static unsigned long alloc_hyp_pages(gfp_t flags, unsigned int order)
+{
+	struct page *page;
+	unsigned long i;
+
+	page = alloc_pages(flags, order);
+	if (!page)
+		return 0;
+
+	for (i = 0; i < (1ul << order); ++i)
+		mark_page_reserved(page + i);
+
+	return (unsigned long)page_address(page);
+}
+
+static unsigned long alloc_hyp_page(gfp_t flags)
+{
+	return alloc_hyp_pages(flags, 0);
+}
+
+/*
+ * Free pages which were previously marked reserved for the hypervisor.
+ */
+static void free_hyp_pages(unsigned long addr, unsigned int order)
+{
+	unsigned long i;
+	struct page *page;
+
+	if (!addr)
+		return;
+
+	page = virt_to_page(addr);
+	for (i = 0; i < (1ul << order); ++i)
+		free_reserved_page(page + i);
+}
+
+static void free_hyp_page(unsigned long addr)
+{
+	return free_hyp_pages(addr, 0);
+}
+
 static void teardown_hyp_mode(void)
 {
 	int cpu;
 
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
-		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_hyp_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
 }
 
 /**
@@ -1483,7 +1528,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		unsigned long stack_page;
 
-		stack_page = __get_free_page(GFP_KERNEL);
+		stack_page = alloc_hyp_page(GFP_KERNEL);
 		if (!stack_page) {
 			err = -ENOMEM;
 			goto out_err;
-- 
2.28.0.402.g5ffc5be6b7-goog

