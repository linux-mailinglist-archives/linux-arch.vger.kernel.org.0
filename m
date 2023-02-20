Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABF769C9BC
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 12:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBTLYc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 06:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBTLYZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 06:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C465AD
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676892214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGvEUYyDyInAU1qTOkUUwH1+5Pn5/FfAg09zLJh1EcU=;
        b=LJ4z/ydlreQO2yAtfBGq5VjJCLgp297eaAHVbIuZOwUBIi2Z0QExyTv6nd/ARNoqMqdjn1
        /zMysMRY0+wYzE6vrOvE/OCyAU5zz2zZy4+k6HBeuFrxSJpfHYMdYB4k5d6NnCqUnBPAwg
        e5+N+BoK+DPErZpuJFnQdtZCGVRIc3E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-213-pV7dovHFN4e2hOF9iER7jg-1; Mon, 20 Feb 2023 06:23:33 -0500
X-MC-Unique: pV7dovHFN4e2hOF9iER7jg-1
Received: by mail-wm1-f71.google.com with SMTP id c65-20020a1c3544000000b003e21fa6f404so689596wma.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 03:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGvEUYyDyInAU1qTOkUUwH1+5Pn5/FfAg09zLJh1EcU=;
        b=oztvzAEBm5/99moO6vFvD3zUs7nsObv94iXrdp6+5pB96cmhmVg+3QmUW+v8ybrc8a
         SPFC6eB4ptk5/fs2OgQTCOONp0PFxIMnn+wfzjA19UasbYEEG6ELZfkRdpVTcLhTbXj2
         Njid5j/4KzIh5PyFyVLlvkhOqP9Gc07CKlT+8Y5Yai7VNAWZwh4pGm/IGNmCDvG6XNXZ
         2pmxYo1HoXIJFt/1LSPbfXDvRpWlhnfJEv+Yy9731EPip24i091m/E1czuEb5T8a2fDp
         wn2r9+kf04MROkRhYsKOo1YTNR2aLnrE4dDWNmjlt1U5oiaqWeaoul92L0wtZcd5USOJ
         1csA==
X-Gm-Message-State: AO0yUKUn/ma8BCu0MgeaD2ktsqlkEAjLYkZM+e/ANG6uWDElDQkyQ9eP
        nO/MHa+M9ulnSo83dR8OAffTV2CD9XI4yevg7Y0I+/OPDUjgK7AVS1UXgOrIyGDYfstmsGd2yOR
        NKqClFJgM7Nr5C9PUaLQ7YQ==
X-Received: by 2002:adf:e889:0:b0:2bf:ae19:d8e4 with SMTP id d9-20020adfe889000000b002bfae19d8e4mr1431227wrm.16.1676892211952;
        Mon, 20 Feb 2023 03:23:31 -0800 (PST)
X-Google-Smtp-Source: AK7set8MwtYqrZBvXsoQ9yPZN/bwu32QfvZtBFBM6ley7E2vAkMmUmM+SZmaWRHMAwPacrP/Dgjyyg==
X-Received: by 2002:adf:e889:0:b0:2bf:ae19:d8e4 with SMTP id d9-20020adfe889000000b002bfae19d8e4mr1431211wrm.16.1676892211619;
        Mon, 20 Feb 2023 03:23:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b002c55ec7f661sm154441wrr.5.2023.02.20.03.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:23:30 -0800 (PST)
