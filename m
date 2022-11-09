Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BCE6234EB
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKIUxY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKIUxX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:53:23 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2F27B37;
        Wed,  9 Nov 2022 12:53:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id io19so18216642plb.8;
        Wed, 09 Nov 2022 12:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ9Dolrn30ZEqCTjBOSWfRyBoKcMQaygSY6Y+KT0Mec=;
        b=NX5S/PpvIB7oLqcAwzdN/Ioz4UByjq90t5Su7sRUT3us5IJbhaw+Znt5IXbXVWh1Z0
         fL5hjn8LoJQwT/Alod0MpVLNjLWtasCGoAZpGi58bNZEu/RJ8kK8nDa9kk5gNcOv1aFR
         CIbP5TgV00ob1KELFcj+4uaHkA+9Ug2qc3ABDxXtYlzlg+Y95CuMLIUbN+hEBj99DeTd
         NUL5D5mCbJ1C2cl6wZJI+5hurMdfzwjakCWlAs0RgRmsf49qUt1eIc3laBhDx1l8OlzK
         litzszx7bMY8wB40GkcbCi/t9lF91XpX49Wx87RXhf8YkEmSf53Wkc/89+DWi6DzETXF
         YA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ9Dolrn30ZEqCTjBOSWfRyBoKcMQaygSY6Y+KT0Mec=;
        b=qYV6Tj6rcQbB9JkEUwNBfjsT0YNoI4IG6HFo8fVVz8kk9vvOvcPnclC/+RQGtxIC0W
         zeLhZAcIiB1sCEhFf80Lnr8ci3TDk3UyGQ8P1owDEkd/Lpm8BUT9Sx9lhKrS2PET16BY
         71HggB6shAk8Od4lwRq451zxzCmWXQo2A1yKv1LPJ3JeyXjnOqUOsB+JmdZEnG/0Lpjv
         yfS7XynVfhCSEpVSOMoM3zsO9vVXRaVLSJSUHKZGdtramfoHGAIT+fUbXZaZXOWnBgTG
         tKZnpWsnEBE4CxAF9bxWtRS4demJr/fvHrmnRJlTOewP90L7sPHnnhndjxWtH7Z+bIN8
         +rfQ==
X-Gm-Message-State: ACrzQf0dtqCS74WAMj1evhpZZapnWFe8GQJ0WGK3kWqHT7jyneYOkQam
        K7X40TKh+zBq7dnT9jvA5DU/VPfWdih7lA==
X-Google-Smtp-Source: AMsMyM4yPvUCtlV3AR1sV5khbTRv3EDOSYNzQcaXkYigDxudTUruWCdW/VPp4VujTZbbU1AvA5ro1w==
X-Received: by 2002:a17:90a:24b:b0:213:9da2:5c98 with SMTP id t11-20020a17090a024b00b002139da25c98mr64206526pje.123.1668027200320;
        Wed, 09 Nov 2022 12:53:20 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:1:c61f:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id y7-20020aa79427000000b0056baca45977sm8659378pfo.21.2022.11.09.12.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:53:19 -0800 (PST)
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
Subject: [RFC PATCH 00/17] x86/hyperv/sev: Add AMD sev-snp enlightened guest support on hyperv
Date:   Wed,  9 Nov 2022 15:52:58 -0500
Message-Id: <20221109205316.984635-1-ltykernel@gmail.com>
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

Tianyu Lan (17):
  x86/boot: Check boot param's cc_blob_address for direct boot mode
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
  x86/sev: Initialize #HV doorbell and handle interrupt requests

 arch/x86/boot/compressed/head_64.S    |   8 +
 arch/x86/boot/compressed/sev.c        | 111 +++++++-
 arch/x86/entry/entry_64.S             |  76 +++++
 arch/x86/hyperv/hv_apic.c             |  79 ++++--
 arch/x86/hyperv/hv_init.c             |  47 ++++
 arch/x86/hyperv/ivm.c                 |  12 +-
 arch/x86/include/asm/cpu_entry_area.h |   6 +
 arch/x86/include/asm/idtentry.h       |  39 ++-
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
 arch/x86/kernel/cpu/mshyperv.c        | 267 +++++++++++++++++-
 arch/x86/kernel/dumpstack_64.c        |   9 +-
 arch/x86/kernel/idt.c                 |   1 +
 arch/x86/kernel/sev.c                 | 384 ++++++++++++++++++++++----
 arch/x86/kernel/traps.c               |  50 ++++
 arch/x86/mm/cpu_entry_area.c          |   2 +
 drivers/clocksource/hyperv_timer.c    |   2 +-
 drivers/hv/connection.c               |  14 +
 drivers/hv/hv.c                       |  32 ++-
 drivers/hv/hv_common.c                |  22 ++
 drivers/hv/ring_buffer.c              |   7 +-
 include/asm-generic/hyperv-tlfs.h     |  19 ++
 include/asm-generic/mshyperv.h        |   2 +
 include/linux/hyperv.h                |   4 +-
 33 files changed, 1250 insertions(+), 114 deletions(-)

-- 
2.25.1

