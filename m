Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F60E7802B
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2019 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfG1P2S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Jul 2019 11:28:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36753 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1P2S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Jul 2019 11:28:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so57342852qtc.3;
        Sun, 28 Jul 2019 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0w9yYqcES2o05gonZr9zRP5Wl/3rtCQeTzQMgiwfiKs=;
        b=XyB89bKIeXZ11A0ivwxD32pSI7Cv+vKQ0QXzaltQZhhZ8pCdWXEXbx8b052XQrabJO
         HgAse6Ad00tYzEzAMHE/w1OihGGuXWJC6b6/1918mLb2DaJ5A5x4WP3ElPeyAMZZ/UTx
         QGPEqdvKvd8XmOHRr2smKA6gcoXFy3YF+9inAX+cwiOuiQfabXBUHkkdLAgLLRZf58lo
         sOD+lqn8doAVanVisZHhEcN4J6E+n/dYPNTy0EBZtn8TwCeoyA10zaSNfBxaDiTTHt1W
         j7W+sRvUwQvZxwxWyE3UJOxa5w9hpo3lkQu7HA11umd+rpjX1b0lEu8k8AtoodoHRnw3
         ARjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0w9yYqcES2o05gonZr9zRP5Wl/3rtCQeTzQMgiwfiKs=;
        b=mB92+mkot/hV108Y8ZK8Nc+gHqPvMVlaARxZZV1raXhM7r3EDNqd4usoyxrzCClMIU
         GqpowazVFmebyxA3p7RkHOfQWkUe7ttraOovwuj/zmENc5YmIrGC048EXgdtaYreu496
         yoCdcbrjcCiGQjfbwkRkYPWQSzrMk4oz5epX0tQG8sAdO2dOBQM1yLHfJts/JeE9vwu9
         VpezMi16Z1c7EsSZEY+mUh6RA40xkUhWoWKgoQQiBXqxr08yoH5fV3HgtBpBJQtUDeuI
         poUSbYqJmuCC+gKVWcTqxzUG/YlR5kaNBziCSw2k0j3K4pQwCN8xxXHgrc9lvM1SOMsd
         Iv+Q==
X-Gm-Message-State: APjAAAW9542J6SX3QlKzAchIDqA1B24CMhQ7lLbValg2qxF2rBWXNGKD
        CgmeD5uWEM+BYSrLYtSUV6M=
X-Google-Smtp-Source: APXvYqwClKx7vFTV9/E9AwGF1SIkXxaYvyIN/lpQXpD/2hdOb4tu2dO6bt8MRqm0MBW/rJIzS5/ohA==
X-Received: by 2002:ac8:2bd4:: with SMTP id n20mr75526234qtn.131.1564327697243;
        Sun, 28 Jul 2019 08:28:17 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q32sm25364274qtd.79.2019.07.28.08.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 08:28:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 51B4321B24;
        Sun, 28 Jul 2019 11:28:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 28 Jul 2019 11:28:15 -0400
X-ME-Sender: <xms:Cr89Xd4SDQToHv6-btJWHPtPTKcRZkJyCBTZ715fmIHZ9oh4CFZjdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeelgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeeghe
    drfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Cr89XRPFlfSLbpjripMHH8JnnC4QV18nLiucxBXHgz1gzLwka9cLBw>
    <xmx:Cr89Xadw5MvmoUX3akgvmtEMtQD30hPtE-g_hcq2re_v4XY4NR0LEg>
    <xmx:Cr89XTeiahgi1zb8uGitTFs5J0IKYhpd11ftqXFsjyxl99E_5oZepQ>
    <xmx:D789XWodY-BtYPOjil1c5VOdq0vcshu1OB_4mwcNSnJp6SFZHr40rTlrmgE>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2DE7380074;
        Sun, 28 Jul 2019 11:28:09 -0400 (EDT)
Date:   Sun, 28 Jul 2019 23:28:06 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] lkmm/docs: Correct ->prop example with additional rfe
 link
Message-ID: <20190728152806.GB26905@tardis>
References: <20190728031303.164545-1-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.1907281027160.6532-100000@netrider.rowland.org>
 <20190728151959.GA82871@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20190728151959.GA82871@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2019 at 11:19:59AM -0400, Joel Fernandes wrote:
