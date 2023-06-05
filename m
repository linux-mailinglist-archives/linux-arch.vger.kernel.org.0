Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124B57230AA
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jun 2023 22:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFEUFv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jun 2023 16:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjFEUFq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jun 2023 16:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BAB0;
        Mon,  5 Jun 2023 13:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A1CC62A3E;
        Mon,  5 Jun 2023 20:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7621C433EF;
        Mon,  5 Jun 2023 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685995543;
        bh=Xx+yBJPOSqZaPMUOD0JySnA5Nn1xDYj1t2eLuqIn69A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1EJKtULBa7QUQw2Nxyj1jOD8qGhCDrmNtcPGUttqHywbiNYM+ukJPTIVNxX+uARw
         dQHatOUa7/9g10f19oKNU+F8+/aGBktlOn8tDw4+DPRnu4nI3oB8cBI8UOIzvvR8Bf
         UCoHhuNbXoWzid672SipILhGPXA6MWJMt6YJmmRMbxw5a4+oJRnz3Js3cohl43aN1L
         ZWfzDAqQLwP+Ma39APcETWN0AZdmku07FYjftPfCg4mkhwWDe/nRZeQbiKQ+XAfIZg
         ua3NyXGnAzS6ZenQsrgSp/it+ft0wmvqoD/4kc49kM3PZeI+3XUrADfmax16enPg7/
         +HhqY1O6W4i7w==
Date:   Mon, 5 Jun 2023 22:05:39 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 11/41] i2c: add HAS_IOPORT dependencies
Message-ID: <ZH5AE61wB12B/6tr@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-i2c@vger.kernel.org
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-12-schnelle@linux.ibm.com>
 <ZH21E3Obp+YPJHkl@shikoro>
 <c439a6d6ed33fc25efc292828a102b6d7996da7a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V/LhWHPF5kUV8UA3"
Content-Disposition: inline
In-Reply-To: <c439a6d6ed33fc25efc292828a102b6d7996da7a.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--V/LhWHPF5kUV8UA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> I believe there were no changes for the i2c portion since v3. Other
> that with the HAS_IOPORT Kconfig option merged the per-subsystem
> patches are now independent and can be merged directly.

Thanks for the feedback.

Only issue is then that PARPORT is still in there. Didn't you want to
drop it as mentioned in http://patchwork.ozlabs.org/project/linux-i2c/patch/20211227164317.4146918-11-schnelle@linux.ibm.com/ ?

And from the same mail, did you reach a conclusion what to do with the
ocores driver?

Happy hacking,

   Wolfram


--V/LhWHPF5kUV8UA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmR+QA8ACgkQFA3kzBSg
KbZsWA/+Oy2ChLbPL+jNVuZQUZuwLhV4pik4RHRA+MO5CG3kK0bdfzmfyC9Kxi+m
+ZbOCd58RsMo2QdFUtpGxDqqWkX+e4BOX0PfS1QgkcTCW21rwaOqkuCzwxI8Np7E
difVPTRIUGs3h8xfcWGoM2kUL4ZN2gFm13QtGe6QUtrqPCnJATU5oApHvz/muFVc
Ux3T6HikEEfIQhh/SEIHv410MBx59ruKeGZBzcRX0zqQWKJ+djovXhxzIpHrvyFA
awN9LCXsVUgmD39ZBswteuD9kUtvDJO+Ju6cU+xvtB+s9aGTL6ioq5wYZIk8bbqo
+3h2aUGnfW5HWP+Pvs5TWpAhK7fyl78iHANmLIBMBoS7AUh1EZHUTOVzh/XgiBom
MF8d9fttsRcyzJ5E45JNcGg+QnSrXMBWIdmv4YD3KXBq7tx8admry5tVsqjp1V01
Cr7XRHoQ1iQuw1S6RVFHVIaYgV2bO1tWDvjtfNCOOxFVpHEdKY3PdQwsH5ktV/uf
0MxUDkm3+siukEVuYTJdp/sVEfmmbUfMOBX1Cj5YVEdgb14PJoi0bsQNVN8y9R2R
mNx3/v7mK10i1PjRUZyjeWtgRYSJyWYk7swNeIMr9bPs1CV6Gh7ySIs4Ae83KXMB
Rt06GbndrfcphLiQTfFUQYQh4fxO0MD1sJ46gmg/ooZqmhjjnD4=
=kqOm
-----END PGP SIGNATURE-----

--V/LhWHPF5kUV8UA3--
