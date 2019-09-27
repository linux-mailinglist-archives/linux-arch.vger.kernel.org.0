Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348F5C03C2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2019 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfI0K6o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 06:58:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfI0K6o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 06:58:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0676ABBD;
        Fri, 27 Sep 2019 10:58:41 +0000 (UTC)
Message-ID: <dc80461e8b9d2e715976ed0b02f41b84922d06f1.camel@suse.de>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        rmk+kernel@arm.linux.org.uk, Will Deacon <will@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>
Date:   Fri, 27 Sep 2019 12:58:39 +0200
In-Reply-To: <20190830034304.24259-1-yamada.masahiro@socionext.com>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JZ6pLibdn1iko2ZTM9LG"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-JZ6pLibdn1iko2ZTM9LG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-30 at 12:43 +0900, Masahiro Yamada wrote:
> Commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> this option. A couple of build errors were reported by randconfig,
> but all of them have been ironed out.
>=20
> Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> (and it will simplify the 'inline' macro in compiler_types.h),
> this commit changes it to always-on option. Going forward, the
> compiler will always be allowed to not inline functions marked
> 'inline'.
>=20
> This is not a problem for x86 since it has been long used by
> arch/x86/configs/{x86_64,i386}_defconfig.
>=20
> I am keeping the config option just in case any problem crops up for
> other architectures.
>=20
> The code clean-up will be done after confirming this is solid.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Resending as the mail delivery system failed to resolve some the hosts,
namely Masahiro's ]

[ Adding some ARM people as they might be able to help ]

This was found to cause a regression on a Raspberry Pi 2 B built with
bcm2835_defconfig which among other things has no SMP support.

The relevant logs (edited to remove the noise) are:

[    5.827333] Run /init as init process
Loading, please wait...
Failed to set SO_PASSCRED: Bad address
Failed to bind netlink socket: Bad address
Failed to create manager: Bad address
Failed to set SO_PASSCRED: Bad address
[    9.021623] systemd[1]: SO_PASSCRED failed: Bad address
[!!!!!!] Failed to start up manager.
[    9.079148] systemd[1]: Freezing execution.

I looked into it, it turns out that the call to get_user() in sock_setsocko=
pt()
is returning -EFAULT. Down the assembly rabbit hole that get_user() is I
found-out that it's the macro 'check_uaccess' who's triggering the error.

I'm clueless at this point, so I hope you can give me some hints on what's
going bad here.

Regards,
Nicolas



--=-JZ6pLibdn1iko2ZTM9LG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2N618ACgkQlfZmHno8
x/6+HggAhZEzBiG9BUNoaWjD8le/0hiblE7XfJOVHfaBiti3ehz5R3wnt0UQMSAe
fwCdZdPkL96AsL23XDqrr3enTTe5nCKB5nM7qG2dJtDAiWsYVH/1Dcvn4pFQNT7m
jKHagHOkcs3By4FkWQ2doBtKcbTkMlddljmbWAxbg3hXTAdNdlMvFzGWO88LWGoX
R9zaedt2oDgF8BX+ctJ2ExNyueAqhJUiyBAQIaMgaHjtXVDL7czb+Qu90Tedp1Mn
mVYwg+o9rda9frK7ZI8TRfYTMJPuUMVlOWIhHb23jQ4VCJJ0oP3Yl2AYuYMqhDSn
Cte1dV9SuV0sE0F87cVbsc9COKvvHQ==
=cwjV
-----END PGP SIGNATURE-----

--=-JZ6pLibdn1iko2ZTM9LG--

