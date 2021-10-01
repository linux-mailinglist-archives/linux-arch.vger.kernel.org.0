Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E141E8EA
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhJAIUv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 04:20:51 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48808 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhJAIUt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 04:20:49 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6A8331C0B80; Fri,  1 Oct 2021 10:19:04 +0200 (CEST)
Date:   Fri, 1 Oct 2021 10:19:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Message-ID: <20211001081903.GA18962@amd>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Instructions
> ------------
> senduipi <index> - send a user IPI to a target task based on the UITT ind=
ex.
>=20
> clui - Mask user interrupts by clearing UIF (User Interrupt Flag).
>=20
> stui - Unmask user interrupts by setting UIF.
>=20
> testui - Test current value of UIF.
>=20
> uiret - return from a user interrupt handler.

Are other CPU vendors allowed to implement compatible instructions?

If not, we should probably have VDSO entries so kernel can abstract
differences between CPUs.

> Untrusted processes
> -------------------
> The current implementation expects only trusted and cooperating processes=
 to
> communicate using user interrupts. Coordination is expected between proce=
sses
> for a connection teardown. In situations where coordination doesn't happen
> (say, due to abrupt process exit), the kernel would end up keeping shared
> resources (like UPID) allocated to avoid faults.

Keeping resources allocated after process exit is a no-no.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFWxHcACgkQMOfwapXb+vJxvwCfT//NrkD3M2U42/1DYnf87idv
hk0AoJONzceoKozw6x+bt0MVUuWLOpzR
=eUmo
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
