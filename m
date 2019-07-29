Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3878494
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 07:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfG2Fu6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 01:50:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40102 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfG2Fu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 01:50:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so58486549qtn.7;
        Sun, 28 Jul 2019 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJnhhgHnLqIOlIwAgwsCfyqdQVADZ5khuGZZWo4mIbQ=;
        b=jNcputYB/zL+UoOXfolJQzIYu7Qz5ryWcf8TWUQgbtUxYb3J1Q26WhU6RSIv/6QVzs
         xUXP8wk6mnInh0JBJmEFzQ17mW3Bmx2PRfLHo6LucaHs6IiPFFR1JlfrUVELi8cFl9Cx
         AjWQJux2hAVW7sNW5BrA70U/wpgFBZ5kIF+NCXSuHCNVMdBKNn7GVDDGba8H1mtp4528
         T7MJUDXD8dzyDT7VHNsgifJ/ic50iAOxCdD61SfJqegIY+94SZkiTdEiMYde/G0e6yv+
         32V5X0OfDy6PxChwzceFo2bTsp3R/SGaEw3Mfjus+g1xL5wjnGXpPEivy+jLKw2bgJVz
         X2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJnhhgHnLqIOlIwAgwsCfyqdQVADZ5khuGZZWo4mIbQ=;
        b=cYazK78KKWenbqpes7da4yRfaAqtllfKbqaz2CkLZSQB7KgeP/PEq9uRZCOuRqnS6+
         J5JTl4GvTSs9rOfsGz+4mRh4ojZzP118LFGxEiSCxabAN9AjdZrXzITMblxrp2oCwIL1
         S1lXBVCnwO4jveYoT9zclUDlRCGltwmcp6lKtwJmLVzOGA4DCkAkMGxYRUreZVGXDlxA
         FPmDsiuZ8qUsZjxthajdLB1BK4XyR41u3UYQ3UwmsMLMav0lbfFSN+Hwr0h0eSRY672Y
         ER4VRWgKSA+5kCWctKOgvGsTlntieth0yjECgVjlIkuU3NnA49mO5XfWMhW72xaPdDIP
         7OTA==
X-Gm-Message-State: APjAAAWIh7aHReKaHK1faAR9VtRVEC7KR+wr6En3UiIpchPmaJf71LGV
        vNI9x19MGbYXvsw3CQUkjPI=
X-Google-Smtp-Source: APXvYqzVqUlWniZ8Qntrv3+PgDDTdkuj4wGnMC4n0FE2MHYHSgCXor2P22W+K4SrZNMB5rNyaM73qA==
X-Received: by 2002:ac8:f91:: with SMTP id b17mr75584763qtk.352.1564379457327;
        Sun, 28 Jul 2019 22:50:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u16sm31089996qte.32.2019.07.28.22.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 22:50:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D230822265;
        Mon, 29 Jul 2019 01:50:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Jul 2019 01:50:54 -0400
X-ME-Sender: <xms:PIk-XdWXcT28NwSu5plHkyawQRNEHX2wY6IGcWZ8qIfGQPLb-y_j4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrledtgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeeghe
    drfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PYk-XVLjm6Hd2YjGmpN_v92crvQZzlhDvScn6Quw6UODoDDNg70glw>
    <xmx:PYk-XQ-Tay2TLnToxAlMz2iB0olWyvXNBLb5UwXxM-X6qWnhwMKMOQ>
    <xmx:PYk-XQSf8x1cSOpVlwxfNR-59NDBJ0olr5K0ZxFKexcyQlv7KferUg>
    <xmx:Pok-XajdRUCJduzBevKmOVU3n1iTNpe09RvKspJpFhX4013O9q3VsqJratg>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E6328005B;
        Mon, 29 Jul 2019 01:50:52 -0400 (EDT)
