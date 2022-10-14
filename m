Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4B5FF035
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJNOW3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJNOW2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 10:22:28 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBF71D5E08
        for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2022 07:22:27 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id h29so5009149vsq.9
        for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2022 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fco4aoSGDktPeCUQicKuShHwB8ASsS0GQpxb9h8fR+w=;
        b=WLXwQ39TkUO4zir3sdYOz4kTOtMQMK6kFCLHeTi79EsXnhwm5TzOUnwgAqFPNy0ZeU
         lDfGHpClHjUkKEYxAUXCH0ihZpc3VDr8Adk0vPdkfTKnEYMXyspZOJDBz7f1PCM01DOa
         1uSmwa8uzl2D3UxAkcTWx/3lTbS6221jVqnqnlJk9iG1JE4CS0Gn1ZqPEdFNw0FvwJ4u
         d9FgmuxsF/0uycvSfhOpIMCEWn8vQ0yiSy/4YKWNJtvDQUE8Uys0lxy6x1NN7Sl678R6
         3MpinPGP/Wzt4jF6tsuqQSH/E+eJtZBpWkqtNEoAd4uh+BTt9daXwLOCmrQPOt/5oZiV
         /7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fco4aoSGDktPeCUQicKuShHwB8ASsS0GQpxb9h8fR+w=;
        b=tqBBiOKXE6joNx3WGXc/Xd1j4R4FFV+TJCwc83Z6lFhLAN7Pm4Y76LiUY5bk8okGLy
         z9R+ZeEHYvLvY3sdBGJOw7rl9IWah5K+eg6RVYUuDkbFSeeKLftAOc/MknEw/sINq7CE
         UUcsZSI4vlJF7oQDmDICQ6gZrddGJbFs3s1BwUfUzpQ4O+roepgHZzsvoromHMSFDYTr
         hRaJM9Nal2O1MKiR57S++96cZL0S/G7LsyV0SXsXG1aIzuOFVMp7wm8Mwyx36O/2Cnlm
         xHDXs9JndsAis+OxV0n6fwJdmQNaZJhkhpgo4Vo5TCGqRM0mcc5U8RgyKytIGlhX3H2D
         caDA==
X-Gm-Message-State: ACrzQf1OpCL5lOi3kFpOcJcld4QpVBrpSTZ2RymDB/dtfD0fTp9ZNsJ1
        zDjvVPqg198gE73iNRoZNVTgY7TbyzcaXO6o5is71Q==
X-Google-Smtp-Source: AMsMyM6l+fGo9Wf4J2FUIvmKXM0/HI/acOrBBzHdAxkVC3nVrGupoi+dtA71v8gOFQ/HUJfxOEjWC90jrAxWlg/FdjE=
X-Received: by 2002:a67:ac09:0:b0:39a:eab8:a3a6 with SMTP id
 v9-20020a67ac09000000b0039aeab8a3a6mr2594681vse.9.1665757346338; Fri, 14 Oct
 2022 07:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
 <b348a306-3043-4ccc-9067-81759ab29143@www.fastmail.com> <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
 <a7cb856c-8a3f-4737-ae9e-b75c306ad88e@www.fastmail.com> <da8e0775-7d3e-d6fa-e1ff-395769d35614@csgroup.eu>
In-Reply-To: <da8e0775-7d3e-d6fa-e1ff-395769d35614@csgroup.eu>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 14 Oct 2022 16:22:15 +0200
Message-ID: <CAMRc=MdNnUS72cSARv8dAVUsujkUM9jyjutJsty9o+=LOkOefg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] gpio: Get rid of ARCH_NR_GPIOS (v2)
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 14, 2022 at 4:13 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi Linus,
>
> Le 14/09/2022 =C3=A0 15:03, Arnd Bergmann a =C3=A9crit :
> > On Wed, Sep 14, 2022, at 2:38 PM, Linus Walleij wrote:
> >> On Wed, Sep 7, 2022 at 12:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >>>>>   drivers/gpio/gpio-sta2x11.c              | 411 ------------------=
-----
> >> (...)
> >>> sta2x11 is an x86 driver, so not my area, but I think it would be
> >>> best to kill off the entire platform rather than just its gpio
> >>> driver, since everything needs to work together and it's clearly
> >>> not functional at the moment.
> >>>
> >>> $ git grep -l STA2X11
> >>> Documentation/admin-guide/media/pci-cardlist.rst
> >>> arch/x86/Kconfig
> >>> arch/x86/include/asm/sta2x11.h
> >>> arch/x86/pci/Makefile
> >>> arch/x86/pci/sta2x11-fixup.c
> >>> drivers/ata/ahci.c
> >>> drivers/gpio/Kconfig
> >>> drivers/gpio/Makefile
> >>> drivers/gpio/gpio-sta2x11.c
> >>> drivers/i2c/busses/Kconfig
> >>> drivers/media/pci/Makefile
> >>> drivers/media/pci/sta2x11/Kconfig
> >>> drivers/media/pci/sta2x11/Makefile
> >>> drivers/media/pci/sta2x11/sta2x11_vip.c
> >>> drivers/media/pci/sta2x11/sta2x11_vip.h
> >>> drivers/mfd/Kconfig
> >>> drivers/mfd/Makefile
> >>> drivers/mfd/sta2x11-mfd.c
> >>> include/linux/mfd/sta2x11-mfd.h
> >>>
> >>> Removing the other sta2x11 bits (mfd, media, x86) should
> >>> probably be done through the respective tree, but it would
> >>> be good not to forget those.
> >>
> >> Andy is pretty much default x86 platform device maintainer, maybe
> >> he can ACK or brief us on what he knows about the status of
> >> STA2x11?
> >
> > I think the explanation given by Davide and Alessandro
> > was rather detailed already:
> >
> > https://lore.kernel.org/lkml/Yw3LQjhZWmZaU2N1@arcana.i.gnudd.com/
> > https://lore.kernel.org/lkml/Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com/
> >
>
> I can't see this series in neither linus tree nor linux-next.
>
> Following the ACK from Andy + the above explanations from Arnd, do you
> plan to merge this series anytime soon ?
>
> Do you need anything more from me ?
>
> Thanks
> Christophe

I will take it after v6.1-rc1 is tagged.

Bart
