Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D565E84B1
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 23:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiIWVMf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiIWVMe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 17:12:34 -0400
X-Greylist: delayed 172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 14:12:32 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900E120BD8;
        Fri, 23 Sep 2022 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663967369;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8EPLphFDiNWhL8Pby2xknYdhlvv4EzmydKR54FAg9ec=;
    b=FJ5BKZNVBbU2DXafu0GgUWMFp6easC+IPpdyGoBCy+9Trd57UpARfp+YlYMWm6MeVe
    fHOS8xPTCSm+oaFO+oFfNG58dnl2bKCQUJtFyFDh85BDOfO9cDa7r3hkNGU39kYGiV+n
    zKbxZ/X6BHcth+iX+6in3jEcQb/ZdiPiGi1L7vkKFMs78tOTXjyDIp5l9N02EEL8Lg1e
    ZXVsWkjtlbDBdBufUZFtERmVCW+veSSjbvfdhyCB4ymkHTZGlCWVXWQu8PD4oMYD+dVO
    9WUPFmOs15INSJ3ZQaitO1n+/h+KPGJ3uIzXz0J4SOZHpxmODvhcOwpe7KYBJp7IRyxv
    OOCg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX2j/OiDv7LX1ITFkr8sRtLhQJY8wZFK/j9E"
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id 5c8007y8NL9S46H
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 23 Sep 2022 23:09:28 +0200 (CEST)
Date:   Fri, 23 Sep 2022 23:09:17 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] hyperv: simplify and rename generate_guest_id
Message-ID: <20220923230917.1506b24c.olaf@aepfle.de>
In-Reply-To: <20220923114259.2945-1-kunyu@nfschina.com>
References: <20220923114259.2945-1-kunyu@nfschina.com>
X-Mailer: Claws Mail 20220819T065813.516423bc hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z3ZAMBJAtFD2rTlSe3KLu4y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/Z3ZAMBJAtFD2rTlSe3KLu4y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fri, 23 Sep 2022 19:42:59 +0800 Li kunyu <kunyu@nfschina.com>:

> +++ b/include/asm-generic/mshyperv.h
> +#include <linux/version.h>

A very long time ago I removed most usage of version.h AFAIR,
so that changing uname -r will dirty just a tiny amount of objects.

But, this header is always coming back, like bad weed.

Please reconsider the suggested approach.

Thanks,
Olaf

--Sig_/Z3ZAMBJAtFD2rTlSe3KLu4y
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmMuIH0ACgkQ86SN7mm1
DoC3eRAAkDcW4/OMC2M5K/p97X4kMMDJalIMuj5+exf0jitT5Yji2HJfkg38hYJ/
nVzOW2oM6Tbkyj9F5/UCYyjMnBFkZrEDyVOEKcqzxk7ApSbR3P/vGkPDyDMNQYuW
nOjqvsN/YESTgf3K8dWohCYhQVkASmaKjwu+hg5YmWBBhzPa+cyeG3sTAkISP2Ng
nIgm04SFsrRm0/paEaBI8xetv9wJbuuQr+Ns6dAsfVAn6hUYYaCHkGpBe0BUgkmk
BAKZNOwE1Oqf0fikpbYRkUurZkdTjWFZLTWcWXp3ySrZ6EL7rJiKKLSITB7IPbIY
068g8pUpDzCkr69GqUkzwdKtyn+EgjGh5S97+hyJHiWrXfVEIg9JJml1eIYh6vQf
r/WhQA/97K6OOSPBE+aVe+KqPq60l90aYGAPJ1/hncteNSedcbRGPcfU8M9qUt8z
3FXHCMRAqCPShqIaIwIqARjdUTxnaxT7pnGBzeCdioMUscwpvNuwi7JUT9/FRCMU
PXm0FM2RDsK6NSnZxvynn25OUe9ATe52xIXR1KNnBkNNWl3o8KnO+KgZdRrdMEj6
Po57fY16DRWw4loQ1vKwKyua3WmIdWYCVp6uCXqlTjXzxtGjUwRMpFk4+Zktpqlh
X8WAjR8j78yPBQ2iFVh0rHZt/zg+Q7jSMF27aWS2U+n8G7NiIdY=
=HYtH
-----END PGP SIGNATURE-----

--Sig_/Z3ZAMBJAtFD2rTlSe3KLu4y--