Date:   Mon, 29 Jul 2019 13:50:44 +0800
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
Message-ID: <20190729055044.GC26905@tardis>
References: <20190728031303.164545-1-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.1907281027160.6532-100000@netrider.rowland.org>
 <20190728151959.GA82871@google.com>
 <20190728152806.GB26905@tardis>
 <20190728153544.GA87531@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20190728153544.GA87531@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2019 at 11:35:44AM -0400, Joel Fernandes wrote:
[...]
> > > > > +load of y (rfe link), P2's smp_store_release() ensures that P2's=
 load
> > > > > +of y executes before P2's store to z (second fence), which impli=
es that
> > > > > +that stores to x and y propagate to P2 before the smp_store_rele=
ase(), which
> > > > > +means that P2's smp_store_release() will propagate stores to x a=
nd y to all
> > > > > +CPUs before the store to z propagates (A-cumulative property of =
this fence).
> > > > > +Finally P0's load of z executes after P2's store to z has propag=
ated to
> > > > > +P0 (rfe link).
> > > >=20
> > > > Again, a better change would be simply to replace the two instances=
 of
> > > > "fence" in the original text with "cumul-fence".
> > >=20
> > > Ok that's fine. But I still feel the rfe is not a part of the cumul-f=
ence.
> > > The fences have nothing to do with the rfe. Or, I am missing somethin=
g quite
> > > badly.
> > >=20
> > > Boqun, did you understand what Alan is saying?
> > >=20
> >=20
> > I think 'cumul-fence' that Alan mentioned is not a fence, but a
> > relation, which could be the result of combining a rfe relation and a
> > A-cumulative fence relation. Please see the section "PROPAGATION ORDER
> > RELATION: cumul-fence" or the definition of cumul-fence in
> > linux-kernel.cat.
> >=20
> > Did I get you right, Alan? If so, your suggestion is indeed a better
> > change.
>=20
> To be frank, I don't think it is better if that's what Alan meant. It is
> better to be explicit about the ->rfe so that the reader walking through =
the
> example can clearly see the ordering and make sense of it.
>=20
> Just saying 'cumul-fence' and then hoping the reader sees the light is qu=
ite
> a big assumption and makes the document less readable.
>=20

After a bit more rereading of the document, I still think Alan's way is
better ;-)

Please consider the context of paragraph, this is an explanation of an
example, which is about the previous sentence:

	The formal definition of the prop relation involves a coe or
	fre link, followed by an arbitrary number of cumul-fence links,
	ending with an rfe link.

, so using "cumul-fence" actually matches the definition of ->prop.

For the ease of readers, I can think of two ways:

1.	Add a backwards reference to cumul-fence section here, right
	before using its name.

2.	Use "->cumul-fence" notation rather than "cumul-fence" here,
	i.e. add an arrow "->" before the name to call it out that name
	"cumul-fence" here stands for links/relations rather than a
	fence/barrier. Maybe it's better to convert all references to=20
	links/relations to the "->" notations in the whole doc.

Thoughts?

Regards,
Boqun

> I mean the fact that you are asking Alan for clarification, means that it=
 is
> not that obvious ;)
>=20
> thanks,
>=20
>  - Joel
>=20
>=20

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl0+iTEACgkQSXnow7UH
+rihvwgApbJd9fPoi9lU3i7ntWzOi9gwzzrLdhw0fYQjT8dF9yg0JxkXOh7uSGUJ
l9rUTipvGtCX/uKqwIotoZ0YDe5zss4MVwu+YJQ7OcDIKdP8rHqiPdwE1qN00dDP
Mx2jrt+ESYqAYoekCDXHdLZa5LW80CNWveegFnCtcUxt5H+agGO0Q5lj5SPgIyJm
ZmAxFlXpUzrdFGI//LN37+Dlo181pqMTfFiqIPW7g/rmO4Rbqp4w46GA+gkZTq93
1Hx8+N4WyUKxf3tW8ySY5J2Yw8j7upWOs5d8hTaUzoBqM8D1yf9Zq+34axPFBMKl
ZrHlzvBVFOF9gpU0f6F3oUETLJZs7g==
=jDmd
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
