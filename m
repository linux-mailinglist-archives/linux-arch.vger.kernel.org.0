Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E972269F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jun 2023 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjFEM4x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jun 2023 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjFEM4k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jun 2023 08:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CF10E4;
        Mon,  5 Jun 2023 05:55:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63301623DD;
        Mon,  5 Jun 2023 12:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B80FC433D2;
        Mon,  5 Jun 2023 12:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685969754;
        bh=J/s+63q1jQKfqUdE3nPApFzudJHfsG4lgtjsJR+y4KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1dbaarNkau+FnYiPQFGyO4H20qEwNyyvrx5CccEz8p47fnXL3oBDSdigs5ckrHT6
         Ru2tsiVt1wqi9OW93JDpzugZtGnSQAGg4Tp/4Qfassuvr4DyuUEXPmTWrf+KOENICJ
         8Ar+yP0fW2vkq7CDsVx/MrAy782NfY5lu7ebeCCwTafuii/vx14Gi/PrV7iDCSEcLc
         HD3w2027m+Qils5B4+Q5YmdaWUeSVIJO8dYJlWlkYZcaOCIbZmVDrKmD+N71BEHiNW
         FSZhvsCeZH32Qp2Y+HFL4uFSTAASgfVZTIsvo+EnvMvjpkNpi2/X5kSsspOG+WB8Tf
         TlBjQsoAcp7uw==
Date:   Mon, 5 Jun 2023 14:55:50 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <ZH3bVsK6OmqBbZqj@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
 <20230605120151.qpoe5ordzdvxmqv7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lT8CzXAuQSEeNSDp"
Content-Disposition: inline
In-Reply-To: <20230605120151.qpoe5ordzdvxmqv7@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--lT8CzXAuQSEeNSDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> (Found via: https://lore.kernel.org/all/ZH21E3Obp+YPJHkl@shikoro where
> the last part of the URL is the Message-Id of your mail.)

I know how I could get it. Just, for scaling reasons it is better if
people send it right away. OK, I should have said that directly :)

Please send also cover-letters to mailing lists.


--lT8CzXAuQSEeNSDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmR921YACgkQFA3kzBSg
KbaxfBAAjVa5/CR5r65vtyv1RPcG3CvlBR9Y5RCq5Mq6yy4Y6e5Mdy/xz5805/lj
t2XOFkxZiq68Xs/ieZ0E6mXp3aIc8wo20SsQhsouLk6BhGlLfUbMfYgH2ZJ/Hcui
PY0odp+KPM2HbZ8qFUq88jptx2kpjedd49zv1Dr43spLcfYqmcbc29pURvib+gyg
eCJwpT7hYNOrMgHONpTk78FS/eb6DfVmkMpMXdxKAsg/mdE+WnSeGGSeCEXmRYJp
l5NlRWCptffhtCCg/tgNhu+gwqqn6jiLiNjjhXVjgMyWDCUFtEqV1RI4fXJ3MeYb
YAYxPdecyfrBR6G/4UO4CxfSahhBz5JBb8LI/ffmvuKKrju6QIeGnX8QxZ2+Rvxc
fw4BLsKgANhsQAo13D+VvKuE59rZvPTgHQvmZa675pZEdnbfvFKpmj9aslb9R75h
NccX4C3kPDVM3f1KEWMh2D5iGtEMi3B9zMDMhxCtcMDDJ+q5LqtdQ31E8SJz4or2
6sU8mQZpx/zu4w8js/DmU+vLVEx+ssJgcHDbCduuJZVDrBluqderSfFDwB/zGmEA
Lw5Uwn0yO/mGd5JDZ2hqEEs4Qv62kJCWx4HE2LPSseYCowUR8IV4BN+yClJXXdch
X8V24/Qwe6aPrYZBZEDVtZN7aIMc7s2jihhTQxMhrC0vRX+xyKI=
=X5/1
-----END PGP SIGNATURE-----

--lT8CzXAuQSEeNSDp--
