Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2AB71A22D
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjFAPQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjFAPQ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08078B3;
        Thu,  1 Jun 2023 08:16:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650352b89f6so430717b3a.0;
        Thu, 01 Jun 2023 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632587; x=1688224587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn03IuitoX1DYIgfFmjhabyzGhJt/kinTeFdj48SpmQ=;
        b=hvqQg8CXS1PoaEp4bdVR/ziC1nUrQAm3ddTPNZu1SmOCKKDA49JCeJrLCRlRrefHp6
         DhpZ0Z92Ql5ru7Eu7QOnfh031Xicudnow6qHKlT9ST/ySSaIwS3rZAr4Lo4gVHLgIuoT
         tQHMCksuZO148nqt2Owb975T1HWT4Va5wKENUqseOEWyWybM2nlD13vTbqpfqkLu2k4G
         9SGAxdvMIPCTASvMBTlTnt1KAezGRefTfrvsC2XiTgdDQ2c1E12t9WsSH0xbwLAYnkNq
         zVHPV67Tb75ZozK4NFjwQ9VBNwKc/kNDfcogSIeA2Nv+oylAlynzlIRRiXVvCXJY6Kcf
         TSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632587; x=1688224587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nn03IuitoX1DYIgfFmjhabyzGhJt/kinTeFdj48SpmQ=;
        b=i4Kc6NziBQaz5gM43lgvaNaiXZmN/HP2p3mcxckb/AbTZD5lA9aK1zSwmM/iNyfozh
         2zKeF5Z6V3f56VrZMm7EPQAFRAzKjqx3ZlXoUhdTRhtZX5JgMYgLWMMu760wG0vK7Y+N
         eeyIhPoN8o64btEaeKUiJzArx42sGOdy7D0/38jtPaetbzSPWGXw7Ui/zUZ6qEupMlR/
         UfbyGppGTzBoNCHjDQpo2uaakMyHGipxaeAt8EOezXT8Ez5GwvNBWK5djazeoFFGD9t+
         B3ksfQHZF1tKjzchJfhB+/jp+UP0jOtrN0sp30HKNadFA2CWapn3eUDwBfaboNRzOHqv
         /AsQ==
X-Gm-Message-State: AC+VfDxGudzz0Up7oDwAIUVfBTYE/EQrPT1XG//Ykj5f3KcIvviGh3+9
        ECPCdyx6vF9IpqMQM6tXczQ=
X-Google-Smtp-Source: ACHHUZ6Fpact9oEca8XSi37Iy9VTQkKMVsahul3D1goqUX8pyo2V2sB6ZvchbUdCSwb+gqhp9cyJGA==
X-Received: by 2002:a05:6a21:32a7:b0:10e:186c:9fee with SMTP id yt39-20020a056a2132a700b0010e186c9feemr8149320pzb.19.1685632587320;
        Thu, 01 Jun 2023 08:16:27 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:26 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 0/9] x86/hyperv: Add AMD sev-snp enlightened guest support on hyperv
Date:   Thu,  1 Jun 2023 11:16:13 -0400
Message-Id: <20230601151624.1757616-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Tianyu Lan (9):
  x86/hyperv: Add sev-snp enlightened guest static key
  x86/hyperv: Set Virtual Trust Level in VMBus init message
  x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP
    enlightened guest
  drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP
    enlightened guest
  x86/hyperv: Use vmmcall to implement Hyper-V hypercall in  sev-snp
    enlightened guest
  clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp
    enlightened guest
  x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest
  x86/hyperv: Add smp support for SEV-SNP guest
  x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES

 arch/x86/hyperv/hv_init.c          |  42 ++++++
 arch/x86/hyperv/ivm.c              | 199 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |   7 +
 arch/x86/include/asm/mshyperv.h    |  73 +++++++++--
 arch/x86/kernel/cpu/mshyperv.c     |  41 +++++-
 drivers/clocksource/hyperv_timer.c |   2 +-
 drivers/hv/connection.c            |   1 +
 drivers/hv/hv.c                    |  57 ++++++++-
 drivers/hv/hv_common.c             |  30 ++++-
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  13 +-
 include/linux/hyperv.h             |   4 +-
 12 files changed, 445 insertions(+), 25 deletions(-)

-- 
2.25.1

