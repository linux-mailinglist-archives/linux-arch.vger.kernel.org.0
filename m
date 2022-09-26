Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEED95E9B61
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiIZIAe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 04:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiIZH7n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 03:59:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F1114091;
        Mon, 26 Sep 2022 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664179022;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2aIymE8raxhclQFqdfiAunlbp0ivgK4VjNPOxvkHMk4=;
    b=a+4Qk+xEsdXr8d9TH27PtKoKWFIXUwlw95X/NLGKUCOnj3uciZem1gugMB+0aEndC/
    5TCXYFBVGumqpsXuKSEa3+ORa2+MNKaaQZU95+KogezrdpHWOR0EFF2pAg9BXgppMxk9
    CKC+juyEWP0+s1CfYQvxeshL2IQSAmsdxboCdrxFaArNPgdB2MC0lkuiU6EJ7fDVv1De
    bEvUD8CFrH/y2YxvoQT0si+bLIiEFJsHOgep05CFnixRXY6VTiM1p0IBNlPBeK1yvtqt
    tqI+Bfz6xwSkgNuFybDuH57N+0mNmD6j4ARQr1u8bo/irtEbrzaJkFvYYGDub/xlZ/v2
    0MEQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX2j/OiDv7LX1ITFkr8sRtLhQJY8wcRJ+GvY"
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id 5c8007y8Q7v0Agb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 26 Sep 2022 09:57:00 +0200 (CEST)
Date:   Mon, 26 Sep 2022 09:56:49 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Li kunyu <kunyu@nfschina.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3] hyperv: simplify and rename generate_guest_id
Message-ID: <20220926095649.1f963340.olaf@aepfle.de>
In-Reply-To: <BYAPR21MB1688890F578A59F69DEB55C1D7509@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20220923114259.2945-1-kunyu@nfschina.com>
        <20220923230917.1506b24c.olaf@aepfle.de>
        <BYAPR21MB1688890F578A59F69DEB55C1D7509@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Mailer: Claws Mail 20220819T065813.516423bc hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LnhPDSg==ZfryNf0WVxkG4t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/LnhPDSg==ZfryNf0WVxkG4t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sat, 24 Sep 2022 05:31:34 +0000 "Michael Kelley (LINUX)" <mikelley@microsof=
t.com>:

> From: Olaf Hering <olaf@aepfle.de> Sent: Friday, September 23, 2022 2:09 =
PM

> > A very long time ago I removed most usage of version.h AFAIR,
> Could you elaborate?

It is the cost of 'make LOCALVERSION=3Dx' vs. 'make LOCALVERSION=3Dy'.

Too many drivers will be recompiled for no good reason as of today.
I claim no consumer below drivers/ and sound/ has a valid usecase for versi=
on.h.
But, someone else has to take the energy and argue them out of the tree.

With the proposed change every consumer of asm-generic/mshyperv.h will be d=
irty,
see 'touch include/asm-generic/mshyperv.h' for the impact. Therefore I think
only the two existing c files should include this header, in case the provi=
ded
information has a true value for the consumer.


Olaf

--Sig_/LnhPDSg==ZfryNf0WVxkG4t
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmMxW0EACgkQ86SN7mm1
DoDG+A/+NdczrJbTrLhHY24iKyo+iEXnHP0XFl+2Wz0JDdS9TYhOp4qk8vIf7Gop
7V3TtYytLyl8v0jdoFjmLhDTijp4l8TbY5AvSZ9C19xGnFb4wDqnGlK9A+7lAfnG
Db3SMwatykAgj6aTVP9Ckrrg5pp7DwuUYHVYsjyB4DqM89ApeXmZvE0RwNcX24sz
VYmtrtRDNT/spTwAVRH15sHt6gQV+p6OgplLURbop8vbpJl2aZNpIIboJTLa5X8p
KN3rYHJ6AUnrIJRki/ffhBH2dxIc4iAzt5zTXNJLQ6yVcIMJD2bNMxzN2FNZIC5v
/V1Bb9jftZzram3UtJ1qvFpGhPRVcfHnm1HPV9bSHRECa7TwGiDZWEZ6Js7ab03G
ZRIU+cqrmyiFY6LjkHfxRReupYUJMU5Ykfon/j7eeZalW88QgPAtzjDAaaErcfGQ
3yG9O2kl0idCguwSHZ97DDnfpRt87oICsgjOhwvEkPhTLpg5HOAcFjbCL3bKkauh
lb1Q4lk3qcTjlwAXdJEvGrePJYL3jjhfBeQAjvCYSqBIZAnn/I/5Vdk5R/MOJGRU
sDCVZQGMV7KsHurnBkGV+jgpoF7Mlced2d7h/4tZ+B/fL6TQ7cGEmRWly2pLQ9q7
JCFWuiKkyijJxhek0s7Duzor29fTuKavonHEVPAEUeSRiU66GYQ=
=rHAw
-----END PGP SIGNATURE-----

--Sig_/LnhPDSg==ZfryNf0WVxkG4t--
