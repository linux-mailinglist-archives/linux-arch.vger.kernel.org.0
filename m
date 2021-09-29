Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4641C7A4
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbhI2PB3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 11:01:29 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60720
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344925AbhI2PB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 11:01:27 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB2E8402E0
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927585;
        bh=3cu0sC+0/nYKnIJicRvpKscpuwOhF+7jr6vCCwWJtCY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UbQk0DZVWmXt0WTDHbR7rTh79aIJDo8e2I4bI8rBymq0KqxjoHVH/ZXVmMCYApfZM
         s+15BFrfwVYB+CMMu9Bph2x4VhXxfwM8dncoaLGL6XTKvWKW/pEK5SrLfIZZKGVZhb
         mayHeLo9k0IjgNJ4bl2QEJupdJ/EaefqflhOQeLZDTdx9GxZEXQKQpXCTlaJiXTSmw
         TzzWg2Y5Fju/8a+wjjgp9j+y56rZFP4buRu+IHOArKBWchXh2+FiVgpFPM4Z3qhVYX
         ChlbPvXUO7vy+WXctQyUe8bRToAeGLZi/hG8w0Ml/e9KgzgRHpQF7fbhrcmfM3Vg7X
         N4WtiOtE/A8ag==
Received: by mail-wm1-f69.google.com with SMTP id z194-20020a1c7ecb000000b0030b7ccea080so2819135wmc.8
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cu0sC+0/nYKnIJicRvpKscpuwOhF+7jr6vCCwWJtCY=;
        b=FAoJVJMboFbIjAvyWDZSgpuzFh8rjaRMt36Lhawg7zN9A9Za1qfyqxUL0xVWBE9iCD
         AeI1gPuo2L7P/QmVddPMGlfO8zMdv+vUbuTnoNmWkna4SwOwExnbdZi6/jvDFJmG8zGv
         BQzZhiqvVd3ccQ+JEyZSsL03M1iBWHUx5iMA9pXQl38upeJMg1IXs0lw6DlSXCiV0htl
         fy4WXG8B2gpH/9uJ5JrBO83wGeYN4ep19nardOAxE99gVI9mqg9xxkJffKYKGpnJg0fx
         pf/ZHoXHmlUFnwFf5edyIiLlc8FDp+npbsL0bUlunUFK8RLiti8cJXJPYS3geC36w5ZI
         CQog==
X-Gm-Message-State: AOAM532B6DYtBmQckHlbgdgxZfvhsFI7+m7v6AoIqHLlyNdXEtTM2iF0
        HXLUq8neayX0gUMkkWrXz+MhytRIJ3lfUTYP2lNA5BSWCaxm4MdRBLU71QyxNhdWY5kGTfwFCgD
        nMxoQjMb2NpFZbAgRZZE+luMfrZj8xojnTgkrlRg=
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr340926wrs.404.1632927585419;
        Wed, 29 Sep 2021 07:59:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz15onekdEY2IjZrEU//1FAWV4fNkSUiHcnuIembEtiBE3MlubprxTIgEM4Jdpb37mujcxXYQ==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr340890wrs.404.1632927585227;
        Wed, 29 Sep 2021 07:59:45 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id l16sm81418wmj.33.2021.09.29.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:59:44 -0700 (PDT)
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
Subject: [PATCH v2 08/10] Documentation: riscv: Add sv48 description to VM layout
Date:   Wed, 29 Sep 2021 16:51:11 +0200
Message-Id: <20210929145113.1935778-9-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

sv48 was just introduced, so add its virtual memory layout to the
documentation.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 Documentation/riscv/vm-layout.rst | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index b7f98930d38d..f10128e0a95f 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -61,3 +61,39 @@ RISC-V Linux Kernel SV39
    ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | modules, BPF
    ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | kernel
   __________________|____________|__________________|_________|____________________________________________________________
+
+
+RISC-V Linux Kernel SV48
+------------------------
+
+::
+
+ ========================================================================================================================
+      Start addr    |   Offset   |     End addr     |  Size   | VM area description
+ ========================================================================================================================
+                    |            |                  |         |
+   0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
+  __________________|____________|__________________|_________|___________________________________________________________
+                    |            |                  |         |
+   0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
+                    |            |                  |         | virtual memory addresses up to the -128 TB
+                    |            |                  |         | starting offset of kernel mappings.
+  __________________|____________|__________________|_________|___________________________________________________________
+                                                              |
+                                                              | Kernel-space virtual memory, shared between all processes:
+  ____________________________________________________________|___________________________________________________________
+                    |            |                  |         |
+   ffff800000000000 | -128    TB | ffff8fffffffffff |   16 TB | kasan
+   ffff9dfffee00000 |  -94    TB | ffff9dfffeffffff |    2 MB | fixmap
+   ffff9dffff000000 |  -94    TB | ffff9dffffffffff |   16 MB | PCI io
+   ffff9e0000000000 |  -94    TB | ffff9fffffffffff |    2 TB | vmemmap
+   ffffa00000000000 |  -92    TB | ffffbfffffffffff |   32 TB | vmalloc/ioremap space
+   ffffc00000000000 |  -64    TB | fffffffeffffffff |   64 TB | direct mapping of all physical memory
+  __________________|____________|__________________|_________|____________________________________________________________
+                                                              |
+                                                              | Identical layout to the 39-bit one from here on:
+  ____________________________________________________________|____________________________________________________________
+                    |            |                  |         |
+   ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | modules, BPF
+   ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | kernel
+  __________________|____________|__________________|_________|____________________________________________________________
-- 
2.30.2

