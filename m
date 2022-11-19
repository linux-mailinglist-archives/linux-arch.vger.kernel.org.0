Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959D9630B3D
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiKSDqk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKSDqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:46:39 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB3BF5A8;
        Fri, 18 Nov 2022 19:46:38 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v28so6620267pfi.12;
        Fri, 18 Nov 2022 19:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItHAAK36iGOGmzzmFGR4SIh5cfls+/gHRc8xpAIVlCc=;
        b=bksUxzMjba7IfWMrf51EUKP8+sLkGf3Qw/GkzgKDvMcj1rHx0NN4Ash9c9rxU7qyhn
         UX5xE5OpyEdNHwGNbO1rRk95saYEYvEqgC1gbd/FQmnShNEu/Xhm7pRyvSxaR6KP7evf
         y6YykC5sEJFrlb0iu/FqlEoUzcHoo8f6W7I9bbC++qNFCo5+QufKQSN9M4F3QcvG0Xyq
         NbFO0jDXallk1AbVhP7sqcMtJlVnch9XStFOZdTEJgu5nYaUSE6uEVWFYCN9Pk7sH/Jc
         elKrBUOB1XLRYauU7ylihIDxaUw1slP+oqwHmkz+Wy6xRT+RJuePxok/+Eg3sYIck40e
         gmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItHAAK36iGOGmzzmFGR4SIh5cfls+/gHRc8xpAIVlCc=;
        b=aClYihSiR+0w/hdA2MW+HeV7r2rhhN4AO+ooGWUann3HnA98snDHuuxOYeW9SGifXG
         Io3W51Au7vEczNzcSUzBaUTgC0L8/DV9VdEO1o8oIGNJZYnWjz9HnKgNd3Nmquh8tnNe
         xJaTe0l/o76Cgc83cXsDmQ4IboL0x9PTmCHUUKV3O/o3OkzDqO9HaZovZNHwqTy/sYDW
         Mnxw4fa0XkkrPkKC7ZwfZ18m45OYSma+TQIuPAKT//djUHOw/60rgS/6OEAeRkYnObux
         sS3cPhCAY7FFSQPnT1tUU/ELLtDQPcDeqj847hQnTPfoV74Cq52Bg3pIt0uwRPTleROU
         DJQQ==
X-Gm-Message-State: ANoB5pmqS92zORoANuT5c5+7dCtYRh0eC0XuRWeblX+u0fVO7RttndQ0
        b2j0G3q47Rt0DjWM4fUmgv0=
X-Google-Smtp-Source: AA0mqf4ofW9HmJGHc2OUrov0qTGpaGYtCLMziwsXYNiW1eTXUvXgN1IOWC4Hy6eOpcE1JeksbaK3Sw==
X-Received: by 2002:a63:e644:0:b0:45f:702a:aec2 with SMTP id p4-20020a63e644000000b0045f702aaec2mr9414542pgj.450.1668829597666;
        Fri, 18 Nov 2022 19:46:37 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:36 -0800 (PST)
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
Subject: [RFC PATCH V2 00/18] x86/hyperv/sev: Add AMD sev-snp enlightened guest support on hyperv
Date:   Fri, 18 Nov 2022 22:46:14 -0500
Message-Id: <20221119034633.1728632-1-ltykernel@gmail.com>
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

Change since v1:
       - Remove boot param changes for cc blob address and
       use setup head to pass cc blob info
       - Remove unnessary WARN and BUG check
       - Add system vector table map in the #HV exception
       - Fix interrupt exit issue when use #HV exception

Ashish Kalra (2):
  x86/sev: optimize system vector processing invoked from #HV exception
  x86/sev: Fix interrupt exit code paths from #HV exception

Tianyu Lan (16):
  x86/sev: Pvalidate memory gab for decompressing kernel
  x86/hyperv: Add sev-snp enlightened guest specific config
  x86/hyperv: apic change for sev-snp enlightened guest
  x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
  x86/hyperv: Get Virtual Trust Level via hvcall
  x86/hyperv: Use vmmcall to implement hvcall in sev-snp enlightened
    guest
  clocksource: hyper-v: decrypt hyperv tsc page in sev-snp enlightened
    guest
  x86/hyperv: decrypt vmbus pages for sev-snp enlightened guest
  x86/hyperv: set target vtl in the vmbus init message
  drivers: hv: Decrypt percpu hvcall input arg page in sev-snp
    enlightened guest
  Drivers: hv: vmbus: Decrypt vmbus ring buffer
  x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
  x86/hyperv: Add smp support for sev-snp guest
  x86/hyperv: Add hyperv-specific hadling for VMMCALL under SEV-ES
  x86/sev: Add a #HV exception handler
  x86/sev: Initialize #HV doorbell and handle interrupt  requests

 arch/x86/boot/compressed/head_64.S    |   8 +
 arch/x86/boot/compressed/sev.c        |  84 ++++++
 arch/x86/entry/entry_64.S             |  82 +++++
 arch/x86/hyperv/hv_apic.c             |  79 +++--
 arch/x86/hyperv/hv_init.c             |  47 +++
 arch/x86/hyperv/ivm.c                 |  12 +-
 arch/x86/include/asm/cpu_entry_area.h |   6 +
 arch/x86/include/asm/idtentry.h       | 107 ++++++-
 arch/x86/include/asm/irqflags.h       |  19 ++
 arch/x86/include/asm/mem_encrypt.h    |   2 +
 arch/x86/include/asm/mshyperv.h       |  68 +++--
 arch/x86/include/asm/msr-index.h      |   6 +
 arch/x86/include/asm/page_64_types.h  |   1 +
 arch/x86/include/asm/sev.h            |  13 +
 arch/x86/include/asm/svm.h            |  55 +++-
 arch/x86/include/asm/trapnr.h         |   1 +
 arch/x86/include/asm/traps.h          |   1 +
 arch/x86/include/uapi/asm/svm.h       |   4 +
 arch/x86/kernel/cpu/common.c          |   1 +
 arch/x86/kernel/cpu/mshyperv.c        | 267 ++++++++++++++++-
 arch/x86/kernel/dumpstack_64.c        |   9 +-
 arch/x86/kernel/idt.c                 |   1 +
 arch/x86/kernel/sev.c                 | 412 ++++++++++++++++++++++----
 arch/x86/kernel/traps.c               |  50 ++++
 arch/x86/kernel/vmlinux.lds.S         |   7 +
 arch/x86/mm/cpu_entry_area.c          |   2 +
 drivers/clocksource/hyperv_timer.c    |   2 +-
 drivers/hv/connection.c               |  14 +
 drivers/hv/hv.c                       |  32 +-
 drivers/hv/hv_common.c                |  22 ++
 drivers/hv/ring_buffer.c              |   7 +-
 include/asm-generic/hyperv-tlfs.h     |  19 ++
 include/asm-generic/mshyperv.h        |   2 +
 include/linux/hyperv.h                |   4 +-
 34 files changed, 1340 insertions(+), 106 deletions(-)

-- 
2.25.1

