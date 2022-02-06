Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE74AB2BA
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 23:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbiBFWox (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 17:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiBFWow (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 17:44:52 -0500
Received: from mail.cs.msu.ru (mx.cs.msu.ru [188.44.42.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36012C06173B;
        Sun,  6 Feb 2022 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
        s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sMiUCqd3ioodflV6KZvkF4VCu6/X+yPX+o+Ps7GHE0o=; b=WZu8rPUpzzQdwfUUbKU00/Eoue
        DfdT2EIUC4ChyvthnFdPH/jE539S1pZ56xcQxsmg2CjWCBe/SiK6iCqKfb0KPZftIUjS1V1SNgK6A
        Mk82dzZo/MkOFG2Fbu9hpohc4TIoT5zv9eOccXnolLlUl89wVXeuDprrA712JkvgOFldg48XrIdRt
        +0lvvFvaEWCJ3GFlhtDF0ADgv8cWymvICECVS3iNTFkYWspVHpRhY2d9ivyQpmkegV0AmvYs7ataL
        805PIODNE/x8QiuaH1RYV2WPhJo/4c8KeaTETMwRELK8o4IggwWkPOhqXDA+5mS+mpUnCmitFhEKR
        5jddxf0g==;
Received: from [37.204.119.143] (port=42160 helo=cello)
        by mail.cs.msu.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1nGqGN-000KfL-Ji; Mon, 07 Feb 2022 01:44:09 +0300
Date:   Mon, 7 Feb 2022 01:44:05 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Walt Drummond <walt@drummond.us>
Cc:     agordeev@linux.ibm.com, arnd@arndb.de, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, chris@zankel.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, hca@linux.ibm.com, deller@gmx.de,
        ink@jurassic.park.msu.ru, James.Bottomley@hansenpartnership.com,
        jirislaby@kernel.org, mattst88@gmail.com, jcmvbkbc@gmail.com,
        mpe@ellerman.id.au, paulus@samba.org, rth@twiddle.net,
        dalias@libc.org, tsbogend@alpha.franken.de, gor@linux.ibm.com,
        ysato@users.osdn.me, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Message-ID: <YgBPNYhs/H0DwePH@cello>
References: <20220206154856.2355838-1-walt@drummond.us>
 <20220206154856.2355838-4-walt@drummond.us>
 <YgA8uIVSX5WSC6Wr@cello>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svn0gnZfWDGyJk09"
Content-Disposition: inline
In-Reply-To: <YgA8uIVSX5WSC6Wr@cello>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH v2 3/3] vstatus: Display an informational message when
 the VSTATUS character is pressed or TIOCSTAT ioctl is called.
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--svn0gnZfWDGyJk09
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2022 at 12:25:21AM +0300, Arseny Maslennikov wrote:
> On Sun, Feb 06, 2022 at 07:48:54AM -0800, Walt Drummond wrote:
> > @@ -2430,6 +2459,11 @@ static int n_tty_ioctl(struct tty_struct *tty, s=
truct file *file,
> >  			retval =3D read_cnt(ldata);
> >  		up_write(&tty->termios_rwsem);
> >  		return put_user(retval, (unsigned int __user *) arg);
> > +	case TIOCSTAT:
>=20
> Perhaps we want to guard this (example pseudocode follows):
>=20
> 		if (*our ldisc is not n_tty*)
> 			return an error like -ENOTTY;
>=20
> ...since kerninfo is useless for non-UI ttys, e. g. serial device
> drivers, and this ioctl could mess them up if this code path can be
> taken. (I have not verified this kind of breakage is possible.) Please
> see the complete rationale below, this paragraph is an illustrational
> note for it.

Oh wait, this *is* n_tty_ioctl(), so the ioctl is n_tty-specific. This
makes the case below even clearer.
I've been clumsy, sorry about that.

> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 6616d4a0d41d..f2f4f48ea502 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -125,7 +125,7 @@ struct ktermios tty_std_termios =3D {	/* for the be=
nefit of tty drivers  */
> >  	.c_oflag =3D OPOST | ONLCR,
> >  	.c_cflag =3D B38400 | CS8 | CREAD | HUPCL,
> >  	.c_lflag =3D ISIG | ICANON | ECHO | ECHOE | ECHOK |
> > -		   ECHOCTL | ECHOKE | IEXTEN,
> > +		   ECHOCTL | ECHOKE | IEXTEN | NOKERNINFO,
>=20
> Does this mean that nokerninfo is on by default? Do we have a reason to
> do that?
>=20
> As of this patch we require icanon and iexten to be set for the message
> to be composed and printed. An experiment shows PTY encapsulation
> programs like openssh turn off both those flags on the tty they run on
> before they take control (contrary to what has been said in LWN), so
> they are unimpacted.
>=20
> The termios(3) page from man-pages states:
>    Raw mode
>        cfmakeraw() sets the terminal to something like the "raw"  mode
>        of  the old Version 7 terminal driver: input is available char=E2=
=80=90
>        acter by character, echoing is disabled, and all  special  pro=E2=
=80=90
>        cessing  of  terminal  input and output characters is disabled.
>        The terminal attributes are set as follows:
>=20
>            termios_p->c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>                            | INLCR | IGNCR | ICRNL | IXON);
>            termios_p->c_oflag &=3D ~OPOST;
>            termios_p->c_lflag &=3D ~(ECHO | ECHONL | ICANON | ISIG | IEXT=
EN);
>            termios_p->c_cflag &=3D ~(CSIZE | PARENB);
>            termios_p->c_cflag |=3D CS8;
>=20
> So any program which uses this API effectively turns off kerninfo as
> implemented here.
>=20
> There are 2 ways n_tty_status() can be called as of this patch: either
> from inside n_tty or via TIOCSTAT. The first path can't be taken on ttys
> whose ldisc is not N_TTY, ...

The second path is OK as well.

> Given all this, is there any other reason to enable nokerninfo (i. e.
> disable status message) by default?

--svn0gnZfWDGyJk09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAmIATy0ACgkQ9dQjyAYL
01BThhAAyojlvq3x6fFW7k+F5Rtcr5jxVEKrP8xCWEudyGFTFGl/swNMGGOpBxCU
eAd/mhCEXEt8QpI/F0wowD7QpFhpWDzTuXQ/LUUyu1VJURaKeH05zrT6AComAyz4
Y0xowt5LE0NLBUhnhCPckh26xJw+8ThB1C8rEq0FX9YrnGDaFtMhgZ4vIfpxHpe1
G+rTk18gFuNPZ8b6mknle7fgPWDxpnNQ0qs/aA56EAzdVVJcrwaWaw3GSnnvn/gQ
lvW8i/lSyIxF19Df8bsCEk01bEuHebBRck7wnT/PSkh2oP7lDBWJ38lWzHyTiQIU
w0k6/7PzyGdy23T7HCMApyaXSYzX6qHPwFo43nR4k5bYa+74RUBoxckJlv4E/7y/
jCzcbdIFuWhGwK2R6Wjlw/i/awuBIRrIcBTNqz1OGUxyKEj7Oo45BtQoEh1bxAyn
O/IDgY0riOZcB0MdPyUvWlpAvdAhBgxfPVVNDttm5CG/qBt8LLnLB/cYfSW6eUGq
FDGxXTcM02iFrVnzb010DgbV8v8T2ijwVNDkv3QoOk4uz4l+nbwXlKoGcBkT0ipx
RKXSBlAZcf1UOntNvCX0bTW0k2h7lfLiuUFxc/VasYl3rt/1Y6wfBlv7HpqMPt3I
2ER6KCbkih5045twm/xub9qDsnanN6q4ck5lprnO1T4rDPVXvH4=
=jF16
-----END PGP SIGNATURE-----

--svn0gnZfWDGyJk09--
