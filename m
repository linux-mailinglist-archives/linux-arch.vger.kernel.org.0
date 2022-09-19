Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C99B5BD3DE
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 19:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiISRgE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiISRf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 13:35:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDAD3AB33;
        Mon, 19 Sep 2022 10:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 970A7B8094A;
        Mon, 19 Sep 2022 17:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5063C433D6;
        Mon, 19 Sep 2022 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663608952;
        bh=/852PW2VlJHyiSgQsLwdhlZsO86XrfHstwRhfor+u30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kqubps6P1Yp/qBJJxiDo7XPigGAvl2S0Q5BqgKXbTCSsXeebcoeb8IB3l0kXBN0JZ
         d+tj328dfG/sX+ABbLBIJn/8PE2gZ2xfiC3woDKXnBhTSQXodT96+dM/dbfg3RCJDl
         GGl73fqtQXVxbY02vYNT4O6+eqa0qU7pcRuJEX5WcBFVSeXiA5OTLbzYVf3upVBtnv
         HTaqKpI3s5tqR6+X4Md4U9o/ZXdwvnkBUlmN4Duh3tFda1ybGBV6lny0TY79VxuODT
         zIbXiTZbpjxIOi+xsjB4m0aSpTZtRZzKMaqvH9HHDPeBcHCdxzHWn6RWaqU3+KxXUZ
         s8q1mchMv4BFg==
Date:   Mon, 19 Sep 2022 18:33:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] Discard .note.gnu.property sections in generic NOTES
Message-ID: <Yyin1FUU7enibeD8@sirena.org.uk>
References: <20200428132105.170886-1-hjl.tools@gmail.com>
 <20200428132105.170886-2-hjl.tools@gmail.com>
 <YyTRM3/9Mm+b+M8N@relinquished.localdomain>
 <e15de60c-8133-3d93-eb1c-c6b1b5389887@csgroup.eu>
 <YyimOW229By98Dn7@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IQ0PHAJ6cTaIwjtK"
Content-Disposition: inline
In-Reply-To: <YyimOW229By98Dn7@relinquished.localdomain>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--IQ0PHAJ6cTaIwjtK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2022 at 10:26:17AM -0700, Omar Sandoval wrote:

In general if you're going to CC someone into a thread please put
a note at the start of your mail explaining why, many of us get
copied on a lot of irrelevant things for no apparently reason so
if it's not immediately obvious why we were sent a mail there's
every chance it'll just be deleted.

> I'm not sure what exactly arch/arm64/include/asm/assembler.h is doing
> with this file. Perhaps the author, Mark Brown, can clarify?

I don't understand the question, what file are you talking about
here?  arch/arm64/include/asm/assembler.h is itself a file and I
couldn't find anything nearby in your mail talking about a file...

--IQ0PHAJ6cTaIwjtK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMop/QACgkQJNaLcl1U
h9CuYQf+LhieRHN+lWuscUX0Gz1aGefX2uk+u1/zVHlI3IS+bi5cEzI4YZz15Fhm
dFlonqfvTgV7AtLj9TiUMT97M/LxM9nsW1x9N6OeSOwwOiNcmYkN+0NMsN8jI99S
wa+rK8Y+KJb1TG3+POFw2Itmy6dmpp5123NKssJodzlZmVn/MBSH5EyztZZv+MO4
giywJmdOZwonwThPfGztYY/yP3AZe2kvVfEwi7R6fEmh5/zXr++ETpkyRdGpph6i
ZBx6WFT70pez5QNA/tKJhPo/agvFApr8XTCllr/dr4zpyrDGKM577/al1JYoic9+
OowcdvXhPOF+9O0gq2jX73BRS0nPJQ==
=XHOY
-----END PGP SIGNATURE-----

--IQ0PHAJ6cTaIwjtK--
