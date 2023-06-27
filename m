Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B831773F2A4
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjF0D2v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjF0D2Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C241FFA;
        Mon, 26 Jun 2023 20:22:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55779047021so1649640a12.3;
        Mon, 26 Jun 2023 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836171; x=1690428171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgGCeKYSgX5ONiSOB6zmaLXgvW+aPX+dovxZk+0yplI=;
        b=GALPKXkbiNlMMUse1NEHvAmZlPFXXLnNu9Ag2REzXgGs7MAVVWh3OHijWErFH5zqfY
         CawAe+8CtBaGyoSYiaqpIQQkX4iSFtFe2P5odLl8Eo1QP/mqwAq0ZBsBg2MhBJ4JLvRj
         Y5q8XTywNBjlHTb4PPFy9wGcfTVqbXU5bItkpTgZXYPDu9elDS26SjEst+DB+KW4rxzB
         4tjun2dFWIJDh/1yDBJdnPRD1lVGc3KkXYisHkcOEiBZ1nvRKEuVdZ6JS9OWoZcRhC0j
         HeXHj3cagbj23P9ytwPsEjuITSiUiVSMYOhtKiUWSx7ak437Bx6P4H5d7A4N99T2Y8hZ
         u3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836171; x=1690428171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgGCeKYSgX5ONiSOB6zmaLXgvW+aPX+dovxZk+0yplI=;
        b=FvHXLZH4rcd+wN+BrMg4C7N7DYH2Mh0+Oo8m1sRsVzbMvGSqni7Jx59nqf2FPZDAsp
         0kN2NmCoNccsMdWAaFFw8cPWxrqZFSiptVgDc1LHnqW6uuuXXO5x0STTpNahHOobkEul
         Y/9rD6C8w5pIVP9Ai09CITCerJGlCY+oGmrGgcr9MCgYcxFeD2zU9kzgFY1dn2QDdFSi
         l13xSebhh2gM+7ktZh1nzo3rgDlXWV/2+ELhDoP1xF/88JqnfCI1tteedVV6m7Asicjl
         HnTrCBoyJknR17mhbuJThuFLsPkva4VmHdWy7IVBMuWqOEQ74IlWvse6S6k8GXdcAGeD
         nKyg==
X-Gm-Message-State: AC+VfDyeXQfP3XL8FNOqzhxayvqeWLUIY+KS2y4uRXkDduDlLGn5wbjF
        swZh48mhvAYoTcXLRQ4Ynr8=
X-Google-Smtp-Source: ACHHUZ60QnnCcLDGoPIP1qsnU2mo1shYfR/zJY/uGFOKsRbz8XfE3h7PsAaYrR9wgCLiy9WMvZFCqA==
X-Received: by 2002:a17:90a:1cb:b0:25e:a5b2:846d with SMTP id 11-20020a17090a01cb00b0025ea5b2846dmr18388882pjd.27.1687836171531;
        Mon, 26 Jun 2023 20:22:51 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:22:50 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 0/9] x86/hyperv: Add AMD sev-snp enlightened guest support on hyperv
Date:   Mon, 26 Jun 2023 23:22:38 -0400
Message-Id: <20230627032248.2170007-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
  x86/hyperv: Use vmmcall to implement Hyper-V hypercall in  sev-snp
    enlightened guest
  clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp
    enlightened guest
  x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest
  x86/hyperv: Add smp support for SEV-SNP guest
  x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES

 arch/x86/hyperv/hv_init.c          |  52 +++++++-
 arch/x86/hyperv/ivm.c              | 199 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |   7 +
 arch/x86/include/asm/mshyperv.h    |  73 +++++++++--
 arch/x86/kernel/cpu/mshyperv.c     |  42 +++++-
 drivers/clocksource/hyperv_timer.c |   2 +-
 drivers/hv/connection.c            |   1 +
 drivers/hv/hv.c                    |  57 ++++++++-
 drivers/hv/hv_common.c             |  19 +++
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  13 +-
 include/linux/hyperv.h             |   4 +-
 12 files changed, 445 insertions(+), 25 deletions(-)

-- 
2.25.1

