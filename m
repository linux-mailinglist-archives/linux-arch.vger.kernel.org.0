Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA06D4F3B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjDCRoM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDCRoM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615C92107;
        Mon,  3 Apr 2023 10:44:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r7-20020a17090b050700b002404be7920aso29376348pjz.5;
        Mon, 03 Apr 2023 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMv3NS5XhEsCAYXWn3ESVcr5ieV886jiRxfmDBuVIfU=;
        b=pd1ROCDaZ68jHr6hwCKXbIOlrkY3nPjTdhPGucgfsoGilpiVmMcR99mHCcfucQcqlm
         86hgl0ZH0w+tscwx2mNOHTdhjjZW5SAlbnwL6mu3IiGTs6iGfP162z75etA6IP05fs4J
         TcG00AOBfOpGNlkYQUrD1gFYMyrCuD9JrFQAkpwdy1LuNnTCihD6aSDhbDXp3ql5wlzF
         YZ9FHQxDYlfw0A8KQ9tAz5Ty/QY6jd93msexD583ggLVqfcWq4Cojs9P4wRVf2D2JGM6
         D3Z4lkkc9L5wb2WCnTW5QplxoGmpBAZM5ROpnQwJN9oarMsWQ7L6t+XvyLQws8Lda1xx
         ZYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMv3NS5XhEsCAYXWn3ESVcr5ieV886jiRxfmDBuVIfU=;
        b=5Io+9//sQJEhCzB8mkFvBCAc6T/Q8q8rEgEkJwy9+u1bNprhgthIsfWq3BdxpvU/RD
         OfsNhqhWi3RN4A4soIp9mPzhOTrTfCMKBUrmXDHLJed5fHpGeulIfaN+xE8HCMmjVLpf
         K+i/FSw5n7hHXxwG9oliJ2ta4mM4js0lO3XEJFRrSpaSOxqoM4up4kBbEtSONzitHSHP
         VMANy6FnmnvXdAAmyWyl4GVtgJf0awUtUUSC4zCFIA/+e6EwfJMK+9gxLGPpRtkzZ9Qq
         qUhKiuNASZ1+zEfTvKQ3VlfuEPLZinPL1uVuXikwlKsVJU2jGuvyDnoD8T1gtrWS/2ug
         oEAg==
X-Gm-Message-State: AAQBX9fV4qg6OPAmpaDZFeZPic2PyUDuA902JQYtryBk6klL8zJ/Qjlv
        wjKNAkqWZ1sjcYsq296yKWE=
X-Google-Smtp-Source: AKy350aE5mgMIF7xAkJwwvpqwaSOclhTbYdem6aF5HYRPLcF7xZXGn9vhmIsZSFKydeMPYrYJ9Lb1g==
X-Received: by 2002:a17:903:32cc:b0:1a1:f5dd:2dde with SMTP id i12-20020a17090332cc00b001a1f5dd2ddemr43879613plr.44.1680543849575;
        Mon, 03 Apr 2023 10:44:09 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:09 -0700 (PDT)
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V4 00/17] x86/hyperv/sev: Add AMD sev-snp enlightened guest support on hyperv
Date:   Mon,  3 Apr 2023 13:43:48 -0400
Message-Id: <20230403174406.4180472-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Change since v3:
       - Replace struct sev_es_save_area with struct vmcb_save_area
       - Move smp, cpu and memory enumerating code from mshyperv.c to ivm.c
       - Handle nested entry case of do_exc_hv() case.
       - Check NMI event when irq is disabled

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

Tianyu Lan (15):
  x86/hyperv: Add sev-snp enlightened guest static key
  Drivers: hv: vmbus: Decrypt vmbus ring buffer
  x86/hyperv: Set Virtual Trust Level in VMBus init message
  x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
    enlightened guest
  clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp
    enlightened guest
  x86/hyperv: decrypt VMBus pages for sev-snp enlightened guest
  drivers: hv: Decrypt percpu hvcall input arg page in sev-snp
    enlightened guest
  x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
  x86/hyperv: SEV-SNP enlightened guest don't support legacy rtc
  x86/hyperv: Add smp support for sev-snp guest
  x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
  x86/sev: Add a #HV exception handler
  x86/sev: Add Check of #HV event in path
  x86/hyperv/sev: Add AMD sev-snp enlightened guest support on hyperv
  x86/sev: Remove restrict interrupt injection from
    SNP_FEATURES_IMPL_REQ

 arch/x86/boot/compressed/sev.c        |   1 -
 arch/x86/entry/entry_64.S             |  84 ++++++
 arch/x86/hyperv/hv_init.c             |  42 +++
 arch/x86/hyperv/ivm.c                 | 181 ++++++++++++
 arch/x86/include/asm/cpu_entry_area.h |   6 +
 arch/x86/include/asm/hyperv-tlfs.h    |   7 +
 arch/x86/include/asm/idtentry.h       | 105 ++++++-
 arch/x86/include/asm/irqflags.h       |  11 +
 arch/x86/include/asm/mem_encrypt.h    |   2 +
 arch/x86/include/asm/mshyperv.h       |  81 ++++-
 arch/x86/include/asm/page_64_types.h  |   1 +
 arch/x86/include/asm/sev.h            |  13 +
 arch/x86/include/asm/svm.h            |  15 +-
 arch/x86/include/asm/trapnr.h         |   1 +
 arch/x86/include/asm/traps.h          |   1 +
 arch/x86/include/asm/x86_init.h       |   2 +
 arch/x86/include/uapi/asm/svm.h       |   4 +
 arch/x86/kernel/cpu/common.c          |   1 +
 arch/x86/kernel/cpu/mshyperv.c        |  42 ++-
 arch/x86/kernel/dumpstack_64.c        |   9 +-
 arch/x86/kernel/idt.c                 |   1 +
 arch/x86/kernel/sev.c                 | 407 ++++++++++++++++++++++----
 arch/x86/kernel/traps.c               |  42 +++
 arch/x86/kernel/vmlinux.lds.S         |   7 +
 arch/x86/kernel/x86_init.c            |   4 +-
 arch/x86/mm/cpu_entry_area.c          |   2 +
 drivers/clocksource/hyperv_timer.c    |   2 +-
 drivers/hv/connection.c               |   1 +
 drivers/hv/hv.c                       |  42 ++-
 drivers/hv/hv_common.c                |  27 +-
 include/asm-generic/hyperv-tlfs.h     |  19 ++
 include/asm-generic/mshyperv.h        |   2 +
 include/linux/hyperv.h                |   4 +-
 33 files changed, 1092 insertions(+), 77 deletions(-)

-- 
2.25.1

