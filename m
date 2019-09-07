Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00712AC66C
	for <lists+linux-arch@lfdr.de>; Sat,  7 Sep 2019 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbfIGLf6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Sep 2019 07:35:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34237 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfIGLf5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Sep 2019 07:35:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id a13so10454576qtj.1
        for <linux-arch@vger.kernel.org>; Sat, 07 Sep 2019 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZfMCqtRG3776EYn97WT0OsP3uu6yPWIiXZtP2HYxXjQ=;
        b=SYqjFOmb1lorXoSExxnMnW2j/lfll6fQ4bkI8ipQTc6lg65BdeoAudUEhWZoQ7J3ji
         nRHofsMHtX4i65qp8p8NR0kj2p4KH590SM8hLFWBFYCv3wYs1W/TjOpqGODP3bUSZNLJ
         ifvznN3u5tbI+zfMhhwz1fZQIW0cCI8W6CNVn0obW+aWt4Xkzesj/WDfhLJvVMoRVtAd
         gTMvwGq4QmG7j+8rLHjXhGIKUXZK+9exAxb5rc52K3nD2J0kki6miNzlHRv48KkYs1+V
         8XG+6UG7a7riG/U1WTFQHilUrnEHrQfwlZkCNAAI0GvfHthev4ml7SEIBLARfC6cmfqa
         m6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZfMCqtRG3776EYn97WT0OsP3uu6yPWIiXZtP2HYxXjQ=;
        b=IjpTWD1hIXMIFc/P2bekvdZGIeFBdqDhrA8qZaZJyceMkrWnIKIkqFtMQj9RYKMDMw
         oqOQeCQuc1CMwGaNDtRhvYZkrRBouGAmwbujubTyrEJsiwlq3jUZJ9b73IA1BkMe6mES
         80qu94sMtqmLihCZlhmhdPqthToig9S+dfdJmSaAfpoKj4Og+YhrbRpnN7CxuUBWR2ZW
         n69aFWjvGVVtDKlIuYx3Hxy5fxRo5Wrlg51EOaz5VMNsKv32XN1hIL+wJeGAsFj+IXJx
         r+N3ReUwKobS5CqTns9UK92QcWulgy63wrglLQYJ+3PUzcpKIld12lVRCNsHvH46LJuJ
         AdTg==
X-Gm-Message-State: APjAAAWxpQjCv68Yn/7lH5F7putkpA3B5RS+zrCGAGNW8RN3S0pBZ9u/
        xuFLKJCtTNE1usKZLSoqYVJ9cQ==
X-Google-Smtp-Source: APXvYqwitwvx6V2pj9mK/oeRTft1UMVSefAlLIqnVI4hN2v3+Pt/MLuW6b+CrfJxqXKkM9TTfHXVdw==
X-Received: by 2002:ac8:13c2:: with SMTP id i2mr13231243qtj.211.1567856156566;
        Sat, 07 Sep 2019 04:35:56 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r55sm4897634qtj.86.2019.09.07.04.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 04:35:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] powerpc/lockdep: fix a false positive warning
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190907070505.GA88784@gmail.com>
Date:   Sat, 7 Sep 2019 07:35:54 -0400
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, bvanassche@acm.org,
        arnd@arndb.de, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <420D09F4-FC19-421C-AE46-4B2A9157FAE3@lca.pw>
References: <20190906231754.830-1-cai@lca.pw>
 <20190907070505.GA88784@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Sep 7, 2019, at 3:05 AM, Ingo Molnar <mingo@kernel.org> wrote:
>=20
>=20
> * Qian Cai <cai@lca.pw> wrote:
>=20
>> The commit 108c14858b9e ("locking/lockdep: Add support for dynamic
>> keys") introduced a boot warning on powerpc below, because since the
>> commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
>> kvm_tmp[] into the .bss section and then free the rest of unused =
spaces
>> back to the page allocator.
>>=20
>> kernel_init
>>  kvm_guest_init
>>    kvm_free_tmp
>>      free_reserved_area
>>        free_unref_page
>>          free_unref_page_prepare
>>=20
>> Later, alloc_workqueue() happens to allocate some pages from there =
and
>> trigger the warning at,
>>=20
>> if (WARN_ON_ONCE(static_obj(key)))
>>=20
>> Fix it by adding a generic helper arch_is_bss_hole() to skip those =
areas
>> in static_obj(). Since kvm_free_tmp() is only done early during the
>> boot, just go lockless to make the implementation simple for now.
>>=20
>> WARNING: CPU: 0 PID: 13 at kernel/locking/lockdep.c:1120
>> Workqueue: events work_for_cpu_fn
>> Call Trace:
>>  lockdep_register_key+0x68/0x200
>>  wq_init_lockdep+0x40/0xc0
>>  trunc_msg+0x385f9/0x4c30f (unreliable)
>>  wq_init_lockdep+0x40/0xc0
>>  alloc_workqueue+0x1e0/0x620
>>  scsi_host_alloc+0x3d8/0x490
>>  ata_scsi_add_hosts+0xd0/0x220 [libata]
>>  ata_host_register+0x178/0x400 [libata]
>>  ata_host_activate+0x17c/0x210 [libata]
>>  ahci_host_activate+0x84/0x250 [libahci]
>>  ahci_init_one+0xc74/0xdc0 [ahci]
>>  local_pci_probe+0x78/0x100
>>  work_for_cpu_fn+0x40/0x70
>>  process_one_work+0x388/0x750
>>  process_scheduled_works+0x50/0x90
>>  worker_thread+0x3d0/0x570
>>  kthread+0x1b8/0x1e0
>>  ret_from_kernel_thread+0x5c/0x7c
>>=20
>> Fixes: 108c14858b9e ("locking/lockdep: Add support for dynamic keys")
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>=20
>> v2: No need to actually define arch_is_bss_hole() powerpc64 only.
>>=20
>> arch/powerpc/include/asm/sections.h | 11 +++++++++++
>> arch/powerpc/kernel/kvm.c           |  5 +++++
>> include/asm-generic/sections.h      |  7 +++++++
>> kernel/locking/lockdep.c            |  3 +++
>> 4 files changed, 26 insertions(+)
>>=20
>> diff --git a/arch/powerpc/include/asm/sections.h =
b/arch/powerpc/include/asm/sections.h
>> index 4a1664a8658d..4f5d69c42017 100644
>> --- a/arch/powerpc/include/asm/sections.h
>> +++ b/arch/powerpc/include/asm/sections.h
>> @@ -5,8 +5,19 @@
>>=20
>> #include <linux/elf.h>
>> #include <linux/uaccess.h>
>> +
>> +#define arch_is_bss_hole arch_is_bss_hole
>> +
>> #include <asm-generic/sections.h>
>>=20
>> +extern void *bss_hole_start, *bss_hole_end;
>> +
>> +static inline int arch_is_bss_hole(unsigned long addr)
>> +{
>> +	return addr >=3D (unsigned long)bss_hole_start &&
>> +	       addr < (unsigned long)bss_hole_end;
>> +}
>> +
>> extern char __head_end[];
>>=20
>> #ifdef __powerpc64__
>> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
>> index b7b3a5e4e224..89e0e522e125 100644
>> --- a/arch/powerpc/kernel/kvm.c
>> +++ b/arch/powerpc/kernel/kvm.c
>> @@ -66,6 +66,7 @@
>> static bool kvm_patching_worked =3D true;
>> char kvm_tmp[1024 * 1024];
>> static int kvm_tmp_index;
>> +void *bss_hole_start, *bss_hole_end;
>>=20
>> static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
>> {
>> @@ -707,6 +708,10 @@ static __init void kvm_free_tmp(void)
>> 	 */
>> 	kmemleak_free_part(&kvm_tmp[kvm_tmp_index],
>> 			   ARRAY_SIZE(kvm_tmp) - kvm_tmp_index);
>> +
>> +	bss_hole_start =3D &kvm_tmp[kvm_tmp_index];
>> +	bss_hole_end =3D &kvm_tmp[ARRAY_SIZE(kvm_tmp)];
>> +
>> 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
>> 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
>> }
>> diff --git a/include/asm-generic/sections.h =
b/include/asm-generic/sections.h
>> index d1779d442aa5..4d8b1f2c5fd9 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -91,6 +91,13 @@ static inline int =
arch_is_kernel_initmem_freed(unsigned long addr)
>> }
>> #endif
>>=20
>> +#ifndef arch_is_bss_hole
>> +static inline int arch_is_bss_hole(unsigned long addr)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>> /**
>>  * memory_contains - checks if an object is contained within a memory =
region
>>  * @begin: virtual address of the beginning of the memory region
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index 4861cf8e274b..cd75b51f15ce 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -675,6 +675,9 @@ static int static_obj(const void *obj)
>> 	if (arch_is_kernel_initmem_freed(addr))
>> 		return 0;
>>=20
>> +	if (arch_is_bss_hole(addr))
>> +		return 0;
>=20
> arch_is_bss_hole() should use a 'bool' - but other than that, this=20
> looks good to me, if the PowerPC maintainers agree too.

I thought about making it a bool in the first place, but since all other =
similar helpers
(arch_is_kernel_initmem_freed(), arch_is_kernel_text(), =
arch_is_kernel_data() etc)
could be bool too but are not, I kept arch_is_bss_hole() just to be =
=E2=80=9Cint=E2=80=9D for consistent.

Although then there is is_kernel_rodata() which is bool. I suppose =
I=E2=80=99ll change
arch_is_bss_hole() to bool, and then could have a follow-up patch to =
covert all similar
helpers to return boo instead.