Message-ID: <f50daeb7-7b41-0bed-73f0-b6358169521b@redhat.com>
Date:   Mon, 20 Feb 2023 12:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-14-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-14-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One of these unusual properties is that shadow stack memory is writable,
> but only in limited ways. These limits are applied via a specific PTE
> bit combination. Nevertheless, the memory is writable, and core mm code
> will need to apply the writable permissions in the typical paths that
> call pte_mkwrite().
> 
> In addition to VM_WRITE, the shadow stack VMA's will have a flag denoting
> that they are special shadow stack flavor of writable memory. So make
> pte_mkwrite() take a VMA, so that the x86 implementation of it can know to
> create regular writable memory or shadow stack memory.
> 
> Apply the same changes for pmd_mkwrite() and huge_pte_mkwrite().
> 
> No functional change.
> 
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> Hi Non-x86 Arch’s,
> 
> x86 has a feature that allows for the creation of a special type of
> writable memory (shadow stack) that is only writable in limited specific
> ways. Previously, changes were proposed to core MM code to teach it to
> decide when to create normally writable memory or the special shadow stack
> writable memory, but David Hildenbrand suggested[0] to change
> pXX_mkwrite() to take a VMA, so awareness of shadow stack memory can be
> moved into x86 code.
> 
> Since pXX_mkwrite() is defined in every arch, it requires some tree-wide
> changes. So that is why you are seeing some patches out of a big x86
> series pop up in your arch mailing list. There is no functional change.
> After this refactor, the shadow stack series goes on to use the arch
> helpers to push shadow stack memory details inside arch/x86.
> 
> Testing was just 0-day build testing.
> 
> Hopefully that is enough context. Thanks!
> 
> [0] https://lore.kernel.org/lkml/0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com/#t
> 
> v6:
>   - New patch
> ---
>   Documentation/mm/arch_pgtable_helpers.rst    |  9 ++++++---
>   arch/alpha/include/asm/pgtable.h             |  6 +++++-
>   arch/arc/include/asm/hugepage.h              |  2 +-
>   arch/arc/include/asm/pgtable-bits-arcv2.h    |  7 ++++++-
>   arch/arm/include/asm/pgtable-3level.h        |  7 ++++++-
>   arch/arm/include/asm/pgtable.h               |  2 +-
>   arch/arm64/include/asm/pgtable.h             |  4 ++--
>   arch/csky/include/asm/pgtable.h              |  2 +-
>   arch/hexagon/include/asm/pgtable.h           |  2 +-
>   arch/ia64/include/asm/pgtable.h              |  2 +-
>   arch/loongarch/include/asm/pgtable.h         |  4 ++--
>   arch/m68k/include/asm/mcf_pgtable.h          |  2 +-
>   arch/m68k/include/asm/motorola_pgtable.h     |  6 +++++-
>   arch/m68k/include/asm/sun3_pgtable.h         |  6 +++++-
>   arch/microblaze/include/asm/pgtable.h        |  2 +-
>   arch/mips/include/asm/pgtable.h              |  6 +++---
>   arch/nios2/include/asm/pgtable.h             |  2 +-
>   arch/openrisc/include/asm/pgtable.h          |  2 +-
>   arch/parisc/include/asm/pgtable.h            |  6 +++++-
>   arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
>   arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++--
>   arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
>   arch/powerpc/include/asm/nohash/32/pte-8xx.h |  2 +-
>   arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
>   arch/riscv/include/asm/pgtable.h             |  6 +++---
>   arch/s390/include/asm/hugetlb.h              |  4 ++--
>   arch/s390/include/asm/pgtable.h              |  4 ++--
>   arch/sh/include/asm/pgtable_32.h             | 10 ++++++++--
>   arch/sparc/include/asm/pgtable_32.h          |  2 +-
>   arch/sparc/include/asm/pgtable_64.h          |  6 +++---
>   arch/um/include/asm/pgtable.h                |  2 +-
>   arch/x86/include/asm/pgtable.h               |  6 ++++--
>   arch/xtensa/include/asm/pgtable.h            |  2 +-
>   include/asm-generic/hugetlb.h                |  4 ++--
>   include/linux/mm.h                           |  2 +-
>   mm/debug_vm_pgtable.c                        | 16 ++++++++--------
>   mm/huge_memory.c                             |  6 +++---
>   mm/hugetlb.c                                 |  4 ++--
>   mm/memory.c                                  |  4 ++--
>   mm/migrate_device.c                          |  2 +-
>   mm/mprotect.c                                |  2 +-
>   mm/userfaultfd.c                             |  2 +-
>   42 files changed, 106 insertions(+), 69 deletions(-)

That looks painful but IMHO worth it :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

