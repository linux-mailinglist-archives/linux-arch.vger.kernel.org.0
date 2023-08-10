Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137DD777D91
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjHJQF1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjHJQE6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 12:04:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD4359D;
        Thu, 10 Aug 2023 09:04:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc34b32785so8202905ad.3;
        Thu, 10 Aug 2023 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683458; x=1692288258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+SF3zl+41agUIJM1O+gfEeVKPjmemuCif+mwIFH9rTo=;
        b=KqpQ0z8Ti+5O1OhHON2G2g8Yi68CISYwscSZk+hMCO1qDfrwUIFODn+iq6elxrV3xY
         YdvC6NjsX8VhdP9Q3/agD6Y+t8NU/gzNpnFtlmhLavueSTvPoMCJ70QqLM3xTQWmyqUd
         TJxkR3UkLjQYhERaBSpQa6DBh4TvrzyWqxdUhB0cEA1qywRxBJYgxVUQb1JsnoRqD97/
         fjHJBJxYPu991as0MGXXNglPdesWCF0hRV+3+gKwmNONCllKZxCDFLidfmKcglwfG7C5
         Tb+RY2qeu5QPms8TmjYBN4Q62MwCwiBo/bvA2ceRtuFMUz9m+gYNE+iRJ6LnMT1SKqlP
         Xg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683458; x=1692288258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SF3zl+41agUIJM1O+gfEeVKPjmemuCif+mwIFH9rTo=;
        b=U7o3tDQQQ/s7Ax1ixzFBY3LLX/48b0ZyecbFIkQH/2V2ISDqZ6vl410yp9v6Y0s5rF
         fzUNJWvYyPd4GXIKobTCs9ZRBzHL16aEkJ9r34g26sjrPb0R2sf31QiKR0LwZpuVYMYR
         z7rUL11onkYzL4NUW//Eb/4rBojqtZCu8KfEnFXpLoEcjTzo/uJAYSwooVhhN5BXJBRd
         mPWZO88GgJzORLPrg3oBBcv8EQfL0rHnn08s21/3J8k8c/wa95LJoch1frfxHh+i/a8u
         4dXjyZN02qLSGqBvFsx+RcdFZ7UuyfSKHGXI+9Xm/Je8brabQ0Gbn1nNeU53w8vvlaSR
         tMrw==
X-Gm-Message-State: AOJu0YzKP5u/zl01d5a3qFEE3mdu3PHJ6Tads/d8WWcRZMgH+KlM+p8q
        jLe3fgD92vJmn2oyJkzJHis=
X-Google-Smtp-Source: AGHT+IERCcvEDw2pKF0cSddJ8O9j63OatCR5sYqSdwi0B65DvV6sgtIFx2CDTMiC/jLgW16c9Ua0Tg==
X-Received: by 2002:a17:902:9a91:b0:1bc:9c49:f8ce with SMTP id w17-20020a1709029a9100b001bc9c49f8cemr2407104plp.4.1691683458189;
        Thu, 10 Aug 2023 09:04:18 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:c620:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b895a17429sm1948821plo.280.2023.08.10.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:04:16 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V5 0/8] x86/hyperv: Add AMD sev-snp enlightened guest support on hyperv
Date:   Thu, 10 Aug 2023 12:04:03 -0400
Message-Id: <20230810160412.820246-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Tianyu Lan <tiala@microsoft.com>

*** BLURB HERE ***
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

Change since v4:
       * Fix compile error on the ARM or other platform.

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

 arch/x86/hyperv/hv_init.c          |  55 +++++++++++++-
 arch/x86/hyperv/ivm.c              | 111 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |   7 ++
 arch/x86/include/asm/mshyperv.h    |  43 +++++++----
 arch/x86/kernel/cpu/mshyperv.c     |  43 +++++++++--
 drivers/clocksource/hyperv_timer.c |   2 +-
 drivers/hv/connection.c            |   1 +
 drivers/hv/hv.c                    |  57 ++++++++++++++-
 drivers/hv/hv_common.c             |  19 +++++
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  14 +++-
 include/linux/hyperv.h             |   4 +-
 12 files changed, 330 insertions(+), 27 deletions(-)

-- 
2.25.1

