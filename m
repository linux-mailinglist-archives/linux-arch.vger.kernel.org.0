Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE51BB303
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 02:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgD1AqQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 20:46:16 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:11350 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgD1AqQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 20:46:16 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 49B2yB31ClzKmbp;
        Tue, 28 Apr 2020 02:46:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id Hb0F5KawT22P; Tue, 28 Apr 2020 02:46:05 +0200 (CEST)
Date:   Tue, 28 Apr 2020 10:45:46 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hagen Paul Pfeifer <hagen@jauu.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Message-ID: <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
References: <20200426130100.306246-1-hagen@jauu.net>
 <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein>
 <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org>
 <20200427185929.GA1768@laniakea>
 <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
 <20200427201303.tbiipopeapxofn6h@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3oqbxiocwy4jimao"
Content-Disposition: inline
In-Reply-To: <20200427201303.tbiipopeapxofn6h@wittgenstein>
X-Rspamd-Queue-Id: 43C7D1693
X-Rspamd-Score: -4.76 / 15.00 / 15.00
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--3oqbxiocwy4jimao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-27, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Mon, Apr 27, 2020 at 10:08:03PM +0200, Arnd Bergmann wrote:
> > The way I understood Jann was that instead of a new syscall that duplic=
ates
> > everything in ptrace(), there would only need to be a new ptrace request
> > such as PTRACE_ATTACH_PIDFD that behaves like PTRACE_ATTACH
> > but takes a pidfd as the second argument, perhaps setting the return va=
lue
> > to the pid on success. Same for PTRACE_SEIZE.
>=20
> That was my initial suggestion, yes. Any enum that identifies a target
> by a pid will get a new _PIDFD version and the pidfd is passed as pid_t
> argument. That should work and is similar to what I did for waitid()
> P_PIDFD. Realistically, there shouldn't be any system where pid_t is
> smaller than an int that we care about.
>=20
> > In effect this is not much different from your a), just a variation on =
the
> > calling conventions. The main upside is that it avoids adding another
> > ugly interface, the flip side is that it makes the existing one slightl=
y worse
> > by adding complexity.
>=20
> Basically, if a new syscall than please a proper re-design with real
> benefits.
>=20
> In the meantime we could make due with the _PIDFD variant. And then if
> someone wants to do the nitty gritty work of adding a ptrace variant
> purely based on pidfds and with a better api and features that e.g. Jann
> pointed out then by all means, please do so. I'm sure we would all
> welcome this as well.

I agree. It would be a shame to add a new ptrace syscall and not take
the opportunity to fix the multitude of problems with the existing API.
But that's a Pandora's box which we shouldn't open unless we want to
wait a long time to get an API everyone is okay with -- a pretty high
price to just get pidfds support in ptrace.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3oqbxiocwy4jimao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXqd8tgAKCRCdlLljIbnQ
EgHUAP0eXsMeBvX6165xj8TEMgh4rB2Aum2qA+WKvKBlmmoq6AD/UQdz5i+S0aA6
FmHhKfcX0nKnO3Qpss//v+w7UiJH/AQ=
=FQhY
-----END PGP SIGNATURE-----

--3oqbxiocwy4jimao--
