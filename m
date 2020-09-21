Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E2273606
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 00:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgIUWwz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 18:52:55 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56940 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIUWwy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2020 18:52:54 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D6A341C0B8C; Tue, 22 Sep 2020 00:52:51 +0200 (CEST)
Date:   Tue, 22 Sep 2020 00:52:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v12 1/8] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
Message-ID: <20200921225251.GB13299@amd>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-2-yu-cheng.yu@intel.com>
 <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org>
 <20200918205933.GB4304@duo.ucw.cz>
 <019b5e45-b116-7f3d-f1f2-3680afbd676c@intel.com>
 <20200918214020.GF4304@duo.ucw.cz>
 <c2b5d697-634d-a5cb-2728-cead44a221c9@intel.com>
 <c91021a9-adb0-8733-2423-f78dbea5c88a@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <c91021a9-adb0-8733-2423-f78dbea5c88a@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +config X86_INTEL_BRANCH_TRACKING_USER
> > +    prompt "Intel Indirect Branch Tracking for user-mode"=20
>=20
> Take the "Intel " and "INTEL_" out, please.  It will only cause us all
> pain later if some of our x86 compatriots decide to implement this.

Are other x86 manufacturers legally allowed to implement that?

> > If the kernel is to be used only on older systems that do not support
> > IBT, and the size of the binary is important, you can save 900 KB by
> > disabling this feature.
> >=20
> > Otherwise, if unsure, say Y.
>=20
> 900k seems like a *lot*.  Where the heck does that come from?
>=20
> Also, comments like that don't age very well.  Consider:
>=20
> 	Support for this feature is only known to be present on Intel
> 	processors released in 2020 or later.  This feature is also
> 	known to increase kernel text size substantially.
>=20
> 	If unsure, say N.

That is much better, thanks.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9pLsMACgkQMOfwapXb+vJrcACfdEe0RXB3Ob0O3qo7vS+3J9EX
tmQAoMBivI2SYhK1uaQoHu+xCvzD3BHu
=QpK9
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
