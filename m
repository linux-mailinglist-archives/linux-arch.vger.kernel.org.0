Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA7519CFA
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348179AbiEDKhW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 06:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348156AbiEDKhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 06:37:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E2728E03;
        Wed,  4 May 2022 03:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60A41B82553;
        Wed,  4 May 2022 10:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBB0C385AF;
        Wed,  4 May 2022 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651660421;
        bh=E8CEzIAsWz9Rmvw13XFPv/adMpOwsz2QRxp2bzHQxCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PQWOF9oSgEdn5spCau1vYDvRsS1HHfUeOA4Od05fC00yS0tyyOD+fOLl9QnmqHGQI
         wHYQy7kje5Gg/nEp5ErHjoGmD/b4jW53yav9c/mfgu8szu/WN5+shhYk03/ZrkMCge
         hqJscs8JhQ+E4P1lB+ZZjurxCFvVODHApQETnqTiVDaNHN/rPdujgfo2jZ6GUPlzQc
         Nbar0v79O8QIIN5ZVjJCRaLxKzs20Aw4M4Pidg5HoDxB7CJzo0m3JPhkeMd+3WSEfq
         m7+4Y5Z/fagiwY7a74bR52JdQzPQyGGYz6GaRyoSKxC7w0BowID1Z6upBKXRXBfuZP
         9jSA629Vn2Qyw==
Received: by mail-wm1-f51.google.com with SMTP id q20so604302wmq.1;
        Wed, 04 May 2022 03:33:40 -0700 (PDT)
X-Gm-Message-State: AOAM531WyMQtVWtA2d2Op2gBYAPD2Rt0kOvFMA9+1+iuKW9L5tTCrNhO
        Dq7rYurHeFnXDCjiZ3s3cn6lvtdP4eEcK2bOdKg=
X-Google-Smtp-Source: ABdhPJwOmoNuUoi/jWtPqmt55hkpFmZRUX1rQCTG/MBa1moNMRI9KXGnBtVTPDUY1plM3AGJvlzbvLih0M2ebaRjwPY=
X-Received: by 2002:a7b:cc93:0:b0:394:2622:fcd9 with SMTP id
 p19-20020a7bcc93000000b003942622fcd9mr7398696wma.20.1651660419246; Wed, 04
 May 2022 03:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220429135108.2781579-44-schnelle@linux.ibm.com> <20220503233802.GA420374@bhelgaas>
In-Reply-To: <20220503233802.GA420374@bhelgaas>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 May 2022 12:33:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
Message-ID: <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
Subject: Re: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 4, 2022 at 1:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Apr 29, 2022 at 03:50:41PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. PCMCIA devices are either LEGACY_PCI devices
> > which implies HAS_IOPORT or require HAS_IOPORT.
> >
> > Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/pcmcia/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> > index 2ce261cfff8e..32b5cd324c58 100644
> > --- a/drivers/pcmcia/Kconfig
> > +++ b/drivers/pcmcia/Kconfig
> > @@ -5,7 +5,7 @@
> >
> >  menuconfig PCCARD
> >       tristate "PCCard (PCMCIA/CardBus) support"
> > -     depends on !UML
> > +     depends on HAS_IOPORT
>
> I don't know much about PC Card.  Is there a requirement that these
> devices must use I/O port space?  If so, can you include a spec
> reference in the commit log?

I think for PCMCIA devices, the dependency makes sense because
all device drivers for PCMCIA devices need I/O ports.

For cardbus, we can go either way, I don't see any reference to
I/O ports in yenta_socket.c or the pccard core, so it would build
fine with or without I/O ports.

> I do see the PC Card spec, r8.1, sec 5.5.4.2.2 says:
>
>   All CardBus PC Card adapters must support either memory-mapped I/O
>   or both memory-mapped I/O and I/O space. The selection will depend
>   largely on the system architecture the adapter is intended to be
>   used in. The requirement to also support memory-mapped I/O, if I/O
>   space is supported, is driven by the potential emergence of
>   memory-mapped I/O only cards. Supporting both modes may also
>   position the adapter to be sold into multiple system architectures.
>
> which sounds like I/O space is optional.

An earlier version of the patch series had a separate
CONFIG_LEGACY_PCI that required CONFIG_HAS_IOPORT
here, which I think made this clearer:

Almost all architectures that support CONFIG_PCI also provide
HAS_IOPORT today (at least at compile time, if not at runtime),
with s390 as a notable exception. Any machines that have legacy
PCI device support will also have I/O ports because a lot of
legacy PCI cards used it, and any machine with a pc-card slot
should also support legacy PCI devices.

If we get new architectures without I/O space in the future, they
would certainly not care about supporting old cardbus devices.

        Arnd
