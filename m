Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB62C57A3D2
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiGSP6o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiGSP6n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 11:58:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2335B79B
        for <linux-arch@vger.kernel.org>; Tue, 19 Jul 2022 08:58:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so7737885pjl.5
        for <linux-arch@vger.kernel.org>; Tue, 19 Jul 2022 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GtB8BI3Lg6RgIY+Axlp49dX2tSqW+wRJGV6SskGWNCM=;
        b=X9q2GMc7HLMzv8eirrUEa5w1MWi56Y0W9j1JKwKt/i1hk0onwXPhvLNJuaz04N5yLC
         QFzEf+SdOP0+Ok5BCOqp5kJnwAlrPuXztiqghKC0+T7VuOmuNm/UA6mcOGMRX27SdVDg
         MIHYRin+E7ZWiYZ64pkCzFtLSM0a92iD994BxYhngFMi8qh09rSjw+3UDF6EwPHAfNm0
         lA+tnQFr3nLUQHma2Wk56b5JO57cQHqs2e03f+jJVKp1vvtgCSBMuGC2nf2OAwzSD6ZX
         Te4nQTx1/QnL5hXh6coSlvDGehckBcBOi3cUsrRpSdcBDGWwC/K+te9+oMGQbZaDhnia
         ojCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GtB8BI3Lg6RgIY+Axlp49dX2tSqW+wRJGV6SskGWNCM=;
        b=GSg77pw7TIjtMIbCb8H3j4UBfVADlmxfy1CbJ8j4RCygED4JMMebJGoi9BWnEhe9Ju
         VbbAozcI2cRivHzrrJ9udogVt8IMvOKkiJHLcGjNJd/ca+z0Tcti5LWyWZlV7GLlYcNj
         9FnEQMiU0MyNLlDFB9equMQEpUU8iK5dkMxnAgIPEM/VengQZY60ObNmk7jVKVcB5334
         NmZZnV2pk9zY9KLIzzoSEflbNbqZZqOAhDvlZ1M2AQiKeSMs9W9Vlb2PkChht+6/6nvn
         EyqF/q4qv9p64aifPRYgjUu/gbeMBBCn5UINWeAX1GR69EgKovWTU6IkGKSPBeaAl8e0
         YQlw==
X-Gm-Message-State: AJIora+HsELU3sThnyoXDZDaJzwsuG/oqXowwF7KECoGgukr9nKi6WEj
        46UYmwPPr3Vq1sSHck2CWsgTZA==
X-Google-Smtp-Source: AGRyM1umXjHvfiCigjJ7IRDdLwG4rJDpGBCKgBPKB6XLgieis4LZ9EeDAGrjqpraxW+lvusRBwMHrQ==
X-Received: by 2002:a17:902:eb86:b0:16c:c491:fce7 with SMTP id q6-20020a170902eb8600b0016cc491fce7mr24066423plg.14.1658246319913;
        Tue, 19 Jul 2022 08:58:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a118200b001ef3f85d1aasm14072478pja.9.2022.07.19.08.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:58:39 -0700 (PDT)
Date:   Tue, 19 Jul 2022 08:58:39 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Jul 2022 08:58:37 PDT (-0700)
Subject:     Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
In-Reply-To: <20220718004114.3925745-3-shorne@gmail.com>
CC:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        shorne@gmail.com, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>, guoren@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-um@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     shorne@gmail.com
Message-ID: <mhng-3ae42214-abe0-4fad-9fa9-8f19809fa4d9@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 17 Jul 2022 17:41:14 PDT (-0700), shorne@gmail.com wrote:
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.
>
> Two things to note are:
>
>  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
>    these architectures avoid creating that file and add the definition
>    to asm/pci.h.
>  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>    undefine it after including asm-generic/pci.h.  Why doesn't csky
>    define it?
>  - pci_get_legacy_ide_irq, This function is only used on architectures
>    that support PNP.  It is only maintained for arm64, in other
>    architectures it is removed.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Second note on isa_dma_bridge_buggy, this is set on x86 but it it also set in
> pci/quirks.c.  We discussed limiting it only to x86 though as its a general
> quick triggered by pci ids I think it will be more tricky than we thought so I
> will leave as is.  It might be nice to move it out of asm/dma.h and into
> asm/pci.h though.
>
> Since v2:
>  - Nothing
> Since v1:
>  - Remove definition of pci_get_legacy_ide_irq
>
>  arch/arm64/include/asm/pci.h | 12 +++---------
>  arch/csky/include/asm/pci.h  | 24 ++++--------------------
>  arch/riscv/include/asm/pci.h | 25 +++----------------------
>  arch/um/include/asm/pci.h    | 24 ++----------------------
>  include/asm-generic/pci.h    | 36 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 73 deletions(-)
>  create mode 100644 include/asm-generic/pci.h
>
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b33ca260e3c9..1180e83712f5 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -9,7 +9,6 @@
>  #include <asm/io.h>
>
>  #define PCIBIOS_MIN_IO		0x1000
> -#define PCIBIOS_MIN_MEM		0
>
>  /*
>   * Set to 1 if the kernel should re-assign all PCI bus numbers
> @@ -18,9 +17,6 @@
>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>
>  #define arch_can_pci_mmap_wc() 1
> -#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
> -
> -extern int isa_dma_bridge_buggy;
>
>  #ifdef CONFIG_PCI
>  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> @@ -28,11 +24,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>  	/* no legacy IRQ on arm64 */
>  	return -ENODEV;
>  }
> -
> -static inline int pci_proc_domain(struct pci_bus *bus)
> -{
> -	return 1;
> -}
>  #endif  /* CONFIG_PCI */
>
> +/* Generic PCI */
> +#include <asm-generic/pci.h>
> +
>  #endif  /* __ASM_PCI_H */
> diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
> index ebc765b1f78b..44866c1ad461 100644
> --- a/arch/csky/include/asm/pci.h
> +++ b/arch/csky/include/asm/pci.h
> @@ -9,26 +9,10 @@
>
>  #include <asm/io.h>
>
> -#define PCIBIOS_MIN_IO		0
> -#define PCIBIOS_MIN_MEM		0
> +/* Generic PCI */
> +#include <asm-generic/pci.h>
>
> -/* C-SKY shim does not initialize PCI bus */
> -#define pcibios_assign_all_busses() 1
> -
> -extern int isa_dma_bridge_buggy;
> -
> -#ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQ on csky */
> -	return -ENODEV;
> -}
> -
> -static inline int pci_proc_domain(struct pci_bus *bus)
> -{
> -	/* always show the domain in /proc */
> -	return 1;
> -}
> -#endif  /* CONFIG_PCI */
> +/* csky doesn't use generic pci resource mapping */
> +#undef ARCH_GENERIC_PCI_MMAP_RESOURCE
>
>  #endif  /* __ASM_CSKY_PCI_H */
> diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> index 7fd52a30e605..12ce8150cfb0 100644
> --- a/arch/riscv/include/asm/pci.h
> +++ b/arch/riscv/include/asm/pci.h
> @@ -12,29 +12,7 @@
>
>  #include <asm/io.h>
>
> -#define PCIBIOS_MIN_IO		0
> -#define PCIBIOS_MIN_MEM		0

