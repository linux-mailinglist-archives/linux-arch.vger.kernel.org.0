Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD80717D64F
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 22:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgCHV0N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 17:26:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:37857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgCHV0N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 17:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583702751;
        bh=Yi7lbxUNXC68w1fVUFuEzq9bidnvSVyt1lzmxMiOzYc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VbEOItHQu99JI/WzUZwH4KNKfLIGNQQo2W+hUBjr77xN8WogyXp5Ug5C3a0bz0NwN
         b5fBorNHMlKX/+XS4Ajy7dL/YbeGuqAAZHMGnNqqkTrdCJa3zbNmN+tuiTd4gBkXan
         cLUQCWrOSACXwBp4aLWfbxpUeAoXN+xnSGebWwy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.212]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Fs-1jfQN71rvS-00oCaB; Sun, 08
 Mar 2020 22:25:51 +0100
Date:   Sun, 8 Mar 2020 22:25:49 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] docs: atomic_ops: Steer readers towards using
 refcount_t for reference counts
Message-ID: <20200308212549.GD2376@latitude>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
 <20200308200007.23314-1-j.neuschaefer@gmx.net>
 <7ff7dc4e-d606-e2a1-edce-a0485e948e48@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
In-Reply-To: <7ff7dc4e-d606-e2a1-edce-a0485e948e48@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:31tpsmX2Gc4XHZFgNmUMGC4L5JPVlXItfoeYC+QBaOB0PGXoDMW
 708cPNcULQJEhwOBvM51ZAWsUOMfQS9O79xlO8u+k3fZMpS1F6PrEPhJFYJq0e25VsnqMbc
 eMjaOiHfO6IPe+F655FQdWYCls5tcxh8a/I+NNhR2aOM15YhHEAZRb/abow40xJ5ALSvKyq
 IZW3bFVWGBSeqpfSB3B/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2qhi7sL3Vwc=:PiVsK3k6q8txHd14E9zckk
 txZhgvCNtdiRzdTqbhZwg1VN31OGFDhA/7O8UGauSKjiMqD3FTl8eF0E+SRgM7mQO0RCzauXs
 0uMv1JgExncQVJ1grsElV1a2OGqC2sBVOy590+NWg8OAdHpqRhWQ3uIqtqWcPX2D2Hf2JAAeM
 XpbOfr5FP++G21SBRNeJ6laa5N9qfetcFTyhv1OXoghYinWyXrL013XgDtddICiZJ9e1iaUQz
 AAscmPj5D2sWCWOgi5CowZcG2WaS7EhCoUx7oK+nEfJ9tLFyBXnxS8+xWzvoQOFsP1lV/Wmd4
 hW4tyCJ/hMy5PxL1JG8cqnTOZS5Y/nuohcxoMAEZRhlItLjtN9tgblututVw6XnqV/AN2qIr6
 hAyHEi6XyF8r2qxalAUDfoUUj7PFbitfnsQZ4GRcDKRr9XljdT793ebMp3Kb4KEVQlWYStdO4
 j99c95PRpFVZrq19LwFRDgTsSrZ3PGFGmFNEK4ApkgU5lF3CF8hAjYyXnj2ku/L/nNWqElItT
 hhgKSjCfOFKuto22TEyKBx8QqQUqOFv4sHNZw0Nzh1rUNh2ODwai8Rsw9Ntcdrw+bCMOVO8Ae
 ZWTZMOW1HKu+MO5Qemv7zdl+DuQXd1Vz9VwnXXhmX/yqa49f081z37jTGO0QVITM18+3YKdnM
 vhcO44rZRVSuLz2+hP9Yh+6IMKDQ29dqhx39jtuSPWcCwj+CFNGDHQhwv3srKKZEPDiFWlGep
 jxA58RYcmcPUugoQm6VKiAG7X9qb1w8z7fZwQnOzc1Hh517T0N4+Lj74BZQRpUDtS/o1DuWUw
 brMtnlE1TWeXAV04DasHXAvnVMGp4esM3xrP4p5FLY1RP9ijx/FluJlU2Y3u/3F/gN/R3gRd3
 1EPCZmxFJmGu3lmFmzS16pv2nJTQJ88nyqocjDhlAXYUoSnh+QkVZYI375coifhiwXkw0QduC
 Zf8Md1T5ZGPfWVxebmpCqjiiZATv+hXhMH5Bx1VHITBTiYcS0Ls54CLEkhQnkFjUBjv3TkNaF
 /Mmk4tyIDtQjje31PNk2cFa1rgatVSYr18nvtXdEiJqX8wNHYExcO7hJULuGH3W9BLql0RSGZ
 kjOclGnCFeIaMUbwBgFMEs0AlxTy3T1UqrD9SrkiaouvDrw32VNKZvzViS5yhGd5+bArc7Uxb
 HMILb2m0xZruyEx163z5f1A/kbaBNqj6txR3vzs3mtpe+J8iSHDtxyBOE0KbNetGGMJlOBnmD
 +boFJYrtTsP5cRjo7
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2020 at 02:07:46PM -0700, Randy Dunlap wrote:
> On 3/8/20 1:00 PM, Jonathan Neusch=C3=A4fer wrote:
[...]
> > +        More recently, reference counts are implement using the
>=20
>                                                implemented

Indeed, good catch.

Thanks,
Jonathan Neusch=C3=A4fer

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5lYtYACgkQCDBEmo7z
X9sxeBAAoyLudMLbrFONlymj1JeXx3yBqw9ZfcOD64ryxfRRF2m1ubwkq6vR+prR
YK0WpHHC9iG6gaW6cF0cZtyt+ees8p2KrOgrwVV9Zol8TRQjM9Y2MdOD6YO5+qQn
AzzjKW6kA4F8la6p1YRXO5ZNZMfzZiJ+7/v7nPtsLzTPcU2TJsEgVGsyuLgh3uxd
AyOtCQmzlQseb6F75DL4gz2gujhqp/UReekuSDrRpyeAHNs24z8ImDNm6CvLDGAH
8bWD/XlopYXE50OalKh150cd1p6xlf8XO8fHIuUqhlJfb1caCBxLQy2Hsc13IyWR
seT0BR+CCr219TO0K0fo2MMjK1gICUXpZqGH2q3Jv3Jbb77BDLsnugOyHQ2A7Bbr
pb//s740vURsI3y3D0+GhttA6OuS5LY4RdmcRqcUDWdem5c4mEa//5F6C/d/vcV5
9Wfuz7A7RAZJjW8RzY3d6G44GumNOaRav1CUm3z9Tuy7NHgzUP2KGxshZAT7pbRg
JOUiNzwKjroh7+1qo6QB43p5q0SEt9WoiCNr6TItHRSaMTIKTWmk+t1MnQyJUwik
AcgOcDfcvXhaGMMFHx9uweA9m7q9p6N+b2CD4KesE6PiYS3mU7lEBlTtBRBMZTMP
w5AIXElmYgW3xubTKzsfe3Z8U2vCnEhIs/DWjBVc/36QJTWvhU4=
=kF/P
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
