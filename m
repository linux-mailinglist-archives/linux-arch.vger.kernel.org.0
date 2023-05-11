Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51206FF338
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbjEKNmB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 09:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbjEKNlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 09:41:53 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0232700;
        Thu, 11 May 2023 06:41:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 06E522B05DDC;
        Thu, 11 May 2023 09:41:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 11 May 2023 09:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683812462; x=1683819662; bh=bN
        MS+yJaTUyOEJLQDsSJtM7hMQk3rsz9Tjm7dcU5DZg=; b=pbfvNGcEhT5R087tiN
        QnEE33cGWBvS5AiGVm1gu96LmUVgkxF03e4K96Ei9qPwA7fiKdXmlXU35YSty4lV
        upc6nhsgrNKO1Zu5vJdZRzsTYt5+zUsNa1/G1LgbSdyvZAkWWcimIWPpFpGxaLK6
        hH7/y6eKFwClAzo+2pbOB483InnbRNbufNRaxh3CrbmLD7GhYXkCtmotomtbcOHW
        NAkD92i1A1Bqcysq66C1J4W0/8Ffr4tm/CjkCymgi72EioBx6dkJg+rOhYWSOSEQ
        rfFDwhYNZARWUi2ZC5uIDwtU5o7jO6mXg31RmRIKFygPD4lgfPnMU2vHZpWLzWR9
        tY6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683812462; x=1683819662; bh=bNMS+yJaTUyOE
        JLQDsSJtM7hMQk3rsz9Tjm7dcU5DZg=; b=NUVaoKGjAUB1IvBp3dt6JHnnJHLVm
        5FazabUKUOC3zaEmLNyDQKpBgQBJXDhw6415JSYAsI7vcdS5XzphHJbcm+e1RYhU
        llcs9weTW01qk5AxUBbjOtH2kzwx7xePfQXIMcfPmjZGOSYBauaruz9JqW/61W85
        heX8lT7nka5DtfPGfdG7S5QpZIuNTpDxxrHbUPJHanrVYS+a2Xfw0XBnyLyCziCN
        FQo1Pxm5MNwRhnbgYrHcF3+uL/xmCS5YxmDTGoWN77KSYtOLmS5dlADRru9/PWae
        uUp8Kzt4lULTaZjWcoN7X0TwqmJ+FUlxtD2Zae1Lsi2pmq9JY+k/goTzg==
X-ME-Sender: <xms:bfBcZMNSgCzv51ibNqiMadxkekdHAGVmhQZVB7Xg4Ch3ubv8oc_OqQ>
    <xme:bfBcZC-LuOp4qL-OBOPp41xrwYUB7X6JxntaEUrPpvOl-0LjASR1mtr0iBts6oiZU
    CITzOT_9aVK9gzgF74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bfBcZDTVU8Z1aHlCiwHMzI3BQFNOhMCOOgQIyHMelQO9w3lKyBypBg>
    <xmx:bfBcZEvrEazOWER04N0wAeZIGr8U1lNFD45nasK99m4-LBGcCbMMFQ>
    <xmx:bfBcZEdVboxFWTIW74hVqDVfva2XernqNuoZ92ynPmme6ph_Ri3bvw>
    <xmx:bvBcZKe-JadH7ZmJYk5LO7CV-vuIG1KgQLl2SxyA8Qajy4KAMUmi0_Uv4kk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 81468B60089; Thu, 11 May 2023 09:41:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <d27e359c-1ea3-4d08-b124-e794fd372b28@app.fastmail.com>
In-Reply-To: <9c4be198444e9987c826c87b592e9dc6@artur-rojek.eu>
References: <20230510110557.14343-6-tzimmermann@suse.de>
 <202305102136.eMjTSPwH-lkp@intel.com>
 <f6b2d541-d235-4e98-afcc-9137fb8afa35@app.fastmail.com>
 <49684d58-c19d-b147-5e9f-2ac526dd50f0@suse.de>
 <743d2b1e-c843-4fb2-b252-0006be2e2bd8@app.fastmail.com>
 <CAMuHMdVvR1jdbZS8KoMf4R3zhLRWKv9XbG61iBGOGGZPHB+taA@mail.gmail.com>
 <9c4be198444e9987c826c87b592e9dc6@artur-rojek.eu>
Date:   Thu, 11 May 2023 15:40:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Artur Rojek" <contact@artur-rojek.eu>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "kernel test robot" <lkp@intel.com>,
        "Helge Deller" <deller@gmx.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Sam Ravnborg" <sam@ravnborg.org>, suijingfeng@loongson.cn,
        oe-kbuild-all@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 11, 2023, at 15:22, Artur Rojek wrote:
> On 2023-05-11 14:35, Geert Uytterhoeven wrote:
>> 
>> CC Artur, who's working on HP Jornada 680.
> Thanks for CC'ing me - I faced this exact issue while working on my
> (still not upstreamed) hd6446x PCMCIA controller driver. The PCMCIA
> subsystem uses `inb/outb`, which expect the `sh_io_port_base` to be set
> to something else than the default `-1`. At first I tried to set it to
> `0xa0000000`, so that all I/O goes through the fixed, non-cacheable P2
> area. That however broke some other driver code (I had no time to debug
> which one). Eventually I ended up taking a suggestion from a MIPS PCMCIA
> driver [1] and simply substract the broken `sh_io_port_base` address
> from `HD64461_IOBASE`, as the base for `socket.io_offset`. This way all
> the PCMCIA `inb/outb` accesses are absolute, no matter what the
> `sh_io_port_base` is set to. This of course is a very ugly solution and
> we should instead fix the root cause of this mess. I will have a better
> look at this patch set and the problem at hand at a later date.
>
> Cheers,
> Artur
>
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pcmcia/db1xxx_ss.c?h=v6.4-rc1#n527

I think the best fix would be to change all those drivers away
from using inb/outb to readb/writeb, except when they access the
actual PCMCIA I/O space behind the bridge.

On most of the modern architectures, inb(addr) now turns into
approximately readb(PCI_IOBASE + addr), with a bit of extra
logic to deal with endianess and barrier semantics.

PCI_IOBASE in turn tends to be a hardcoded virtual address
to which the physical I/O space window gets mapped during
early boot, though you can also #define it to sh_io_port_base
if you want to allocate the virtual address dynamically and
leave the existing logic unchanged.

Setting sh_io_port_base to zero however is a problem for any
driver that passes a small port number into it -- this then
turns into a user space pointer dereference, which is trivially
exploitable.

     Arnd
