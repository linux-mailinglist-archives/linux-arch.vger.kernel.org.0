Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66701757223
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 05:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGRDXM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 23:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGRDXL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 23:23:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A534A10CC;
        Mon, 17 Jul 2023 20:23:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2633b669f5fso3054117a91.2;
        Mon, 17 Jul 2023 20:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689650589; x=1692242589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yv7DKGWYDQ3IstVTsPYilBNPKZLlN7W5JVMW63FDnUE=;
        b=NziB6tMWEIkehLIhq54A2/pAaY4/k/NgI74p6LMaa3K/M9PtjpifkYTiSoSk482dvk
         DAEGDBDe05Jb34OFq1nSqUbTkCSTc+6nhhhzvKLsY+P3l5BFjL0FKkUmzNzTfNySU14O
         8DxgcXkixqlNETV4SORdYMUFGnz5AuNZ+zgR8k3YioNJY/t6GFjdp3YEwr096pA8Wosp
         ll0+R5OCrq4+a5luVlrw2kdEa+CXzDKS26WWko+Udlqb6iofCZ2GIDAzD+ldh0xepu7Q
         BUQd4sIy9wbCiIi+NWMzccPv7rQVel4Y2509j123sZpUg2Kpm3xG4t+87N8KwXP2hIgk
         h4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650589; x=1692242589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yv7DKGWYDQ3IstVTsPYilBNPKZLlN7W5JVMW63FDnUE=;
        b=Dcn4AOD0IlfRkamZQLwQdAaQukbl5pAX5Ramiu57jNvdYwlxu84IkuqLrrKWNKbA9U
         n6cM0SNb9Xl+0RZcJz/ymGRNSGmx8AMn62Rdvhu6q1U1JJ3GgRBXoD0qy6RSumx/yvNS
         ucfrkr6e8L4oYvlh2o7OYttFJKpOKM4STpZD10xM/n5t+vmaU75URL81ASXjfpC5uM/Y
         5pAbbE2Fk5dkQcI0WUVan7bR8oOCDgIQDXfoZBkjo2LxQaK4wkUoVHRa2Lkk+8pq7GoN
         NhafKUa6igcj9nkbV5eWrL3XMW/tPWTP9FUJCpDEkuRdpK/KXkNJMQXNYNbt5QuU/rna
         mf3w==
X-Gm-Message-State: ABy/qLZYzbAHYbTNKVMZEKR8asu5z8nuD/wud07P67MPwzUYVGsCnsIc
        98qzAZn91oljEmvSH5AZGvSQW55iGfNOoA==
X-Google-Smtp-Source: APBJJlHtQf1X7VmpSTDopgk/6RS4OMpPJlLEArvbBovUU+zonMPD+nxI/TvzVWWaEzRw/emwgNZwKQ==
X-Received: by 2002:a17:90a:a013:b0:263:f590:f231 with SMTP id q19-20020a17090aa01300b00263f590f231mr687290pjp.26.1689650588933;
        Mon, 17 Jul 2023 20:23:08 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id s92-20020a17090a2f6500b00263f41a655esm504040pjd.43.2023.07.17.20.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:23:08 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 0/9] x86/hyperv: Add AMD sev-snp enlightened guest support on hyperv
Date:   Mon, 17 Jul 2023 23:22:54 -0400
Message-Id: <20230718032304.136888-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
  x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest
  x86/hyperv: Add smp support for SEV-SNP guest
  x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES

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

