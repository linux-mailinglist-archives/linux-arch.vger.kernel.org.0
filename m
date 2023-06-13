Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59972E250
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 13:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjFML4H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 07:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjFML4G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 07:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86070C5;
        Tue, 13 Jun 2023 04:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19A6D63561;
        Tue, 13 Jun 2023 11:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACCDC433D2;
        Tue, 13 Jun 2023 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686657360;
        bh=Y55L/ifTD+Az3stG2Sj9E0dJ66FX1dAYyv7iV54FE38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJlSzc9cAgm+2yPlvuu8gZ/T9bYn86hE9l2Db7NKeGcKpGhGvt7nMuKa9vtZJwAT7
         0Pmee1IYLv6zI2hlTDbTl6kEbzuR1MPKb0GXqZkfxDGQN3LMMHlPbOmipHaUitPNM4
         jBKIhm7wEHcU4eP3gK1FD9EmtjFk8kbAc+SOmOedWRYnvFr4EU/ZjtWIc91Cnva7MV
         hqMk3ik2IP8ek/EQJOmpQZqBnsvWOCw6XrnSMmjExBuNtmzzbjCyLNhYBa1kXiNB4P
         nkM/bQf3AFb+1byGT0Q1A0J92v6m3KwLTngcBazzoy7js0bJb/+ns83TVxjGjk/Ojs
         japRf5kSxwZmg==
Date:   Tue, 13 Jun 2023 12:55:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfP6EvgSuUvXOsjA"
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--kfP6EvgSuUvXOsjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 05:10:49PM -0700, Rick Edgecombe wrote:

> +Enabling arch_prctl()'s
> +=======================
> +
> +Elf features should be enabled by the loader using the below arch_prctl's. They
> +are only supported in 64 bit user applications. These operate on the features
> +on a per-thread basis. The enablement status is inherited on clone, so if the
> +feature is enabled on the first thread, it will propagate to all the thread's
> +in an app.

I appreciate it's very late in the development of this series but given
that there are very similar features on both arm64 and riscv would it
make sense to make these just regular prctl()s, arch_prctl() isn't used
on other architectures and it'd reduce the amount of arch specific work
that userspace needs to do if the interface is shared.

It should also be possible to support both interfaces for x86 I guess,
though that feels like askng for trouble.

--kfP6EvgSuUvXOsjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIWUMACgkQJNaLcl1U
h9Decwf/Sfj1gjBXiige5kMFXXsGESCn0ysC4UryS29Y6kt4AZaDRY4e+Sav+q1E
HJvMz1T1PvtW/of626ohvIdHHQfnw/cgBY8fiJty2koBqH3rLv49GkdgFBqGQadw
i6mt0r8Iic3mgMA0U0vKYbaVRH3XFW57t/wHv/s0ZXymAp/gfHVEu19h/mJ5Q6Id
VcxOUUbwLG8iAQqf4LeFqinIuDMF/RLh8ww2N7qfmZAjtZjVR1sK9EZEL3wi7rPf
TXkYE2ytzOBsdr20PSk0IPDn6THMit+hJN13KtV+fC1CR4pUrPpV34smNhxLdKz4
w23fBr1HzZUByK5stGOoiP+mPWjeqQ==
=Bwcu
-----END PGP SIGNATURE-----

--kfP6EvgSuUvXOsjA--
