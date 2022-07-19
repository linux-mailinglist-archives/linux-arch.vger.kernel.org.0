Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69385797EC
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiGSKvt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 06:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiGSKvs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 06:51:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E9371B1;
        Tue, 19 Jul 2022 03:51:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y15so6881851plp.10;
        Tue, 19 Jul 2022 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9r5Q68sSonSuFNnUgS5s5Aq4lQPVRc3ftjUkjt5E+/U=;
        b=BOnJQHOrKNukFMXMC1nU6y4ArvL3vrbcOB435U/Vzx1k1fn6r436k543OFDgaWokoN
         tDErjZCkEJHwVO1H9RQMX6lk34fHev+Aj5/gKGFjtSnH8f4W9B86s0nsqJfg9JeN8ml2
         JpIehp+Baf/hC0iEenp4Vlpui6EBPFyHuw5pyeahpcXpOlX6hXba88BFS6CklcADGLsD
         uF4jiHQM1YmdN8VkpQPyWmk/8xJ0QlGm1a4CTd/3gGsmLRaK9WiL+TrM3sZCWwiys/37
         kJ3jZOnmNy/5GCMbwcqkClcv2x5+kayzRqwLIi+9L4ewDsXPITUTBKitxHlTC+mUPCTq
         HiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9r5Q68sSonSuFNnUgS5s5Aq4lQPVRc3ftjUkjt5E+/U=;
        b=LPsDP8XJBZ6ZK9N1ajE4Vj30okuZZfWMtbEkaaS16BZQvZWzxzWBtLg99TcJK0keNB
         kCC/h2FHh1VqTABv/nRUDKPoND6hklQslHcXeZH/psN8Wa6V62BXNv8cACJ1L6azOkov
         StgCs5mLtcAXWUxDvtJkSJoH/PJZ2oflVRJ78LBsH2nhbrI4eM5ja7p2pCYa5HlUDsAw
         XnahBTph8fFho7/VgDl5CTFUUi/QBnCDXjgcgOhdtf26dvTA6lWdfgqWyS8FduTsSDcN
         SehIEbjScym1ph0+bgUO4mTgSaM6Z+Rla8xm0SQgsqmv60TbMtM85A4H6vPAhl/jaLtb
         YTIQ==
X-Gm-Message-State: AJIora/958TaYEQsanx3r7zXYskZTgNYgZRgrba+OA4HTRv7RQePpWwS
        w+/vVtodIiSq79McmrqG19M=
X-Google-Smtp-Source: AGRyM1vZ9IAj9wB2om7mrxhh/fUk9aNQMH63dmua/3Emg6xcerZ0EDmPY1xKNwyujRSIvj70HenApQ==
X-Received: by 2002:a17:90b:3e89:b0:1f0:4233:b20e with SMTP id rj9-20020a17090b3e8900b001f04233b20emr37808145pjb.0.1658227905897;
        Tue, 19 Jul 2022 03:51:45 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x23-20020a1709027c1700b001696751796asm11299184pll.139.2022.07.19.03.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 03:51:45 -0700 (PDT)
Date:   Tue, 19 Jul 2022 19:51:43 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Child <nick.child@ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] asm-generic: Remove pci.h copying remaining code
 to x86
Message-ID: <YtaMv2kfdxFyDsis@antec>
References: <20220717033453.2896843-1-shorne@gmail.com>
 <20220717033453.2896843-2-shorne@gmail.com>
 <YtTif+vNq+gkfqsc@infradead.org>
 <CAK8P3a02R651U9Md8DHT33FgSp56Baiw4sNCWCFBPcMi0bB1-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a02R651U9Md8DHT33FgSp56Baiw4sNCWCFBPcMi0bB1-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 18, 2022 at 10:40:34AM +0200, Arnd Bergmann wrote:
> On Mon, Jul 18, 2022 at 6:33 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sun, Jul 17, 2022 at 12:34:52PM +0900, Stafford Horne wrote:
> > > The generic pci.h header now only provides a definition of
> > > pci_get_legacy_ide_irq which is used by architectures that support PNP.
> > > Of the architectures that use asm-generic/pci.h this is only x86.
> >
> > Please move this into a separate header, ike legacy-ide.h.  It doens't
> > have anyting to do with actual PCI support.
> 
> It looks like asm/libata-portmap.h is meant to have this information already,
> and this is what libata uses, while drivers/ide used the
> pci_get_legacy_ide_irq()
> function for the same purpose.
> 
> Only ia64 and powerpc have interesting definitions of both, and they
> return the same thing, so I think this is sufficient to remove the last caller:
> 
> diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
> index 2fa0f7d55259..d7a6250589d6 100644
> --- a/drivers/pnp/resource.c
> +++ b/drivers/pnp/resource.c
> @@ -16,7 +16,7 @@
>  #include <asm/io.h>
>  #include <asm/dma.h>
>  #include <asm/irq.h>
> -#include <linux/pci.h>
> +#include <linux/libata.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> 
> @@ -322,8 +322,8 @@ static int pci_dev_uses_irq(struct pnp_dev *pnp,
> struct pci_dev *pci,
>                  * treat the compatibility IRQs as busy.
>                  */
>                 if ((progif & 0x5) != 0x5)
> -                       if (pci_get_legacy_ide_irq(pci, 0) == irq ||
> -                           pci_get_legacy_ide_irq(pci, 1) == irq) {
> +                       if (ATA_PRIMARY_IRQ(pci) == irq ||
> +                           ATA_SECONDARY_IRQ(pci) == irq) {
>                                 pnp_dbg(&pnp->dev, "  legacy IDE device %s "
>                                         "using irq %d\n", pci_name(pci), irq);
>                                 return 1;
> 
> This is fine on the architectures that currently return an error from
> pci_get_legacy_ide_irq() but will change to returning 15/14 instead,
> because they do not support ISA devices, so pci_dev_uses_irq()
> will never be called either.

I like this, I didn't know about the ATA_PRIMARY_IRQ/ATA_SECONDARY_IRQ macro.
Let me add this to the series before 1/2.  I will keep you as the author via
Signed-off-by annotation.

-Stafford
