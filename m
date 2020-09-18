Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921DF2708B5
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRWEA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 18:04:00 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38744 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRWEA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 18:04:00 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8146F1C0B78; Sat, 19 Sep 2020 00:03:55 +0200 (CEST)
Date:   Sat, 19 Sep 2020 00:03:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <20200918220355.GC7443@duo.ucw.cz>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-2-yu-cheng.yu@intel.com>
 <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org>
 <20200918205933.GB4304@duo.ucw.cz>
 <019b5e45-b116-7f3d-f1f2-3680afbd676c@intel.com>
 <20200918214020.GF4304@duo.ucw.cz>
 <CAMe9rOrmq-7mZkp=O+wRRX+wGa=1dopUhXRbCJBJQUdGA3N=7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <CAMe9rOrmq-7mZkp=O+wRRX+wGa=1dopUhXRbCJBJQUdGA3N=7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-09-18 14:46:12, H.J. Lu wrote:
> On Fri, Sep 18, 2020 at 2:40 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > On Fri 2020-09-18 14:25:12, Yu, Yu-cheng wrote:
> > > On 9/18/2020 1:59 PM, Pavel Machek wrote:
> > > > On Fri 2020-09-18 13:24:13, Randy Dunlap wrote:
> > > > > Hi,
> > > > >
> > > > > If you do another version of this:
> > > > >
> > > > > On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
> > > > > > Introduce Kconfig option X86_INTEL_BRANCH_TRACKING_USER.
> > > > > >
> > > > > > Indirect Branch Tracking (IBT) provides protection against CALL=
-/JMP-
> > > > > > oriented programming attacks.  It is active when the kernel has=
 this
> > > > > > feature enabled, and the processor and the application support =
it.
> > > > > > When this feature is enabled, legacy non-IBT applications conti=
nue to
> > > > > > work, but without IBT protection.
> > > > > >
> > > > > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > > > > ---
> > > > > > v10:
> > > > > > - Change build-time CET check to config depends on.
> > > > > >
> > > > > >   arch/x86/Kconfig | 16 ++++++++++++++++
> > > > > >   1 file changed, 16 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > > index 6b6dad011763..b047e0a8d1c2 100644
> > > > > > --- a/arch/x86/Kconfig
> > > > > > +++ b/arch/x86/Kconfig
> > > > > > @@ -1963,6 +1963,22 @@ config X86_INTEL_SHADOW_STACK_USER
> > > > > >           If unsure, say y.
> > > > > > +config X86_INTEL_BRANCH_TRACKING_USER
> > > > > > +       prompt "Intel Indirect Branch Tracking for user-mode"
> > > > > > +       def_bool n
> > > > > > +       depends on CPU_SUP_INTEL && X86_64
> > > > > > +       depends on $(cc-option,-fcf-protection)
> > > > > > +       select X86_INTEL_CET
> > > > > > +       help
> > > > > > +         Indirect Branch Tracking (IBT) provides protection ag=
ainst
> > > > > > +         CALL-/JMP-oriented programming attacks.  It is active=
 when
> > > > > > +         the kernel has this feature enabled, and the processo=
r and
> > > > > > +         the application support it.  When this feature is ena=
bled,
> > > > > > +         legacy non-IBT applications continue to work, but wit=
hout
> > > > > > +         IBT protection.
> > > > > > +
> > > > > > +         If unsure, say y
> > > > >
> > > > >     If unsure, say y.
> > > >
> > > > Actually, it would be "If unsure, say Y.", to be consistent with the
> > > > rest of the Kconfig.
> > > >
> > > > But I wonder if Yes by default is good idea. Only very new CPUs will
> > > > support this, right? Are they even available at the market? Should =
the
> > > > help text say "if your CPU is Whatever Lake or newer, ...." :-) ?
> > >
> > > I will revise the wording if there is another version.  But a CET-cap=
able
> > > kernel can run on legacy systems.  We have been testing that combinat=
ion.
> >
> > Yes, but enabling CET is unneccessary overhead on older systems. And
> > Kconfig is great place to explain that.
> >
>=20
> I can't tell any visible CET kernel overhead on my non-CET machines.

I assume you are not a troll but you sound a bit like one.

Please list kernel size before and after enabling
X86_INTEL_CET option(s).

That's the overhead I'm talking about, and that's why Kconfig should
explain what machines this is useful on.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2UuywAKCRAw5/Bqldv6
8tNJAJ9zzAqfN0aeU1k6gJtk7OBI9HGT+gCffaWJMFOfRANSTM5cDlxOOo23LTw=
=3UMg
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
