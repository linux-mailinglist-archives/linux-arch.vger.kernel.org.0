Return-Path: <linux-arch+bounces-4765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95890168A
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75742812DF
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021AB4436C;
	Sun,  9 Jun 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ivzuu+cK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276C6AC0;
	Sun,  9 Jun 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948229; cv=none; b=XMyT5ZabNjocFwgXWfNxoOCXBOrOpL/e8qKeqHSVRzDMn9WWdnGEmLTVteyKz/3xXbRc375u50ESQ/zLlUzXfvRvoomEZ7noq6ICZdAAIraQ/xPAUlZBpbuR0U37K3fszGYnsawXSiRcXgOMLmCFIj6Izdd3U4GigZO39XQ4AI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948229; c=relaxed/simple;
	bh=ughDwphXf3dYe4EijagZi0zfWLW6TKptPdAqN0DgPKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZE5NQYzGdg8Pm4ylnR7jkMm36mL4+9Hcx11a1H0gkGjZ6e/kCNpMHC8VVPTetsnOuBYCyCRgfcIQc6+zQj6YaAOqcFW+bGyN2g1n+pDxweYpugAhdxMLI3CTByJzeP0pQdIN/VbREngx3Vz6HEe529sr/c6+TzOBFbnZ5mAMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ivzuu+cK; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948228; x=1749484228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z8JQDhiIHyghD/mh78yFhS3Rp61K/3MKFSXJkIVLIho=;
  b=Ivzuu+cKyEsM1Qe7GZ2P9vNzi5PZ0JdTFtuYISPs3Y5/ir5XE8mROleP
   YUiL8XhFW0u85nMRQdCFVf3zAXc3HT0bruMLCTejNQ0pKambXWjybD+8J
   gx6t4KxXCDV/kv/Fo4exu0iq/UDt2CfF7QD4/MjHDKrt1u3yp/co0ghHq
   E=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="300979316"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:50:25 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:59941]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.236:2525] with esmtp (Farcaster)
 id 37964eda-c515-4ff2-b20a-3dd4b8262df1; Sun, 9 Jun 2024 15:50:23 +0000 (UTC)
X-Farcaster-Flow-ID: 37964eda-c515-4ff2-b20a-3dd4b8262df1
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:50:23 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:50:17 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<graf@amazon.de>, <dwmw2@infradead.org>, <paul@amazon.com>,
	<nsaenz@amazon.com>, <mlevitsk@redhat.com>, <jgowans@amazon.com>,
	<corbet@lwn.net>, <decui@microsoft.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <amoorthy@google.com>
Subject: [PATCH 00/18] Introducing Core Building Blocks for Hyper-V VSM Emulation
Date: Sun, 9 Jun 2024 15:49:27 +0000
Message-ID: <20240609154945.55332-1-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

This series introduces core KVM functionality necessary to emulate Hyper-V's
Virtual Secure Mode in a Virtual Machine Monitor (VMM).

Hyper-V's Virtual Secure Mode (VSM) is a virtualization security feature that
leverages the hypervisor to create secure execution environments within a
guest. VSM is documented as part of Microsoft's Hypervisor Top Level Functional
Specification [1]. Security features that build upon VSM, like Windows
Credential Guard, are enabled by default on Windows 11 and are becoming a
prerequisite in some industries.

VSM introduces the concept of Virtual Trust Levels (VTLs). These are
independent execution contexts, each with its own CPU architectural state,
local APIC state, and a different view of memory. They are hierarchical, with
more privileged VTLs having priority over the execution of lower VTLs and
control over lower VTLs' state. Windows leverages these low-level
paravirtualized primitives, as well as the hypervisor's higher trust base, to
prevent guest data exfiltration even when the operating system itself has been
compromised.

As discussed at LPC2023 and in our previous RFC [2], we decided to model each
VTL as a distinct KVM VM. With this approach, and the RWX memory attributes
introduced in this series, we have been able to implement VTL memory
protections in a non-intrusive way, using generic KVM APIs. Additionally, each
CPU's VTL is modeled as a distinct KVM vCPU, owned by the KVM VM tracking that
VTL's state. VTL awareness is fully removed from KVM, and the responsibility
for VTL-aware hypercalls, VTL scheduling, and state transfer is delegated to
userspace.

Series overview:
- 1-8: Introduce a number of Hyper-V hyper-calls, all of which are VTL-aware and
       expected to be handled in userspace. Additionally an new VTL-specifc MP
       state is introduced.
- 9-10: Pass the instruction length as part of the userspace fault exit data
        in order to simplify VSM's secure intercept generation.
