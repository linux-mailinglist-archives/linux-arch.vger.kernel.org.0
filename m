Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C336970603D
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjEQGgh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEQGgf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2781549EA;
        Tue, 16 May 2023 23:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA41B64275;
        Wed, 17 May 2023 06:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D55C433A4;
        Wed, 17 May 2023 06:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684305392;
        bh=Ku3YtoN4Hzn4TsV8mPhiZtOx0rcQ/qZG5lb6BPhQMi0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IRL6VsRXuHhJi9q3qnBaWyoBTb3yam9+E96B+YV7OHrAJ67vs0hsp1e3XjMrprRBu
         9vExcIOWr3t/MAJw4WZMlgBMvLOKgj885sIOuTVL2OmN5XA7s7Cl8eWX1esls8ZUod
         Hw34Y2gM3uwrRy3OsINUw3vnKrDG53KzEzKVQtpkwXQoTk4CXaq72NAD3DPpMCDRdX
         kWuUE0lJe/vIJvhGk5bmaLwJCXMlOEDDajJslLZSajCmNRDmD4ZnOWzmmgzaLRHZCP
         rpgPbgfUrB3BWROBz4kzf5BdHvk7KTbArfIg/ect7ZQO0Vzv225A273/MhtUqMaRJk
         mDZ4+4kbU1jZg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9659e9bbff5so57398466b.1;
        Tue, 16 May 2023 23:36:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDxIAddlKhMpbqTmwXTdXVZAYHKDf7Ua3znBxEXc27nZbxS7bhg/
        uWlcaVnh2pFXZXZiGQD6HEDQdIyhNlpU0gnRBK4=
X-Google-Smtp-Source: ACHHUZ6AakZOUggGtSXFwcAoEh3ebxPbEEHIRj6SNR6WY3+hDU3wL2YoWj8ZZDJFnYsYbpCJj1ydopf2ChRFOwJlJxM=
X-Received: by 2002:a17:907:318b:b0:957:17c5:8705 with SMTP id
 xe11-20020a170907318b00b0095717c58705mr33472986ejb.51.1684305390009; Tue, 16
 May 2023 23:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230516124610.535360-1-chenhuacai@loongson.cn> <e181913e-633d-e2ab-95f4-a653758d678d@xen0n.name>
