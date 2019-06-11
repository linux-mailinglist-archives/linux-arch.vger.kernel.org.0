Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6721E3C908
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2019 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfFKKdT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jun 2019 06:33:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33330 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFKKdT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jun 2019 06:33:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 21FC68023C; Tue, 11 Jun 2019 12:33:06 +0200 (CEST)
Date:   Tue, 11 Jun 2019 12:33:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
Message-ID: <20190611103316.GA20775@amd>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <20190606200926.4029-4-yu-cheng.yu@intel.com>
 <20190607080832.GT3419@hirez.programming.kicks-ass.net>
 <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
 <20190607174336.GM3436@hirez.programming.kicks-ass.net>
 <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
 <20190608205218.GA2359@xo-6d-61-c0.localdomain>
 <e1543e7beb0eb55d6febcd847ccab9b219e60338.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <e1543e7beb0eb55d6febcd847ccab9b219e60338.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-06-10 08:47:45, Yu-cheng Yu wrote:
> On Sat, 2019-06-08 at 22:52 +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > > I've no idea what the kernel should do; since you failed to answer =
the
> > > > question what happens when you point this to garbage.
> > > >=20
> > > > Does it then fault or what?
> > >=20
> > > Yeah, I think you'll fault with a rather mysterious CR2 value since
> > > you'll go look at the instruction that faulted and not see any
> > > references to the CR2 value.
> > >=20
> > > I think this new MSR probably needs to get included in oops output wh=
en
> > > CET is enabled.
> > >=20
> > > Why don't we require that a VMA be in place for the entire bitmap?
> > > Don't we need a "get" prctl function too in case something like a JIT=
 is
> > > running and needs to find the location of this bitmap to set bits its=
elf?
> > >=20
> > > Or, do we just go whole-hog and have the kernel manage the bitmap
> > > itself. Our interface here could be:
> > >=20
> > > 	prctl(PR_MARK_CODE_AS_LEGACY, start, size);
> > >=20
> > > and then have the kernel allocate and set the bitmap for those code
> > > locations.
> >=20
> > For the record, that sounds like a better interface than userspace know=
ing
> > about the bitmap formats...
> > 									Pavel
>=20
> Initially we implemented the bitmap that way.  To manage the bitmap, ever=
y time
> the application issues a syscall for a .so it loads, and the kernel does
> copy_from_user() & copy_to_user() (or similar things).  If a system has a=
 few
> legacy .so files and every application does the same, it can take a long =
time to
> boot up.

Loading .so is already many syscalls, I'd not expect measurable
performance there. Are you sure?
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz/g2wACgkQMOfwapXb+vIj7QCfRkp2CAAYHfFjIjZpoiuF3QSp
XOcAn2kbcxPiUdvqncAD5H23uN2WhHP1
=j3lF
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
