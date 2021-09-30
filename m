Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D689941DEFC
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350828AbhI3Q2b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 12:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350903AbhI3Q2b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 12:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633019208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8PISp8iVa05eQ0nPoH/bRhmYC2DUIpy9ROZ0Fj+fBBY=;
        b=Ncl7FmhqvoZGFcNlxr3r6omEUv9/KcNCiaygtQ3oaeUtmMQI7+WCzb5vYm0FDpa8sNwzfm
        OUf4ueP6ihsq8CpUUyqPwHmfcQcy+HKWmKfhAfhBcZlOg5CvCSxgiBvUMp7SgM9gZm3EWd
        1xLDmBPHYQrOlasLAL/Zfz9EFo81dbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-g76yGbzRPzCK8PZNQzH-fA-1; Thu, 30 Sep 2021 12:26:46 -0400
X-MC-Unique: g76yGbzRPzCK8PZNQzH-fA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D68F835DEE;
        Thu, 30 Sep 2021 16:26:43 +0000 (UTC)
Received: from localhost (unknown [10.39.195.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57C985F4E2;
        Thu, 30 Sep 2021 16:26:41 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:26:40 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Message-ID: <YVXlQIt/oWQlIupu@stefanha-x1.localdomain>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9X2Z49tWwf/3JF/"
Content-Disposition: inline
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--i9X2Z49tWwf/3JF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 01:01:19PM -0700, Sohil Mehta wrote:
> User Interrupts Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> User Interrupts (Uintr) is a hardware technology that enables delivering
> interrupts directly to user space.
>=20
> Today, virtually all communication across privilege boundaries happens by=
 going
> through the kernel. These include signals, pipes, remote procedure calls =
and
> hardware interrupt based notifications. User interrupts provide the found=
ation
> for more efficient (low latency and low CPU utilization) versions of these
> common operations by avoiding transitions through the kernel.
>=20
> In the User Interrupts hardware architecture, a receiver is always expect=
ed to
> be a user space task. However, a user interrupt can be sent by another us=
er
> space task, kernel or an external source (like a device).
>=20
> In addition to the general infrastructure to receive user interrupts, this
> series introduces a single source: interrupts from another user task.  Th=
ese
> are referred to as User IPIs.
>=20
> The first implementation of User IPIs will be in the Intel processor code=
-named
> Sapphire Rapids. Refer Chapter 11 of the Intel Architecture instruction s=
et
> extensions for details of the hardware architecture [1].
>=20
> Series-reviewed-by: Tony Luck <tony.luck@intel.com>
>=20
> Main goals of this RFC
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Introduce this upcoming technology to the community.
> This cover letter includes a hardware architecture summary along with the
> software architecture and kernel design choices. This post is a bit long =
as a
> result. Hopefully, it helps answer more questions than it creates :) I am=
 also
> planning to talk about User Interrupts next week at the LPC Kernel summit.
>=20
> - Discuss potential use cases.
> We are starting to look at actual usages and libraries (like libevent[2] =
and
> liburing[3]) that can take advantage of this technology. Unfortunately, we
> don't have much to share on this right now. We need some help from the
> community to identify usages that can benefit from this. We would like to=
 make
> sure the proposed APIs work for the eventual consumers.
>=20
> - Get early feedback on the software architecture.
> We are hoping to get some feedback on the direction of overall software
> architecture - starting with User IPI, extending it for kernel-to-user
> interrupt notifications and external interrupts in the future.=20
>=20
> - Discuss some of the main architecture opens.
> There is lot of work that still needs to happen to enable this technology=
=2E We
> are looking for some input on future patches that would be of interest. H=
ere
> are some of the big opens that we are looking to resolve.
> * Should Uintr interrupt all blocking system calls like sleep(), read(),
>   poll(), etc? If so, should we implement an SA_RESTART type of mechanism
>   similar to signals? - Refer Blocking for interrupts section below.
>=20
> * Should the User Interrupt Target table (UITT) be shared between threads=
 of a
>   multi-threaded application or maybe even across processes? - Refer Shar=
ing
>   the UITT section below.
>=20
> Why care about this? - Micro benchmark performance
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> There is a ~9x or higher performance improvement using User IPI over othe=
r IPC
> mechanisms for event signaling.
>=20
> Below is the average normalized latency for a 1M ping-pong IPC notificati=
ons
> with message size=3D1.
>=20
> +------------+-------------------------+
> | IPC type   |   Relative Latency      |
> |            |(normalized to User IPI) |
> +------------+-------------------------+
> | User IPI   |                     1.0 |
> | Signal     |                    14.8 |
> | Eventfd    |                     9.7 |

Is this the bi-directional eventfd benchmark?
https://github.com/intel/uintr-ipc-bench/blob/linux-rfc-v1/source/eventfd/e=
ventfd-bi.c

Two things stand out:

1. The server and client threads are racing on the same eventfd.
   Eventfds aren't bi-directional! The eventfd_wait() function has code
   to write the value back, which is a waste of CPU cycles and hinders
   progress. I've never seen eventfd used this way in real applications.
   Can you use two separate eventfds?

2. The fd is in blocking mode and the task may be descheduled, so we're
   measuring eventfd read/write latency plus scheduler/context-switch
   latency. A fairer comparison against user interrupts would be to busy
   wait on a non-blocking fd so the scheduler/context-switch latency is
   mostly avoided. After all, the uintrfd-bi.c benchmark does this in
   uintrfd_wait():

     // Keep spinning until the interrupt is received
     while (!uintr_received[token]);

--i9X2Z49tWwf/3JF/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFV5UAACgkQnKSrs4Gr
c8hf0wgAm6bnfUmQ8qskTYEGJX82TAe5nbxR5p9nO/xZtesrjT3IUeVFHKuylsNr
eItzDKlRBJlncB1z4cLXkKhT2+ARj4zN88mJ0qXZKIZpravgmW7A9E8EgOeFOixA
Vkxo6220auDhTeLLCyfg76/5mtW/Kb6Taj1wfc3WZQxZeb9exv9R1LGRV8NzsipE
FCuKTyzjhdVtkFfS9w24/SK6z3b9rTyDHcVENET/LFHRfax7Tona3+bsWGrhH/cB
ArwCJ4ziT8ZAgoK0rbuxCj0+PT2ZM2uXF3ctsjk+ljZC6yUAIxZJGS7siboRUIjH
icdl/RoAJ4wqNTJRBciAqv2rRRkpxg==
=M4lD
-----END PGP SIGNATURE-----

--i9X2Z49tWwf/3JF/--

