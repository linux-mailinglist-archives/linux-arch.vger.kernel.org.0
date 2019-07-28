Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E277D31
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2019 04:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbfG1CIt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jul 2019 22:08:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47057 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfG1CIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jul 2019 22:08:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so56337884qtn.13;
        Sat, 27 Jul 2019 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V61NPWjchiBOHtAmKVIMz0adEPCVGxNV1XN6PxXx67M=;
        b=EPekws7UfdQ9SxeCls6K/cBGyxQJMdNH73q2PVtjFZjkWBdqtFIagl+8KeStzETwm7
         tlGkhlH1OlKR566C4Knw05CgZXBLY88K/2DTi4WkhO4MWS+7SMcG+j0tu+M4mVndaABS
         C0c04I/SPrxUaJmmRIgis3dm5/ATDyGBULwoznHkr0mKw82YEcDyaPWjJR6/SjMSGFr+
         rY0+95sFEu2pWxuVIxoA4zine9VK7wby4sOY+I425SET/nIoywFxWvtXEt+ObsL1Gcae
         fTVAaw58s7fDDeCs+cCemdsFjvcIg0bDyymxnXpgMKs6cncwOLj105be9KefHvhZ3IjJ
         PgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V61NPWjchiBOHtAmKVIMz0adEPCVGxNV1XN6PxXx67M=;
        b=Y5RXy/fNqTNSniWuQo9hnw8j7E+4SaSkAsp1TTd+mbFowDZe/ncQO9/c4gDabSY5sd
         mOR2FxID2spnBXgiGZ69I2HM/5Qq7p7B4sXuq97aCwLXuEOefM6ktfRJeBDEb2EOWOKG
         4/O0Pq/MJVOu6kqX+0g0oeqOO5cK9/QHNtrCFEb4tX3Nnh8oisWVG5Fphw9Vl3LtmI7+
         e51hkb97YTgLNZuGybcEgPD2LCKSVYw+q6GGOHGQevnMsVPjwiaXb2n6khmyg5H0e7Si
         d8hlS7LlDW6nyoX73dZE074UzM/4b5EsLfwdCc2GBqf7L2OO6+bEP21gFoM60e85GcFx
         tMVQ==
X-Gm-Message-State: APjAAAWo0qV0g0FvMlPLe5QBkTf9zJ0rRDC6UhtaqPdQEsXxanLUf/26
        sI+1D1sUP9XU7BVgyjaT3PA=
X-Google-Smtp-Source: APXvYqzKB+0TTEbHdA8NzubHRg78yf/Y+7jRdzjTirwnfGCdY5CkqWR3B2xDP63JUD8WVVDqtfq4WA==
X-Received: by 2002:ad4:4a14:: with SMTP id m20mr72715562qvz.58.1564279728293;
        Sat, 27 Jul 2019 19:08:48 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v4sm23902354qtq.15.2019.07.27.19.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 19:08:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2246B21B4C;
        Sat, 27 Jul 2019 22:08:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 27 Jul 2019 22:08:45 -0400
X-ME-Sender: <xms:qwM9XVYJd7mHLHs4PWPP2E_c9D0gGWaA1MFpfCRHGpe9Cy1hkVWKkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeejgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeeghe
    drfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:qwM9XTIoutbrefs1aBKSJOJAxFCzPhsni7rmR7coDb4pScmEqqpvHg>
    <xmx:qwM9XQH-Kf2g8lbpe7GePr-H4Is3TIUM8er_8NoxcIHcqV1GE5FdqQ>
    <xmx:qwM9XUcyfvJgWmlbQMtuICnPVFvqHhnNJS7RrqnvTsqrcb_yGdXkxQ>
    <xmx:rQM9XY1zPqRDlv5-YN7aVf0A286jbwrsLGguL4Flo8YN5bO3EjzkTZmnpsI>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06DA2380074;
        Sat, 27 Jul 2019 22:08:43 -0400 (EDT)
