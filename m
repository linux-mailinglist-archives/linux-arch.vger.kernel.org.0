Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241852BF0D
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiERQM7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbiERQM6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 12:12:58 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA91D676A;
        Wed, 18 May 2022 09:12:57 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id c62so2539887vsc.10;
        Wed, 18 May 2022 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KGkMa3g/rHsmweFm19WSFkNSCkDNMIHHwZBFYqVTp0=;
        b=Cpj/zTCLj2u4PYrHMtOkWqD4crW4MaWYQhdeYy77T7KFC+Hxamdz3VPYWA7QNxml+p
         NYk4ccQZMHFm9k7kj9w1kAjLPl9Gye49xgaCkTnobYlhCDUn4mFmCVDzaTjQbKrFX64X
         ILDaXwD7qcnrmcFcwC8sVrt7kY7C+amKR5IlD+XbZ98PH9jqoBA7C3BEkzBXPUUg2jnU
         FGOCHz0WygiLsuGJ50XYcfpnQvHYoY2YIl2CTJ65+bCBhz/ZAqnBf6UPYtzkaFz5f91W
         tBiX8T4DgY9CV82DORwV+L+CIsckDj9oiiPCQuamYNg03iqdbkjw8gG1k/mPs9on0jkk
         uUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KGkMa3g/rHsmweFm19WSFkNSCkDNMIHHwZBFYqVTp0=;
        b=cSAcgL0ElGf37sNWq3bMehb29BawZUCWx95QzHVfCi5SSAGXQ0nVCyqqQZJA4q18wt
         1PIrUDtuRlaUVHKeHXlLuKdgDSdwm/bz13lT0JUJKV37khqRVZqwti+d8+bCCaLlLAZA
         csyoa2QMnRpEi0RxNv/SrNGku7eWdDRXEf0DwaZ4qQlqNlzxR+90UeDCrewUZx9z+sn7
         c+MAtI+54sIDMEB8hZ6sDUo5N9QhX+KJNmtZhoTmWYbAbF5FmddFpRdDq7X7S4xJNqKy
         JzxUQXCxzRKBXYg7z3JtHoE2JHiC88K3fuBrafwEiJMGqQzbrs5weczRoZC15eMUSqW7
         l2tg==
X-Gm-Message-State: AOAM531M3fcFjaQBiY59xdUFlXBIFJPjjC8ew9fTKE91a+ra3VCC6xW0
        kQ4C5HnbCbwk8UPFCT3iChaFL28qVMkaxXdhNZ8=
X-Google-Smtp-Source: ABdhPJxvjRB9rwkN1E+S9721LkhDkzC1Jx/I8CqjSj4chw2F1s8Rrkzc9mmrSu7cfka3YY2iqvBnFTB6FdsZVguJG1w=
X-Received: by 2002:a67:d91e:0:b0:335:c784:637 with SMTP id
 t30-20020a67d91e000000b00335c7840637mr295713vsj.40.1652890376041; Wed, 18 May
 2022 09:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-7-chenhuacai@loongson.cn> <bfc3a1b2-af80-c619-09fc-9d0972b87bf4@xen0n.name>
