Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF530DC89
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 15:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhBCOUX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 09:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhBCOUV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 09:20:21 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA124C061788
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 06:19:40 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id m7so4102845wro.12
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3+fgEg8CcwEZPzx5ba9dQiG1Bbp/LPpxkX/DyY7YReU=;
        b=ECa2T6w6Xzk+c+UXae/1//JfQrHaqmwEkNwbH6t+u9iPQ+/taS5oBKC8Gdqmp/aqiS
         aWV1vP6sIY7I+36pxfKtp6BYAhvNYVM64tQOefQf3JpLHeq5B5y7sSNryppKrNjWC09F
         KQQw/1A6xu6SK5Ii45Ua8ZLlMnDnoZjIvHpqAo5Dh84Q+1sfak9uVyPdlgkGcyuMPrAI
         wB88GN04WPUz/e/1yHNgAd0LN897HqvJADs9WusShW2qlUqp7oHeS/3lUgZFXR+SgmIx
         5TRBYFlfBEMGsSEHF4P6X7W+Hdy05RHZMqLi2jrB0fCxInNLjLcZo1WaTrAND7O1t9AA
         BuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3+fgEg8CcwEZPzx5ba9dQiG1Bbp/LPpxkX/DyY7YReU=;
        b=pnlDqZc0a7xThs48qbzMKOeTRPQoA3uOMLBBMEsMDIz3ZZHpPwz2dORuPjKIkviLqz
         4TrAXhXffoHKS+TdUcNiEOjFPMkAo+iHpcxazqE4j+BB6lGTRwLASw27Vz3YoQWqQh6R
         YhMJ2blO3BGXzWzlxmLzABPi1+1X+H1LmICyf6lZ1V8J3KWI6RMAeKBpa0T85FdKqEK6
         9qEGKaNTkHUFwiAqZfvCWG4M6T7TT7r/wSEGicpqdRD3510HGOxlQOD2TMgYnbpszASy
         Yt8CLKan7pemTpcHS/lV+9NLdCLWJLUaVdDs0kBAmXi3De0oN+dXCJeqOvJCl7YHU/6M
         O/Ew==
X-Gm-Message-State: AOAM532rHkyv7BgSH4umIcFYfxtveIv+JjJtheW2NYdLUomvbN5glwgP
        9+FYsVnU240tx4pjvXJkFNvZeWoVECxi
X-Google-Smtp-Source: ABdhPJyxHdPdDI/OtCdUuxvsWAYFicQkJiykIbbaVqcEXDzFTBrAuOyz3VUX4A/8Da4tuA80b98i9u7Cj/PZ
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c044:: with SMTP id
 u4mr1036932wmc.1.1612361978973; Wed, 03 Feb 2021 06:19:38 -0800 (PST)
Date:   Wed,  3 Feb 2021 14:19:31 +0000
In-Reply-To: <20210203141931.615898-1-qperret@google.com>
Message-Id: <20210203141931.615898-3-qperret@google.com>
Mime-Version: 1.0
References: <20210203141931.615898-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 2/2] KVM: arm64: Stub EXPORT_SYMBOL for nVHE EL2 code
From:   Quentin Perret <qperret@google.com>
To:     arnd@arndb.de, maz@kernel.org, catalin.marinas@arm.com,
        will@kernel.org
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, ardb@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to ensure the module loader does not get confused if a symbol
is exported in EL2 nVHE code (as will be the case when we will compile
e.g. lib/memset.S into the EL2 object), make sure to stub all exports
using __DISABLE_EXPORTS in the nvhe folder.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 1f1e351c5fe2..c9c121c8d5de 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -3,8 +3,8 @@
 # Makefile for Kernel-based Virtual Machine module, HYP/nVHE part
 #
 
-asflags-y := -D__KVM_NVHE_HYPERVISOR__
-ccflags-y := -D__KVM_NVHE_HYPERVISOR__
+asflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
+ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o
-- 
2.30.0.365.g02bc693789-goog

