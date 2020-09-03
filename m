Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9A25BE33
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgICJRn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgICJRk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:17:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E1C061244
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:17:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q13so2794161ejo.9
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybBiP+e417RFA7nMR4Bu7V33eb9o8gA61OetpUfftkQ=;
        b=APLmMrE9eEbfLFqGCI1U6UkzQSGgJVYT4fP69U8vY4IlnhXbOnr9RQuoxMki8HmaZ2
         hKKQGLreepg4yFdemEkt4tTzSK31vCuqaa+W9k2u/u9b4F7KVEas6PBuxUVrrIHd7zV/
         83k8qYFhmmAueuH8UbIKhI4d0y51jhHFNYF7MZibLhrowrX7RKs0qA4jpeEV+fLRSHa3
         LAkXEcSV6ctzyXlOPMd8Fc3wo9JJkJ6bwRk4wjYBhBa2pCVPkGdRYlRATOUWBEXYu1ud
         il6iZjUzLeM46Wwbgu3Qmmqltj3yRYqjHzSmkJyqufbPD/tdNc6KSK7+lqX0f2abBSob
         J2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybBiP+e417RFA7nMR4Bu7V33eb9o8gA61OetpUfftkQ=;
        b=f51T1c18yVpjOymY7HhBt9gEpkZU7rR0dzj11SvztjWRLUtlvTBFV8z8V4APAzSlOO
         oUmsKO4ej5rcAGKvMigKv++bCUpuJGfT0U3epWIOuBIiwYLUCNU02kfWC4NUc8do1Fyc
         VzR0Oz65GLs65VBiGgUrALh8YoHFY89zcqJyKEFvFxOeIzP2JGVtacZv+DNsu17hS3sI
         SUrK9IyUauvpMfgQEMmbB4JhygdwaLVdrF65PIaMu5RDcfMKBc4a2hxV34dAoZDluNcV
         PcC3tLcfPNQyJX9MMVzdaOyXV/5OVz0wQiKSC8R7O28hssp5CtEREKQlNvGERLWrN/ug
         PmQQ==
X-Gm-Message-State: AOAM5332DjUSG8X7+9FU8UhMhRqM6v4ZaCqkqwVnLXMysX9+I6WdDNE+
        5qYDuqIcjtblWQKzQHfZxm37ow==
X-Google-Smtp-Source: ABdhPJys1SWvJYPNpq0WObC+uy+nfuWZtybUHYnPbVexD1i1iV/lX+1rXLt1ldV/IBiG+6LOepfP3w==
X-Received: by 2002:a17:906:a116:: with SMTP id t22mr1160350ejy.353.1599124654241;
        Thu, 03 Sep 2020 02:17:34 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id x10sm2414585eds.21.2020.09.03.02.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:17:33 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 00/10] Independent per-CPU data section for nVHE
Date:   Thu,  3 Sep 2020 11:17:02 +0200
Message-Id: <20200903091712.46456-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce '.hyp.data..percpu' as part of ongoing effort to make nVHE
hyp code self-contained and independent of the rest of the kernel.

The series builds on top of the "Split off nVHE hyp code" series which
used objcopy to rename '.text' to '.hyp.text' and prefix all ELF
symbols with '__kvm_nvhe' for all object files under kvm/hyp/nvhe.

The series is structured as follows:

 - patch 1: Modify generic PERCPU_* linker script macros to make it
     possible to define multiple per-CPU ELF sections with prefixed
     section and symbol names.

 - patch 2: Improve existing hyp build rules. This could be sent and merged
    independently of per-CPU but this series builds on it.

 - patches 3-4: Replace hyp helpers for accessing per-CPU variables
     with common helpers modified to work correctly in hyp. Per-CPU
     variables can now be accessed with one API anywhere.

 - patches 5-7: Where VHE and nVHE use per-CPU variables defined in
     kernel proper, move their definitions to hyp/ where they are
     duplicated and owned by VHE/nVHE, respectively. Non-VHE hyp code
     now refers only to per-CPU variables defined in its source files.
     Helpers are added so that kernel proper can continue to access
     nVHE hyp variables, same way as it does with other nVHE symbols.

 - patches 8-10: Introduce '.hyp.data..percpu' ELF section and allocate
     memory for every CPU core during KVM init. All nVHE per-CPU state
     is now grouped together in ELF and in memory. Introducing a new
     per-CPU variable does not require adding new memory mappings any
     more. nVHE hyp code cannot accidentally refer to kernel-proper
     per-CPU data as it only has the pointer to its own per-CPU memory.

Patches are rebased on v5.9-rc3 and available in branch 'topic/percpu-v2' at:
    https://android-kvm.googlesource.com/linux

Changes v1 -> v2:
  * 5.9-rc3 base
  * partially link hyp code, add linker script

David Brazdil (10):
  Macros to override naming of percpu symbols and sections
  kvm: arm64: Partially link nVHE hyp code, simplify HYPCOPY
  kvm: arm64: Remove __hyp_this_cpu_read
  kvm: arm64: Remove hyp_adr/ldr_this_cpu
  kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
  kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
  kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
  kvm: arm64: Mark hyp stack pages reserved
  kvm: arm64: Set up hyp percpu data for nVHE
  kvm: arm64: Remove unnecessary hyp mappings

 arch/arm64/include/asm/assembler.h        |  27 ++++--
 arch/arm64/include/asm/kvm_asm.h          |  74 ++++++++-------
 arch/arm64/include/asm/kvm_host.h         |   2 +-
 arch/arm64/include/asm/kvm_mmu.h          |  23 ++---
 arch/arm64/include/asm/percpu.h           |  33 ++++++-
 arch/arm64/include/asm/sections.h         |   1 +
 arch/arm64/kernel/image-vars.h            |   2 -
 arch/arm64/kernel/vmlinux.lds.S           |  10 ++
 arch/arm64/kvm/arm.c                      | 110 ++++++++++++++++++----
 arch/arm64/kvm/hyp/hyp-entry.S            |   2 +-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h   |   8 +-
 arch/arm64/kvm/hyp/nvhe/Makefile          |  56 +++++------
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S         |  19 ++++
 arch/arm64/kvm/hyp/nvhe/switch.c          |   8 +-
 arch/arm64/kvm/hyp/vhe/switch.c           |   5 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |   4 +-
 arch/arm64/kvm/pmu.c                      |  13 ++-
 include/asm-generic/vmlinux.lds.h         |  40 +++++---
 19 files changed, 304 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp.lds.S

--
2.28.0.402.g5ffc5be6b7-goog

