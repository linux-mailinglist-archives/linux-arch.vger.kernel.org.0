Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0049518602
	for <lists+linux-arch@lfdr.de>; Tue,  3 May 2022 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiECOHQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 May 2022 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiECOHP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2022 10:07:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1F1EAD0
        for <linux-arch@vger.kernel.org>; Tue,  3 May 2022 07:03:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hh4so13462457qtb.10
        for <linux-arch@vger.kernel.org>; Tue, 03 May 2022 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rEA/WO8Mvi9mkyG5kqELFWFIRU5FfjNv5FVVN5OBPRg=;
        b=MDQvYf3gHtS8HMjUwWzCiC1Fxsu4angXku7mUGw6MlSIkca0gx06FMTNx90ziQLTSJ
         HZ9lhSQHa/EVC5868dkxuWAOvyZvMsoYkrz21ar6/5K54iB4gG3yLII8mizfC5izOGhg
         klbEw4Uz6lDilG7A1yQKqjoJs5bxmZCVvTYE186FFYeDLqZ0QtGW3vB5k8Q3rJrS+q4f
         kHyhTreXc46uS3u+ahxQtcx7/4fegW8vGCjGHNhJYSJ33xjwcCwj9jk1OsGlGhKhRVWA
         F3/o+H3gGosX+5Bds/YwlxtRVNephxXBMJSflC65Dd2DQw10H50pNPKWfwebZDRhySKA
         zSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rEA/WO8Mvi9mkyG5kqELFWFIRU5FfjNv5FVVN5OBPRg=;
        b=14tIr+cKWcsQO9VPN+KYbDqVujO6E7bVkmiCnQmMb1SZ6O8mVuGjGlQfO2N1GBQuT0
         Z+YGk9onBAsO58lLS06d3QIopAwS/ty1QXSHhJ7VcCJL8e8GVDQog57ldPq01FEIOafT
         pHB02gsg4GkVtQZEjQFv81Kk4GbDdtkJNQ8HkmrFmddLn4yPAkmHW1BHB9NH6jkVL1nF
         XbhudTKq5CklVBjnJFzyqS6cJutV3sqAi5FvQ+ziYSJl03ELVRXBrm8dPovGkH2Yk4MQ
         WwAx3nV7+lBQyuURz6G08dZMaSw9INSBlIIA5uvJ4rPElRsAD5/2tbJN/DXwXfNCYyOa
         uiAg==
X-Gm-Message-State: AOAM530hHFFrqRJVr9F8p1sZxBRvMVz9YNxpE/b+GYUQz2YjykqH3ECE
        tMiB36n6rHOMrolaw+3jOGas0Q==
X-Google-Smtp-Source: ABdhPJw7Ve6j3sQ7hOzQ1wudzvX76tu9J1CZFDESduQg/nFoUbXy7Wi6oqzqRoi1RsCGOF4EtrRjFQ==
X-Received: by 2002:ac8:580e:0:b0:2f3:7ff9:39c6 with SMTP id g14-20020ac8580e000000b002f37ff939c6mr14863406qtg.434.1651586621658;
        Tue, 03 May 2022 07:03:41 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a146600b0069fc13ce217sm5811708qkl.72.2022.05.03.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:03:41 -0700 (PDT)
Date:   Tue, 3 May 2022 10:03:39 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Linus Walleij' <linus.walleij@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
Message-ID: <YnE2OxAsXmXSB87L@fedora>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-19-schnelle@linux.ibm.com>
 <Ymv3DnS1vPMY8QIg@fedora>
 <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com>
 <YmwGLrh4U+pVJo0m@fedora>
 <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com>
 <c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qkJkToKVV3ZYwUlC"
Content-Disposition: inline
In-Reply-To: <c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--qkJkToKVV3ZYwUlC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2022 at 01:08:04PM +0000, David Laight wrote:
> From: Linus Walleij
> > Sent: 01 May 2022 22:56
> >=20
> > On Fri, Apr 29, 2022 at 5:37 PM William Breathitt Gray
> > <william.gray@linaro.org> wrote:
> > > On Fri, Apr 29, 2022 at 04:46:00PM +0200, Niklas Schnelle wrote:
> >=20
> > > > Good question. As far as I can see most (all?) of these have "select
> > > > ISA_BUS_API" which is "def_bool ISA". Now "config ISA" seems to
> > > > currently be repeated in architectures and doesn't have an explicit
> > > > HAS_IOPORT dependency (it maybe should have one). But it does only =
make
> > > > sense on architectures with HAS_IOPORT set.
> > >
> > > There is such a thing as ISA DMA, but you'll still need to initialize
> > > the device via the IO Port bus first, so perhaps setting HAS_IOPORT f=
or
> > > "config ISA" is the right thing to do: all ISA devices are expected to
> > > communicate in some way via ioport.
> >=20
> > Adding that dependency seems like the right solution to me.
>=20
> I think it all depends on what HAS_IOPORT is meant to mean and
> how portable kernel binaries need to be.
>=20
> x86 is (probably) the only architecture that actually has 'in'
> and 'out' instructions - but that doesn't mean that some other
> cpu (and I mean cpu+pcb not architecture) have the ability to
> generate 'IO' bus cycles on a specific physical bus.
>=20
> While the obvious case is a physical address window that generates
> PCI(e) IO cycles from normal memory cycles it isn't the only one.
>=20
> I've used sparc cpu systems that have pcmcia card slots.
> These are pretty much ISA and the drivers might expect to
> access port 0x300 (etc) - certainly that would be right on x86.
>=20
> In this case is isn't so much that the ISA_BUS depends on support
> for in/out but that presence of the ISA bus provides the required
> in/out support.

That's true, it does seem somewhat backwards to have a depends on line
when the bus is really just providing the support for devices that want
to use it rather than requiring it. Do you think a HAVE_IOPORT line
should be added independently for each driver instead of adding it to
ISA_BUS?

> Now, maybe, the drivers should be using some ioremap variant and
> then calling ioread8() rather than directly calling inb().
> But that seems orthogonal to this changeset.
>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

Using ioremap() does have the benefit of making it easier to reuse the
code for some of these PC104 drivers with their PCI device variants; the
ioread8() calls and such can stay the same and we just initialize to the
proper address during probe. I plan to look into this in the future
then.

William Breathitt Gray

--qkJkToKVV3ZYwUlC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYnE2NgAKCRC1SFbKvhIj
K1ziAQC/Gcd4KmfP+1GLpIrE5Gy3ocse41ufgCdCXVkLTjgj2QEA4Mr46B97PGjA
9gDCAjBNMj+K03gxZel1wfWWyw4bZwQ=
=cAd7
-----END PGP SIGNATURE-----

--qkJkToKVV3ZYwUlC--
