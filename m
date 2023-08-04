Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC577044E
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjHDPXB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjHDPXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1965149EB;
        Fri,  4 Aug 2023 08:22:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb8a89b975so15263815ad.1;
        Fri, 04 Aug 2023 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162576; x=1691767376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKT51FiIG/jADTR6ZwhJgUzQz0lXZlfjB4qfN7TtFMA=;
        b=LgVupe8BUCkSq2TYgdUfTD8KvZ+1km7i2BgmfH3fot3UqjKMQlElJ/rORqbZLm8AlJ
         ZQAW5g1LwA8SehbjIqMt07GJEPEuUc02i0Oel54nDzgzp7lnzp9jahMsUsQtDIIpMLvJ
         La2yIQO68g8I4T3oYK/zjj8SwCfAZCwxMOZkyvJv9zBkhUMMoZKF6Kv30eoHgwzsJlic
         fa39LJYKJNLKxcmc+0ljEUv8kOqPqSHZ1inB8PcLg0iKnCx7PuQ+0QG4w+WXmrMRJjIm
         mKvgBdon8MsEyUV8VI/y4SCvdT9QCBVSZYcxNoJWUjzdbQTiWbHA6McivnQkCfkOA4Ai
         gzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162576; x=1691767376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKT51FiIG/jADTR6ZwhJgUzQz0lXZlfjB4qfN7TtFMA=;
        b=Cf0boX5gyUJUlDh6too2NVrPh0BuN/mxD6Z5RZBPfmF+jer0Kyg4kBNFZHJDkK7t3j
         SVzXBEClLuPgK6Car9Z+eu8BS2hW4jaZ5JbozV9UPoDkOjlYmzKe+ApUluRgjnalqjuA
         MTFvl8jHJd/p9hNAH5UlsGNcVWrYapZCEEluVC5bcVu9SwxplmYGRg+MmrmSrlexS15K
         sp6tTniuGcWgaVAUd5sCqqR8F/HRTyDLnkS2ZJ58H1CQIoZ0r8/aUEgbZd4Gqb0vy1cK
         FuxbeqAL1uwhF0HAGYLwcOLebbYiq6QmPF7uF21DOSaj/cu5lpvt7JCQ2pRDhU7Fphod
         kjRQ==
X-Gm-Message-State: AOJu0YymnpFFGJMGhYL2QDoweKXYgq6A5pRxtx4o/7XP4fZOW9Ig962h
        7kQaJ6hc6+nTItSfyruFlCY=
X-Google-Smtp-Source: AGHT+IGDwpxERBz0T+Ye0CQ8gbyUjzUKBh2CRok0ropOPneel0Eg4K+EYe9Sf9moeYm5lu1u80ZA3Q==
X-Received: by 2002:a17:902:c1c9:b0:1bc:32f2:812a with SMTP id c9-20020a170902c1c900b001bc32f2812amr1833697plc.27.1691162576353;
        Fri, 04 Aug 2023 08:22:56 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:22:55 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V4 0/9] x86/hyperv: Add AMD sev-snp enlightened guest support on hyperv
Date:   Fri,  4 Aug 2023 11:22:44 -0400
Message-Id: <20230804152254.686317-1-ltykernel@gmail.com>
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

Tianyu Lan (9):
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
  x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest

 arch/x86/hyperv/hv_init.c          |  52 +++++++-
 arch/x86/hyperv/ivm.c              | 199 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |   7 +
 arch/x86/include/asm/mshyperv.h    |  56 ++++++--
 arch/x86/kernel/cpu/mshyperv.c     |  42 +++++-
 drivers/clocksource/hyperv_timer.c |   2 +-
 drivers/hv/connection.c            |   1 +
 drivers/hv/hv.c                    |  57 ++++++++-
 drivers/hv/hv_common.c             |  19 +++
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  13 +-
 include/linux/hyperv.h             |   4 +-
 12 files changed, 426 insertions(+), 27 deletions(-)

-- 
2.25.1

