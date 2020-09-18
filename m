Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80243270822
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgIRVYG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:24:06 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35150 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgIRVYG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 17:24:06 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CE3731C0B78; Fri, 18 Sep 2020 23:24:03 +0200 (CEST)
Date:   Fri, 18 Sep 2020 23:24:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20200918212403.GE4304@duo.ucw.cz>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-2-yu-cheng.yu@intel.com>
 <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org>
 <20200918205933.GB4304@duo.ucw.cz>
 <CAMe9rOo0+SBPtN7yb8_-h0dRAoOXkad8wi9d-EiWAfgFSedXjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <CAMe9rOo0+SBPtN7yb8_-h0dRAoOXkad8wi9d-EiWAfgFSedXjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > +   help
> > > > +     Indirect Branch Tracking (IBT) provides protection against
> > > > +     CALL-/JMP-oriented programming attacks.  It is active when
> > > > +     the kernel has this feature enabled, and the processor and
> > > > +     the application support it.  When this feature is enabled,
> > > > +     legacy non-IBT applications continue to work, but without
> > > > +     IBT protection.
> > > > +
> > > > +     If unsure, say y
> > >
> > >         If unsure, say y.
> >
> > Actually, it would be "If unsure, say Y.", to be consistent with the
> > rest of the Kconfig.
> >
> > But I wonder if Yes by default is good idea. Only very new CPUs will
> > support this, right? Are they even available at the market? Should the
> > help text say "if your CPU is Whatever Lake or newer, ...." :-) ?
> >
>=20
> CET enabled kernel runs on all x86-64 processors.  All my machines
> are running the same CET enabled kernel binary.

I believe that.

But enabling CET in kernel is useless on Core 2 Duo machine, right?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2UlcwAKCRAw5/Bqldv6
8r0mAJ9JcTHq3hoeh6afJxFoVECsAnMbOACfVq6tEmAU2T5ovnJ0hthFdEAfoN4=
=kXk6
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
