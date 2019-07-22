Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357C26FED2
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2019 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfGVLix (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jul 2019 07:38:53 -0400
Received: from sauhun.de ([88.99.104.3]:39256 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfGVLiw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jul 2019 07:38:52 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 2529E2C28E9;
        Mon, 22 Jul 2019 13:38:49 +0200 (CEST)
Date:   Mon, 22 Jul 2019 13:38:46 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/14] docs: fix broken doc references due to renames
Message-ID: <20190722113845.GA1115@ninjato>
References: <cover.1563277838.git.mchehab+samsung@kernel.org>
 <aa415583bf6b812b0249093a601aa31412f3a1cf.1563277838.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <aa415583bf6b812b0249093a601aa31412f3a1cf.1563277838.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 09:10:42AM -0300, Mauro Carvalho Chehab wrote:
> Some files got renamed but probably due to some merge conflicts,
> a few references still point to the old locations.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Wolfram Sang <wsa@the-dreams.de> # I2C part


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl01oEEACgkQFA3kzBSg
KbYvLhAAiBCzjlLaOX8TozT9yXWwqRye46Tkkjqei2Gh2ruk6HulzAm4JLL1ghij
bD5UKIqsqMqs8SThEWtBr7lpGKPY5dTOO7Lvp3Gg6Ykw4DSJHjwRbY9Gz3eKpjm6
XCeKu+qe7IWU4PyqjfTmT2tYQBjZTg8+e5ycnPtgLxvLZGpqoOwplZvwady9klS0
6KfODAi0M8Bv05man76ECm1z4PeUjQMjuSgO4lxWDm9QPN6pL1tZ1DN4TWoQpmY8
gnS6iqRtIVwRqjxnx3BNP6q0iF0oMBIJbufn+udz5FVAvXkWtx6gaJ+HZO02CPnd
DfLhbW0h0SzzRnLA8rtuTQl/wJwHcfRtlYBNitXwbXIewlBTqlhzhvuW7JZnXJTe
QXk4bXJuRofQsmWiK/i6bP0ifWyWmH/mLQkZhXEAZXsiiSHYuLC0RGLYTk2OSbRS
d4kM+3WQfr0F8KTgmhKZv0g6yKqxziFVCBFMkKvpYqOfk3MuRf9JREpFnAmtHaox
310crjxth9IwT/SMq813fSz5+SueTeiTp7DZyOANc23QCyJTpTTnIsdpzYzna4+i
t8H5nyy2JKWKP7rvIfn2O4BKHOt14Klmbno/pUak4lxLadz7Av7mC65akEwLWSiI
0qO7h0/ZSuPlu8OPAyR3I7cvx8/RriyeQJUceA6/KjTSKtWhw/E=
=7t6S
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