Date:   Sun, 28 Jul 2019 10:08:37 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] docs/lkmm: Correct ->prop example with additional rfe
 link
Message-ID: <20190728020837.GA26905@tardis>
References: <20190728000031.112364-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190728000031.112364-1-joel@joelfernandes.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Sat, Jul 27, 2019 at 08:00:31PM -0400, Joel Fernandes (Google) wrote:
> This lkmm example should describe an additional rfe link between P1's
> store to y and P2's load of y, which should be critical to establishing
> the ordering resulting in the ->prop ordering on P0. IOW, there are 2 rfe
> links, not one.
>=20
> Correct these in the docs to make the ->prop ordering in P0 more clear.
>=20
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/memory-model/Documentation/explanation.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/mem=
ory-model/Documentation/explanation.txt
> index 68caa9a976d0..6c0dfaac7f04 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1302,8 +1302,8 @@ followed by an arbitrary number of cumul-fence link=
s, ending with an
>  rfe link.  You can concoct more exotic examples, containing more than
>  one fence, although this quickly leads to diminishing returns in terms
>  of complexity.  For instance, here's an example containing a coe link
> -followed by two fences and an rfe link, utilizing the fact that
> -release fences are A-cumulative:
> +followed by a fence, an rfe link, another fence and and a final rfe link,
> +utilizing the fact that release fences are A-cumulative:
> =20

This part looks good to me.

>  	int x, y, z;
> =20
> @@ -1334,11 +1334,13 @@ If x =3D 2, r0 =3D 1, and r2 =3D 1 after this cod=
e runs then there is a prop
>  link from P0's store to its load.  This is because P0's store gets
>  overwritten by P1's store since x =3D 2 at the end (a coe link), the
>  smp_wmb() ensures that P1's store to x propagates to P2 before the
> -store to y does (the first fence), the store to y propagates to P2
> -before P2's load and store execute, P2's smp_store_release()
> -guarantees that the stores to x and y both propagate to P0 before the
> -store to z does (the second fence), and P0's load executes after the
> -store to z has propagated to P0 (an rfe link).
> +store to y does (the first fence), P2's store to y happens before P2's
> +load of y (rfe link), P2's smp_store_release() ensures that P2's load
> +of y executes before P2's store of z (second fence), which also would
> +imply that stores to x and y happen before the smp_store_release(), which

I think it's more accurate to say:

"imply that stores to x and y progagates to P2 before the
smp_store_release()"

, because by definition the propagation ordering that
smp_store_release() guarantees only works with stores that already
propagated to the CPU executing it, not the stores that execute/happen
before.

With that, feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +means that P2's smp_store_release() will propagate stores to x and y to =
all
> +CPUs before the store to z does (A-cumulative property of this fence).
> +Finally P0's load executes after store to z has propagated to P0 (rfe li=
nk).
> =20
>  In summary, the fact that the hb relation links memory access events
>  in the order they execute means that it must not have cycles.  This
> --=20
> 2.22.0.709.g102302147b-goog
>=20

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl09A6IACgkQSXnow7UH
+rg+7wf/XFideg6QZVgKL4rs10Ddm7DiVW1wbUEX1GGvlpvp6PUCReS6iTa6tDdY
3B6r1N+JWNVZMHSwiZp75bGhAow5isYI092NeLo1OGdsiBrr0qUFirAtQlm8G7Tn
L2xr75R7Z+vgz2KBDKZoLXz951hs4Qe02wwmMOPgCwyu0iz+crQwnNclrOjs9/Xx
blTx8UK3ektrGHZnDvYfGaZnrTzdsgj+Ji9TL0cloYviTh6Niluyo4R/G4UREbzX
5OfaKiz2THfl4FnyvvyZpHkNOfgIdPomVaaqAw0GgZ4N7HBg0VCLLlAdrFUF09rW
mTvI6Qr/Mm9ZLM7XvVHM4jTmUy9+FA==
=IRgM
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
