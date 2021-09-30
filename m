Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04541DF0F
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350390AbhI3QcO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 12:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351270AbhI3QcH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 12:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633019424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7/zMdrPeVyZNLTntHruwDpYub+H9qwtzzzSUntktcA=;
        b=KtA1vjLn+sdHoDiIp9U80N+wzWoU16UzI9ctPdYu1NI7JyATuhgYtjUVHt83ENNgKPDPN8
        8KV7+pvJgacC5DYhXHCadsS8lsfBNvim4lVPj5xRaG3qLw59KAsqGS5R7/vt9DosZQKLfh
        xw3VplwDXdw7nRGGt04wxPB7kzwep+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-z2r_DDwdMRWSxVzVoPhJUw-1; Thu, 30 Sep 2021 12:30:22 -0400
X-MC-Unique: z2r_DDwdMRWSxVzVoPhJUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FA3A18125C0;
        Thu, 30 Sep 2021 16:30:19 +0000 (UTC)
Received: from localhost (unknown [10.39.195.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3A2B1017E3E;
        Thu, 30 Sep 2021 16:30:18 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:30:17 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Message-ID: <YVXmGTo5Uzp44QQq@stefanha-x1.localdomain>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <456bf9cf-87b8-4c3d-ac0c-7e392bcf26de@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IzEoHzzIxT1o87/+"
Content-Disposition: inline
In-Reply-To: <456bf9cf-87b8-4c3d-ac0c-7e392bcf26de@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--IzEoHzzIxT1o87/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2021 at 09:31:34PM -0700, Andy Lutomirski wrote:
> On Mon, Sep 13, 2021, at 1:01 PM, Sohil Mehta wrote:
> > User Interrupts Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > User Interrupts (Uintr) is a hardware technology that enables delivering
> > interrupts directly to user space.
> >
> > Today, virtually all communication across privilege boundaries happens =
by going
> > through the kernel. These include signals, pipes, remote procedure call=
s and
> > hardware interrupt based notifications. User interrupts provide the fou=
ndation
> > for more efficient (low latency and low CPU utilization) versions of th=
ese
> > common operations by avoiding transitions through the kernel.
> >
>=20
> ...
>=20
> I spent some time reviewing the docs (ISE) and contemplating how this all=
 fits together, and I have a high level question:
>=20
> Can someone give an example of a realistic workload that would benefit fr=
om SENDUIPI and precisely how it would use SENDUIPI?  Or an example of a re=
alistic workload that would benefit from hypothetical device-initiated user=
 interrupts and how it would use them?  I'm having trouble imagining someth=
ing that wouldn't work as well or better by simply polling, at least on DMA=
-coherent architectures like x86.

I was wondering the same thing. One thing came to mind:

An application that wants to be *interrupted* from what it's doing
rather than waiting until the next polling point. For example,
applications that are CPU-intensive and have green threads. I can't name
a real application like this though :P.

Stefan

--IzEoHzzIxT1o87/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFV5hkACgkQnKSrs4Gr
c8gkYAf8DF5mZAyvdq7MYNw7V3LLjLXQA/PJX65e9s/VzX1DOImgxepjEQfAkQUT
/IncDgMu0mkE0+jU/ZwEngFzI77d5uDzt/xV8cVHjqfE7vCy8SASNg4HFijkl7aF
aS+vZ2XK89S28S8ocQ/d7GPE80E+IEuxjInzASwimHFCmFtW8U+ka4CmIxbsw6e1
1ahYfTSnKrwSR2qSzW7cwU4WZFibG0TR0Lgz/oBm9dQuqu7IArWmSTNRKAQPJtqU
Q+TtjQh/s1Gvvzq8gvdBB6/2mWVE4fUfwatayUBb3HdcUt+5/J32kT/vjeY9HSZL
PkwYaTLC72ly4H9nhy2lYDD7XbfgFQ==
=O0C0
-----END PGP SIGNATURE-----

--IzEoHzzIxT1o87/+--

