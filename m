Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6718D7569A2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jul 2023 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGQQwB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjGQQv5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 12:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F7170D;
        Mon, 17 Jul 2023 09:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 063A661181;
        Mon, 17 Jul 2023 16:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812EAC433C7;
        Mon, 17 Jul 2023 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689612706;
        bh=GDoZ+CsfFo9PibsTP4iZm+ttTgfHxn11DDJbAlCFH8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEoHMX2JdQeUVyNkgdWBKI6yr5pe/INc5DfODCru+00fN8J5XJg/01FraxC5Uf+FG
         XLGyykcZarElT+yfQ88/qw3rxbdtmQwlMm4MVMWcjVA8W1BzI++pek5YZKKBwI7XR6
         Vc/WH98m5BnS7DdeM2++eaKr94hk2O0k89Bc1b9ybe/FsHvQBWZ/9PaJFm5XUvbhPh
         78TOOOqQ+Nd6w2oOqOYhgVZm+Y7ykGxydEmczeSZwjlePi5nZMkHrFdDg9hL8zxSio
         SCc95tvYUaXDed+x2C7VwVXHcnKo0+0JBdhxm/Vl4xw/gxBOwJrvOMJAyCgSMZ+3MK
         +O+f2UpDtYbxQ==
Date:   Mon, 17 Jul 2023 17:51:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "david@redhat.com" <david@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Message-ID: <285d346e-14e7-4f43-9b5b-faded6205142@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
 <b389274a-abed-40dc-8e33-7ce922ea9b61@sirena.org.uk>
 <87acbb49fa83b0e3f261315a531e105da9e5b9d6.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="klyEM8Lfv/18WVhb"
Content-Disposition: inline
In-Reply-To: <87acbb49fa83b0e3f261315a531e105da9e5b9d6.camel@intel.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--klyEM8Lfv/18WVhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2023 at 03:55:50PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2023-07-14 at 23:57 +0100, Mark Brown wrote:

> > The same issue seems to apply with the version that was in -next
> > based
> > on v6.4-rc4 too.

> The version in your branch is not the same as the version in tip (which
> had a squashed build fix). I was able to reproduce the build error with
> your branch. But not with the one in tip rebased on v6.5-rc1. So can
> you try this version:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/shstk&id=899223d69ce9f338056f4c41ef870d70040fc860

Ah, I'd not seen that patch or that tip had been rebased - I'd actually
been using literally the branch from tip as my base at whatever point I
last noticed it changing up until I rebased onto -rc1.

--klyEM8Lfv/18WVhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS1cZIACgkQJNaLcl1U
h9DfWwf/Qv2sx8Qywn2HA+F1wJsVWOOqaPIZzIVBQ5Kg2bysQK3YMNLLZWKdXMsh
sTgXGVlr5oANLjP/hYxvcaxk16N1y51q6PuBh4lJN1w37tEdph1ZIcSejQY/jKpf
fKFWHZ++2w+lXvIOB/7rYQe+XutmQzCVmL0Cod8zxf2UhC4WJe9/3RCKxi6rfxuV
NXldTW7h7dqnurbev4TX4npwjcetNGofPUer7VZD7o1vRKXvX9VLG42UbeV4cu+g
ICKZmGwC9G23gWg0Ql2QkeOr43PLBo4AocKhyO6B22uYLOrA8BQHJUrbnD4ZUyD+
4rWq0iWXOnrixnw11LOSSIVZ2HkwmQ==
=SaIl
-----END PGP SIGNATURE-----

--klyEM8Lfv/18WVhb--
