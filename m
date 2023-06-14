Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120672FFB3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbjFNNN5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244795AbjFNNNz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 09:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF7268B;
        Wed, 14 Jun 2023 06:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C76F1639C3;
        Wed, 14 Jun 2023 13:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E57C433C0;
        Wed, 14 Jun 2023 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686748385;
        bh=x8Up71mCwqWQG8AsnfE4/2MdVJDUJadORPWbH0I1tuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmGuG1scUFZKhFQNFytyrqQs4QH8kSngMWTDWQhh/IAxUShNkfAlHA0mYatvTs83/
         jOKmBA00V+we+EzssIXOd/Qz6QecVS5ksEJeq0J3SvWSO8bj5PSDHbZgMaN95IeN8R
         P733m+ruVwxdOGQxxq0YxO2HZWTkeNUJANSmfjGDgbvalwxGKpo4E3gTq3Iv5L2IZO
         zKhN1qUc4PaKfYBJnBHQfjM3sPbtik1D4+Ru3w0XxYPIZqDW9YzPa4GikNGjqHoBr8
         valRm0kUucRd4MnoMTxBiQVaEQ6kAsOzmbiwXIMM0TI99Z7h0v4MW5wcMejZM+cOhR
         a/QxJGFDHl0Uw==
Date:   Wed, 14 Jun 2023 14:12:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <898e952a-be97-4424-b889-4f766e3e0cd4@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
 <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
 <87y1knh729.fsf@oldenburg.str.redhat.com>
 <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
 <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
 <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ibPQ7ywZvQ2KqFY"
Content-Disposition: inline
In-Reply-To: <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
X-Cookie: At participating locations only.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--4ibPQ7ywZvQ2KqFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 07:57:37PM +0000, Edgecombe, Rick P wrote:

> For alt shadow stack's, this is what I came up with:
> https://lore.kernel.org/lkml/20220929222936.14584-40-rick.p.edgecombe@intel.com/

> Unfortunately it can't work automatically with sigaltstack(). Since it
> has to be a new thing anyway, it's been left for the future. I guess
> that might have a better chance of being cross arch.

Yeah, I've not seen and can't think of anything that's entirely
satisfactory either.  Like Szabolcs says I do think we need a story on
this.

> BTW, last time this series accidentally broke an arm config and made it
> all the way through the robots up to Linus. Would you mind giving
> patches 1-3 a check?

I'm in the middle of importing the whole series into my development
branch, but note that I'm only really working with arm64 not arm so
might miss stuff the bots would hit.  Hopefully there should be some
Tested-bys coming for arm64 anyway.

--4ibPQ7ywZvQ2KqFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSJvNQACgkQJNaLcl1U
h9CPyQf/Y4GwjTyNGgoEGlusyMBRxull9v6onRkwCcTUbLHk6Nmd68eA186L2jZS
kTkjXNcM67CHwcz3xw1W/1T4uXcitQqHeNznnES31wFwPnJYZzDJSF3RfyhC3WXk
eh9so9SyTG2SO/AK4CUgdhSph0eYMo2o606r/S+4mWiThEC6sMK/5Wly6vVmM4mm
dAHJecna4winLvCpMTb5gW/khUtn5Bc3w58b/45FoVytXFnMV65H+Q/WIsySPl2J
pHH93UeI0zJXXKzhm6iSQBFjRmLa18i7o0k456fIKYxFYknblATaeJvSXC4YhCtA
zVN7zhOEPqONu5RRMukB6WRZgpm3tw==
=ErsU
-----END PGP SIGNATURE-----

--4ibPQ7ywZvQ2KqFY--
