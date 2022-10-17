Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5D36009E5
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJQJHE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 05:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJQJHE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 05:07:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF9011C36
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2022 02:07:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b12so15069218edd.6
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2022 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xdq9xbr020A2zlmiuY2oondIvU96505rZYEMIN0lgIc=;
        b=GQIN4/WooCJ2OHKtHJosN8lSPTtVrRlJUqL5rWCcbAtfINFwAcGTT3/6CWdSDRQhkN
         u08q1uJifA+ieXvytc2J235H5xj2pRj14qr6eGRclva/4HFNCBf9x4klZ/hypeWxAr+/
         IHoIjZNek7ko6Kt5zdIQfRRJzv+oaBEapjTS+34iMfq8OhyFkGdFPtbxPnJD5iN6wvhk
         Ye/d4Lo22A95RZZnHhTvk+PRePMxvhEJ13Lh7lS3BR+hQU19DtV2LNYBZZpGkU5niTSV
         qPFQ2EVOuZ3duTve/gA5uoizzqmQHfnVNPLAYQSXT5apgL85JDw9WzKe0zkZFNXrb/eD
         1G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xdq9xbr020A2zlmiuY2oondIvU96505rZYEMIN0lgIc=;
        b=YvUy34ZlXTr+/gBRD36Rw85NPpWtsb/UnY8YK+wAK/+SfWKXTOp4+oDETArjOw7MQM
         oIrpjgPQ+i6KEAl39C5zpgUvdp2P2UY14g9159Khc/bclaofyDtPhOdUWDwCTbDLieal
         O1E7r5OEtXLZb12cgQyBHHjswPRvBm1rkcZABX/VvzM6qBKJuNBtAxYcQ5/23xsoLH/S
         81Wlw+9XmMknXe8I/gtTQK6tFXdA9d7SdRRubCxAtFq6A7FPsKmTAt9eLeeVyQQs5JJU
         1rc78QDt6sSv+E8sKSgtm3JE4CH1sO3VQNji5xeF4iv7MpbXVJ89RH7RLR1SbyCdDxOm
         jOsQ==
X-Gm-Message-State: ACrzQf0deXmgqkVJGKZgjVZYU2VQiJYhkp2OS/kAmi5F5M1Inh5gucnh
        u3oB6aCreGVAHrAG/y6vPe+r7+hN9tsIc+bRlRZ26w==
X-Google-Smtp-Source: AMsMyM62S+E/GWBTiUhHThKnM675pxwyWJv1uxbW8J4NBHMS/gSep3jb96h+Z5CpyjMuz54kCYuFjJzngCAyMipwfTQ=
X-Received: by 2002:a05:6402:2694:b0:45c:a035:34bc with SMTP id
 w20-20020a056402269400b0045ca03534bcmr9197352edd.158.1665997621080; Mon, 17
 Oct 2022 02:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
 <b348a306-3043-4ccc-9067-81759ab29143@www.fastmail.com> <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
 <a7cb856c-8a3f-4737-ae9e-b75c306ad88e@www.fastmail.com> <da8e0775-7d3e-d6fa-e1ff-395769d35614@csgroup.eu>
 <CAMRc=MdNnUS72cSARv8dAVUsujkUM9jyjutJsty9o+=LOkOefg@mail.gmail.com> <CAMRc=MeZUap-h=NZm1L0BfN2=ms6VeOJA+05HPyLq_hE8kVuEQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeZUap-h=NZm1L0BfN2=ms6VeOJA+05HPyLq_hE8kVuEQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 11:06:49 +0200
Message-ID: <CACRpkdYPCZ9QAwNripOXGuFgvtnC+vzQ5EbYaWJEF1u9E_x4Yw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] gpio: Get rid of ARCH_NR_GPIOS (v2)
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 17, 2022 at 11:05 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Fri, Oct 14, 2022 at 4:22 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >
> > On Fri, Oct 14, 2022 at 4:13 PM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> > >
> > > Hi Linus,
> > >
> > > Le 14/09/2022 =C3=A0 15:03, Arnd Bergmann a =C3=A9crit :
> > > > On Wed, Sep 14, 2022, at 2:38 PM, Linus Walleij wrote:
> > > >> On Wed, Sep 7, 2022 at 12:15 PM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> > > >>>>>   drivers/gpio/gpio-sta2x11.c              | 411 --------------=
---------
> > > >> (...)
> > > >>> sta2x11 is an x86 driver, so not my area, but I think it would be
> > > >>> best to kill off the entire platform rather than just its gpio
> > > >>> driver, since everything needs to work together and it's clearly
> > > >>> not functional at the moment.
> > > >>>
> > > >>> $ git grep -l STA2X11
> > > >>> Documentation/admin-guide/media/pci-cardlist.rst
> > > >>> arch/x86/Kconfig
> > > >>> arch/x86/include/asm/sta2x11.h
> > > >>> arch/x86/pci/Makefile
> > > >>> arch/x86/pci/sta2x11-fixup.c
> > > >>> drivers/ata/ahci.c
> > > >>> drivers/gpio/Kconfig
> > > >>> drivers/gpio/Makefile
> > > >>> drivers/gpio/gpio-sta2x11.c
> > > >>> drivers/i2c/busses/Kconfig
> > > >>> drivers/media/pci/Makefile
> > > >>> drivers/media/pci/sta2x11/Kconfig
> > > >>> drivers/media/pci/sta2x11/Makefile
> > > >>> drivers/media/pci/sta2x11/sta2x11_vip.c
> > > >>> drivers/media/pci/sta2x11/sta2x11_vip.h
> > > >>> drivers/mfd/Kconfig
> > > >>> drivers/mfd/Makefile
> > > >>> drivers/mfd/sta2x11-mfd.c
> > > >>> include/linux/mfd/sta2x11-mfd.h
> > > >>>
> > > >>> Removing the other sta2x11 bits (mfd, media, x86) should
> > > >>> probably be done through the respective tree, but it would
> > > >>> be good not to forget those.
> > > >>
> > > >> Andy is pretty much default x86 platform device maintainer, maybe
> > > >> he can ACK or brief us on what he knows about the status of
> > > >> STA2x11?
> > > >
> > > > I think the explanation given by Davide and Alessandro
> > > > was rather detailed already:
> > > >
> > > > https://lore.kernel.org/lkml/Yw3LQjhZWmZaU2N1@arcana.i.gnudd.com/
> > > > https://lore.kernel.org/lkml/Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com/
> > > >
> > >
> > > I can't see this series in neither linus tree nor linux-next.
> > >
> > > Following the ACK from Andy + the above explanations from Arnd, do yo=
u
> > > plan to merge this series anytime soon ?
> > >
> > > Do you need anything more from me ?
> > >
> > > Thanks
> > > Christophe
> >
> > I will take it after v6.1-rc1 is tagged.
> >
> > Bart
>
> Now queued.

Thanks for reviewing and applying this!

Let's test it in linux-next we need wide coverage for this.

Yours,
Linus Walleij
