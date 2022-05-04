Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DCD51A1CB
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbiEDOLG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344973AbiEDOLE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 10:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBB541338;
        Wed,  4 May 2022 07:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6890461A35;
        Wed,  4 May 2022 14:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14A1C385A4;
        Wed,  4 May 2022 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651673247;
        bh=AOzP1mjGIKqKOsNlo9BHb/hKxiRMov98HMlUP91rW/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QFkrSmgCkKXjqTPEq4kQlT0ktmBYcUZhWXaNTU/xLrJiMFoy3ekEvJ76ZybZitrbT
         NgRYx3J2l+pWcvJHZN58Q3tlp7gXbafjbBeGHoY88sZ8VKL1H1qA4bVMMgdf+AtkAF
         ZIGp2V58aIKQyKmpuIXfbUPMTDLkNzL+QfKxkr08XcEVMAT4VwdM73l8HAjN97MPcc
         4oEzXkI7lCXLc4Vu4LNIBC9qQ+wxT7crzjS0TbrwArlun6Px6QbG0EoqNFoNWm59XO
         mB+Q7vkxkSyDoRSX40CorQVysexK45CIzoRJNlKvH1zObWQr0j4dX9eSoaNZVlspNq
         HOfc7g1HcUzyQ==
Received: by mail-wr1-f43.google.com with SMTP id d5so2181986wrb.6;
        Wed, 04 May 2022 07:07:27 -0700 (PDT)
X-Gm-Message-State: AOAM533lI/2iybd3pb0fmsY0ib2ml2cLZqRCy1nFu8hoFrgtSI6ZSn1B
        Vw63GiMgW8xJ4VOV7S5gz/mPbwsD88MKQGGI968=
X-Google-Smtp-Source: ABdhPJyBvuzUVHauiOOhlgsX/356BcYJrvgYX24D9gTDq9FHSvu8LBFLLUOrs+/KZcEXVCs6uf2aemiYa3pCuILeHqY=
X-Received: by 2002:a5d:49cb:0:b0:20a:cee3:54fc with SMTP id
 t11-20020a5d49cb000000b0020acee354fcmr16094949wrs.12.1651673246077; Wed, 04
 May 2022 07:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220429135108.2781579-44-schnelle@linux.ibm.com>
 <20220503233802.GA420374@bhelgaas> <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
 <alpine.DEB.2.21.2205041311280.9548@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2205041311280.9548@angie.orcam.me.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 May 2022 16:07:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jwv00En13=5mHVA4OGRzDpAsPKy4nqM79L6xP5=aQFQ@mail.gmail.com>
Message-ID: <CAK8P3a2jwv00En13=5mHVA4OGRzDpAsPKy4nqM79L6xP5=aQFQ@mail.gmail.com>
Subject: Re: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
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

On Wed, May 4, 2022 at 2:38 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Wed, 4 May 2022, Arnd Bergmann wrote:
>
> > Almost all architectures that support CONFIG_PCI also provide
> > HAS_IOPORT today (at least at compile time, if not at runtime),
> > with s390 as a notable exception. Any machines that have legacy
> > PCI device support will also have I/O ports because a lot of
> > legacy PCI cards used it, and any machine with a pc-card slot
> > should also support legacy PCI devices.
> >
> > If we get new architectures without I/O space in the future, they
> > would certainly not care about supporting old cardbus devices.
>
>  POWER9 is another architecture with no port I/O space[1]:

POWER9 is just an implementation of the power architecture
that has a particular PCI host bridge. I would assume that
arch/powerpc/ would continue to set HAS_IOPORT because
it knows how to access I/O ports at compile-time.

If a particular host bridge does not declare an I/O port range
in its DT, then of course it won't be accessible, but that is
different from architectures that have no concept of I/O ports.

         Arnd
