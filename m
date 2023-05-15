Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A92703578
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbjEOQ70 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 12:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbjEOQ7Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D4011D;
        Mon, 15 May 2023 09:59:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24e3b69bc99so9329453a91.2;
        Mon, 15 May 2023 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169963; x=1686761963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NetrHyA9aTHO12kOXVHLfNdXD6bWd3/ADT376MZNP08=;
        b=OFTGusHZcWI0b5Nox3GEcaSms7z5HXj1c32YcVrP8W7Cpw11qfHLFGa6f258DZsRh4
         lnRvCqmrxxh/gIPFJalueEnjo6EmGnKzFmo10U2KQTliG16cxFcwbgKpqjfEyVVWrlDc
         IdFsRSqkpnkmlzBLrjXDcEYDXoBSI5F/FpmWq9m+RLGAEtLh//YHIskn9CQ48bS2r2jr
         phoA9vE1h7sEdOT67hAAxaVBb2dVwpdSlfWdE31WeCH3rfW6A9GK2akb7AyWNO++fIOJ
         BFliahWY160AvwnpY1sdDJY/VjTnNZrDocm46FhWr+BgN6yajmFlX1qEra490r23b45B
         R5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169963; x=1686761963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NetrHyA9aTHO12kOXVHLfNdXD6bWd3/ADT376MZNP08=;
        b=NtByOEY2/TTSfuufHJb4fNsNbobZYDTgFLj6JSue/q/BIXjwtX6QNUN1AQaSPmwmsH
         rBodNhPoWl3wO2Elne24bkoB6dICFzvIXX6iGXdwHXQK1EBkJNXIJJEdO8Ylx4BUnevx
         8c8QGDuwSnszlA8zOAA1wFPbGtV3YOMN9uz1mu7XlQ+UL+rsibnOlO6Lqv2faIEo92KE
         N2MC1XHuV1NO5cqr6XKC06C4mUq2HfmYyxeZcuLGt/awzGtolvAgdqOPoqztrc41cEhJ
         6KZlckAEG8J+jYGCrP1zr2udoO5ng9xaiFuXCbevtgpiE6s+8f+i+nCgwuIKbTPoBz5s
         ppbQ==
X-Gm-Message-State: AC+VfDwru3AvQtQGsF9S4FVyYZp40+xri445gNNpmm1hIY0PgqXNbNp1
        sas+xrMvfl9DSadAn7beq40=
X-Google-Smtp-Source: ACHHUZ4/nFDj2h5aDZ4chISqddNF7Jwhg02FYofjW39s2dw652S5ij45Gr2UVyCYuSkhClqV9p4Wpg==
X-Received: by 2002:a17:90a:e00f:b0:247:19ac:9670 with SMTP id u15-20020a17090ae00f00b0024719ac9670mr33641804pjy.26.1684169962891;
        Mon, 15 May 2023 09:59:22 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:22 -0700 (PDT)
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
Subject: [RFC PATCH V6 00/14] x86/hyperv/sev: Add AMD sev-snp enlightened guest support on hyperv
Date:   Mon, 15 May 2023 12:59:02 -0400
Message-Id: <20230515165917.1306922-1-ltykernel@gmail.com>
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

Change since v6:
       - Merge Ashish Kalr patch https://github.com/
       ashkalra/linux/commit/6975484094b7cb8d703c45066780dd85043cd040
       - Merge patch "x86/sev: Fix interrupt exit code paths from
        #HV exception" with patch "x86/sev: Add AMD sev-snp enlightened guest
	 support on hyperv".
       - Fix getting processor num in the hv_snp_get_smp_config() when ealry is false.

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

Ashish Kalra (1):
  x86/sev: optimize system vector processing invoked from #HV exception

Tianyu Lan (13):
  x86/sev: Add a #HV exception handler
  x86/sev: Add Check of #HV event in path
  x86/sev: Add AMD sev-snp enlightened guest support on hyperv
  x86/hyperv: Add sev-snp enlightened guest static key
  x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP
    enlightened guest
  x86/hyperv: Set Virtual Trust Level in VMBus init message
  x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
    enlightened guest
  clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp
    enlightened guest
  hv: vmbus: Mask VMBus pages unencrypted for sev-snp enlightened guest
  drivers: hv: Decrypt percpu hvcall input arg page in sev-snp
    enlightened guest
  x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
  x86/hyperv: Add smp support for sev-snp guest
  x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES

 arch/x86/entry/entry_64.S             |  46 ++-
 arch/x86/hyperv/hv_init.c             |  42 +++
 arch/x86/hyperv/ivm.c                 | 196 +++++++++++++
 arch/x86/include/asm/cpu_entry_area.h |   6 +
 arch/x86/include/asm/hyperv-tlfs.h    |   7 +
 arch/x86/include/asm/idtentry.h       |  52 +++-
 arch/x86/include/asm/irqflags.h       |  14 +-
 arch/x86/include/asm/mem_encrypt.h    |   2 +
 arch/x86/include/asm/mshyperv.h       |  74 ++++-
 arch/x86/include/asm/page_64_types.h  |   1 +
 arch/x86/include/asm/trapnr.h         |   1 +
 arch/x86/include/asm/traps.h          |   1 +
 arch/x86/include/uapi/asm/svm.h       |   4 +
 arch/x86/kernel/cpu/common.c          |   1 +
 arch/x86/kernel/cpu/mshyperv.c        |  42 ++-
 arch/x86/kernel/dumpstack_64.c        |   9 +-
 arch/x86/kernel/idt.c                 |   1 +
 arch/x86/kernel/sev.c                 | 404 +++++++++++++++++++++++---
 arch/x86/kernel/traps.c               |  60 ++++
 arch/x86/kernel/vmlinux.lds.S         |   7 +
 arch/x86/mm/cpu_entry_area.c          |   2 +
 drivers/clocksource/hyperv_timer.c    |   2 +-
 drivers/hv/connection.c               |   1 +
 drivers/hv/hv.c                       |  37 ++-
 drivers/hv/hv_common.c                |  27 +-
 include/asm-generic/hyperv-tlfs.h     |   3 +-
 include/asm-generic/mshyperv.h        |   1 +
 include/linux/hyperv.h                |   4 +-
 28 files changed, 960 insertions(+), 87 deletions(-)

-- 
2.25.1

