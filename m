Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB157D2A4
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 19:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiGURhn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGURhl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 13:37:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3C1AF01;
        Thu, 21 Jul 2022 10:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CBE9B82606;
        Thu, 21 Jul 2022 17:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7EEC341C6;
        Thu, 21 Jul 2022 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658425055;
        bh=2AWWnE4tIrpJ8SBcVy69tEqxyINDzFIjNPSFonICTzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YlgQcJcxhim+W1ssq5nFy9NNdDXmnUR3+Fu3aU2VsxEi88lU0u99Pl8k9aQIhb7le
         lHSWW87lwcSMrSMVWEzXOAI73VPC+hzhbluy0iofuobXEShdi4FkBi37ESFcbF9ywC
         IIIywpkDc9UmSWImxOqrB10k9vMhDtylfqJfnNvdE/RifTHHZenoLcS2PlB5yeQxQk
         UtRxmmvJ5ynXbzI1EfKgwa4k+5IX5/5rMD+KQhtMhDFNMN98whd1A3m6XufrgNvKWG
         LYZJhLfCXnnCRitqdQFVyQN2e1Yska1TPVoFWQlyIpWJ2+XW38ZQeNxkEAdLzBfA6V
         62z9Hrd/awSMA==
Date:   Thu, 21 Jul 2022 12:37:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 4/4] asm-generic: Add new pci.h and use it
Message-ID: <20220721173733.GA1731649@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721134924.596152-5-shorne@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 21, 2022 at 10:49:24PM +0900, Stafford Horne wrote:
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Since v4:
>  - Add reviewed-by
> 
>  arch/arm64/include/asm/pci.h | 10 ++--------
>  arch/csky/include/asm/pci.h  | 17 ++---------------
>  arch/riscv/include/asm/pci.h | 23 ++++-------------------
>  arch/um/include/asm/pci.h    | 14 ++------------
>  include/asm-generic/pci.h    | 32 ++++++++++++++++++++++++++++++++
>  5 files changed, 42 insertions(+), 54 deletions(-)
>  create mode 100644 include/asm-generic/pci.h

> +++ b/include/asm-generic/pci.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ASM_GENERIC_PCI_H
> +#define __ASM_GENERIC_PCI_H
> +
> +#include <linux/types.h>

Do we need <linux/types.h> here?  I don't see anything below that
depends on it.

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
> +/* Enable generic resource mapping code in drivers/pci/ */
> +#define ARCH_GENERIC_PCI_MMAP_RESOURCE
> +
> +#ifdef CONFIG_PCI_DOMAINS
> +static inline int pci_proc_domain(struct pci_bus *bus)
> +{
> +	/* always show the domain in /proc */
> +	return 1;
> +}
> +#endif /* CONFIG_PCI_DOMAINS */
> +
> +#endif /* __ASM_GENERIC_PCI_H */
> -- 
> 2.36.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
