Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC87746297
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jul 2023 20:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjGCSiT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGCSiS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 14:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9AB137;
        Mon,  3 Jul 2023 11:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F12D60FE8;
        Mon,  3 Jul 2023 18:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C75C433C7;
        Mon,  3 Jul 2023 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688409496;
        bh=PbN14/Dkbpb3I7UfEf+MueR7WvA16x243pRvsQ4xVeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IP9Zm1Vo4XMFzACthKdt1xgOwg0m9L9tlji7BKPeJcis8lKBigCHCRtnjD95b4fHx
         nGGMrg9l2I85k1vWsK4aGYArlT9ir15Au9ef6D+a8NxdOiEYRyZvWeGhqpASDcRTU+
         YieQ/Q1Oy4EVXg543ID0BT5aubS371dhCIjsUdH1woiQr0g6BSp7CdhhHjbr/PHiNN
         GuW2eD9li2WNGp8z1rEAjfbIiBrVpeRAedUejWTBcxmBs+IMfWGYxsjkyW5lAk6+jL
         2hkwwIocL+upa2WIaiqFCWhvtyVZMPR91PFU67VVZbFBsgCS0IbtjYp0lJdZ34HT29
         cP6GAaCvm974g==
Date:   Mon, 3 Jul 2023 19:38:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <16147d5c-3f4c-4be0-8af1-9cd34d010363@sirena.org.uk>
References: <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com>
 <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
 <ZJR545en+dYx399c@arm.com>
 <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
 <ZJ2sTu9QRmiWNISy@arm.com>
 <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
 <ZKMRFNSYQBC6S+ga@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D5fPsWucXka/TR0l"
Content-Disposition: inline
In-Reply-To: <ZKMRFNSYQBC6S+ga@arm.com>
X-Cookie: Please go away.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--D5fPsWucXka/TR0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 03, 2023 at 07:19:00PM +0100, szabolcs.nagy@arm.com wrote:
> The 07/02/2023 18:03, Edgecombe, Rick P wrote:

> > 3. Support more options for shadow stack sizing. (I think you are
> > referring to this conversation:
> > https://lore.kernel.org/lkml/ZAIgrXQ4670gxlE4@arm.com/). I don't see
> > why this is needed for the base implementation. If ARM wants to add a
> > new rlimit or clone variant, I don't see why x86 can't support it
> > later.

> i think it can be added later.

> but it may be important for deployment on some platforms, since a
> libc (or other language runtime) may want to set the shadow stack
> size differently than the kernel default, because

I agree that this can be deferred to later, so long as we err on the
side of large stacks now we can provide an additional limit without
confusing things.

--D5fPsWucXka/TR0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSjFYsACgkQJNaLcl1U
h9BYQwgAhRm5MgFMw8EWJtEyiQ4CP2w9dpB5HKwcEwXRO4LTusw+Rm1ZD+UHy/od
nFrB/LuHxH11pDwa/T80iFHemMyEV8OyoTKsxX8VaQKp+9n2H6lq7J4+rujJFoMV
uPrq7opwtLLgu8L8JXUC9SCTXETmiKzEK+YXfN1PvS2BzMKN0RFrzIh8LQ+E20Q8
JBRT4vsKJpQN63kUHGHl/2WgP/f6H+qeEapyXuaNa49uRsr0j2BE26xUOGB+K39U
zoPbUSo27naEGpLCHPRDDPQxz3PowV3hXvLoVHa0nBgBlfEbMGzaJxtiqrwAYKvy
i6I+y/Thvht3Bain7j8d4Pw/bQhawQ==
=xDQQ
-----END PGP SIGNATURE-----

--D5fPsWucXka/TR0l--
