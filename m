Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928DE5A5FC0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiH3Jrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiH3Jru (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 05:47:50 -0400
X-Greylist: delayed 1796 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 02:47:49 PDT
Received: from mail.gnudd.com (mail.gnudd.com [93.91.132.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4A4A83F
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 02:47:49 -0700 (PDT)
Received: from dciminaghi by mail.gnudd.com with local (Exim 4.94.2)
        (envelope-from <dciminaghi@arcana.gnudd.com>)
        id 1oSw8m-0002Aa-Tn; Tue, 30 Aug 2022 09:58:32 +0200
Date:   Tue, 30 Aug 2022 09:58:32 +0200
From:   Davide Ciminaghi <ciminaghi@gnudd.com>
Sender: ciminaghi@gnudd.com
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com>
References: <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
 <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
 <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
 <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu>
 <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
 <515364a9-33a1-fafa-fdce-dc7dbd5bb7fb@csgroup.eu>
 <CAK8P3a36qbRW8hd+1Uhi88kh+-KTjDMT-Zr8Jq9h_G3zQLfzgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAK8P3a36qbRW8hd+1Uhi88kh+-KTjDMT-Zr8Jq9h_G3zQLfzgw@mail.gmail.com>
X-Face: #Q;A)@_4.#>0+_%y]7aBr:c"ndLp&#+2?]J;lkse\^)FP^Lr5@O0{)J;'nny4%74.fM'n)M
 >ISCj.KmsL/HTxz!:Ju'pnj'Gz&.
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


tl;dr: sta2x11 support can be removed.

On Sun, Aug 28, 2022 at 12:04:29PM +0200, Arnd Bergmann wrote:
> On Sun, Aug 28, 2022 at 11:06 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> > Le 26/08/2022 ?? 23:54, Linus Walleij a ??crit :

....

>
> I think that just means the code that one would have to modify
> is in vendor kernels of devices using this chip, but there is no
> way to fix those if they are not in mainline. The last meaningful
> patches on this SoC support were in 2012 by  Davide Ciminaghi
> and Alessandro Rubini, though they still Acked patches after that.
> 
> I wonder if I was missing the interesting bit about it, if the driver
> is just obsolete and can be removed, or if there is something
> that is still worth fixing here.
>
Hi,

the sta2x11 was a chip containing AMBA peripherals and a PCIe to AMBA bridge
(it is still in production as far as I know, but deprecated for new designs).
It would typically be installed on x86 machines, so you needed to build and
run AMBA drivers in an x86 environment. The original drivers we started from
had platform data, but then we were told to switch to DTS.

Device trees, though, were not very common under x86 at the time and,
perhaps most important, we had a bunch of amba peripherals "behind" a
pci bus, which is a dynamic thing. Our idea was to build a device
tree at runtime (in user space) and then booting a second kernel via
kexec with the correct DTB, but this was not a complete solution.
For instance we needed to patch the device tree at runtime to
take dynamically assigned IRQ numbers into account.
Also the clocks tree had to be dynamically instantiated, once for each sta2x11
chip. Finally, there were some problems allocating dma buffers because
the AMBA side of the bridge could only reach some ranges of physical
addresses.

We had a more or less working prototype, and you may want to have a look
at some of our work:

https://lore.kernel.org/lkml/5202C655.6050609@zytor.com/t/

Nevertheless the upstreaming effort was eventually too big for Alessandro
and myself.
So the sta2x11 drivers upstreaming project has been abandoned (even though
I like to think of it as one of the funniest failures of my life).
Sta2x11 related drivers can of course be removed.


Thanks and regards
Davide
