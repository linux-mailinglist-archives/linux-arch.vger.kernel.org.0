Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2441D4A5F92
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 16:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiBAPIL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 10:08:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60064 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiBAPIH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 10:08:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC31DB82E40;
        Tue,  1 Feb 2022 15:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624A5C340F3;
        Tue,  1 Feb 2022 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643728084;
        bh=Si9E3r6pYgLyZE78Wh6CEM9V0J4HBM/qUu4KIFvH+oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEuBg74CDZ3f6e40uvnJ5RT+SSwK1btZFI7S/uL/U8kEQKFmaRhBsDqnLCSARwUZ3
         KNytW4sxdwomRz6uGtcIYBx5R1X/EtERVDp2SRYHEuDWMlN3gt5nt1U9B+R/mAagrj
         lBQAywSJoO832oF0w0SFIIsC3dtJb9ybRVuwkRAbau7d3Y+4ITMf+j3Y8lPLHnzFZQ
         g2XQSyewZOa2P5q0uosp1gznuC1qPs/vrzHrIjA5TrHE5af3auUXxeOjawqNSFn1jp
         gED0x9TRgUjeg9doS6jwQ+ATkoPG6AeEbYS6+hXrOxYNVImxP3ZQYMqu+qKHmQcDop
         k7rgXY9AMpikQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 21/21] KVM: compat: riscv: Prevent KVM_COMPAT from being selected
Date:   Tue,  1 Feb 2022 23:05:45 +0800
Message-Id: <20220201150545.1512822-22-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201150545.1512822-1-guoren@kernel.org>
References: <20220201150545.1512822-1-guoren@kernel.org>
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
Cc: Anup Patel <anup@brainfault.org>
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

