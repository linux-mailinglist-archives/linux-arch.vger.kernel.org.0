Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7C780A0A
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 12:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359286AbjHRK30 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359756AbjHRK3Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 06:29:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D06198C;
        Fri, 18 Aug 2023 03:29:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bddac1b7bfso5483655ad.0;
        Fri, 18 Aug 2023 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692354563; x=1692959363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAOYIka5Ba+QNJWMFjNluq/JSBUVx0FXHOUVJen5wv0=;
        b=rHS7YGIvhTMzJHR0q5AgP6lXMgRnAuNdtEhB/2se7mhyJp5guapTooTJBnUpiM9PbY
         8921t8sPdp0VZUJskUvnKaiB1jmHwEHvDvP0inM/4h3M9YLW1xPNssY6Y2O5NTZVIPc4
         kA/q0WBr/LjGdSz4f4Y2A1k9t9mVH45XPRvEW8bhwg1dVgAXT9ZDmZpuR1zypfdBKgQb
         M5RctwvAfQj1hCqZRyCYjZZyJBhovIeYPBdUdc0bFeMmZac7iCvxmpAp/5qFuoEECHk0
         KkeG9cn/i0IPombG8C6rLpI2BQ4Qmc40hSp7GsoGaEKoPfkuylsV9BY7irXZYpEM9djw
         t82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354563; x=1692959363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAOYIka5Ba+QNJWMFjNluq/JSBUVx0FXHOUVJen5wv0=;
        b=Z+t9iVdFq8/c1vNUaVcVK69qWLmAxZ960ZLhDcFHNZ5C6G8jdq1z+JpBlT5oBssmrU
         Ni7rl33DClTR+5XFZAD8GXt1vsdrn7eQs9aWdhscLM5OP3OgPDM0iryUFNDE/fP8BBbD
         Modrn5tdQyNIjBiRz8aoG3IP/crtDpHKAReRiUqPjKKfiJ4R0uzUzw7nqlX9Lvq+oEQ9
         oBZsdWtcdQcm8Qtx21WCcW3Fb5Ukf7FBtRNR2e2rEkk3Zjj7Qu/bLcfgtieVgc79y61R
         MmF7ePmpr5ANZhK2jJ7sVrGLXcFDQye+/IfUBW7oFsOYFXce0Eb5yomA/L2pL/TICECf
         k5Wg==
X-Gm-Message-State: AOJu0Yzi+x/dii8bdd8IhcSRWFp+KJ1gX7bUlLV+tqHW3wU6dl0YzGTx
        +hWocs8ABsI64zEQ1c3Mjco=
X-Google-Smtp-Source: AGHT+IHrgOA2BpNm2jhSevrxtQbkLKx8pR9Qm/wO5XLUmmyFg2Y+jjrscJ2av8MSE8z5WrcKNtD+8g==
X-Received: by 2002:a17:902:ecd2:b0:1bf:193a:70b6 with SMTP id a18-20020a170902ecd200b001bf193a70b6mr2746715plh.5.1692354562938;
        Fri, 18 Aug 2023 03:29:22 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:4545:4938:97f0:2e1f])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001b9be79729csm1386766plt.165.2023.08.18.03.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:29:22 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH v7 0/8] x86/hyperv: Add AMD sev-snp enlightened guest support on hyperv
Date:   Fri, 18 Aug 2023 06:29:10 -0400
Message-Id: <20230818102919.1318039-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V provides two modes for running SEV-SNP VMs:

1) In vTOM mode with a paravisor (see Section 15.36.8 of [1])
2) In "fully enlightened" mode with normal "C" bit control
   over page encryption, and no paravisor
 
For #1, the paravisor runs in VMPL 0, while Linux runs in VMPL 2
(see Section 15.36.7 of [1]). The paravisor is typically provided
by Hyper-V and handles most of the SNP-related functionality. As
such, most of the SNP functionality in the Linux guest is bypassed.
The guest operates in vTOM mode, where encryption is enabled by default.
The guest must still request page transitions between private and shared,
but there is relatively less SNP machinery required in the guest. Support
for this mode of operation first went upstream in the 5.15 kernel.

For #2, this patch set provides the initial support. The existing
SEV-SNP machinery in the kernel is fully used, but Hyper-V specific
updates are required to properly share Hyper-V communication pages
between the guest and host and to start APs at boot time.

In either mode, Hyper-V requires that the guest implement the SEV-SNP
Restricted Interrupt Injection feature (see Section 15.36.16 of [1],
and Section 5 of [2]). Without this feature, the guest is subject to
attack by a compromised hypervisor that can inject any exception at
any time, such as injecting an interrupt while the guest has interrupts
disabled. In vTOM mode, Restricted Interrupt Injection is implemented
by the paravisor, so no Linux guest changes are required. But in fully
enlightened mode, the Linux guest must provide the implementation.

This patch set is derived from an earlier patch set that includes both
the Hyper-V specific changes and Restricted Interrupt Injection support.[3]
But it is now limited to only the Hyper-V specific changes. The Restricted
Interrupt Injection support will come later in a separate patch set.

[1] https://www.amd.com/system/files/TechDocs/24593.pdf
[2] https://www.amd.com/system/files/TechDocs/56421-guest-hypervisor-communication-block-standardization.pdf
[3] https://lore.kernel.org/lkml/20230515165917.1306922-1-ltykernel@gmail.com/

Change since v6:
       * Fix code sytle in the get_vtl()
       * Rework code into smp patch 

Change since v5:
       * Remove input page check in the get_vtl()
       * Convert alternative back to if else check in the hypercall
       implementation.

Change since v3:
       * Fix fossil comment

Change since v2:
       * Update Change log.
       * Rework Hyper-V hypercall implementation.

Change since v1:
       * vTOM case uses paravisor_present flag and
       	 HV_ISOLATION_TYPE_SNP type.
       * Rework some patches' change log
       * Fix some comments in the patches

Tianyu Lan (8):
  x86/hyperv: Add sev-snp enlightened guest static key
  x86/hyperv: Set Virtual Trust Level in VMBus init message
  x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP
    enlightened guest
  drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP
    enlightened guest
  x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
    enlightened guest
  clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp
    enlightened guest
  x86/hyperv: Add smp support for SEV-SNP guest
  x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES

 arch/x86/hyperv/hv_init.c          |  50 +++++++++-
 arch/x86/hyperv/ivm.c              | 149 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |   7 ++
 arch/x86/include/asm/mshyperv.h    |  38 +++++++-
 arch/x86/kernel/cpu/mshyperv.c     |  41 +++++++-
 drivers/clocksource/hyperv_timer.c |   2 +-
 drivers/hv/connection.c            |   1 +
 drivers/hv/hv.c                    |  57 ++++++++++-
 drivers/hv/hv_common.c             |  19 ++++
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  14 ++-
 include/linux/hyperv.h             |   4 +-
 12 files changed, 368 insertions(+), 15 deletions(-)

-- 
2.25.1

