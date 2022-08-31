Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD25A7FBC
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiHaONu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiHaONe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 10:13:34 -0400
Received: from mail.gnudd.com (mail.gnudd.com [93.91.132.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C23D75A2;
        Wed, 31 Aug 2022 07:13:19 -0700 (PDT)
Received: from dciminaghi by mail.gnudd.com with local (Exim 4.94.2)
        (envelope-from <dciminaghi@arcana.gnudd.com>)
        id 1oTOSL-0004O9-3A; Wed, 31 Aug 2022 16:12:37 +0200
Date:   Wed, 31 Aug 2022 16:12:36 +0200
From:   Davide Ciminaghi <ciminaghi@gnudd.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Courbot <gnurou@gmail.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, Alessandro Rubini <rubini@gnudd.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Message-ID: <Yw9sVCNtaLUjZH/F@arcana.i.gnudd.com>
References: <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
 <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
 <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
 <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu>
 <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
 <515364a9-33a1-fafa-fdce-dc7dbd5bb7fb@csgroup.eu>
 <CAK8P3a36qbRW8hd+1Uhi88kh+-KTjDMT-Zr8Jq9h_G3zQLfzgw@mail.gmail.com>
 <Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com>
 <CACRpkdZeAAZYqV3ccd-X=ZwdnfSwRUdXchGETB-WTkgSZQL=Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CACRpkdZeAAZYqV3ccd-X=ZwdnfSwRUdXchGETB-WTkgSZQL=Pw@mail.gmail.com>
X-Face: #Q;A)@_4.#>0+_%y]7aBr:c"ndLp&#+2?]J;lkse\^)FP^Lr5@O0{)J;'nny4%74.fM'n)M
 >ISCj.KmsL/HTxz!:Ju'pnj'Gz&.
Sender: ciminaghi@gnudd.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 31, 2022 at 03:32:25PM +0200, Linus Walleij wrote:
> On Tue, Aug 30, 2022 at 9:58 AM Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> 
> > the sta2x11 was a chip containing AMBA peripherals and a PCIe to AMBA bridge
> > (it is still in production as far as I know, but deprecated for new designs).
> > It would typically be installed on x86 machines, so you needed to build and
> > run AMBA drivers in an x86 environment. The original drivers we started from
> > had platform data, but then we were told to switch to DTS.
> 
> For the record I think that was bad advice, I hope it wasn't me.
> But the world was different back then I suppose.
> Adding DTS to x86 which is inherently ACPI is not a good idea.
> Especially if you look at how SBSA ACPI UARTS were done
> in drivers/tty/serial/amba-pl011.c.
>
now that I think of it, ACPI was also listed as a possible choice, but the
problem was that we didn't know much about ACPI, and took the DTS way.
So there was no bad advice, just fear of the unknown :-)

Thanks
Davide