In-Reply-To: <e181913e-633d-e2ab-95f4-a653758d678d@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 17 May 2023 14:36:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7+VVbBTRt9d7AUOF6ka92Okdjg2iBPZEv2CGsvi2MHug@mail.gmail.com>
Message-ID: <CAAhV-H7+VVbBTRt9d7AUOF6ka92Okdjg2iBPZEv2CGsvi2MHug@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Introduce hardware page table walker
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Liang Gao <gaoliang@loongson.cn>, Jun Yi <yijun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Tue, May 16, 2023 at 9:13=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 2023/5/16 20:46, Huacai Chen wrote:
> > Loongson-3A6000 and newer processors have hardware page table walker
> > (PTW) support. PTW can handle all fastpaths of TLBI/TLBL/TLBS/TLBM
> > exceptions by hardware, software only need to handle slowpaths (page
> > faults).
> >
> > BTW, PTW doesn't append _PAGE_MODIFIED for page table entries, so we
> > change pmd_dirty() and pte_dirty() to also check _PAGE_DIRTY for the
> > "dirty" attribute.
>
> Too bad we can't get a sneak peek at the new manuals... reviewing some
> of the code anyway.
>
> >
> > Signed-off-by: Liang Gao <gaoliang@loongson.cn>
> > Signed-off-by: Jun Yi <yijun@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/cpu-features.h |  2 +-
> >   arch/loongarch/include/asm/cpu.h          |  2 ++
> >   arch/loongarch/include/asm/loongarch.h    |  4 ++++
> >   arch/loongarch/include/asm/pgtable.h      |  4 ++--
> >   arch/loongarch/include/asm/tlb.h          |  3 +++
> >   arch/loongarch/include/uapi/asm/hwcap.h   |  1 +
> >   arch/loongarch/kernel/cpu-probe.c         |  4 ++++
> >   arch/loongarch/kernel/proc.c              |  1 +
> >   arch/loongarch/mm/tlb.c                   | 24 ++++++++++++++++++----=
-
> >   arch/loongarch/mm/tlbex.S                 | 21 ++++++++++++++++++++
> >   10 files changed, 58 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch=
/include/asm/cpu-features.h
> > index f6177f133477..2eafe6a6aca8 100644
> > --- a/arch/loongarch/include/asm/cpu-features.h
> > +++ b/arch/loongarch/include/asm/cpu-features.h
> > @@ -64,6 +64,6 @@
> >   #define cpu_has_eiodecode   cpu_opt(LOONGARCH_CPU_EIODECODE)
> >   #define cpu_has_guestid             cpu_opt(LOONGARCH_CPU_GUESTID)
> >   #define cpu_has_hypervisor  cpu_opt(LOONGARCH_CPU_HYPERVISOR)
> > -
> > +#define cpu_has_ptw          cpu_opt(LOONGARCH_CPU_PTW)
> >
> >   #endif /* __ASM_CPU_FEATURES_H */
> > diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/=
asm/cpu.h
> > index 88773d849e33..48b9f7168bcc 100644
> > --- a/arch/loongarch/include/asm/cpu.h
> > +++ b/arch/loongarch/include/asm/cpu.h
> > @@ -98,6 +98,7 @@ enum cpu_type_enum {
> >   #define CPU_FEATURE_EIODECODE               23      /* CPU has EXTIOI=
 interrupt pin decode mode */
> >   #define CPU_FEATURE_GUESTID         24      /* CPU has GuestID featur=
e */
> >   #define CPU_FEATURE_HYPERVISOR              25      /* CPU has hyperv=
isor (running in VM) */
> > +#define CPU_FEATURE_PTW                      26      /* CPU has hardwa=
re page table walker */
> >
> >   #define LOONGARCH_CPU_CPUCFG                BIT_ULL(CPU_FEATURE_CPUCF=
G)
> >   #define LOONGARCH_CPU_LAM           BIT_ULL(CPU_FEATURE_LAM)
> > @@ -125,5 +126,6 @@ enum cpu_type_enum {
> >   #define LOONGARCH_CPU_EIODECODE             BIT_ULL(CPU_FEATURE_EIODE=
CODE)
> >   #define LOONGARCH_CPU_GUESTID               BIT_ULL(CPU_FEATURE_GUEST=
ID)
> >   #define LOONGARCH_CPU_HYPERVISOR    BIT_ULL(CPU_FEATURE_HYPERVISOR)
> > +#define LOONGARCH_CPU_PTW            BIT_ULL(CPU_FEATURE_PTW)
> >
> >   #endif /* _ASM_CPU_H */
> > diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/in=
clude/asm/loongarch.h
> > index b3323ab5b78d..93b22a7af654 100644
> > --- a/arch/loongarch/include/asm/loongarch.h
> > +++ b/arch/loongarch/include/asm/loongarch.h
> > @@ -138,6 +138,7 @@ static inline u32 read_cpucfg(u32 reg)
> >   #define  CPUCFG2_MIPSBT                     BIT(20)
> >   #define  CPUCFG2_LSPW                       BIT(21)
> >   #define  CPUCFG2_LAM                        BIT(22)
> > +#define  CPUCFG2_PTW                 BIT(24)
> >
> >   #define LOONGARCH_CPUCFG3           0x3
> >   #define  CPUCFG3_CCDMA                      BIT(0)
> > @@ -453,6 +454,9 @@ static __always_inline void iocsr_write64(u64 val, =
u32 reg)
> >   #define  CSR_PWCTL0_PTBASE          (_ULCAST_(0x1f) << CSR_PWCTL0_PTB=
ASE_SHIFT)
> >
> >   #define LOONGARCH_CSR_PWCTL1                0x1d    /* PWCtl1 */
> > +#define  CSR_PWCTL1_PTW_SHIFT                24
> > +#define  CSR_PWCTL1_PTW_WIDTH                1
> > +#define  CSR_PWCTL1_PTW                      (_ULCAST_(0x1) << CSR_PWC=
TL1_PTW_SHIFT)
> >   #define  CSR_PWCTL1_DIR3WIDTH_SHIFT 18
> >   #define  CSR_PWCTL1_DIR3WIDTH_WIDTH 5
> >   #define  CSR_PWCTL1_DIR3WIDTH               (_ULCAST_(0x1f) << CSR_PW=
CTL1_DIR3WIDTH_SHIFT)
> > diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/incl=
ude/asm/pgtable.h
> > index d28fb9dbec59..5f93d6eef657 100644
> > --- a/arch/loongarch/include/asm/pgtable.h
> > +++ b/arch/loongarch/include/asm/pgtable.h
> > @@ -362,7 +362,7 @@ extern pgd_t invalid_pg_dir[];
> >    */
> >   static inline int pte_write(pte_t pte)      { return pte_val(pte) & _=
PAGE_WRITE; }
> >   static inline int pte_young(pte_t pte)      { return pte_val(pte) & _=
PAGE_ACCESSED; }
> > -static inline int pte_dirty(pte_t pte)       { return pte_val(pte) & _=
PAGE_MODIFIED; }
> > +static inline int pte_dirty(pte_t pte)       { return pte_val(pte) & (=
_PAGE_DIRTY | _PAGE_MODIFIED); }
>
> Will this affect existing models? I can't seem to remember the details.
No problem here, because the DIRTY bit is set by hardware only, and
the DIRTY bit always spreads to MODIFIED by tlb handler. Moreover,
ARM64 does the same.

