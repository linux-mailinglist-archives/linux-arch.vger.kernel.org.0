Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B360377E5CF
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbjHPP7f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbjHPP7M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 11:59:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042042727;
        Wed, 16 Aug 2023 08:58:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565f24a24c4so800667a12.1;
        Wed, 16 Aug 2023 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201533; x=1692806333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJxbYgZN2VigqrdMYxCnYDpGUSj9KXOQ2TcyDRZS3Zc=;
        b=HEO5X+ormeu429MSsdbUDXvJZuT7MB/qPjVVY8/JnwJztUjfVPqXTbaGzR2mY62twb
         2YYtqItRN5vtAVRikgLmOxYc6sbKMMn4B0ISJ4GSeW8CiC/cjIKbK9DdOK9x7P8euXuI
         Atc95lZxUmc7qnKg6fB5HifI/hLdnc00tc+Pha8iQIKEzZrZoXeGk2Zn1qDAorFkPlRx
         Q0nQfB95Icy8EAO13heY6YvgVNiveSZ1Tvw3Yg0bCdHQnzVu5e+yogXHKsYcoZzFf7HK
         WMknyojcnHRNMkgu8HXDCEQsWCJiM+CWMWnog3Zm+vCted3S/cyDB/GM9/KZtZ9fpPb6
         cS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201533; x=1692806333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJxbYgZN2VigqrdMYxCnYDpGUSj9KXOQ2TcyDRZS3Zc=;
        b=HsWXTF0C/HhM3v+URmJyq4fWoOoNpnnrtCKjMBBU0G+UToPtFTsAYDiSg7+b8WpQeB
         7yM5qBK3U1iFbfhHV4UXZ4tG7aUCPKV8yNoxp4/LVC7ljwDA5oIGJ6g1MEhcITYX+Avp
         yV0iYlosmUGD0N+DEbIhU+OEWa+KHyL/4NfKJk8uyopRpWs1/h0zrPf04NnFTHx7fry+
         BDg3qEK1lz8RLVfpfeGkRuTESbRx7bv2lPrpZIBS39imNalgnpy4A99vSiQ3tOYwR0O0
         3ebs/2cLmGzuWNrUFbAT86DId4ZFye0PabyzQAgmjLgW/od3YyJrRtRlDoTaNpHhz201
         pmdw==
X-Gm-Message-State: AOJu0YzBAuTjH3RkylvjzKfYHBxMjgPsWtsoYPjxQ7PXCX8wiKSA/DqZ
        /2+Qbsr3Ljm8VVlOyaTzHkQ=
X-Google-Smtp-Source: AGHT+IGi5Yvuch4Yvp5OWvAfsRVast8tMKEoiw7MAW3qXeuZjkX4TXOgH+/t2Ggd+t/E5AOqHa3wTA==
X-Received: by 2002:a17:90a:fb8b:b0:26b:e2b:6c8d with SMTP id cp11-20020a17090afb8b00b0026b0e2b6c8dmr1881012pjb.41.1692201533381;
        Wed, 16 Aug 2023 08:58:53 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:e588:8d80:9ae5:5adc])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm13366973plw.42.2023.08.16.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:58:52 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH v6 0/8] x86/hyperv: Add AMD sev-snp enlightened guest support on hyperv
Date:   Wed, 16 Aug 2023 11:58:41 -0400
Message-Id: <20230816155850.1216996-1-ltykernel@gmail.com>
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
 arch/x86/include/asm/mshyperv.h    |  55 ++++++++---
 arch/x86/kernel/cpu/mshyperv.c     |  43 ++++++++-
 drivers/clocksource/hyperv_timer.c |   2 +-
 drivers/hv/connection.c            |   1 +
 drivers/hv/hv.c                    |  57 ++++++++++-
 drivers/hv/hv_common.c             |  19 ++++
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  14 ++-
 include/linux/hyperv.h             |   4 +-
 12 files changed, 377 insertions(+), 25 deletions(-)

-- 
2.25.1

