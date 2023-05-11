Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20466FF2BC
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbjEKNZb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbjEKNYZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 09:24:25 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0B11623;
        Thu, 11 May 2023 06:22:26 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id AC3D220007;
        Thu, 11 May 2023 13:22:13 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 11 May 2023 15:22:13 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vineet Gupta <vgupta@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Sam Ravnborg <sam@ravnborg.org>, suijingfeng@loongson.cn,
        oe-kbuild-all@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
In-Reply-To: <CAMuHMdVvR1jdbZS8KoMf4R3zhLRWKv9XbG61iBGOGGZPHB+taA@mail.gmail.com>
References: <20230510110557.14343-6-tzimmermann@suse.de>
 <202305102136.eMjTSPwH-lkp@intel.com>
 <f6b2d541-d235-4e98-afcc-9137fb8afa35@app.fastmail.com>
 <49684d58-c19d-b147-5e9f-2ac526dd50f0@suse.de>
 <743d2b1e-c843-4fb2-b252-0006be2e2bd8@app.fastmail.com>
 <CAMuHMdVvR1jdbZS8KoMf4R3zhLRWKv9XbG61iBGOGGZPHB+taA@mail.gmail.com>
Message-ID: <9c4be198444e9987c826c87b592e9dc6@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-05-11 14:35, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> CC Artur, who's working on HP Jornada 680.
Thanks for CC'ing me - I faced this exact issue while working on my
(still not upstreamed) hd6446x PCMCIA controller driver. The PCMCIA
subsystem uses `inb/outb`, which expect the `sh_io_port_base` to be set
to something else than the default `-1`. At first I tried to set it to
`0xa0000000`, so that all I/O goes through the fixed, non-cacheable P2
area. That however broke some other driver code (I had no time to debug
which one). Eventually I ended up taking a suggestion from a MIPS PCMCIA
driver [1] and simply substract the broken `sh_io_port_base` address
from `HD64461_IOBASE`, as the base for `socket.io_offset`. This way all
the PCMCIA `inb/outb` accesses are absolute, no matter what the
`sh_io_port_base` is set to. This of course is a very ugly solution and
we should instead fix the root cause of this mess. I will have a better
look at this patch set and the problem at hand at a later date.

Cheers,
Artur

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pcmcia/db1xxx_ss.c?h=v6.4-rc1#n527

> 
> On Wed, May 10, 2023 at 5:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, May 10, 2023, at 16:27, Thomas Zimmermann wrote:
>> > Am 10.05.23 um 16:15 schrieb Arnd Bergmann:
>> >> On Wed, May 10, 2023, at 16:03, kernel test robot wrote:
>> 
>> >> I think that's a preexisting bug and I have no idea what the
>> >> correct solution is. Looking for HD64461 shows it being used
>> >> both with inw/outw and readw/writew, so there is no way to have
>> >> the correct type. The sh __raw_readw() definition hides this bug,
>> >> but that is a problem with arch/sh and it probably hides others
>> >> as well.
>> >
>> > The constant HD64461_IOBASE is defined as integer at
>> >
>> >
>> > https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/hd64461.h#L17
>> >
>> > but fb_readw() expects a volatile-void pointer. I guess we could add a
>> > cast somewhere to silence the problem. In the current upstream code,
>> > that appears to be done by sh's __raw_readw() internally:
>> >
>> >
>> > https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/io.h#L35
>> 
>> Sure, that would make it build again, but that still doesn't make the
>> code correct, since it's completely unclear what base address the
>> HD64461_IOBASE is relative to. The hp6xx platform code only passes it
>> through inw()/outw(), which take an offset relative to 
>> sh_io_port_base,
>> but that is not initialized on hp6xx. I tried to find in the history
>> when it broke, apparently that was in 2007 commit 34a780a0afeb ("sh:
>> hp6xx pata_platform support."), which removed the custom inw/outw
>> implementations.
> 
> See also commit 4aafae27d0ce73f8 ("sh: hd64461 tidying."), which
> claims they are no longer needed.
> 
> Don't the I/O port macros just treat the port as an absolute base 
> address
> when sh_io_port_base isn't set?
> 
> Gr{oetje,eeting}s,
> 
>                         Geert


