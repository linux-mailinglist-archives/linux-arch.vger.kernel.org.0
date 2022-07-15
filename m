Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA635769D8
	for <lists+linux-arch@lfdr.de>; Sat, 16 Jul 2022 00:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiGOWXO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 18:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiGOWXO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 18:23:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6952661B21;
        Fri, 15 Jul 2022 15:23:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso9071807pjz.0;
        Fri, 15 Jul 2022 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ou4ITJAtDpdEe2oGXNdiIauXOvcSg7DQL0fAZO9cl2U=;
        b=Q8lGAoHw8McxXXPUu9JJi1XBb9QitejFhB3EEwl7pOmObYxg0niuVsgwD5pp+sh+vE
         xuIKedL/WXyDOOgKJBNrsDZftnMo9VkkzEBAU07KrLja6rRFtcHKmFquU9rhG815UU2M
         4qN1XN8OsBzeKfEo5BTfdcSUJQ2BwjYyJuOFMY1ANoellCCLxbAHe55abXJ7Zm6HvfQg
         GKaa2Vtf5KUXirx9wqbsorAJO9z4sV3vRf0YDGd8uZXmu52ax/4hGUDH+Qk3BfTyJPaN
         iAwhnKMbwb+t+CoQOhksE/3VAGMsc4nRaI5nIO7QpJ2agWHS8WCalQSMbeCbYh/XUxGP
         0SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ou4ITJAtDpdEe2oGXNdiIauXOvcSg7DQL0fAZO9cl2U=;
        b=x08JxCvc5rlQ5ZmgNiCzeJKKD0khSHmMG1Linjb+lulR/ekCIW7YI4xU9wcl7EOLRe
         ZoYZOhgg5C+qx7gTsJj88V69d0XVs6VJPUNHrJ/7/A9CaBOedV0MfL/NqbsXVYsW71eY
         lWzI0mcztRxxdWPO1tOuSz2+y4WoPwb2cTMiujnblCyMLQgC/xKs9rox0BVogtXu3YHK
         7uDm/gRC9vYEUeCIpyYyjp+VxfV+sAR6IfKTOZy+ouYamt7fIiuKuEhuu4MtHrZP3IT+
         ibxRZwh1C949nmWbw/dV1qw5qsc53qMd13K71Kc/L4/pJ3QKnXSY9ThDhAnroz2h9rMs
         bUJQ==
X-Gm-Message-State: AJIora84iZb2eVpPtQhjvJK45J+4qhmEx0ku1rges7Ir1S3zMx+nxMdo
        35lS67olAUwwS7rvMJuk64Q=
X-Google-Smtp-Source: AGRyM1tY7KJ/8yKzDhwZuUT2Q/d9pehX12mE0ZjdresU33mAA0lNxgF0E239suZTF5xMlCXXfdaB4Q==
X-Received: by 2002:a17:90b:3e8e:b0:1f0:1ac:5908 with SMTP id rj14-20020a17090b3e8e00b001f001ac5908mr17817321pjb.175.1657923792909;
        Fri, 15 Jul 2022 15:23:12 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id j20-20020a170902759400b00161ccdc172dsm4013893pll.300.2022.07.15.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 15:23:12 -0700 (PDT)
Date:   Sat, 16 Jul 2022 07:23:10 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtHozgXIkpyWHKth@antec>
References: <20220714214657.2402250-1-shorne@gmail.com>
 <20220714214657.2402250-3-shorne@gmail.com>
 <CAK8P3a2_HKMf8nMcSkK1_jyCEHEdzz=YiRmPvN+ACbPTafXJzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2_HKMf8nMcSkK1_jyCEHEdzz=YiRmPvN+ACbPTafXJzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 15, 2022 at 10:09:21AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 14, 2022 at 11:46 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > The asm/pci.h used for many newer architectures share similar
> > definitions.  Move the common parts to asm-generic/pci.h to allow for
> > sharing code.
> 
> This looks very nice, thanks for doing it!
> 
> > Two things to note are:
> >
> >  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
> >    these architectures avoid creating that file and add the definition
> >    to asm/pci.h.
> 
> I would prefer if we could just kill off this variable for non-x86, as it's
> only set to a nonzero value in two implementations that are both
> x86-specific and most of the references are gone. That does not have
> to be part of this series though, if you don't want to address it here, just
> add a comment to the new pci.h file.

I will look at it, maybe in a v3.

> >  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
> >    undefine it after including asm-generic/pci.h.  Why doesn't csky
> >    define it?
> 
> Adding David Woodhouse to Cc, as he introduced this interface. As I
> understand it, this was meant as a replacement for the old
> architecture specific pci_mmap_page_range interface, and is ideally
> used everywhere.
> 
> It's probably something that slipped through the review of csky and
> should have been there.
> 
> As an aside, it seems the pci_mmap_page_range() cleanup was
> left almost complete, with sparc being the only one left after
> David Miller found a problem with the generic code. Not sure if
> this was ever resolved:
> https://lore.kernel.org/lkml/1519887203.622.3.camel@infradead.org/t/#u

I see, I will leave it foe now.

> > +#ifndef PCIBIOS_MIN_IO
> > +#define PCIBIOS_MIN_IO         0
> > +#endif
> > +
> > +#define PCIBIOS_MIN_MEM                0
> 
> We should probably #ifdef both of these for consistency.

OK.

> > +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > +{
> > +       /* no legacy ide irq support */
> > +       return -ENODEV;
> > +}
> 
> And this can just go away now, according to what we found.

Yeah, that will be nice.

-Stafford
