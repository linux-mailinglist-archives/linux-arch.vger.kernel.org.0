Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D42219FCA
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 14:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGIMOg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 08:14:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34573 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726327AbgGIMOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 08:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594296874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwRIPXQdD58+F7cV0LER43YEzOAqv3hHNiA5thj41Io=;
        b=T+nG7teysCQg9Wgr5b8XmzUEiYcCai/DdYNiuEWUrAuset/I638gBJLBFxoLDnOWtgDTf7
        +DnxG87twGbH6fsfLMIa9TnTkWoJdVATePkGGYliHaTqrFDzvyi0JN0bGv+v0HvDQ6XK6S
        2mDyQfmsrCJ8zVtmqiOR6iyfm6S0/to=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-DQ0mAbIkNLKUmIjbuqXKJw-1; Thu, 09 Jul 2020 08:14:32 -0400
X-MC-Unique: DQ0mAbIkNLKUmIjbuqXKJw-1
Received: by mail-wr1-f71.google.com with SMTP id w4so1764350wrm.5
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 05:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kwRIPXQdD58+F7cV0LER43YEzOAqv3hHNiA5thj41Io=;
        b=oUmW0swZR4Qbg8ct2BPztKc+WMADQn3/sS6n7GjU0dklXySSaOLlt2Fc8jq60UUJ8N
         8fGl2elngR3IfIoccL0533va605IZmyfjY3J/Vd+AQI+zfkJK3iWBHy69x1MmG7FSG2O
         Cv8T6uz8EQAl8s/NYZDcmiFfDjy3mFo36ITNf8D55IbgCDFQ/uXPVphxJ4BamNvLjQFh
         WMx1h73lCGoiNYIxoWfgweEU6eeg8p9WJdb/bp/NlNErVwaRdqBGHpRjisoeojmZEYnL
         aNTuoKErPz80N2TbOEbcsM07fy7cjGKHgwUBu2nfgupjaVZWen13RBsgD0QsQc/NElwp
         W5Eg==
X-Gm-Message-State: AOAM530B8UzEPss7ntHlSwsqysSMvPdIQcHGf/GYn6F7KxH6sJr0VJLh
        N9fK4bhZm3oWuinEAIiJvK9fNPpwJHDvWFDLBdf3Xxxa3WNlI/yoqjHpsVZFL81WGgtURQ0FTSv
        uX0TfwWszbFbyXrzE+pCS2A==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr13361794wml.36.1594296871531;
        Thu, 09 Jul 2020 05:14:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRhPo7g5kUipBnsOFe+3r9VY5ESGX0vtcsJ/9+mosHc1rT3gI7GlSh2CG+AM/UAt8pI6ZlHQ==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr13361761wml.36.1594296871306;
        Thu, 09 Jul 2020 05:14:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id c206sm4897543wmf.36.2020.07.09.05.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 05:14:30 -0700 (PDT)
Subject: Re: [PATCH v3 00/21] KVM: Cleanup and unify kvm_mmu_memory_cache
 usage
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Christoffer Dall <christoffer.dall@arm.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9cce79d8-bc8a-8a3a-060a-c9a882dd7e07@redhat.com>
Date:   Thu, 9 Jul 2020 14:14:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/07/20 04:35, Sean Christopherson wrote:
> The only interesting delta from v2 is that patch 18 is updated to handle
> a conflict with arm64's p4d rework.  Resolution was straightforward
> (famous last words).
> 
> 
> This series resurrects Christoffer Dall's series[1] to provide a common
> MMU memory cache implementation that can be shared by x86, arm64 and MIPS.
> 
> It also picks up a suggested change from Ben Gardon[2] to clear shadow
> page tables during initial allocation so as to avoid clearing entire
> pages while holding mmu_lock.
> 
> The front half of the patches do house cleaning on x86's memory cache
> implementation in preparation for moving it to common code, along with a
> fair bit of cleanup on the usage.  The middle chunk moves the patches to
> common KVM, and the last two chunks convert arm64 and MIPS to the common
> implementation.
> 
> Fully tested on x86 only.  Compile tested patches 14-21 on arm64, MIPS,
> s390 and PowerPC.

