Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B44041C7B6
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbhI2PCn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 11:02:43 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60844
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344955AbhI2PCm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 11:02:42 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F06140279
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927660;
        bh=vJN7Ck0uNCFG+Ctq/qAp6lWVQYR8Vj2mrO3VtePHdDo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tEGistNa+9p4GCeynYFirlziYJXgNLGzJ2JJMoT+Tap0tLGz391AGxVvCydht056f
         iOJCRsaiLWfg2A1tzFMtGSvqtOsMoeBxnpUtmBT2Sl1qj+y9cfJGMj7iFxaPvFnMmr
         PCRf07qEpQg2CLDdhyKICr1HS8CvR261L1tggxCNxpmk9qKg07k/b6Dzw3RVu/pOT7
         GY+/YJT58PH+x7rIg1Mi4a1c9s+W5U9FMcwVXsbSJQnrH0UDLLLxKkbQojQfNCDYw3
         HzDjuitcxo0Bx3ndSzYvBokQiDMc2ysBRGCD1iowJ0nbtWmwBCe+spBMrv8fFZjCkL
         wnF86zJRyQBHw==
Received: by mail-lf1-f71.google.com with SMTP id s28-20020a056512203c00b003f42015e912so2654880lfs.4
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 08:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJN7Ck0uNCFG+Ctq/qAp6lWVQYR8Vj2mrO3VtePHdDo=;
        b=CyBjwSO3NnkwB5jPv060ouzMJFDSLonyAI2sa8yODqe2ndDATqbWCJhaBrgqgvHSGt
         lETdODzb7oh6D4vk3MKuUOzQMkbC7Jvr0rFSFXSydoDMDTVirCXp3CIhQJY7nXbYYSfw
         BBgPoNiyMNJx6CwcZixpY9azrh8KVTg2PyjAazwL7shleGAN3KZFxNhT4n5Uf2oCHIwl
         +7JrGhG+39nnt2WzFWxTTbaRYnclV1Pj2eE64CEtq5iHb+A3fhCe0A3JQRSzMfqgv+cT
         wby0SAs+2k3QbdV50QVR4swTCKHr05tNeTA9D95W5m+aYC0vPj3hw8f7MPXgkWfGl3uH
         pphA==
X-Gm-Message-State: AOAM530yIY25pXU37jW+LphZthKAqSxrCRf+S+w/+W5IQ7oqy4kEQ0fo
        oXb0Oc1v/1fEe7FvvnPXp+MgnG4kYBLBsbbH8NuJ0rkInhM/1IzKpnf/3TrbKxxJhdhf0nEVCcW
        VGZr0OM1HgPmiKbC84Eq+N/jP94w9YXULfFTCvUw=
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr327577wrk.125.1632927646755;
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfXtNjTqRwTy6zB0yjO+6WDv1SXfe8fP/ut2QpPS8jTHw1twOX+D4X0+hshAyxExD632O4tw==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr327526wrk.125.1632927646559;
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id e8sm142306wrr.42.2021.09.29.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 09/10] riscv: Initialize thread pointer before calling C functions
Date:   Wed, 29 Sep 2021 16:51:12 +0200
Message-Id: <20210929145113.1935778-10-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Because of the stack canary feature that reads from the current task
structure the stack canary value, the thread pointer register "tp" must
be set before calling any C function from head.S: by chance, setup_vm
and all the functions that it calls does not seem to be part of the
functions where the canary check is done, but in the following commits,
some functions will.

Fixes: f2c9699f65557a31 ("riscv: Add STACKPROTECTOR supported")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 8f21ef339c68..892a25c6079d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -301,6 +301,7 @@ clear_bss_done:
 	REG_S a0, (a2)
 
 	/* Initialize page tables and relocate to virtual addresses */
+	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
 #ifdef CONFIG_BUILTIN_DTB
-- 
2.30.2

