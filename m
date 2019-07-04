Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50275FD89
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2019 21:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfGDTu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jul 2019 15:50:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50150 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfGDTu2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jul 2019 15:50:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 67D7A8067F; Thu,  4 Jul 2019 21:50:14 +0200 (CEST)
Date:   Thu, 4 Jul 2019 21:50:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jann Horn <jannh@google.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH] binfmt_elf: Extract .note.gnu.property from an ELF
 file
Message-ID: <20190704195024.GA4013@amd>
References: <20190628172203.797-1-yu-cheng.yu@intel.com>
 <CAG48ez0rHHfcRgiVZf5FP0YOzxsXigvpg6ci790cmiN6PBwkhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <CAG48ez0rHHfcRgiVZf5FP0YOzxsXigvpg6ci790cmiN6PBwkhQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > +static int scan(u8 *buf, u32 buf_size, int item_size, test_item_fn tes=
t_item,
> > +               next_item_fn next_item, u32 *arg, u32 type, u32 *pos)
> > +{
> > +       int found =3D 0;
> > +       u8 *p, *max;
> > +
> > +       max =3D buf + buf_size;
> > +       if (max < buf)
> > +               return 0;
>=20
> How can this ever legitimately happen? If it can't, perhaps you meant
> to put a WARN_ON_ONCE() or something like that here?
> Also, computing out-of-bounds pointers is UB (section 6.5.6 of C99:
> "If both the pointer operand and the result point to elements of the
> same array object, or one past the last element of the array object,
> the evaluation shall not produce an overflow; otherwise, the behavior
> is undefined."), and if the addition makes the pointer wrap, that's
> certainly out of bounds; so I don't think this condition can trigger
> without UB.

Kernel assumes sane compiler. We pass flags to get it... C99 does not
quite apply here.
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0eWIAACgkQMOfwapXb+vLSMgCcC98TTx9pMIkokJGKGUu3i6ME
o+AAn3TIA7Pjz5wBcK19BycwV2+shMN6
=83sj
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
