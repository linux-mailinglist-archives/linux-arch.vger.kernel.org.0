Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A51D4068D3
	for <lists+linux-arch@lfdr.de>; Fri, 10 Sep 2021 11:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhIJJHp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 10 Sep 2021 05:07:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3758 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhIJJHp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Sep 2021 05:07:45 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H5VLX22N2z67hcS;
        Fri, 10 Sep 2021 17:04:36 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 10 Sep 2021 11:06:32 +0200
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 10:06:32 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Fri, 10 Sep 2021 10:06:31 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     "kernel-team@android.com" <kernel-team@android.com>,
        Marc Zyngier <maz@kernel.org>,
        Jade Alglave <jade.alglave@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 0/4] Fix racing TLBI with ASID/VMID reallocation
Thread-Topic: [PATCH 0/4] Fix racing TLBI with ASID/VMID reallocation
Thread-Index: AQHXiraYscBrfnIwF0OIF7R8segGVaudIb7g
Date:   Fri, 10 Sep 2021 09:06:31 +0000
Message-ID: <753ff5ea79d54db0af83d195adcfa2b1@huawei.com>
References: <20210806113109.2475-1-will@kernel.org>
In-Reply-To: <20210806113109.2475-1-will@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.92.65]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will@kernel.org]
> Sent: 06 August 2021 12:31
> To: linux-arm-kernel@lists.infradead.org
> Cc: kernel-team@android.com; Will Deacon <will@kernel.org>; Catalin
> Marinas <catalin.marinas@arm.com>; Marc Zyngier <maz@kernel.org>; Jade
> Alglave <jade.alglave@arm.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; kvmarm@lists.cs.columbia.edu;
> linux-arch@vger.kernel.org
> Subject: [PATCH 0/4] Fix racing TLBI with ASID/VMID reallocation
> 
> Hi all,
> 
> While reviewing Shameer's reworked VMID allocator [1] and discussing
> with Marc, we spotted a race between TLB invalidation (which typically
> takes an ASID or VMID argument) and reallocation of ASID/VMID for the
> context being targetted.
> 
> The first patch spells out an example with try_to_unmap_one() in a
> comment, which Catalin has kindly modelled in TLA+ at [2].
> 
> Although I'm posting all this together for ease of review, the intention
> is that the first patch will go via arm64 with the latter going via kvm.
> 
> Cheers,
> 
> Will
> 
> [1]
> https://lore.kernel.org/r/20210729104009.382-1-shameerali.kolothum.thodi
> @huawei.com
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/commi
> t/

Hi Catalin,

I am going through the ASID TLA+ model and in the above commit, it appears that the
different ASID check(=> ActiveAsid(c1) # ActiveAsid(c2)) for the Invariant
UniqueASIDActiveTask is now removed.

Just wondering why that is not relevant anymore?

Thanks,
Shameer

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jade Alglave <jade.alglave@arm.com>
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Cc: <kvmarm@lists.cs.columbia.edu>
> Cc: <linux-arch@vger.kernel.org>
> 
> --->8
> 
> Marc Zyngier (3):
>   KVM: arm64: Move kern_hyp_va() usage in __load_guest_stage2() into the
>     callers
>   KVM: arm64: Convert the host S2 over to __load_guest_stage2()
>   KVM: arm64: Upgrade VMID accesses to {READ,WRITE}_ONCE
> 
> Will Deacon (1):
>   arm64: mm: Fix TLBI vs ASID rollover
> 
>  arch/arm64/include/asm/kvm_mmu.h              | 17 ++++++-----
>  arch/arm64/include/asm/mmu.h                  | 29
> ++++++++++++++++---
>  arch/arm64/include/asm/tlbflush.h             | 11 +++----
>  arch/arm64/kvm/arm.c                          |  2 +-
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  6 ++--
>  arch/arm64/kvm/hyp/nvhe/switch.c              |  4 ++-
>  arch/arm64/kvm/hyp/nvhe/tlb.c                 |  2 +-
>  arch/arm64/kvm/hyp/vhe/switch.c               |  2 +-
>  arch/arm64/kvm/hyp/vhe/tlb.c                  |  2 +-
>  arch/arm64/kvm/mmu.c                          |  2 +-
>  11 files changed, 52 insertions(+), 27 deletions(-)
> 
> --
> 2.32.0.605.g8dce9f2422-goog

