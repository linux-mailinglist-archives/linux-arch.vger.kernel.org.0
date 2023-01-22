Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BE676AA6
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAVCqP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVCqM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:12 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA8D1A4BA;
        Sat, 21 Jan 2023 18:46:11 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z31so3467335pfw.4;
        Sat, 21 Jan 2023 18:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45kGiTtB+vXWni3TA9/zrv6bh+xs9n4x7ot8haE6gy4=;
        b=O2Knt9aVXRTW2nCyCrfcqZdZ5VPu9rh5mx/R6N58RtY8RFeZkt/S+k56LRzRdP3UsH
         Jh0h30MtMcVQSsz5Arss98QYQW3doQXDypsgDxLaEwKtghxmKxnD4Khvd2nHg7R90Fpx
         VznwGowj4zxxGf8Dexvz3uNggQZrDJKOXKPFaOcUWSYjlNSDlRpfpGabgALHhk8yDuE3
         U597ultZK8I04RoHfeA+3kDQoc4NhgK3+md/0qAespW3NDiV8sRh9iHHjLtuLoR5R4qT
         ccFzfgVZbJbZptY+cjZ+W1XdOmF8dYR/jzhngbX7raukvFemIAtVDab+NMdJf2EUjT9y
         yQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45kGiTtB+vXWni3TA9/zrv6bh+xs9n4x7ot8haE6gy4=;
        b=qvTJF+xnhEGxMGN9XYKxPdQx7/ZXSVMuS4yCpiqDOQLsslJfGw8c+TZZmJXgD9fH+Z
         5cvyfNW4emhPyVDUvDWZFCTgx7mBCCSWKZeEKCRpqkAB1N8gUU17tn/dXzCE8ye5MSCf
         uGCPw6bOwTRyHURuWJonTdSe/Uu+5npstlUQkyostfZMgSBwPk2hKnWUQN5pt4HHlGnt
         uFsO6AzqJ1rzvOjLw45ffj01s/Y6clQ98NIiUfdKyF7zOqlG3tUSPqqg5TJsFZxpSDrh
         9Q/RzPh+o0E19Pm+UOAEzdfOyBxaaFqfk0O1KOB5eodN/OTmxQzVKynlSHmKtAIaFhzs
         0b2A==
X-Gm-Message-State: AFqh2kr/5MmGiZGk78is3F2tKMgPr0TNHhH82mM3izYr7GhralqEUIov
        L8sxez5JLq/3UrJ5uaXzRORVK2X7BT5FT7yT
X-Google-Smtp-Source: AMrXdXvIVDLXNIw7ddhIgQtOeb0iqRF8KyluXeLtXSCQIpdIBXyhIK2SOJWYAL5+UncfUii2PfdTMg==
X-Received: by 2002:aa7:9483:0:b0:58b:b78f:fcb7 with SMTP id z3-20020aa79483000000b0058bb78ffcb7mr24143508pfk.17.1674355571163;
        Sat, 21 Jan 2023 18:46:11 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:10 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp enlightened guest support on hyperv
Date:   Sat, 21 Jan 2023 21:45:50 -0500
Message-Id: <20230122024607.788454-1-ltykernel@gmail.com>
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

This patchset is to add AMD sev-snp enlightened guest
support on hyperv. Hyperv uses Linux direct boot mode
to boot up Linux kernel and so it needs to pvalidate
system memory by itself.

In hyperv case, there is no boot loader and so cc blob
is prepared by hypervisor. In this series, hypervisor
set the cc blob address directly into boot parameter
of Linux kernel. If the magic number on cc blob address
is valid, kernel will read cc blob.

Shared memory between guests and hypervisor should be
decrypted and zero memory after decrypt memory. The data
in the target address. It maybe smearedto avoid smearing
data.

Introduce #HV exception support in AMD sev snp code and
#HV handler.

Change since v2:
       - Remove validate kernel memory code at boot stage
       - Split #HV page patch into two parts
       - Remove HV-APIC change due to enable x2apic from
       	 host side
       - Rework vmbus code to handle error of decrypt page
       - Spilt memory and cpu initialization patch. 

Change since v1:
       - Remove boot param changes for cc blob address and
       use setup head to pass cc blob info
       - Remove unnessary WARN and BUG check
       - Add system vector table map in the #HV exception
       - Fix interrupt exit issue when use #HV exception

Ashish Kalra (2):
  x86/sev: optimize system vector processing invoked from #HV exception
  x86/sev: Fix interrupt exit code paths from #HV exception

Tianyu Lan (14):
  x86/hyperv: Add sev-snp enlightened guest specific config
  x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
  x86/hyperv: Set Virtual Trust Level in vmbus init message
  x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
    enlightened guest
  clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp
    enlightened guest
  x86/hyperv: decrypt vmbus pages for sev-snp enlightened guest
  drivers: hv: Decrypt percpu hvcall input arg page in sev-snp
    enlightened guest
  x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
  x86/hyperv: SEV-SNP enlightened guest don't support legacy rtc
  x86/hyperv: Add smp support for sev-snp guest
  x86/hyperv: Add hyperv-specific hadling for VMMCALL under SEV-ES
  x86/sev: Add a #HV exception handler
  x86/sev: Add Check of #HV event in path
  x86/sev: Initialize #HV doorbell and handle interrupt requests

 arch/x86/entry/entry_64.S             |  82 ++++++
 arch/x86/hyperv/hv_init.c             |  43 +++
 arch/x86/hyperv/ivm.c                 |  10 +
 arch/x86/include/asm/cpu_entry_area.h |   6 +
 arch/x86/include/asm/hyperv-tlfs.h    |   4 +
 arch/x86/include/asm/idtentry.h       | 105 ++++++-
 arch/x86/include/asm/irqflags.h       |  10 +
 arch/x86/include/asm/mem_encrypt.h    |   2 +
 arch/x86/include/asm/mshyperv.h       |  56 +++-
 arch/x86/include/asm/msr-index.h      |   6 +
 arch/x86/include/asm/page_64_types.h  |   1 +
 arch/x86/include/asm/sev.h            |  13 +
 arch/x86/include/asm/svm.h            |  59 +++-
 arch/x86/include/asm/trapnr.h         |   1 +
 arch/x86/include/asm/traps.h          |   1 +
 arch/x86/include/asm/x86_init.h       |   2 +
 arch/x86/include/uapi/asm/svm.h       |   4 +
 arch/x86/kernel/cpu/common.c          |   1 +
 arch/x86/kernel/cpu/mshyperv.c        | 228 ++++++++++++++-
 arch/x86/kernel/dumpstack_64.c        |   9 +-
 arch/x86/kernel/idt.c                 |   1 +
 arch/x86/kernel/sev.c                 | 395 ++++++++++++++++++++++----
 arch/x86/kernel/traps.c               |  42 +++
 arch/x86/kernel/vmlinux.lds.S         |   7 +
 arch/x86/kernel/x86_init.c            |   4 +-
 arch/x86/mm/cpu_entry_area.c          |   2 +
 drivers/clocksource/hyperv_timer.c    |   2 +-
 drivers/hv/connection.c               |   1 +
 drivers/hv/hv.c                       |  33 ++-
 drivers/hv/hv_common.c                |  26 +-
 include/asm-generic/hyperv-tlfs.h     |  19 ++
 include/asm-generic/mshyperv.h        |   2 +
 include/linux/hyperv.h                |   4 +-
 33 files changed, 1102 insertions(+), 79 deletions(-)

-- 
2.25.1

