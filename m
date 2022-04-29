Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583D3514FAE
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 17:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378579AbiD2Pkn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378572AbiD2Pkm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 11:40:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A6D64F4
        for <linux-arch@vger.kernel.org>; Fri, 29 Apr 2022 08:37:23 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t207so578882qke.12
        for <linux-arch@vger.kernel.org>; Fri, 29 Apr 2022 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bZXp9UdtwQUhq4ByWWPM2fGxW46dWdEnK/AAX/Cv5Mk=;
        b=K7k1NR2iw9kVdnCUnxPN/AGmdqZLJYlSXYLXaJhLiudcd1Mtfwu8JpG1ZiL21PbPDl
         cZKLE89rhE2vHHzVazDpdjx/0YSML1XahKPVknxXXd3hsT2Oz+bwVvWGWPMtv3uucyup
         IrWcjmwiZ4ehml0LcXKVLkAuFRzWVjst1EZEsV/Ag4yMMWb8ZQn9Is5yrcfTKQSKO32C
         v39WiD/8BkGWUU0aCAosD6uGHsWt8/WCfg1025NmSs6w3Qzp7mwsQZ2PXyD+5M28iOlZ
         S/C4saM3TAbiCrvaCL8cBRRByxhaJdVo87fa/f6cpD6YSIrtgXx7MAZ4o6kS9t+CxrbX
         jsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bZXp9UdtwQUhq4ByWWPM2fGxW46dWdEnK/AAX/Cv5Mk=;
        b=wU8Zx7bsJHDPNyU7dunanNYFa0WazFCW+MV/C+50YoMQ7lqhzUoGqDiXrs+aRqvcMk
         URjGIXP+lZ4YeXn1NqajJzhiCsXTfO28cIhxq/VWE5Gxkw19vuo0ErAEoF45eee7HvU2
         y8vHzGOyPVPDQYXoYS/loq6YXrpv1cmBK5Hgsh1u/MJKAm+kay/5uDC8PTHpLafjokjk
         OlMFU+fzJRjludXayTN/gCHU+RoX4MnWWv943lAqEuExGb9lwr/QfdsOklgY7FbihJeJ
         o575MyTNARMYZDdiH6oRrn+XcY16U2kHTBQDe6WbDspt9OkxVThFOK0pXvfnfQXpfnZV
         D2cQ==
X-Gm-Message-State: AOAM532VYhLC6Ze4Jlq8Y96AZE15TiCtCFz9PRPWvkvJAiUXS3OttPOh
        P1ix4ERJU/YnKl2J2WclpeEcnw==
X-Google-Smtp-Source: ABdhPJw2cY0R0MGKHsfQdnqbWfaWvp4skgSgNWcuhYrHEFDV9lMBXC/qRnYVkHx3ENkOwGHbC2LFiw==
X-Received: by 2002:a05:620a:1906:b0:67b:3ac1:8f72 with SMTP id bj6-20020a05620a190600b0067b3ac18f72mr22573943qkb.478.1651246641508;
        Fri, 29 Apr 2022 08:37:21 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r9-20020ac85c89000000b002f378738ed4sm1906774qta.7.2022.04.29.08.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:37:20 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:37:18 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
Message-ID: <YmwGLrh4U+pVJo0m@fedora>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-19-schnelle@linux.ibm.com>
 <Ymv3DnS1vPMY8QIg@fedora>
 <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UN0ca/LPGGPy0rfH"
Content-Disposition: inline
In-Reply-To: <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--UN0ca/LPGGPy0rfH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 04:46:00PM +0200, Niklas Schnelle wrote:
> On Fri, 2022-04-29 at 10:32 -0400, William Breathitt Gray wrote:
> > On Fri, Apr 29, 2022 at 03:50:16PM +0200, Niklas Schnelle wrote:
> > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and frie=
nds
> > > not being declared. We thus need to add HAS_IOPORT as dependency for
> > > those drivers using them.
> > >=20
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >  drivers/gpio/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > > index 45764ec3b2eb..14e5998ee95c 100644
> > > --- a/drivers/gpio/Kconfig
> > > +++ b/drivers/gpio/Kconfig
> > > @@ -697,7 +697,7 @@ config GPIO_VR41XX
> > > =20
> > >  config GPIO_VX855
> > >  	tristate "VIA VX855/VX875 GPIO"
> > > -	depends on (X86 || COMPILE_TEST) && PCI
> > > +	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
> > >  	select MFD_CORE
> > >  	select MFD_VX855
> > >  	help
> > > --=20
> > > 2.32.0
> >=20
> > I noticed a number of other GPIO drivers make use of inb()/outb() -- for
> > example the PC104 drivers -- should the respective Kconfigs for those
> > drivers also be adjusted here?
> >=20
> > William Breathitt Gray
>=20
> Good question. As far as I can see most (all?) of these have "select
> ISA_BUS_API" which is "def_bool ISA". Now "config ISA" seems to
> currently be repeated in architectures and doesn't have an explicit
> HAS_IOPORT dependency (it maybe should have one). But it does only make
> sense on architectures with HAS_IOPORT set.

There is such a thing as ISA DMA, but you'll still need to initialize
the device via the IO Port bus first, so perhaps setting HAS_IOPORT for
"config ISA" is the right thing to do: all ISA devices are expected to
communicate in some way via ioport.

William Breathitt Gray

--UN0ca/LPGGPy0rfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYmwGKgAKCRC1SFbKvhIj
K8KEAP0TKKesiZ/wUezoJg8+48qr5yK22ZRd1gc3a6/67xLQNgEAvu4pev2XF5/q
8PHoF5Bmkx2ZgF9O5X8qFa9zGNUxqAk=
=PRGE
-----END PGP SIGNATURE-----

--UN0ca/LPGGPy0rfH--