> On Sun, Jul 28, 2019 at 10:48:51AM -0400, Alan Stern wrote:
> > On Sat, 27 Jul 2019, Joel Fernandes (Google) wrote:
> >=20
> > > The lkmm example about ->prop relation should describe an additional =
rfe
> > > link between P1's store to y and P2's load of y, which should be
> > > critical to establishing the ordering resulting in the ->prop ordering
> > > on P0. IOW, there are 2 rfe links, not one.
> > >=20
> > > Correct these in the docs to make the ->prop ordering on P0 more clea=
r.
> > >=20
> > > Cc: kernel-team@android.com
> > > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> >=20
> > This is not a good update.  See below...
>=20
> No problem, thanks for the feedback. I am new to the LKMM so please bear
> with me.. I should have tagged this RFC.
>=20
> > >  .../memory-model/Documentation/explanation.txt  | 17 ++++++++++-----=
--
> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/tools/memory-model/Documentation/explanation.txt b/tools=
/memory-model/Documentation/explanation.txt
> > > index 68caa9a976d0..aa84fce854cc 100644
> > > --- a/tools/memory-model/Documentation/explanation.txt
> > > +++ b/tools/memory-model/Documentation/explanation.txt
> > > @@ -1302,8 +1302,8 @@ followed by an arbitrary number of cumul-fence =
links, ending with an
> > >  rfe link.  You can concoct more exotic examples, containing more than
> > >  one fence, although this quickly leads to diminishing returns in ter=
ms
> > >  of complexity.  For instance, here's an example containing a coe link
> > > -followed by two fences and an rfe link, utilizing the fact that
> > > -release fences are A-cumulative:
> > > +followed by a fence, an rfe link, another fence and and a final rfe =
link,
> >                                                    ^---^
> > > +utilizing the fact that release fences are A-cumulative:
> >=20
> > I don't like this, for two reasons.  First is the repeated "and" typo.
>=20
> Will fix the trivial typo, sorry about that.
>=20
> > More importantly, it's not necessary to go into this level of detail; a
> > better revision would be:
> >=20
> > +followed by two cumul-fences and an rfe link, utilizing the fact that
> >=20
> > This is appropriate because the cumul-fence relation is defined to=20
> > contain the rfe link which you noticed wasn't mentioned explicitly.
>=20
> No, I am talking about the P1's store to Y and P2's load of Y. That is not
> through a cumul-fence so I don't understand what you meant? That _is_ mis=
sing
> the rfe link I am referring to, that is left out.
>=20
> The example says r2 =3D 1 and then we work backwards from that. r2 could =
very
> well have been 0, there's no fence or anything involved, it just happens =
to
> be the executation pattern causing r2 =3D 1 and hence the rfe link. Right?
>=20
> > >  	int x, y, z;
> > > =20
> > > @@ -1334,11 +1334,14 @@ If x =3D 2, r0 =3D 1, and r2 =3D 1 after this=
 code runs then there is a prop
> > >  link from P0's store to its load.  This is because P0's store gets
> > >  overwritten by P1's store since x =3D 2 at the end (a coe link), the
> > >  smp_wmb() ensures that P1's store to x propagates to P2 before the
> > > -store to y does (the first fence), the store to y propagates to P2
> > > -before P2's load and store execute, P2's smp_store_release()
> > > -guarantees that the stores to x and y both propagate to P0 before the
> > > -store to z does (the second fence), and P0's load executes after the
> > > -store to z has propagated to P0 (an rfe link).
> > > +store to y does (the first fence), P2's store to y happens before P2=
's
> > ---------------------------------------^
> >=20
> > This makes no sense, since P2 doesn't store to y.  You meant P1's store
> > to y.  Also, the use of "happens before" is here unnecessarily
> > ambiguous (is it an informal usage or does it refer to the formal
> > happens-before relation?).  The original "propagates to" is better.
>=20
> Will reword this.
>=20
> > > +load of y (rfe link), P2's smp_store_release() ensures that P2's load
> > > +of y executes before P2's store to z (second fence), which implies t=
hat
> > > +that stores to x and y propagate to P2 before the smp_store_release(=
), which
> > > +means that P2's smp_store_release() will propagate stores to x and y=
 to all
> > > +CPUs before the store to z propagates (A-cumulative property of this=
 fence).
> > > +Finally P0's load of z executes after P2's store to z has propagated=
 to
> > > +P0 (rfe link).
> >=20
> > Again, a better change would be simply to replace the two instances of
> > "fence" in the original text with "cumul-fence".
>=20
> Ok that's fine. But I still feel the rfe is not a part of the cumul-fence.
> The fences have nothing to do with the rfe. Or, I am missing something qu=
ite
> badly.
>=20
> Boqun, did you understand what Alan is saying?
>=20

I think 'cumul-fence' that Alan mentioned is not a fence, but a
relation, which could be the result of combining a rfe relation and a
A-cumulative fence relation. Please see the section "PROPAGATION ORDER
RELATION: cumul-fence" or the definition of cumul-fence in
linux-kernel.cat.

Did I get you right, Alan? If so, your suggestion is indeed a better
change.

Regards,
Boqun

> thanks,
>=20
>  - Joel
>=20

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl09vwIACgkQSXnow7UH
+rhTkQf+P27OfVcqDn7RAZlp6KBxXcTwxUccGXSnJcXP3XYvPCkOSkFyBLkZeZbF
LM/uL1Ec0Cc6xSIl4Bsqh+y6C11SV5HibIaLRrzuuC2A9Hfzm0eU+6BhzX9ppLfb
0YVlO0aiwUhN4Dp3LLeJVCEkMkICgvW4sJtRNqGTf8f9SyjLrmQWClxui+PifO8O
ZHj5Lo03at/Qz5MCDTRAqfpfXY0h0/fI0tkLVlTn7115hUSessr5VQFbZCSjAe6L
Nmp8tNbqSgEGWiLwzaju7EOIGk3ffaHfPihl9V5PTg8mtXf5Bp9Ml+7WDnAr4uKO
Qj9ctOJd8qAjbRBoBeHLhhQtBvoblw==
=LDZp
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
