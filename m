Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12136229D5E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 18:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgGVQpO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbgGVQpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B2C0619DC
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so2553791wru.6
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcTngC2Bes9sF1CupaxPgWX3tAw0UoRfYaGJIdlmeeQ=;
        b=mvQ2D74QyUwCzSPTgbT4sWDjrm7UJoVfL3cHenKVZM4lEyQ4kiJMrsWap47ViZ/Wvr
         rZDWLr9NFPdHynImP8k+kUbehz7sK/izWI9taaixH28DDyAQxLDE2IVjI4JHth6sqvMd
         Bm3MyxL4Ev2MPQ719BJsT1suvEsdnYD9LiwdooMdWfuceghQTEMxSuCUAzFCiQNkszgr
         776DU9p9GQmi0hKDgGS6X4PrAU7F1kaKRpoHIctLA3l3w5RGa68JqwP9mYrDKItjiXEp
         YdYfHynQXX5o0Cs0P73flkaXSX7R5VWhnBQrZk7Ew+typZtMNI/jv6YpF1C6khkBO0C0
         nNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcTngC2Bes9sF1CupaxPgWX3tAw0UoRfYaGJIdlmeeQ=;
        b=n4mb3yFsEdJtRIFAPE0+CB9NNPVS83y7+GYKDadD8qxfy3152CYcK2ZtXNYiZQ6fwa
         D1DUf+VAVJ8LxQY1cc1zvzI7NPfCNCi3oSj6p2omPvoKjr1lwPeHxNF7LYJi2qJl15Hs
         p2IyXG+hiKJmF2bKrcjdrj/Dz3tAMqBujKeGpi6U6M0BdWyF6qBvqEPKLkSPsEpc9h/l
         HsR5fdD14Q0y4SBEvmzsOyiAbJlw2R7JRz8l4U3b9LWvy+2X66/HUbnU7ZocxsfsD+AB
         YkF1ozbgxoxYgdjxbWwuxhQvdQdiiyJya+xdbqYxfSEoV3kTJpOmaLXlnYuUdbOsgOQ7
         D8DQ==
X-Gm-Message-State: AOAM532AkXK3vg4josyHSKA2f//UEfEY6JZ4N1mZGFIXnm3NzDJWOZED
        DPUsMwPejEnEyf/LdSFA8Lz8bw==
X-Google-Smtp-Source: ABdhPJx2hxeObfvv1sweoqi7kI9BIJM5pRi6WnEDs4mkAmQ3drosmvpJW+pWqVpWlbJoNaizyRi9hA==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr388087wrv.146.1595436311404;
        Wed, 22 Jul 2020 09:45:11 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id e5sm631557wrc.37.2020.07.22.09.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:10 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 7/9] kvm: arm64: Mark hyp stack pages reserved
Date:   Wed, 22 Jul 2020 17:44:22 +0100
Message-Id: <20200722164424.42225-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
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
index 0700c3d21b23..dc557b380c87 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1451,13 +1451,58 @@ static int init_subsystems(void)
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
@@ -1481,7 +1526,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		unsigned long stack_page;
 
-		stack_page = __get_free_page(GFP_KERNEL);
+		stack_page = alloc_hyp_page(GFP_KERNEL);
 		if (!stack_page) {
 			err = -ENOMEM;
 			goto out_err;
-- 
2.27.0

