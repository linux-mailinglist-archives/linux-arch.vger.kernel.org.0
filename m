Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908411F3FE1
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgFIPxf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 11:53:35 -0400
Received: from ozlabs.org ([203.11.71.1]:49977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbgFIPxe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jun 2020 11:53:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49hF5h2Zbfz9sRK;
        Wed, 10 Jun 2020 01:53:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591718012;
        bh=MVR0wu1WoLMcDMDIi7X7cjBzBYkvIBCEhvhBXLeas1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kd6bzfOPzl1O284EHmMfACEZ4Z3kTmQt3TkPdxk/xbq/g+CndtPFmzrb5I6cFIjL3
         TCj8JaxomBlTHtD1HNd3lc11OaisOObYmnDuz0FWnhNXSbk6sQLB5RlzgJ0kKRUzeO
         4RR9BFJegW96ziLLfs0zdJoGNtdfcBxK/U97/BO3jytFhykBazbLcZNC0CG1U2m2mH
         XQv7oGH3L2LTlmr4yTmGzGKyWtcRG+9Y55CWOl5wpi02RuPeOuAVdUc5/3abNg45Jz
         0YoTrf4Qt9kN56z6VRUaS9He9TnbXXz9osNTC7BUx30agRYOyV7aR7iIGkseR/qS8O
         YxmXhftkoU8cQ==
Date:   Wed, 10 Jun 2020 01:53:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, jroedel@suse.de, linux-mm@kvack.org,
        peterz@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linux-next@vger.kernel.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@kernel.org>, manvanth@linux.vnet.ibm.com,
        hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Move p?d_alloc_track to separate header file
Message-ID: <20200610015327.02d210ba@canb.auug.org.au>
In-Reply-To: <2aecbc65-db1a-dccd-046d-b7c97b714ee0@csgroup.eu>
References: <20200609120533.25867-1-joro@8bytes.org>
        <2aecbc65-db1a-dccd-046d-b7c97b714ee0@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rdvwFz8_JqljFG+KPhRUM/U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/rdvwFz8_JqljFG+KPhRUM/U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Tue, 9 Jun 2020 17:24:14 +0200 Christophe Leroy <christophe.leroy@csgrou=
p.eu> wrote:
>
> Le 09/06/2020 =C3=A0 14:05, Joerg Roedel a =C3=A9crit=C2=A0:
> > From: Joerg Roedel <jroedel@suse.de>
> >=20
> > The functions are only used in two source files, so there is no need
> > for them to be in the global <linux/mm.h> header. Move them to the new
> > <linux/pgalloc-track.h> header and include it only where needed. =20
>=20
> Do you mean we will now create a new header file for any new couple on=20
> functions based on where they are used ?
>=20
> Can you explain why this change is needed or is a plus ?

Well at a minimum, it means 45 lines less to be parsed every time the
linux/mm is included (in at last count, 1996 places some of which are
include files included by other files).  And, as someone who does a lot
of builds every day, I am in favour of that :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/rdvwFz8_JqljFG+KPhRUM/U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7fsHcACgkQAVBC80lX
0Gweigf+PD8mMUG1c9BtwY0sS3cc9f4TEcShuv7vlAhWEDtMJ9S9N9/8iPkWNrhV
ULELcWDWgQozqP470o451a9APq+Llzh+bKUho77kXN3GEXlkeiR0Q0VzEIDRqB2u
D4fwyQH7pdPTQTnXCKffVuHk9D7PIp4/Y/d4oMwDRVkHppv7GmXzyq8iWjoZwkJm
E2hfxBWErz7ZQxHbkv7ns7pWvBSgjn0VYr6JqsyW4Sv199pESrO97zgKJFk7FD3M
NcqyhVvPxGwVYA8TstWfsokP5tPRz5RSABoZTNqmdwzu+I1gYEANCmPDnC9zetHn
pvmbLciQrEbjgRevDnJHaJQZiNKVnw==
=xmAg
-----END PGP SIGNATURE-----

--Sig_/rdvwFz8_JqljFG+KPhRUM/U--