In-Reply-To: <bfc3a1b2-af80-c619-09fc-9d0972b87bf4@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 19 May 2022 00:12:43 +0800
Message-ID: <CAAhV-H4G5aB0+c1NiJtaQGh+EGP8Q0QDkNgpS_vMNPvznt1=cw@mail.gmail.com>
Subject: Re: [PATCH V11 06/22] LoongArch: Add CPU definition headers
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Wed, May 18, 2022 at 11:45 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 5/18/22 17:26, Huacai Chen wrote:
> > Add common headers (CPU definition and address space layout) for basic
> > LoongArch support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/addrspace.h    |  112 ++
> >   arch/loongarch/include/asm/cpu-features.h |   73 +
> >   arch/loongarch/include/asm/cpu-info.h     |  116 ++
> >   arch/loongarch/include/asm/cpu.h          |  127 ++
> >   arch/loongarch/include/asm/fpregdef.h     |   53 +
> >   arch/loongarch/include/asm/loongarch.h    | 1519 +++++++++++++++++++++
> >   arch/loongarch/include/asm/loongson.h     |  153 +++
> >   arch/loongarch/include/asm/regdef.h       |   41 +
> >   8 files changed, 2194 insertions(+)
> >   create mode 100644 arch/loongarch/include/asm/addrspace.h
> >   create mode 100644 arch/loongarch/include/asm/cpu-features.h
> >   create mode 100644 arch/loongarch/include/asm/cpu-info.h
> >   create mode 100644 arch/loongarch/include/asm/cpu.h
> >   create mode 100644 arch/loongarch/include/asm/fpregdef.h
> >   create mode 100644 arch/loongarch/include/asm/loongarch.h
> >   create mode 100644 arch/loongarch/include/asm/loongson.h
> >   create mode 100644 arch/loongarch/include/asm/regdef.h
> >
> > [snip]
> >
> > diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
> > new file mode 100644
> > index 000000000000..2be0efe93875
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/loongarch.h
> > @@ -0,0 +1,1519 @@
> >
> > [snip]
> >
> > +
> > +/* FPU register names */
> > +#define LOONGARCH_FCSR0      $r0
> > +#define LOONGARCH_FCSR1      $r1
> > +#define LOONGARCH_FCSR2      $r2
> > +#define LOONGARCH_FCSR3      $r3
> Why not reuse the definitions in <asm/fpregdef.h>?
> > +
> > +/* FPU Status Register Values */
> > +#define FPU_CSR_RSVD 0xe0e0fce0
> > +
> > +/*
> > + * X the exception cause indicator
> > + * E the exception enable
> > + * S the sticky/flag bit
> > + */
> > +#define FPU_CSR_ALL_X        0x1f000000
> > +#define FPU_CSR_INV_X        0x10000000
> > +#define FPU_CSR_DIV_X        0x08000000
> > +#define FPU_CSR_OVF_X        0x04000000
> > +#define FPU_CSR_UDF_X        0x02000000
> > +#define FPU_CSR_INE_X        0x01000000
> > +
> > +#define FPU_CSR_ALL_S        0x001f0000
> > +#define FPU_CSR_INV_S        0x00100000
> > +#define FPU_CSR_DIV_S        0x00080000
> > +#define FPU_CSR_OVF_S        0x00040000
> > +#define FPU_CSR_UDF_S        0x00020000
> > +#define FPU_CSR_INE_S        0x00010000
> > +
> > +#define FPU_CSR_ALL_E        0x0000001f
> > +#define FPU_CSR_INV_E        0x00000010
> > +#define FPU_CSR_DIV_E        0x00000008
> > +#define FPU_CSR_OVF_E        0x00000004
> > +#define FPU_CSR_UDF_E        0x00000002
> > +#define FPU_CSR_INE_E        0x00000001
> > +
> > +/* Bits 8 and 9 of FPU Status Register specify the rounding mode */
> > +#define FPU_CSR_RM   0x300
> > +#define FPU_CSR_RN   0x000   /* nearest */
> > +#define FPU_CSR_RZ   0x100   /* towards zero */
> > +#define FPU_CSR_RU   0x200   /* towards +Infinity */
> > +#define FPU_CSR_RD   0x300   /* towards -Infinity */
> > +
> > +#define read_fcsr(source)    \
> > +({   \
> > +     unsigned int __res;     \
> > +\
> > +     __asm__ __volatile__(   \
> > +     "       movfcsr2gr      %0, "__stringify(source)" \n"   \
> > +     : "=r" (__res));        \
> > +     __res;  \
> > +})
> > +
> > +#define write_fcsr(dest, val) \
> > +do { \
> > +     __asm__ __volatile__(   \
> > +     "       movgr2fcsr      %0, "__stringify(dest)" \n"     \
> > +     : : "r" (val)); \
> > +} while (0)
> > +
> > +#endif /* _ASM_LOONGARCH_H */
> > diff --git a/arch/loongarch/include/asm/loongson.h b/arch/loongarch/include/asm/loongson.h
> > new file mode 100644
> > index 000000000000..db4992ae6a6c
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/loongson.h
> > @@ -0,0 +1,153 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifndef __ASM_LOONGSON_H
> > +#define __ASM_LOONGSON_H
> > +
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/pci.h>
> > +#include <asm/addrspace.h>
> > +#include <asm/bootinfo.h>
> > +
> > +extern const struct plat_smp_ops loongson3_smp_ops;
> > +
> > +#define LOONGSON_REG(x) \
> > +     (*(volatile u32 *)((char *)TO_UNCACHE(LOONGSON_REG_BASE) + (x)))
> > +
> > +#define LOONGSON_LIO_BASE    0x18000000
> > +#define LOONGSON_LIO_SIZE    0x00100000      /* 1M */
> > +#define LOONGSON_LIO_TOP     (LOONGSON_LIO_BASE+LOONGSON_LIO_SIZE-1)
> > +
> > +#define LOONGSON_BOOT_BASE   0x1c000000
> > +#define LOONGSON_BOOT_SIZE   0x02000000      /* 32M */
> > +#define LOONGSON_BOOT_TOP    (LOONGSON_BOOT_BASE+LOONGSON_BOOT_SIZE-1)
> > +
> > +#define LOONGSON_REG_BASE    0x1fe00000
> > +#define LOONGSON_REG_SIZE    0x00100000      /* 1M */
> > +#define LOONGSON_REG_TOP     (LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
> > +
> > +/* GPIO Regs - r/w */
> > +
> > +#define LOONGSON_GPIODATA            LOONGSON_REG(0x11c)
> > +#define LOONGSON_GPIOIE                      LOONGSON_REG(0x120)
> > +#define LOONGSON_REG_GPIO_BASE          (LOONGSON_REG_BASE + 0x11c)
> > +
> > +#define MAX_PACKAGES 16
> > +
> > +/* Chip Config registor of each physical cpu package */
> "register" -- same below
> > +extern u64 loongson_chipcfg[MAX_PACKAGES];
> > +#define LOONGSON_CHIPCFG(id) (*(volatile u32 *)(loongson_chipcfg[id]))
> > +
> > +/* Chip Temperature registor of each physical cpu package */
> > +extern u64 loongson_chiptemp[MAX_PACKAGES];
> > +#define LOONGSON_CHIPTEMP(id) (*(volatile u32 *)(loongson_chiptemp[id]))
> > +
> > +/* Freq Control register of each physical cpu package */
> > +extern u64 loongson_freqctrl[MAX_PACKAGES];
> > +#define LOONGSON_FREQCTRL(id) (*(volatile u32 *)(loongson_freqctrl[id]))
> > +
> > +#define xconf_readl(addr) readl(addr)
> > +#define xconf_readq(addr) readq(addr)
> > +
> > +static inline void xconf_writel(u32 val, volatile void __iomem *addr)
> > +{
> > +     asm volatile (
> > +     "       st.w    %[v], %[hw], 0  \n"
> > +     "       ld.b    $r0, %[hw], 0   \n"
> > +     :
> > +     : [hw] "r" (addr), [v] "r" (val)
> > +     );
> > +}
> > +
> > +static inline void xconf_writeq(u64 val64, volatile void __iomem *addr)
> > +{
> > +     asm volatile (
> > +     "       st.d    %[v], %[hw], 0  \n"
> > +     "       ld.b    $r0, %[hw], 0   \n"
> > +     :
> > +     : [hw] "r" (addr),  [v] "r" (val64)
> > +     );
> > +}
> > +
> > +/* ============== LS7A registers =============== */
> > +#define LS7A_PCH_REG_BASE            0x10000000UL
> > +/* LPC regs */
> > +#define LS7A_LPC_REG_BASE            (LS7A_PCH_REG_BASE + 0x00002000)
> > +/* CHIPCFG regs */
> > +#define LS7A_CHIPCFG_REG_BASE                (LS7A_PCH_REG_BASE + 0x00010000)
> > +/* MISC reg base */
> > +#define LS7A_MISC_REG_BASE           (LS7A_PCH_REG_BASE + 0x00080000)
> > +/* ACPI regs */
> > +#define LS7A_ACPI_REG_BASE           (LS7A_MISC_REG_BASE + 0x00050000)
> > +/* RTC regs */
> > +#define LS7A_RTC_REG_BASE            (LS7A_MISC_REG_BASE + 0x00050100)
> > +
> > +#define LS7A_DMA_CFG                 (volatile void *)TO_UNCACHE(LS7A_CHIPCFG_REG_BASE + 0x041c)
> > +#define LS7A_DMA_NODE_SHF            8
> > +#define LS7A_DMA_NODE_MASK           0x1F00
> > +
> > +#define LS7A_INT_MASK_REG            (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x020)
> > +#define LS7A_INT_EDGE_REG            (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x060)
> > +#define LS7A_INT_CLEAR_REG           (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x080)
> > +#define LS7A_INT_HTMSI_EN_REG                (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x040)
> > +#define LS7A_INT_ROUTE_ENTRY_REG     (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x100)
> > +#define LS7A_INT_HTMSI_VEC_REG               (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x200)
> > +#define LS7A_INT_STATUS_REG          (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x3a0)
> > +#define LS7A_INT_POL_REG             (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x3e0)
> > +#define LS7A_LPC_INT_CTL             (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x2000)
> > +#define LS7A_LPC_INT_ENA             (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x2004)
> > +#define LS7A_LPC_INT_STS             (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x2008)
> > +#define LS7A_LPC_INT_CLR             (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x200c)
> > +#define LS7A_LPC_INT_POL             (volatile void *)TO_UNCACHE(LS7A_PCH_REG_BASE + 0x2010)
> > +
> > +#define LS7A_PMCON_SOC_REG           (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x000)
> > +#define LS7A_PMCON_RESUME_REG                (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x004)
> > +#define LS7A_PMCON_RTC_REG           (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x008)
> > +#define LS7A_PM1_EVT_REG             (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x00c)
> > +#define LS7A_PM1_ENA_REG             (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x010)
> > +#define LS7A_PM1_CNT_REG             (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x014)
> > +#define LS7A_PM1_TMR_REG             (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x018)
> > +#define LS7A_P_CNT_REG                       (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x01c)
> > +#define LS7A_GPE0_STS_REG            (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x028)
> > +#define LS7A_GPE0_ENA_REG            (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x02c)
> > +#define LS7A_RST_CNT_REG             (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x030)
> > +#define LS7A_WD_SET_REG                      (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x034)
> > +#define LS7A_WD_TIMER_REG            (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x038)
> > +#define LS7A_THSENS_CNT_REG          (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x04c)
> > +#define LS7A_GEN_RTC_1_REG           (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x050)
> > +#define LS7A_GEN_RTC_2_REG           (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x054)
> > +#define LS7A_DPM_CFG_REG             (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x400)
> > +#define LS7A_DPM_STS_REG             (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x404)
> > +#define LS7A_DPM_CNT_REG             (volatile void *)TO_UNCACHE(LS7A_ACPI_REG_BASE + 0x408)
> > +
> > +typedef enum {
> > +     ACPI_PCI_HOTPLUG_STATUS = 1 << 1,
> > +     ACPI_CPU_HOTPLUG_STATUS = 1 << 2,
> > +     ACPI_MEM_HOTPLUG_STATUS = 1 << 3,
> > +     ACPI_POWERBUTTON_STATUS = 1 << 8,
> > +     ACPI_RTC_WAKE_STATUS    = 1 << 10,
> > +     ACPI_PCI_WAKE_STATUS    = 1 << 14,
> > +     ACPI_ANY_WAKE_STATUS    = 1 << 15,
> > +} AcpiEventStatusBits;
> > +
> > +#define HT1LO_OFFSET         0xe0000000000UL
> > +
> > +/* PCI Configuration Space Base */
> > +#define MCFG_EXT_PCICFG_BASE         0xefe00000000UL
> > +
> > +/* REG ACCESS*/
> > +#define ls7a_readb(addr)     (*(volatile unsigned char  *)TO_UNCACHE(addr))
> > +#define ls7a_readw(addr)     (*(volatile unsigned short *)TO_UNCACHE(addr))
> > +#define ls7a_readl(addr)     (*(volatile unsigned int   *)TO_UNCACHE(addr))
> > +#define ls7a_readq(addr)     (*(volatile unsigned long  *)TO_UNCACHE(addr))
> > +#define ls7a_writeb(val, addr)       *(volatile unsigned char  *)TO_UNCACHE(addr) = (val)
> > +#define ls7a_writew(val, addr)       *(volatile unsigned short *)TO_UNCACHE(addr) = (val)
> > +#define ls7a_writel(val, addr)       *(volatile unsigned int   *)TO_UNCACHE(addr) = (val)
> > +#define ls7a_writeq(val, addr)       *(volatile unsigned long  *)TO_UNCACHE(addr) = (val)
> > +
> > +#endif /* __ASM_LOONGSON_H */
> > diff --git a/arch/loongarch/include/asm/regdef.h b/arch/loongarch/include/asm/regdef.h
> > new file mode 100644
> > index 000000000000..49a374c2612c
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/regdef.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_REGDEF_H
> > +#define _ASM_REGDEF_H
> > +
> > +#define zero $r0     /* wired zero */
> > +#define ra   $r1     /* return address */
> > +#define tp   $r2
> > +#define sp   $r3     /* stack pointer */
> > +#define a0   $r4     /* argument registers, a0/a1 reused as v0/v1 for return value */
> > +#define a1   $r5
> > +#define a2   $r6
> > +#define a3   $r7
> > +#define a4   $r8
> > +#define a5   $r9
> > +#define a6   $r10
> > +#define a7   $r11
> > +#define t0   $r12    /* caller saved */
> > +#define t1   $r13
> > +#define t2   $r14
> > +#define t3   $r15
> > +#define t4   $r16
> > +#define t5   $r17
> > +#define t6   $r18
> > +#define t7   $r19
> > +#define t8   $r20
> > +#define u0   $r21
> > +#define fp   $r22    /* frame pointer */
> > +#define s0   $r23    /* callee saved */
> > +#define s1   $r24
> > +#define s2   $r25
> > +#define s3   $r26
> > +#define s4   $r27
> > +#define s5   $r28
> > +#define s6   $r29
> > +#define s7   $r30
> > +#define s8   $r31
> > +
> > +#endif /* _ASM_REGDEF_H */
>
> Apart from the minor nits:
Thanks, typos will be fixed.

Huacai
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
