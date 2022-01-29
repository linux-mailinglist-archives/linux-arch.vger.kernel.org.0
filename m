Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7746D4A2F3A
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 13:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiA2MUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jan 2022 07:20:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48558 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbiA2MTi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jan 2022 07:19:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0017B8234E;
        Sat, 29 Jan 2022 12:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA85DC36AE3;
        Sat, 29 Jan 2022 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643458775;
        bh=J65VF607Au+lXQP+8mKXArK6fDS/9hBK5qV8mWwi4fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNexS/zfRcpJQb9tKy9uq83XaLRwvXw8cgOzwvW9WGM8zvfpjFXUMmOHV7wpYFjBp
         R4zZeyMkYScimS69R0rmPSDQiLeoyC4tNXnoZopSCmrKnJ8CXAdNqsBzb1ez7gi6HN
         0Tyxrhtp5Mi9AKTv9oQEZpKazjfoFIi00SyeBHUBliq5cJENB09Lf+Pi7mLjn7YNBT
         aPsDFmioeyhcJlUMm3AZSlSK9ucd2doig8+iZU2Wyg6rU0gRs5rtmxtw+5HhoIUawl
         66/hvRTiAyCZ/rB8cQbfhby7/PO6/fXx4w8NqSqdB00+lX+6mDb6AecdxvXlTOakZB
         Pa6OVe+KOUrow==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de, hch@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 17/17] KVM: compat: riscv: Prevent KVM_COMPAT from being selected
Date:   Sat, 29 Jan 2022 20:17:28 +0800
Message-Id: <20220129121728.1079364-18-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129121728.1079364-1-guoren@kernel.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current riscv doesn't support the 32bit KVM API. Let's make it
clear by not selecting KVM_COMPAT.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 virt/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index f4834c20e4a6..a8c5c9f06b3c 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -53,7 +53,7 @@ config KVM_GENERIC_DIRTYLOG_READ_PROTECT
 
 config KVM_COMPAT
        def_bool y
-       depends on KVM && COMPAT && !(S390 || ARM64)
+       depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
 
 config HAVE_KVM_IRQ_BYPASS
        bool
-- 
2.25.1

