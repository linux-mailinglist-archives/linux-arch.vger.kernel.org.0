Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF82658563F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jul 2022 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiG2Uol (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jul 2022 16:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiG2Uok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jul 2022 16:44:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6705787354;
        Fri, 29 Jul 2022 13:44:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso135436pjl.4;
        Fri, 29 Jul 2022 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e89Wjmz1E02x+mbLAXuK5dyaUraaaSSIEBZ/XVsTGx4=;
        b=iLZ8zcAPfvhV4PdQqR0qLBC3CQoeysv5ya+fZ9yhvisSnviDKW79RUBsWwHF/bDjMd
         wHCYDspEpBXGQP8qbnPN3b5xfD28/aYy+fcqlB/PLVCech5fcG/URGXZkPhiOB+5Cawt
         bS/ABWZ9aqi2MrJL09X28ts+AyV4REziZtb4VvibKA1K7STeVApdO7KZKAmArnrZ73O8
         oAy5AF47owRU4e/OaYH5kIXGepOcaXfQtw61+ysN/j2dLzbDQrbXX8wFEL8p0yP9lYtT
         qATTkqGamIC+gcGsQGf3ZkFFp2VJHM7vfTCv0bJEn2YS+tUnSgsLqIbix+NupG0lughW
         SXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e89Wjmz1E02x+mbLAXuK5dyaUraaaSSIEBZ/XVsTGx4=;
        b=lVotUAJSkKumPOoOzFwzXlqQ1YbWhgIJDrWPmi46v8A619Bug4dN5awpw0a5GK0x76
         a6ZcRtl7QSLoQjLZg/kUWhQgIPAv/yi1iqrdtOU9J37pWS4e93nEvJHr9FvbPTCBZGz2
         UKEZbFfkiOKRV9HYwHyzMOMHwEi1+Pi6KjpYNm2LqBbaeBuVd7jEJmYq1jdRiIL0fHGP
         KTdfmyJniTBsBgLYmKCqm/rBSRaDDjdhtoVV+IqkPDFnwsVfmUcY1ZgiqZUG25n/aCMk
         A+gQesHgKOFnrCe6TNd6w96JvbFdb8S+hAJ7NHvs73XeSfJFrT0MxAnXFDT716eUda9g
         Uk6A==
X-Gm-Message-State: ACgBeo2zHEuHYJL/oQA4LuXyg+lnLoZf0kcW2Z636rPEl+hm9sDozKgc
        Rgvy6LlUZpVQOWiCktiaziQ=
X-Google-Smtp-Source: AA6agR4kFZdb2p8EU7pRLrriO5e1OGhHX8cNS6JOktqJdFFsq42qBQC9PXZR0EYNv1iKlzH/1x4CMA==
X-Received: by 2002:a17:90b:1d01:b0:1f2:104:6424 with SMTP id on1-20020a17090b1d0100b001f201046424mr5835111pjb.101.1659127478299;
        Fri, 29 Jul 2022 13:44:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709027e8c00b0016daa51c9b5sm4040820pla.61.2022.07.29.13.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:44:38 -0700 (PDT)
Date:   Sat, 30 Jul 2022 05:44:36 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
Message-ID: <YuRGtBef7KMTqg0i@antec>
References: <20220722212248.802500-1-shorne@gmail.com>
 <20220729170449.GA463615@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729170449.GA463615@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 29, 2022 at 12:04:49PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 23, 2022 at 06:22:48AM +0900, Stafford Horne wrote:
> > When building OpenRISC PCI which has no ioport_map we get the following build
> > error.
> > 
> >     lib/pci_iomap.c: In function 'pci_iomap_range':
> >       CC      drivers/i2c/i2c-core-base.o
> >     ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
> >        29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
> >           |                                         ^~~~~~~~~~
> >     lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
> >        44 |                 return __pci_ioport_map(dev, start, len);
> >           |                        ^~~~~~~~~~~~~~~~
> > 
> > This patch adds a NULL definition of __pci_ioport_map for architetures
> > which do not support ioport_map.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Appended to my pci/header-cleanup-immutable branch for v5.20, thanks!

Thanks, I did have this in the PCI series on my OpenRISC fot-next branch.  I
will just rebase that on the pci/header-cleanup-immutable branch to avoid having
the patch there two times.

Also, your updated subject on the commit is much better.

-Stafford

> > ---
> > The Kconfig I am using to test this is here:
> >   https://github.com/stffrdhrn/linux/commits/or1k-virt-4
> > 
> >  include/asm-generic/pci_iomap.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> > index 5a2f9bf53384..8fbb0a55545d 100644
> > --- a/include/asm-generic/pci_iomap.h
> > +++ b/include/asm-generic/pci_iomap.h
> > @@ -25,6 +25,8 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
> >  #ifdef CONFIG_NO_GENERIC_PCI_IOPORT_MAP
> >  extern void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
> >  				      unsigned int nr);
> > +#elif !defined(CONFIG_HAS_IOPORT_MAP)
> > +#define __pci_ioport_map(dev, port, nr) NULL
> >  #else
> >  #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
> >  #endif
> > -- 
> > 2.36.1
> > 
