Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E694270813
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRVXC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:23:02 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34998 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVXC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 17:23:02 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0590D1C0B78; Fri, 18 Sep 2020 23:22:59 +0200 (CEST)
Date:   Fri, 18 Sep 2020 23:22:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is
 enabled
Message-ID: <20200918212258.GD4304@duo.ucw.cz>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <f02b511d-1d48-6dea-d2e6-84d58e21e6cd@intel.com>
 <20200918210026.GC4304@duo.ucw.cz>
 <862eef02-eba2-e13f-ed67-f915f749ebca@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <862eef02-eba2-e13f-ed67-f915f749ebca@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-09-18 14:21:10, Yu, Yu-cheng wrote:
> On 9/18/2020 2:00 PM, Pavel Machek wrote:
> > On Fri 2020-09-18 12:32:57, Dave Hansen wrote:
> > > On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
> > > > Emulation of the legacy vsyscall page is required by some programs
> > > > built before 2013.  Newer programs after 2013 don't use it.
> > > > Disable vsyscall emulation when Control-flow Enforcement (CET) is
> > > > enabled to enhance security.
> > >=20
> > > How does this "enhance security"?
> > >=20
> > > What is the connection between vsyscall emulation and CET?
> >=20
> > Boom.
> >=20
> > We don't break compatibility by default, and you should not tell
> > people to enable CET by default if you plan to do this.
>=20
> I would revise the wording if there is another version.  What this patch
> does is:
>=20
> If an application is compiled for CET and the system supports it, then the
> application cannot do vsyscall emulation.  Earlier we allow the emulation,
> and had a patch that fixes the shadow stack and endbr for the emulation
> code.  Since newer programs mostly do no do the emulation, we changed the
> patch do block it when attempted.
>=20
> This patch would not block any legacy applications or any applications on
> older machines.

Aha, makes sense, sorry for the noise.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2UlMgAKCRAw5/Bqldv6
8vVFAJ41iKxZD+QTSRHZvYWU+1CsdoJREgCcCLoiJeApvT43KAk2xvBWtw06jWU=
=Yah9
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
