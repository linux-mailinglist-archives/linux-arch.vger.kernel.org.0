Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF7730B90
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 01:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjFNXcK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 19:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFNXcJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 19:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2992A6;
        Wed, 14 Jun 2023 16:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C442615A3;
        Wed, 14 Jun 2023 23:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE05C433C8;
        Wed, 14 Jun 2023 23:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686785527;
        bh=l5wAvCitc5+XKYN4a/EDPNr+xHHIzMGnu3Cj5Q32aYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eX+05HaNgBK708k/aFiwmh8c+LYFM85sZ25U2E+kSSlULE9dba/ZjTIYcGxeIHL+A
         VBJSPVq71d6msFBOKgNxuOV6HWtNNM7laV2UF+bIeoMVWDEB3qOwd6ntu0/32StiYF
         Lt5GEVVehA0f1XlnZ0dIutG0kETw5Crnx+wflBeHQgN6GVio3SmfAQyI9mG1CZ0sAv
         blDsLxnwB41locARynWgOwCMGEDRgBiY8pBEwt0uZ/d4SJYp5/Z+jI7+Ql0DnmZ7U9
         YL13BOC0mjccfgsJkhTCxBQ73amqKKQiBT9H7SmI2/x0QkjxpIk20uiQcgHdL55shU
         i8HM0piQnUYtw==
Date:   Thu, 15 Jun 2023 00:31:55 +0100
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
Subject: Re: [PATCH v9 14/42] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Message-ID: <cab1bfce-9012-4d30-a3c3-dcc05bc1ed42@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-15-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KwuAiGV8shjV9U/y"
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-15-rick.p.edgecombe@intel.com>
X-Cookie: You are false data.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--KwuAiGV8shjV9U/y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 05:10:40PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>=20
> New hardware extensions implement support for shadow stack memory, such
> as x86 Control-flow Enforcement Technology (CET). Add a new VM flag to
> identify these areas, for example, to be used to properly indicate shadow
> stack PTEs to the hardware.

Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>

--KwuAiGV8shjV9U/y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSKTeoACgkQJNaLcl1U
h9DbBAf/dklSBcWFUf8rLQLLjmWtQFSN5/oHbHRtuYaWxh4ca4gZrDA4wxc8+bHc
sheZePItfvKV5Ps+A/7PsQgLFiu8gv5QYrRO579LsqK3q1Omq2TRxw1dgoC89wYd
92eDscUDZwbhDg6tf/4BkTKbhkhrsVKfPYNvACjfxZ4Wn5Qj6RsQ7V+eyEqm1gyq
E3RQmvinPuzLAwZwxYHCRML2ClfdJtAW+KlZTnhI6EFJ5PHHQ0HWUbddZOarjBGl
ALevoPpwE8doIxGr5WYG7qQmlpY0BpAD9NSniZ6i7cT1/zp0zMht86N/cmfjEy8I
TPrS9cFs9I4OoDDbyA7Dv+M33R72Gw==
=2riz
-----END PGP SIGNATURE-----

--KwuAiGV8shjV9U/y--