- 11-17: Introduce RWX memory attributes as well as extend userspace faults.
- 18: Introduces the main VSM CPUID bit which gates all VTL configuration and
      runtime hypercalls.

The series is accompanied by two repositories:
 - A PoC QEMU implementation of VSM [3]: This PoC VSM implementation is capable
   of booting Windows Server 2016 and 2019 with Credential Guard (CG) enabled
   on VMs of any size or vCPUs number. It's generally stable, but still sees
   its share of crashes. The PoC itself implements VSM interfaces to
   accommodate CG's needs, and it's by no means comprehensive. All in all,
   don't expect anything usable in production.

 - VSM kvm-unit-tests [4]: They cover all VSM hypercalls, as well as KVM APIs
   introduced by this series. But unfortunately depends on the QEMU
   implementation.

We mostly tested on an Intel machine, both with and without TDP. Basic tests
were also run on AMD (build and kvm-unit-tests). Please note that v2 will
include KVM self-tests to close the testing gap, and allow merging this while
we work on the userspace bits.

The series is based on 'kvm/master', that is, commit db574f2f96d0, and also
available in github [5].

This series also serves as a call-out to anyone interested in collaborating. We
have a proven design, a working PoC, and hopefully a path forward to merge
these KVM APIs. There is plenty to do in both QEMU and KVM still, I'll post a
list of ideas in the future. Feel free to get in touch!

Thanks,
Nicolas

[1] https://raw.githubusercontent.com/Microsoft/Virtualization-Documentation/master/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf
[2] https://lore.kernel.org/lkml/20231108111806.92604-1-nsaenz@amazon.com/
[3] https://github.com/vianpl/qemu/tree/vsm-v1
[4] https://github.com/vianpl/kvm-unit-tests/tree/vsm-v1
[4] https://github.com/vianpl/linux/tree/vsm-v1

---

Anish Moorthy (1):
  KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to
    userspace

Nicolas Saenz Julienne (17):
  KVM: x86: hyper-v: Introduce XMM output support
  KVM: x86: hyper-v: Introduce helpers to check if VSM is exposed to
    guest
  hyperv-tlfs: Update struct hv_send_ipi{_ex}'s declarations
  KVM: x86: hyper-v: Introduce VTL awareness to Hyper-V's PV-IPIs
  KVM: x86: hyper-v: Introduce MP_STATE_HV_INACTIVE_VTL
  KVM: x86: hyper-v: Exit on Get/SetVpRegisters hcall
  KVM: x86: hyper-v: Exit on TranslateVirtualAddress hcall
  KVM: x86: hyper-v: Exit on StartVirtualProcessor and
    GetVpIndexFromApicId hcalls
  KVM: x86: Keep track of instruction length during faults
  KVM: x86: Pass the instruction length on memory fault user-space exits
  KVM: x86/mmu: Introduce infrastructure to handle non-executable
    mappings
  KVM: x86/mmu: Avoid warning when installing non-private memory
    attributes
  KVM: x86/mmu: Init memslot if memory attributes available
  KVM: Introduce RWX memory attributes
  KVM: x86: Take mem attributes into account when faulting memory
  KVM: Introduce traces to track memory attributes modification.
  KVM: x86: hyper-v: Handle VSM hcalls in user-space

 Documentation/virt/kvm/api.rst     | 107 +++++++++++++++++++++++-
 arch/x86/hyperv/hv_apic.c          |   3 +-
 arch/x86/include/asm/hyperv-tlfs.h |   2 +-
 arch/x86/kvm/Kconfig               |   1 +
 arch/x86/kvm/hyperv.c              | 127 +++++++++++++++++++++++++++--
 arch/x86/kvm/hyperv.h              |  18 ++++
 arch/x86/kvm/mmu/mmu.c             |  91 +++++++++++++++++----
 arch/x86/kvm/mmu/mmu_internal.h    |   9 +-
 arch/x86/kvm/mmu/mmutrace.h        |  29 +++++++
 arch/x86/kvm/mmu/paging_tmpl.h     |   2 +-
 arch/x86/kvm/mmu/tdp_mmu.c         |   8 +-
 arch/x86/kvm/svm/svm.c             |   7 +-
 arch/x86/kvm/vmx/vmx.c             |  23 +++++-
 arch/x86/kvm/x86.c                 |  17 +++-
 include/asm-generic/hyperv-tlfs.h  |  16 +++-
 include/linux/kvm_host.h           |  45 +++++++++-
 include/trace/events/kvm.h         |  20 +++++
 include/uapi/linux/kvm.h           |  15 ++++
 virt/kvm/kvm_main.c                |  35 +++++++-
 19 files changed, 527 insertions(+), 48 deletions(-)

-- 
2.40.1


