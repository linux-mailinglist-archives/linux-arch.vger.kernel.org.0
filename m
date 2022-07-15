Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5C575C83
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiGOHkc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGOHkb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 03:40:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FE1753BE;
        Fri, 15 Jul 2022 00:40:30 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MA7Ss-1oNpiA3254-00BfVX; Fri, 15 Jul 2022 09:40:28 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31cf1adbf92so39648387b3.4;
        Fri, 15 Jul 2022 00:40:27 -0700 (PDT)
X-Gm-Message-State: AJIora/fTKTlEaQ6ForIwp6vaAUn/b1dpffbCpl9ZZp7EW7eVUyBRrY+
        OOlAwzzHtCrJhUczSWFnSA3F0hO+0qnHf0ghyiY=
X-Google-Smtp-Source: AGRyM1uqN7hbJWu1Kc45V1df/TuEhLpRBy0jFrUgJKDcJEoO7ehMJuFR6t3QFdid1eQbrmQCLxECRTpajxA3X2Ob8Ys=
X-Received: by 2002:a81:1e4d:0:b0:31c:86f1:95b1 with SMTP id
 e74-20020a811e4d000000b0031c86f195b1mr14141207ywe.42.1657870826723; Fri, 15
 Jul 2022 00:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220714214657.2402250-1-shorne@gmail.com> <20220714214657.2402250-2-shorne@gmail.com>
 <CAMo8BfKkGRHiFq1vu1ZKkURkUqC+Ee7D42yuKrCeDF+578s9cw@mail.gmail.com>
In-Reply-To: <CAMo8BfKkGRHiFq1vu1ZKkURkUqC+Ee7D42yuKrCeDF+578s9cw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Jul 2022 09:40:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3S5crDdUcO0kAgOLVGYgXnkU9D3uo44Wrcu5LdAWCGoQ@mail.gmail.com>
Message-ID: <CAK8P3a3S5crDdUcO0kAgOLVGYgXnkU9D3uo44Wrcu5LdAWCGoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] asm-generic: Remove pci.h copying code out to architectures
To:     Max Filippov <jcmvbkbc@gmail.com>
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
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
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
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xBt1Buqz4uz21xjgRTcz1sB5ZZm4RpSgjeDdgjcJqTVZpbgGxE9
 nD1Zu4Ge/pN+IeJ5he3jwNMmhWT/KQ3Tih2/6CVgZId1G/PwWsU/qowRmpQOyfQoQmRELAt
 O10L1cjPx95JNrnrugzLqkMFdBASwkg7W3Y7jkVvUZ2Vh4E6XJobZnUTDU1xZGnR6J8Ks3c
 d7BkFYX1WbWfFA63SEFXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:seUnc9f1U8s=:S9bJx32885XPj3UntqciIn
 ryJq6wlXd/INdO3qLpKv+zCWHiUjDZHNmdPUsxhqmWEa6ZmnX3NvQ6MeLIbAd7o+CAlnsafus
 i6abMxSuJr9BGrFHXiAxrKZsCbGYlKWDaeBu0foqLJvV32PORbOHK8cus2vZRSGLElHIF+V47
 pvCZWmjE1I9A4hSILa+lvmBteOWavAMvo4PuzH3bl+SJGR9gYLOWU76tKbbO1ev+0wg1dkfJ5
 jOkbcykeZEbY7bJ4JT3Kz8xo4oc93rUUELLafzbIWwCdOln8ovo4DIlrFkLawnUqdn41KTZta
 cFPNuJW3CvbABFv8dsogeL7fN12yN4Kkgw/TPHMIVVrBBmhxRo0d/TZTJqcrs1biQHTOUG9dZ
 qm+D02lYx5lTen6fDRIlPt2K7ob7TKdEOzBhR0v+/91FZZCGY1t0MD4mUaXTa9CzdnE2MxJ8B
 YJWBF61C1YkdlKt1pVua25I1BXCzAFjCn1PjGmdBbGS2LFNTnqOikH1V0oxOf7zRDz/IXOjuH
 czUNZlrKFoEKu4X0Ui99YyM0CqG3o2h7CmsLh1sdC9NmN7r2Fokzucsn4it15JPSVSY5SFGUP
 LRyKGnUfuYWNKhpkJLqEINJ9de8p6aWvBjdfBllf+cZ/FJujV62i2d1HUj9UYmqlUhyJq1Rsi
 itoNBMjEm6QsNefBh/wXaPPABqzFahvNiJ0qTDow2Ei7rKvAlSkA49IX1DnPzE6GLN82Y9oEs
 F4pvQjtLbS4jo0FS7R2xfwsOEXeIZ/mXlHNC6LHMWI+lBUgpWEfJ4GktmCkEXYZyYI3np/PBw
 BqfiRAVc9YXGgJDvTumU2YsGpgrAOXJcSE+XeecOUGLMAlQo51d20sGA78I9SDjWn1YQgsyBM
 UBE4CRWuJ9+H8oksXb0w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 15, 2022 at 3:45 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Thu, Jul 14, 2022 at 2:47 PM Stafford Horne <shorne@gmail.com> wrote:
>
> > +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > +{
> > +       return channel ? 15 : 14;
> > +}
>
> This addition does not make sense for the xtensa as it isn't even possible
> to enable PNP support (the only user of this function) on xtensa.

Nice catch! I had looked at this function earlier and only tried to infer
which architectures might have this based on who has those interrupt
numbers reserved for ISA devices, but looking at CONFIG_PNP is clearly
better here.

PNP depends on "ISA || ACPI", and this already rules out most
architectures. The remaining ones are:

* x86, ia64, alpha: These clearly use PNP based on-board devices on
   common machines, and use PC-style interrupts

* arm64, loongarch: These select PNP when ACPI is enabled. I don't
   think they actually use PNP, but for the moment the function needs to
  be defined, probably returning 0. Loongarch still lacks PCI support
  though, so asm/pci.h is not yet there.

* arm, mips, powerpc: Only a few older machines in each of these
  support ISA devices, and the function is probably machine specific.
  These all have a custom pci.h already and don't use the asm-generic
  version.

* m68k: there are two that enable CONFIG_ISA and one that enables
  CONFIG_PCI, but nothing that has both, so we don't need this
  function.

In summary, I think only x86 actually uses this function, and it is
correct there, everything else either has its own implementation
or does not need it, so the existing asm-generic/pci.h file can
just be folded into the x86 asm/pci.h. That is a great cleanup.

        Arnd
