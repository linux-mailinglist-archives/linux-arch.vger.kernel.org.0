Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6772EA54
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbjFMR5W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFMR5V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 13:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E6919A8;
        Tue, 13 Jun 2023 10:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C83960F9E;
        Tue, 13 Jun 2023 17:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9901FC433F2;
        Tue, 13 Jun 2023 17:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686679039;
        bh=IqkXJldW0A8Y3vMcqq5u/QYVg8dqjY4RiGJcpPC+dDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXNaOwvwJobwrSfQe3xFszHWpyiN680KdOA21GqS7X2QKkM4lO3Ya5uu/CVey7AYQ
         6B0SdqkaM82XRdl3/S/adJtfmiMsGODaMhh7ViBWfe0bx6/gp2uv+ZiOWf0IKUS7Q4
         /fUcMef7XXkwU+hbd0Nn801CVkLL5iqlL3NZdOB1dJ53duw0F+I8u/IvER2mgMrGpr
         8JYWyHb3aB0nG6LbiG8JhLATWfFPRRyp4gM1KsSfHBg7cQ0yIt8TELy9vX7795LTIS
         GONT6vW9Orcmg0TeSaj/vqBca40GctyDGjeFFrmaAja5mE7CYoKQV+CMJTpPgvHEte
         YLpTuDs9MvDVw==
Date:   Tue, 13 Jun 2023 18:57:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
 <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
 <87y1knh729.fsf@oldenburg.str.redhat.com>
 <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltcThYaE8QK6dqDg"
Content-Disposition: inline
In-Reply-To: <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--ltcThYaE8QK6dqDg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 05:11:35PM +0000, Edgecombe, Rick P wrote:

> Two things that came up as far as unifying the interface were:
> 1. The map_shadow_stack syscall
> x86 shadow stack does some optional pre-populating of the shadow stack
> memory. And in additional not all types of memory are supported
> (private anonymous only). This is partly to strengthen the security
> (which might be a cross-arch thing) and also partly due to x86's
> Write=0,Dirty=1 PTE bit combination. So a new syscall fit better. Some
> core-mm folks were not super keen on overloading mmap() to start doing
> things like writing to the memory being mapped, as well.

Right, the strengthening security bits made this one look cross arch -
that one wasn't worrying me.

> 2. The arch_prctl() interface
> While enable and disable might be shared, there are some arch-specific
> stuff for x86 like enabling the WRSS instruction.

> For x86 all of the exercising of the kernel interface was in arch
> specific code, so unifying the kernel interface didn't save much on the
> user side. If there turns out to be some unification opportunities when
> everything is explored and decided on, we could have the option of
> tying x86's feature into it later.

> I think the map_shadow_stack syscall had the most debate. But the
> arch_prctl() was mostly agreed on IIRC. The debate was mostly with
> glibc folks and the riscv shadow stack developer.

For arm64 we have an equivalentish thing to WRSS which lets us control
if userspace can explicitly push or pop values onto the shadow stack
(GCS for us) so it all maps on well - before I noticed that it was
arch_prctl() I was looking at it and thinking it worked for us.  At the
minute I've taken the prctl() patch from the riscv series and added in a
flag for writability since we just don't have an arch_prctl(), this
isn't a huge deal but it just seemed like needless effort to wonder why
it's different.

> For my part, the thing I would really like to see unified as much as
> possible is at the app developer's interface (glibc/gcc). The idea
> would be to make it easy for app developers to know if their app
> supports shadow stack. There will probably be some differences, but it
> would be great if there was mostly the same behavior and a small list
> of differences. I'm thinking about the behavior of longjmp(),
> swapcontext(), etc.

Yes, very much so.  sigaltcontext() too.

--ltcThYaE8QK6dqDg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIrfAACgkQJNaLcl1U
h9BVLAf+KkmhHb5ViBKmTT5RX0bhxDT5K+kyBt9O8VX7Yf4WGGM3Fewbz4iSD/Nx
mLQ5cFFNZzLIAq+sPgH07Fua09/YuFeHw+3wluPhl/gR6ntKdzsnyO/D5i0XJ2Xb
uwvQDzsmyjv59ztCH47aBTjpXlpS3uCkUnbQ+7uyO8B340Azh1IVSH65RN54Y7Yx
BsjSEIauQFDGbvHfMg8K6a4WDFBjBRhng6/c3izXh4zfMKlj7FS9LNdpUIAPDrrV
PbbFBlx/9ZA9bh5bCQezEGey0B9n7mrkmSTdym1yTz4dvuTqRdzsb2Lz8I/tZaXg
Gd9+l3Zwvvuq1ZkIboLiiS0t6FnepQ==
=xrY1
-----END PGP SIGNATURE-----

--ltcThYaE8QK6dqDg--
