Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C1A6F2F6E
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 10:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjEAI5c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAI5b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:57:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322B9F9;
        Mon,  1 May 2023 01:57:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab032d9266so300295ad.0;
        Mon, 01 May 2023 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931449; x=1685523449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bX2mQ4P6ZogNunBq0Lc5T0DlAQR8t1tOegQb5CpOumI=;
        b=Tbxb3dvNOtClsI+atlYHMXQwQZGRLQB4MDw6DardQr7aZHh8IYlpR7uW3Ctus/km/m
         r/Ck9Zbrka10Bv1eXAu5WzssZTt5EVSfpP/L4CHETKejEKk0vZx22vkiuKqo1OZDMqaz
         yQUBjnkzp0oDBpipUGSTJNuRMwvcB6lA7+4DjZUpLyMj5eDrTBLUtCDbK8T7f7OrYBMJ
         TBunugaGdJHXvGtKdOtJBkWi5rsax6pMUldHFBokDngTRi6mY/sDcQ0eDBdnK/OQbZLh
         nOUINUH8lo/sQdj0KpRzquAUkh9B0t+SjKiK38fTN4jc7p+DAuRDsh1QijLlJYFtbAFN
         a85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931449; x=1685523449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX2mQ4P6ZogNunBq0Lc5T0DlAQR8t1tOegQb5CpOumI=;
        b=XDIUSWI6yb0cc+vk00Mswo35UrC2yj+u4C4n1LbosAfcAYa8zCUfjPcsjVJRE+9WwX
         aRYRRjB+6yVhxVXYGtXvZbjojt03ZCe9SMeq4+9qfApFShXLwB2kpFSFZHe3F7Ubx0bT
         1ulGWeon84Hd1r9ksRAB1qhsSw01w3WOiVPz2ggQJaHG6mzwm4Xy0DOGj4IJyLY24aGq
         KSACCX48jReUZZ+gzBQiAql0+fqnMVfYCsddR98Ysph1ge1o88cFG6nbrJ/KXPh10s+Y
         PzUI1yGR0NRy1CJtKeDNuRL0eA2sStboy7l4Q4KK/rI/eSEKa8GUdKSjAU0g4KNQIQy/
         CI7w==
X-Gm-Message-State: AC+VfDxrj/hY6NQrys70Fl8IrE7SIYlBizBaC4x8Hf3JiRtvZ6IG3atp
        TdTxvf64tqQhkaFco8+FAjo=
X-Google-Smtp-Source: ACHHUZ4RnM8+RWya9iFFjs9T5MYFjV7RM9uGsDQBwtL4GIvkNn7jQ/Hc7lmgCFZCVugdzoBb8NSrFA==
X-Received: by 2002:a17:902:ce8a:b0:1a9:87c1:bf61 with SMTP id f10-20020a170902ce8a00b001a987c1bf61mr15704221plg.2.1682931449645;
        Mon, 01 May 2023 01:57:29 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:29 -0700 (PDT)
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
Subject: [RFC PATCH V5 00/15] x86/hyperv/sev: Add AMD sev-snp enlightened guest support on hyperv
Date:   Mon,  1 May 2023 04:57:10 -0400
Message-Id: <20230501085726.544209-1-ltykernel@gmail.com>
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

This patchset is to add AMD sev-snp enlightened guest
support on hyperv. Hyperv uses Linux direct boot mode
to boot up Linux kernel and so it needs to pvalidate
system memory by itself.

In hyperv case, there is no boot loader and so cc blob
is prepared by hypervisor. In this series, hypervisor
set the cc blob address directly into boot parameter
of Linux kernel.

Shared memory between guests and hypervisor should be
decrypted and zero memory after decrypt memory. The data
in the target address. It maybe smearedto avoid smearing
data.

Introduce #HV exception support in AMD sev snp code and
#HV handler.

Change since v4:
       - Use pgcount to free intput arg page.
       - Fix encrypt and free page order.
       - struct_size to calculate array size
       - Share asm code between #HV and #VC exception.

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

Tianyu Lan (13):
  x86/hyperv: Add sev-snp enlightened guest static key
  x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
  x86/hyperv: Set Virtual Trust Level in VMBus init message
  x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
    enlightened guest
  clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp
    enlightened guest
  hv: vmbus: decrypt VMBus pages for sev-snp enlightened guest
  drivers: hv: Decrypt percpu hvcall input arg page in sev-snp
    enlightened guest
  x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
  x86/hyperv: Add smp support for sev-snp guest
  x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
  x86/sev: Add a #HV exception handler
  x86/sev: Add Check of #HV event in path
  x86/sev: Add AMD sev-snp enlightened guest support on hyperv

 arch/x86/entry/entry_64.S             |  46 ++-
 arch/x86/hyperv/hv_init.c             |  42 +++
 arch/x86/hyperv/ivm.c                 | 186 ++++++++++++
 arch/x86/include/asm/cpu_entry_area.h |   6 +
 arch/x86/include/asm/hyperv-tlfs.h    |   7 +
 arch/x86/include/asm/idtentry.h       | 106 ++++++-
 arch/x86/include/asm/irqflags.h       |  14 +-
 arch/x86/include/asm/mem_encrypt.h    |   2 +
 arch/x86/include/asm/mshyperv.h       |  82 +++++-
 arch/x86/include/asm/page_64_types.h  |   1 +
 arch/x86/include/asm/sev.h            |  13 +
 arch/x86/include/asm/svm.h            |  15 +-
 arch/x86/include/asm/trapnr.h         |   1 +
 arch/x86/include/asm/traps.h          |   1 +
 arch/x86/include/uapi/asm/svm.h       |   4 +
 arch/x86/kernel/cpu/common.c          |   1 +
 arch/x86/kernel/cpu/mshyperv.c        |  42 ++-
 arch/x86/kernel/dumpstack_64.c        |   9 +-
 arch/x86/kernel/idt.c                 |   1 +
 arch/x86/kernel/sev.c                 | 408 ++++++++++++++++++++++----
 arch/x86/kernel/traps.c               |  42 +++
 arch/x86/kernel/vmlinux.lds.S         |   7 +
 arch/x86/mm/cpu_entry_area.c          |   2 +
 drivers/clocksource/hyperv_timer.c    |   2 +-
 drivers/hv/connection.c               |   1 +
 drivers/hv/hv.c                       |  41 ++-
 drivers/hv/hv_common.c                |  27 +-
 include/asm-generic/hyperv-tlfs.h     |  19 ++
 include/asm-generic/mshyperv.h        |   1 +
 include/linux/hyperv.h                |   4 +-
 30 files changed, 1047 insertions(+), 86 deletions(-)

-- 
2.25.1

