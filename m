Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D636D577DBF
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jul 2022 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiGRIk5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jul 2022 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiGRIk4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2022 04:40:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38605643D;
        Mon, 18 Jul 2022 01:40:55 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MzyAy-1nHnbX127a-00wzfO; Mon, 18 Jul 2022 10:40:53 +0200
Received: by mail-yb1-f175.google.com with SMTP id 7so2009864ybw.0;
        Mon, 18 Jul 2022 01:40:52 -0700 (PDT)
X-Gm-Message-State: AJIora8X1Aam3ySj99TD9MY7dEOrlzAcfoHZSziEomsOrAjSbgLG0eR3
        v3RZQoiFJulLqzogfBppia/njAD+HIPZjpj74D0=
X-Google-Smtp-Source: AGRyM1v6P9bRfP0SGacMoyNgstO+0kAXXfpT0DxcKtXM2lnDi5JkTyHnmtvpqCyUYAbfe++I5HITDjFfLLAjFIN9yoU=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr25927260ybq.472.1658133650969; Mon, 18
 Jul 2022 01:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220717033453.2896843-1-shorne@gmail.com> <20220717033453.2896843-2-shorne@gmail.com>
 <YtTif+vNq+gkfqsc@infradead.org>
In-Reply-To: <YtTif+vNq+gkfqsc@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jul 2022 10:40:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a02R651U9Md8DHT33FgSp56Baiw4sNCWCFBPcMi0bB1-g@mail.gmail.com>
Message-ID: <CAK8P3a02R651U9Md8DHT33FgSp56Baiw4sNCWCFBPcMi0bB1-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] asm-generic: Remove pci.h copying remaining code
 to x86
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VA+ADZ1wlySE9Ouh2tYgU0A8V4oQDK6lPEeoN9EGdoubUZTOHeD
 mP3qZxOOrOyzBXf7VEeKAez7oCwQjAB7mSIfnIdxmzayc77FlghLUKmImGs2Qi7jkpQ46Sx
 mlXcKYCf770vn2MC/YUeoNNcpJouPP015V2R2VQElZ6j9Mh5zlTdp7VdWlCdhtq5X1IxSN4
 Vo23t32Imfrki/PvPbzsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4b3jq7bjLLE=:a6qWrjWnERxR/3JaIClND/
 DeiDquV6H8SJWHIaREUVCNILb2747FAmBq4hAwESAA8dFrq8z+X3wOvj9jvRGJIZPAFoFQqa+
 1CGLsM/kx1ZAe97kLjHsfnabr0C3IGizgzLpu8HtdbJGSmKxN+km8B1G0d/NdxP0xrjwDdyB0
 LbEZ/8NkMTReY0kzowLf1LutJ+ECbNyuUsQRC04RJchI9Ezxp3oPUs5AltUscC6wjNg+n4zDc
 lE4tZ3kwy+WVvQjqfV/ScuT277jRzNyjU26FycqDC6jGCq/yp0Sxk7wFwhHYoSz1J4YBP37OA
 H3TVEaSFYEp0BGS8F6wnkG2Xb+qrPxdBJvr7Y4J8XLEiISkKR/lrWtdDyG/HIksfIscUG/zKj
 jS7Q2ChLj2XGo2Pbmk2DHR87gfoysZgStaEjymog1xDKEfpgVL1ft71+i+G8pQvHDzC2c4UwY
 UUOC3FkL7RxJBsxEQ+SoirTqVXh8CA7RTmxZUIQrk2hc8xL9b67lMJ8N78U9Ogk8DzrAzaLk0
 5OR7JIeoGBsFy2YOiJ321GR04ymgZ846JuKqac+ha58viPaHnohhZhGlGV/D205LOJurQo6g6
 6wxILAg/bldYxAI3UeRoKKemhZ221RQ8J7fDPCIUH/orpvq3O4Halu/OAiHsnMOC8kmF3fJ9R
 JcZqLRpkowdRcOw7voZhpFbAoSxdwWFKovPN1BZmFXaoi4wB+PGe6W66tFttvCeNXsNDZJ0SR
 cZzf7hR0bkQfwBo6G//PlVEy0sp+ltYv1eVHE36fxEm6tZjW2RpxzIvfyIo6Xh0rKcaelbg+N
 skhOpesKt88SkWklSTgAXKVpaOdJ0/zs3bBkbHWvVJARJweqXTY4hsrAlGgwdBGP9PVPTyWlL
 h2q7+CBWav3EOUiTQMlYzaeCWF4I4m4y7AmXMuE3Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 18, 2022 at 6:33 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Jul 17, 2022 at 12:34:52PM +0900, Stafford Horne wrote:
> > The generic pci.h header now only provides a definition of
> > pci_get_legacy_ide_irq which is used by architectures that support PNP.
> > Of the architectures that use asm-generic/pci.h this is only x86.
>
> Please move this into a separate header, ike legacy-ide.h.  It doens't
> have anyting to do with actual PCI support.

It looks like asm/libata-portmap.h is meant to have this information already,
and this is what libata uses, while drivers/ide used the
pci_get_legacy_ide_irq()
function for the same purpose.

Only ia64 and powerpc have interesting definitions of both, and they
return the same thing, so I think this is sufficient to remove the last caller:

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 2fa0f7d55259..d7a6250589d6 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -16,7 +16,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/irq.h>
-#include <linux/pci.h>
+#include <linux/libata.h>
 #include <linux/ioport.h>
 #include <linux/init.h>

@@ -322,8 +322,8 @@ static int pci_dev_uses_irq(struct pnp_dev *pnp,
struct pci_dev *pci,
                 * treat the compatibility IRQs as busy.
                 */
                if ((progif & 0x5) != 0x5)
-                       if (pci_get_legacy_ide_irq(pci, 0) == irq ||
-                           pci_get_legacy_ide_irq(pci, 1) == irq) {
+                       if (ATA_PRIMARY_IRQ(pci) == irq ||
+                           ATA_SECONDARY_IRQ(pci) == irq) {
                                pnp_dbg(&pnp->dev, "  legacy IDE device %s "
                                        "using irq %d\n", pci_name(pci), irq);
                                return 1;

This is fine on the architectures that currently return an error from
pci_get_legacy_ide_irq() but will change to returning 15/14 instead,
because they do not support ISA devices, so pci_dev_uses_irq()
will never be called either.

        Arnd