>
> >
> >   static inline pte_t pte_mkold(pte_t pte)
> >   {
> > @@ -506,7 +506,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
> >
> >   static inline int pmd_dirty(pmd_t pmd)
> >   {
> > -     return !!(pmd_val(pmd) & _PAGE_MODIFIED);
> > +     return !!(pmd_val(pmd) & (_PAGE_DIRTY | _PAGE_MODIFIED));
> >   }
> >
> >   static inline pmd_t pmd_mkclean(pmd_t pmd)
> > diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/=
asm/tlb.h
> > index f5e4deb97402..0dc9ee2b05d2 100644
> > --- a/arch/loongarch/include/asm/tlb.h
> > +++ b/arch/loongarch/include/asm/tlb.h
> > @@ -163,6 +163,9 @@ extern void handle_tlb_store(void);
> >   extern void handle_tlb_modify(void);
> >   extern void handle_tlb_refill(void);
> >   extern void handle_tlb_protect(void);
> > +extern void handle_tlb_load_ptw(void);
> > +extern void handle_tlb_store_ptw(void);
> > +extern void handle_tlb_modify_ptw(void);
> >
> >   extern void dump_tlb_all(void);
> >   extern void dump_tlb_regs(void);
> > diff --git a/arch/loongarch/include/uapi/asm/hwcap.h b/arch/loongarch/i=
nclude/uapi/asm/hwcap.h
> > index 8840b72fa8e8..6955a7cb2c65 100644
> > --- a/arch/loongarch/include/uapi/asm/hwcap.h
> > +++ b/arch/loongarch/include/uapi/asm/hwcap.h
> > @@ -16,5 +16,6 @@
> >   #define HWCAP_LOONGARCH_LBT_X86             (1 << 10)
> >   #define HWCAP_LOONGARCH_LBT_ARM             (1 << 11)
> >   #define HWCAP_LOONGARCH_LBT_MIPS    (1 << 12)
> > +#define HWCAP_LOONGARCH_PTW          (1 << 13)
>
> This feature should be irrevelant to userspace, right? We should
> probably not add it here.
Not used now but we don't know the future, add it which is similar to LVZ.

>
> >
> >   #endif /* _UAPI_ASM_HWCAP_H */
> > diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/=
cpu-probe.c
> > index f42acc6c8df6..e925579c7a71 100644
> > --- a/arch/loongarch/kernel/cpu-probe.c
> > +++ b/arch/loongarch/kernel/cpu-probe.c
> > @@ -136,6 +136,10 @@ static void cpu_probe_common(struct cpuinfo_loonga=
rch *c)
> >               c->options |=3D LOONGARCH_CPU_CRYPTO;
> >               elf_hwcap |=3D HWCAP_LOONGARCH_CRYPTO;
> >       }
> > +     if (config & CPUCFG2_PTW) {
> > +             c->options |=3D LOONGARCH_CPU_PTW;
> > +             elf_hwcap |=3D HWCAP_LOONGARCH_PTW;
> > +     }
> >       if (config & CPUCFG2_LVZP) {
> >               c->options |=3D LOONGARCH_CPU_LVZ;
> >               elf_hwcap |=3D HWCAP_LOONGARCH_LVZ;
> > diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.=
c
> > index 0d82907b5404..782a34e7336e 100644
> > --- a/arch/loongarch/kernel/proc.c
> > +++ b/arch/loongarch/kernel/proc.c
> > @@ -79,6 +79,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >       if (cpu_has_crc32)      seq_printf(m, " crc32");
> >       if (cpu_has_complex)    seq_printf(m, " complex");
> >       if (cpu_has_crypto)     seq_printf(m, " crypto");
> > +     if (cpu_has_ptw)        seq_printf(m, " ptw");
> >       if (cpu_has_lvz)        seq_printf(m, " lvz");
> >       if (cpu_has_lbt_x86)    seq_printf(m, " lbt_x86");
> >       if (cpu_has_lbt_arm)    seq_printf(m, " lbt_arm");
> > diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> > index 8bad6b0cff59..3e1d1d3c7058 100644
> > --- a/arch/loongarch/mm/tlb.c
> > +++ b/arch/loongarch/mm/tlb.c
> > @@ -167,6 +167,9 @@ void __update_tlb(struct vm_area_struct *vma, unsig=
ned long address, pte_t *ptep
> >       int idx;
> >       unsigned long flags;
> >
> > +     if (cpu_has_ptw)
> > +             return;
> > +
> >       /*
> >        * Handle debugger faulting in for debugee.
> >        */
> > @@ -220,7 +223,11 @@ static void setup_ptwalker(void)
> >       pte_w =3D PAGE_SHIFT - 3;
> >
> >       pwctl0 =3D pte_i | pte_w << 5 | pmd_i << 10 | pmd_w << 15 | pud_i=
 << 20 | pud_w << 25;
> > -     pwctl1 =3D pgd_i | pgd_w << 6;
> > +
> > +     if (!cpu_has_ptw)
> > +             pwctl1 =3D pgd_i | pgd_w << 6;
> > +     else
> > +             pwctl1 =3D pgd_i | pgd_w << 6 | CSR_PWCTL1_PTW;
>
> This is better in avoiding the duplication:
>
> if (cpu_has_ptw)
>      pwctl1 |=3D CSR_PWCTL1_PTW;
OK, I can change but I don't know the advantages.

>
> >
> >       csr_write64(pwctl0, LOONGARCH_CSR_PWCTL0);
> >       csr_write64(pwctl1, LOONGARCH_CSR_PWCTL1);
> > @@ -264,10 +271,17 @@ void setup_tlb_handler(int cpu)
> >       if (cpu =3D=3D 0) {
> >               memcpy((void *)tlbrentry, handle_tlb_refill, 0x80);
> >               local_flush_icache_range(tlbrentry, tlbrentry + 0x80);
> > -             set_handler(EXCCODE_TLBI * VECSIZE, handle_tlb_load, VECS=
IZE);
> > -             set_handler(EXCCODE_TLBL * VECSIZE, handle_tlb_load, VECS=
IZE);
> > -             set_handler(EXCCODE_TLBS * VECSIZE, handle_tlb_store, VEC=
SIZE);
> > -             set_handler(EXCCODE_TLBM * VECSIZE, handle_tlb_modify, VE=
CSIZE);
> > +             if (!cpu_has_ptw) {
>
> Better not have the condition inverted for less cognitive burden (have
> to go "no [hardware] page table walker" -> "take the software approach"
> otherwise).
I want to let the "old behaviors" appear earlier.

>
> > +                     set_handler(EXCCODE_TLBI * VECSIZE, handle_tlb_lo=
ad, VECSIZE);
> > +                     set_handler(EXCCODE_TLBL * VECSIZE, handle_tlb_lo=
ad, VECSIZE);
> > +                     set_handler(EXCCODE_TLBS * VECSIZE, handle_tlb_st=
ore, VECSIZE);
> > +                     set_handler(EXCCODE_TLBM * VECSIZE, handle_tlb_mo=
dify, VECSIZE);
> > +             } else {
> > +                     set_handler(EXCCODE_TLBI * VECSIZE, handle_tlb_lo=
ad_ptw, VECSIZE);
> > +                     set_handler(EXCCODE_TLBL * VECSIZE, handle_tlb_lo=
ad_ptw, VECSIZE);
> > +                     set_handler(EXCCODE_TLBS * VECSIZE, handle_tlb_st=
ore_ptw, VECSIZE);
> > +                     set_handler(EXCCODE_TLBM * VECSIZE, handle_tlb_mo=
dify_ptw, VECSIZE);
> > +             }
> >               set_handler(EXCCODE_TLBNR * VECSIZE, handle_tlb_protect, =
VECSIZE);
> >               set_handler(EXCCODE_TLBNX * VECSIZE, handle_tlb_protect, =
VECSIZE);
> >               set_handler(EXCCODE_TLBPE * VECSIZE, handle_tlb_protect, =
VECSIZE);
> > diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> > index 240ced55586e..01df8a0b87f6 100644
> > --- a/arch/loongarch/mm/tlbex.S
> > +++ b/arch/loongarch/mm/tlbex.S
> > @@ -190,6 +190,13 @@ nopage_tlb_load:
> >       jr              t0
> >   SYM_FUNC_END(handle_tlb_load)
> >
> > +SYM_FUNC_START(handle_tlb_load_ptw)
> > +     csrwr   t0, LOONGARCH_CSR_KS0
> > +     csrwr   t1, LOONGARCH_CSR_KS1
> > +     la_abs  t0, tlb_do_page_fault_0
> > +     jirl    zero, t0, 0
>
> jr t0
OK, thanks.

>
> > +SYM_FUNC_END(handle_tlb_load_ptw)
> > +
> >   SYM_FUNC_START(handle_tlb_store)
> >       csrwr           t0, EXCEPTION_KS0
> >       csrwr           t1, EXCEPTION_KS1
> > @@ -339,6 +346,13 @@ nopage_tlb_store:
> >       jr              t0
> >   SYM_FUNC_END(handle_tlb_store)
> >
> > +SYM_FUNC_START(handle_tlb_store_ptw)
> > +     csrwr   t0, LOONGARCH_CSR_KS0
> > +     csrwr   t1, LOONGARCH_CSR_KS1
> > +     la_abs  t0, tlb_do_page_fault_1
> > +     jirl    zero, t0, 0
>
> Same here.
OK, thanks.

>
> > +SYM_FUNC_END(handle_tlb_store_ptw)
> > +
> >   SYM_FUNC_START(handle_tlb_modify)
> >       csrwr           t0, EXCEPTION_KS0
> >       csrwr           t1, EXCEPTION_KS1
> > @@ -486,6 +500,13 @@ nopage_tlb_modify:
> >       jr              t0
> >   SYM_FUNC_END(handle_tlb_modify)
> >
> > +SYM_FUNC_START(handle_tlb_modify_ptw)
> > +     csrwr   t0, LOONGARCH_CSR_KS0
> > +     csrwr   t1, LOONGARCH_CSR_KS1
> > +     la_abs  t0, tlb_do_page_fault_1
> > +     jirl    zero, t0, 0
>
> And here.
OK, thanks.

Huacai
>
> > +SYM_FUNC_END(handle_tlb_modify_ptw)
> > +
> >   SYM_FUNC_START(handle_tlb_refill)
> >       csrwr           t0, LOONGARCH_CSR_TLBRSAVE
> >       csrrd           t0, LOONGARCH_CSR_PGD
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