My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing 
out address 0 to devices").  Do you mind either splitting out the 
arch/riscv bits or having this in via some sort of shared tag?

> -
> -/* RISC-V shim does not initialize PCI bus */
> -#define pcibios_assign_all_busses() 1
> -
> -#define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
> -
> -extern int isa_dma_bridge_buggy;
> -
>  #ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQ on risc-v */
> -	return -ENODEV;
> -}
> -
> -static inline int pci_proc_domain(struct pci_bus *bus)
> -{
> -	/* always show the domain in /proc */
> -	return 1;
> -}
> -
>  #ifdef	CONFIG_NUMA
>
>  static inline int pcibus_to_node(struct pci_bus *bus)
> @@ -50,4 +28,7 @@ static inline int pcibus_to_node(struct pci_bus *bus)
>
>  #endif  /* CONFIG_PCI */
>
> +/* Generic PCI */
> +#include <asm-generic/pci.h>
> +
>  #endif  /* _ASM_RISCV_PCI_H */
> diff --git a/arch/um/include/asm/pci.h b/arch/um/include/asm/pci.h
> index da13fd5519ef..34fe4921b5fa 100644
> --- a/arch/um/include/asm/pci.h
> +++ b/arch/um/include/asm/pci.h
> @@ -4,28 +4,8 @@
>  #include <linux/types.h>
>  #include <asm/io.h>
>
> -#define PCIBIOS_MIN_IO		0
> -#define PCIBIOS_MIN_MEM		0
> -
> -#define pcibios_assign_all_busses() 1
> -
> -extern int isa_dma_bridge_buggy;
> -
> -#ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQs */
> -	return -ENODEV;
> -}
> -#endif
> -
> -#ifdef CONFIG_PCI_DOMAINS
> -static inline int pci_proc_domain(struct pci_bus *bus)
> -{
> -	/* always show the domain in /proc */
> -	return 1;
> -}
> -#endif  /* CONFIG_PCI */
> +/* Generic PCI */
> +#include <asm-generic/pci.h>
>
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>  /*
> diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
> new file mode 100644
> index 000000000000..fbc25741696a
> --- /dev/null
> +++ b/include/asm-generic/pci.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ASM_GENERIC_PCI_H
> +#define __ASM_GENERIC_PCI_H
> +
> +#include <linux/types.h>
> +
> +#ifndef PCIBIOS_MIN_IO
> +#define PCIBIOS_MIN_IO		0
> +#endif
> +
> +#ifndef PCIBIOS_MIN_MEM
> +#define PCIBIOS_MIN_MEM		0
> +#endif
> +
> +#ifndef pcibios_assign_all_busses
> +/* For bootloaders that do not initialize the PCI bus */
> +#define pcibios_assign_all_busses() 1
> +#endif
> +
> +extern int isa_dma_bridge_buggy;
> +
> +/* Enable generic resource mapping code in drivers/pci/ */
> +#define ARCH_GENERIC_PCI_MMAP_RESOURCE
> +
> +#ifdef CONFIG_PCI
> +
> +static inline int pci_proc_domain(struct pci_bus *bus)
> +{
> +	/* always show the domain in /proc */
> +	return 1;
> +}
> +
> +#endif /* CONFIG_PCI */
> +
> +#endif /* __ASM_GENERIC_PCI_H */
