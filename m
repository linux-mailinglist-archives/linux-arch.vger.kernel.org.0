Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E657D65C
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 23:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiGUV6t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiGUV6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 17:58:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E58F936B6;
        Thu, 21 Jul 2022 14:58:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so6528059pjq.4;
        Thu, 21 Jul 2022 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PktSKT1L2O3nGxL2SVwxNXiNfS8ZomkMf08apPvZeCg=;
        b=DJY3jYWEFScuIXxMnaqONdYTGCVVwRulQsGebVz6JYCl1utvdLvXQ94toEx5kGMkZZ
         z1/pEiOFwUNWBrMC7+4ufNAkz0jd7cbHp8Zx0ZkqjXfnzObxdRWZcdzVyVOTA1gGu7Wp
         JmFlPgpXKXjsmdzknKots5Mlaul12c7HuPzlH/glqY7CBGvnUXzOUm/Pn6d996JPp/kd
         n4swd/grc13CTgVSCCDo1KShFnI4Jm/FapFGmE8Z2OWfZZMKtLemGcWh4NS19m7XSq9K
         xCmGPLb+25sN7ef6IEg88SWqFRVXLoHcy1Qc9xBZLqp1omKZJBnUyIg5gJB28vKKwrti
         vv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PktSKT1L2O3nGxL2SVwxNXiNfS8ZomkMf08apPvZeCg=;
        b=QX3ON5P8XnidJ3mqnXmOxCx30psrBgp2f2fHaCVchi4PAvYzaHh7oouU5akT/bHnzz
         CGkMXACMHBAJFnMii1Sk11QDzcANeFkIgAvIVydM+ozIG3XDxxX40Dmd1ysTiM1ZcnJ+
         ZFK9I3RBFuAvOJevR2wxKAToqPNSSHV7C1AwMq8tBdfxhDGVSyKf5krwlfCh13WcreDF
         m4/iseMeKoFM+yN8LsMigP9H8OogUQc2TCVB61Ifgs2Uhbcg5D7NB1SSTrUJ3xcbSIi2
         7nOBowFR+pnGE4lw6TDyRwpviH3ELKFWj1HUWn5VQh6gcmGr1ZHpqaEqJgUEuOBrMlJY
         I+Kg==
X-Gm-Message-State: AJIora+ShTVDGUfTQI3igZk2vlwavHQ3sTo2K0qs/h5q3ntrtiMKnZCv
        cafkeCgX0t7Wg8J0elw5n/s=
X-Google-Smtp-Source: AGRyM1ulFYUkEqFxa2Ru+9pVLJDAQXGuHlUKI/EVz0VkAXFTFzAMfPLdmoEQMlVX34zoyjKglGkluQ==
X-Received: by 2002:a17:902:db02:b0:16c:5568:d740 with SMTP id m2-20020a170902db0200b0016c5568d740mr362437plx.100.1658440725499;
        Thu, 21 Jul 2022 14:58:45 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id b17-20020a170903229100b0016bef6f6903sm2266180plh.72.2022.07.21.14.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:58:44 -0700 (PDT)
Date:   Fri, 22 Jul 2022 06:58:43 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <YtnMEwh3U3Ng9q4a@antec>
References: <20220721134924.596152-5-shorne@gmail.com>
 <20220721173733.GA1731649@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721173733.GA1731649@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 21, 2022 at 12:37:33PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 21, 2022 at 10:49:24PM +0900, Stafford Horne wrote:
> > The asm/pci.h used for many newer architectures share similar
> > definitions.  Move the common parts to asm-generic/pci.h to allow for
> > sharing code.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> > Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Since v4:
> >  - Add reviewed-by
> > 
> >  arch/arm64/include/asm/pci.h | 10 ++--------
> >  arch/csky/include/asm/pci.h  | 17 ++---------------
> >  arch/riscv/include/asm/pci.h | 23 ++++-------------------
> >  arch/um/include/asm/pci.h    | 14 ++------------
> >  include/asm-generic/pci.h    | 32 ++++++++++++++++++++++++++++++++
> >  5 files changed, 42 insertions(+), 54 deletions(-)
> >  create mode 100644 include/asm-generic/pci.h
> 
> > +++ b/include/asm-generic/pci.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __ASM_GENERIC_PCI_H
> > +#define __ASM_GENERIC_PCI_H
> > +
> > +#include <linux/types.h>
> 
> Do we need <linux/types.h> here?  I don't see anything below that
> depends on it.

Thanks, you are right, I think some of the earlier functions may have needed it,
which is why I had it earlier.  But now that we have removed those we should be
able to remove this.

That said, I think some of the architecture includes could also be removed.  On
OpenRISC we are able to get away with only having the global asm-generic/pci.h
so we don't need a wrapper pci.h header at all.

However, I don't have everything setup to build all of those architectures so I
was being a bit conservative to remove headers.  I'll see what I can do in the
next version.

-Stafford

> > +#ifndef PCIBIOS_MIN_IO
> > +#define PCIBIOS_MIN_IO		0
> > +#endif
> > +
> > +#ifndef PCIBIOS_MIN_MEM
> > +#define PCIBIOS_MIN_MEM		0
> > +#endif
> > +
> > +#ifndef pcibios_assign_all_busses
> > +/* For bootloaders that do not initialize the PCI bus */
> > +#define pcibios_assign_all_busses() 1
> > +#endif
> > +
> > +/* Enable generic resource mapping code in drivers/pci/ */
> > +#define ARCH_GENERIC_PCI_MMAP_RESOURCE
> > +
> > +#ifdef CONFIG_PCI_DOMAINS
> > +static inline int pci_proc_domain(struct pci_bus *bus)
> > +{
> > +	/* always show the domain in /proc */
> > +	return 1;
> > +}
> > +#endif /* CONFIG_PCI_DOMAINS */
> > +
> > +#endif /* __ASM_GENERIC_PCI_H */
> > -- 
> > 2.36.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
