Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD074678D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 04:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGDCZ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 22:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGDCZ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 22:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE35E7A;
        Mon,  3 Jul 2023 19:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7698E61122;
        Tue,  4 Jul 2023 02:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEB1C433CC;
        Tue,  4 Jul 2023 02:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688437546;
        bh=7BbYRfUvhTgI2QFW1Y6cE+p5KDbc51E2oTSjWqrcvO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kbaC7+wZ/EG4LXCLwpT/VvSHZ/EDVwWVQj8QLklXrilCvS9UD+R4hTDz9RJ744SCK
         K2QZuEwvl5nrJU4Wb1HERSmKNW0NVe3F62lpkSdDS6iR5zytJKPjl6si75rRjy23js
         +jq0O29gorWzXv9s4zUU5Dtb9Pcn8lgHlghSIRGaEGXv8c5YFFLbCrXzvVRRZGVh2n
         YP2ah5eT13RQRVL6tf1LHEFwZJ4KuHEhtthr7ggtlRaylIDjIvf51ibQjuORsxVlb6
         NNEzBE5knY6kr49joE029aTvZYWCbWBWaTH1vheozCFtyxqu25+x1ofGg5hEkTasFJ
         An3jSBbAeWxSA==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so5700359f8f.0;
        Mon, 03 Jul 2023 19:25:46 -0700 (PDT)
X-Gm-Message-State: ABy/qLbU6opu5AAOxKl9Wh6vjKvy5Y/kQtC1piqvSo5M+MSx7EXWUpqw
        G83H9mQLMZ9scihDFYVRnNVxGoHXSqX5nIa5BR8=
X-Google-Smtp-Source: APBJJlFXB+TDXgDFk89vPWMn0GYOkgHoExxt8ps+HmmWXjWZwQ5KJ5BdUVI0f0Sb/VYAqg2qMHekpadE/VOYICA9Y9E=
X-Received: by 2002:adf:cc81:0:b0:314:d19:fc31 with SMTP id
 p1-20020adfcc81000000b003140d19fc31mr9582567wrj.51.1688437545091; Mon, 03 Jul
 2023 19:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230629082032.3481237-1-guoren@kernel.org> <2ab8ca7c-a648-f73c-1815-086274af6013@ghiti.fr>
In-Reply-To: <2ab8ca7c-a648-f73c-1815-086274af6013@ghiti.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 4 Jul 2023 10:25:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQdr1YGTAwtrHCxSomjTHXgdzwWSff2VRKxq06S62aJtA@mail.gmail.com>
Message-ID: <CAJF2gTQdr1YGTAwtrHCxSomjTHXgdzwWSff2VRKxq06S62aJtA@mail.gmail.com>
Subject: Re: [PATCH] riscv: pageattr: Fixup synchronization problem between
 init_mm and active_mm
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.co, zong.li@sifive.com,
        atishp@atishpatra.org, jszhang@kernel.org, bjorn@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 3, 2023 at 6:17=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> Hi Guo,
>
> On 29/06/2023 10:20, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The machine_kexec() uses set_memory_x to add the executable attribute t=
o the
> > page table entry of control_code_buffer. It only modifies the init_mm b=
ut not
> > the current->active_mm. The current kexec process won't use init_mm dir=
ectly,
> > and it depends on minor_pagefault, which is removed by commit 7d3332be0=
11e4
>
>
> Is the removal of minor_pagefault an issue? I'm not sure I understand
> this part of the changelog.
I use two different work-around patches to answer your question:
1st:
-----
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 705d63a59aec..b8b200c81606 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -249,7 +249,7 @@ void handle_page_fault(struct pt_regs *regs)
* only copy the information from the master page table,
* nothing more.
*/
- if (unlikely((addr >=3D VMALLOC_START) && (addr < VMALLOC_END))) {
+ if (unlikely(addr >=3D 0x8000000000000000UL)) {
vmalloc_fault(regs, code, addr);
return;
}
------

2nd:
------
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8e65f0a953e5..270f50852886 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1387,7 +1387,7 @@ static void __init create_linear_mapping_page_table(v=
oid)
if (end >=3D __pa(PAGE_OFFSET) + memory_limit)
end =3D __pa(PAGE_OFFSET) + memory_limit;

- create_linear_mapping_range(start, end, 0);
+ create_linear_mapping_range(start, end, PMD_SIZE);
}

#ifdef CONFIG_STRICT_KERNEL_RWX
-----

The removal of minor_pagefault could be an issue, but in this case
it's the VMALLOC_START/END which prevents the minor_pagefault at
first. I didn't say commit 7d3332be011e4 is the problem.

>
>
> > ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area") of 64B=
IT. So,
> > when it met pud mapping on an MMU_SV39 machine, it caused the following=
:
> >
> >   kexec_core: Starting new kernel
> >   Will call new kernel at 00300000 from hart id 0
> >   FDT image at 747c7000
> >   Bye...
> >   Unable to handle kernel paging request at virtual address ffffffda23b=
0d000
> >   Oops [#1]
> >   Modules linked in:
> >   CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
> >   Hardware name: Sophgo Mango (DT)
> >   epc : 0xffffffda23b0d000
> >    ra : machine_kexec+0xa6/0xb0
> >   epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
> >    gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
> >    t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
> >    s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
> >    a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
> >    a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
> >    s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
> >    s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
> >    s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
> >    s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
> >    t5 : ffffffff815351b0 t6 : ffffffc80c173b50
> >   status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 00000000000=
0000c
> >
> > Yes, Using set_memory_x API after boot has the limitation, and at least=
 we
> > should synchronize the current->active_mm to fix the problem.
> >
> > Fixes: d3ab332a5021 ("riscv: add ARCH_HAS_SET_MEMORY support")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   arch/riscv/mm/pageattr.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> > index ea3d61de065b..23d169c4ee81 100644
> > --- a/arch/riscv/mm/pageattr.c
> > +++ b/arch/riscv/mm/pageattr.c
> > @@ -123,6 +123,13 @@ static int __set_memory(unsigned long addr, int nu=
mpages, pgprot_t set_mask,
> >                                    &masks);
> >       mmap_write_unlock(&init_mm);
> >
> > +     if (current->active_mm !=3D &init_mm) {
> > +             mmap_write_lock(current->active_mm);
> > +             ret =3D  walk_page_range_novma(current->active_mm, start,=
 end,
> > +                                          &pageattr_ops, NULL, &masks)=
;
> > +             mmap_write_unlock(current->active_mm);
> > +     }
> > +
> >       flush_tlb_kernel_range(start, end);
> >
> >       return ret;
>
>
> I don't understand: any page table inherits the entries of
> swapper_pg_dir (see pgd_alloc()), so any kernel page table entry is
> "automatically" synchronized, so why should we synchronize one 4K entry
> explicitly? A PGD entry would need to be synced, but not a PTE entry.
The purpose of the second walk_page_range_novma() is for pgd's entries
synchronization. I'm a bit lazy here, I agree, it's unnecessary to
write lower level entries again. So I would use a simple pgd entries
synchronization from vmalloc_fault in the next version of patch, all
right?


>


--
Best Regards
 Guo Ren