Queued, thanks.

Paolo

> v3:
>   - Rebased to kvm/queue, commit a037ff353ba6 ("Merge ... into HEAD")
>   - Collect more review tags. [Ben]
> 
> v2:
>   - Rebase to kvm-5.8-2, commit 49b3deaad345 ("Merge tag ...").
>   - Use an asm-generic kvm_types.h for s390 and PowerPC instead of an
>     empty arch-specific file. [Marc]
>   - Explicit document "GFP_PGTABLE_USER == GFP_KERNEL_ACCOUNT | GFP_ZERO"
>     in the arm64 conversion patch. [Marc]
>   - Collect review tags. [Ben]
> 
> Sean Christopherson (21):
>   KVM: x86/mmu: Track the associated kmem_cache in the MMU caches
>   KVM: x86/mmu: Consolidate "page" variant of memory cache helpers
>   KVM: x86/mmu: Use consistent "mc" name for kvm_mmu_memory_cache locals
>   KVM: x86/mmu: Remove superfluous gotos from mmu_topup_memory_caches()
>   KVM: x86/mmu: Try to avoid crashing KVM if a MMU memory cache is empty
>   KVM: x86/mmu: Move fast_page_fault() call above
>     mmu_topup_memory_caches()
>   KVM: x86/mmu: Topup memory caches after walking GVA->GPA
>   KVM: x86/mmu: Clean up the gorilla math in mmu_topup_memory_caches()
>   KVM: x86/mmu: Separate the memory caches for shadow pages and gfn
>     arrays
>   KVM: x86/mmu: Make __GFP_ZERO a property of the memory cache
>   KVM: x86/mmu: Zero allocate shadow pages (outside of mmu_lock)
>   KVM: x86/mmu: Skip filling the gfn cache for guaranteed direct MMU
>     topups
>   KVM: x86/mmu: Prepend "kvm_" to memory cache helpers that will be
>     global
>   KVM: Move x86's version of struct kvm_mmu_memory_cache to common code
>   KVM: Move x86's MMU memory cache helpers to common KVM code
>   KVM: arm64: Drop @max param from mmu_topup_memory_cache()
>   KVM: arm64: Use common code's approach for __GFP_ZERO with memory
>     caches
>   KVM: arm64: Use common KVM implementation of MMU memory caches
>   KVM: MIPS: Drop @max param from mmu_topup_memory_cache()
>   KVM: MIPS: Account pages used for GPA page tables
>   KVM: MIPS: Use common KVM implementation of MMU memory caches
> 
>  arch/arm64/include/asm/kvm_host.h  |  11 ---
>  arch/arm64/include/asm/kvm_types.h |   8 ++
>  arch/arm64/kvm/arm.c               |   2 +
>  arch/arm64/kvm/mmu.c               |  56 +++----------
>  arch/mips/include/asm/kvm_host.h   |  11 ---
>  arch/mips/include/asm/kvm_types.h  |   7 ++
>  arch/mips/kvm/mmu.c                |  44 ++--------
>  arch/powerpc/include/asm/Kbuild    |   1 +
>  arch/s390/include/asm/Kbuild       |   1 +
>  arch/x86/include/asm/kvm_host.h    |  14 +---
>  arch/x86/include/asm/kvm_types.h   |   7 ++
>  arch/x86/kvm/mmu/mmu.c             | 129 +++++++++--------------------
>  arch/x86/kvm/mmu/paging_tmpl.h     |  10 +--
>  include/asm-generic/kvm_types.h    |   5 ++
>  include/linux/kvm_host.h           |   7 ++
>  include/linux/kvm_types.h          |  19 +++++
>  virt/kvm/kvm_main.c                |  55 ++++++++++++
>  17 files changed, 176 insertions(+), 211 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kvm_types.h
>  create mode 100644 arch/mips/include/asm/kvm_types.h
>  create mode 100644 arch/x86/include/asm/kvm_types.h
>  create mode 100644 include/asm-generic/kvm_types.h
> 

