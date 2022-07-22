Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC83C57E7AA
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 21:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiGVTz0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 15:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGVTz0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 15:55:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA021252;
        Fri, 22 Jul 2022 12:55:22 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mg6mM-1nZttn0Psc-00hcEN; Fri, 22 Jul 2022 21:55:21 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31e7055a61dso58108187b3.11;
        Fri, 22 Jul 2022 12:55:20 -0700 (PDT)
X-Gm-Message-State: AJIora/cAMhWTVJkIEDv24U5sMiKCvz1AxLinDg9sI5wyE15NzJd0ynp
        DL+cE5i/1KKgQ/7+nKeMHR9l3129FrR2shCCjcs=
X-Google-Smtp-Source: AGRyM1uXuwQnOqTAc2eAgULJ3gnB6/3HxjqG6YsVYm4rwIeb3o/ICJSu11fKuAtGWX5g0pRwxfQ7v0EfBH0rTQPFdhs=
X-Received: by 2002:a0d:cec1:0:b0:31e:590c:c6e4 with SMTP id
 q184-20020a0dcec1000000b0031e590cc6e4mr1302476ywd.42.1658519719648; Fri, 22
 Jul 2022 12:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
 <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014> <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
In-Reply-To: <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jul 2022 21:55:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
Message-ID: <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
To:     Rob Herring <robh@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Stafford Horne <shorne@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:O3tm97ktOQsIdtuCJXuJ3uCcUUlhuoEFWT3e4rEfl0Fg6Zixcm2
 7S8otfg3urwov4ASLkqF0fyWwSzET/3VewEfYR0qJTsRdLkJe9KOmhptWAlt4E8VVWsVAKY
 VMDKLzLTDPZfEavzbXmAeHZaJgFpgxlMmZQWF8qkGaxv5sy31BO0q4p0V6pDgzaIP+8yHxw
 jtCUd9MEEok91XBkCvc6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:36iDOpIY/Hs=:2vXnQwsiyWLk/bjZ/223V9
 SsohMBwjwbwuUNsHbt33nFvPoMV7gNjldqAuP3jrDfIGZPupYhIFn+JVCTGiH2XiYismwygaS
 TlcO/t2LpWvz4pBoF7KSkWqOdjkBmj5+ee3hDV12DqqUnAalwDv7oLiqOMi7T1BfnK/aVaNDp
 GhjU/voDray/WpQbAvbe2eQKkp0C1ZBekdVA8NF3mXT3gF0nDNDft+4rsiGQrSi9Hqgfcyic8
 jUhzy2ejGQ/yGOGXWPHuQH14z9CbMeWqcoEi85A7v8zCQuPK8pYL1hMyqP4M1E76o5RbqZeRU
 okavhF4ho+8ACS0Ls+i0eVO9QJfF3OntboEaGeUtc6P3LmfRDsioJxXVEZxliJsQmkSE4pWoc
 6UBmHgqwS8wFUiqIslW8LTQixsH2r51+U0rlDeeI2g3DFN8Kv8RdtfysxZlAfdWBTtv7e395t
 lZA6dir31couJtwrzx8aWP+6qzONW45QIAoVqN3byAyEpln0ADJLeDWF0RxTUvPv7wvQftE4r
 PA4M07JmuAeE3OSOxyYDF/8PmH9YMqcQslsM0JYROmAHBftj3RmBo4vdZoCOcGZL+vl/2X/T5
 nqZyPDJ11MC3mlTp8BS5Q/f7eCy8TPb9JY/MfFLE2RK5PsunWF2F9w2wszn5x8ehTnCN7t5Qe
 wMSrRKIR16+4lpCCri88tssHwCkS+XkI6qsE5ji+YBrBXav6LqamoCYpUH7IDoeIs/HTRMl1h
 bwRVw7MKNOWgMLHaMjK+aidULTZI/40GY0UE6A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 22, 2022 at 6:36 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 22, 2022 at 9:27 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From fu740:
>                        ranges = <0x81000000  0x0 0x60080000  0x0
> 0x60080000 0x0 0x10000>,      /* I/O */
...
> So again, how does one get a 0 address handed out when that's not even
> a valid region according to DT? Is there some legacy stuff that
> ignores the bridge windows?

The PCI-side port number 0x60080000 gets turned into Linux I/O resource 0,
which I think is what __pci_assign_resource operates on.

The other question is why the platform would want to configure the
PCI bus to have a PCI I/O space window of size 0x10000 at the address
it's mapped into, rather than putting it at address zero. Is this a hardware
bug, a bootloader bug, or just badly set up in the DT?

Putting the PCI address of the I/O space window at port 0 is usually
better because it works with PCI devices and drivers that assume that
port numbers are below 0xfffff, and makes the PCI port number match
the Linux port number.

         Arnd
