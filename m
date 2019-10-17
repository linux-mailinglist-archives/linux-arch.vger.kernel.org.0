Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43D0DA2AB
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 02:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391239AbfJQA0D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 20:26:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38216 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfJQA0D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 20:26:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so969339qta.5;
        Wed, 16 Oct 2019 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4Hjken7XU2rfPp3dnVy1MaKiaTDJ8xCPdPitHymU3c=;
        b=csQqSPN/MGMvhU7skkKyvEgZzVQXO9UtV6gWrDu3gonQToGoEuQEgJ9AjvMPvbwgIF
         +oREHMSAN8YZ3MbVgmYjKeOTN3inuXTVkgzDhuWFONWsJZPVMpqC3T0FmkJCYMOT6owQ
         KACvVEVlS+FuQvqxRoRF9r6USc4ObR5pLoOlmSRBFhCPeceZvDBGmlWgIXSuOG/pafEp
         uY4oSoBUSn0SkSBGPgyUqt2KMX7T35aDDjMmjKzLw+WSfserZtwaHXNHUU1cSSsSTmEQ
         pSk/B8fFRIDl//jlg/wph1G/OYr/lKPNQ9J90dhkq4/zmChmYKpmE5t4/p0dQowfPXFf
         Ji6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4Hjken7XU2rfPp3dnVy1MaKiaTDJ8xCPdPitHymU3c=;
        b=toy4LROaGh/1uceD8tt/Y/Ixz8Q5/sydbE9Qr7VgOU/SlQ3RbwEkPq/QZUt1EJTPe9
         H61xz1ipNehP1fTomecUPO6MYoIpZNFoI5UDAwc4IAQ64g19Gkeq2PnRFJP0jCB/3h4n
         OfeyDX6DtwmwthHlGeB2bSOKaKKJHeM9SRJL+/UVfkR6w772s2X2m1mEO3IyZVHlM8ia
         bReU9r3PuYodq6gkuc8UEmJrjLYD0kF1GqlgFaHvxi9m/7GYC6AXRfD1537WZXrCEKlS
         no1OP2f7pPd5imyZ1hkhwXEQT8qykvu+/nHrhuxePeU0keAy3Snj5T767rB5VxxNVYPc
         wqaQ==
X-Gm-Message-State: APjAAAXnDfOEQ7/f3+RhAWdOlk/GsWUXm06O1Fod5dsvgLU0atXrrk2Y
        E9AIT/I3mqkUtE+Auy9z4wM=
X-Google-Smtp-Source: APXvYqwnuvz1GcoONkwCw4W+ofBxGx3iz4s+XHmcMH/nQPqH09WNGtoGGUd1Vbn15devxycq9f20pw==
X-Received: by 2002:aed:3847:: with SMTP id j65mr1055138qte.124.1571271961879;
        Wed, 16 Oct 2019 17:26:01 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y5sm333254qki.108.2019.10.16.17.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 17:26:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A11A621D75;
        Wed, 16 Oct 2019 20:25:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 16 Oct 2019 20:25:58 -0400
X-ME-Sender: <xms:FLWnXSxe46wrvL0VHqF5V2Ftj42Nf9hCqNC4-vIa5pbRXW7LwZKVWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppedutd
    durdekiedrgedurddvuddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:FLWnXVRhKT-ELDdbHCzUD4h16wZdhG07nxKVIzY0GK3e0T7AQAQ_lw>
    <xmx:FLWnXZX2aRHtB7FOPmJpE0Vt6fX-FF8krlsUle2XV1odHISlIxcovA>
    <xmx:FLWnXXbpI_54bhxEulyOPPPIzzBXXBx2l_kZQlorezepl81GJumBIA>
    <xmx:FrWnXV97T3hNSRFPeBAYdtOEaxoLxandJ9m0BIPe1jkzxQkvR8MN13GMnGY>
Received: from localhost (unknown [101.86.41.212])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25DF68005C;
        Wed, 16 Oct 2019 20:25:55 -0400 (EDT)
Date:   Thu, 17 Oct 2019 08:25:51 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>, ard.biesheuvel@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191017002551.GC2701514@tardis>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-2-elver@google.com>
 <20191016094234.GB2701514@tardis>
 <CANpmjNOxmQDKin=9Cyi+ERVQ-ehH79AaPjRvJNfFfmgOjJAogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <CANpmjNOxmQDKin=9Cyi+ERVQ-ehH79AaPjRvJNfFfmgOjJAogA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 12:06:51PM +0200, Marco Elver wrote:
> On Wed, 16 Oct 2019 at 11:42, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi Marco,
> >
> > On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:
> > [...]
> > > --- /dev/null
> > > +++ b/kernel/kcsan/kcsan.c
> > > @@ -0,0 +1,81 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more=
 info please
> > > + * see Documentation/dev-tools/kcsan.rst.
> > > + */
> > > +
> > > +#include <linux/export.h>
> > > +
> > > +#include "kcsan.h"
> > > +
> > > +/*
> > > + * Concurrency Sanitizer uses the same instrumentation as Thread San=
itizer.
> >
> > Is there any documentation on the instrumentation? Like a complete list
> > for all instrumentation functions plus a description of where the
> > compiler will use those functions. Yes, the names of the below functions
> > are straightforward, but an accurate doc on the instrumentation will
> > cerntainly help people review KCSAN.
>=20
> As far as I'm aware neither GCC nor Clang have documentation on the
> emitted instrumentation that we could reference (other than look into
> the compiler passes).
>=20

Yeah, I don't find them either, which makes me surprised, because I
think the thread sanitizer has been there for a while...

> However it is as straightforward as it seems: the compiler emits
> instrumentation calls for all loads and stores that the compiler
> generates; inline asm is not instrumented. I will add a comment to
> that effect for v2.
>=20

Or you can push the compiler people to document it, and we can simply
reference it in kernel ;-)

Regards,
Boqun

> Thanks,
> -- Marco
>=20
> > Regards,
> > Boqun
> >
> > > + */
> > > +
> > > +#define DEFINE_TSAN_READ_WRITE(size)                                =
           \
> > > +     void __tsan_read##size(void *ptr)                              =
        \
> > > +     {                                                              =
        \
> > > +             __kcsan_check_access(ptr, size, false);                =
        \
> > > +     }                                                              =
        \
> > > +     EXPORT_SYMBOL(__tsan_read##size);                              =
        \
> > > +     void __tsan_write##size(void *ptr)                             =
        \
> > > +     {                                                              =
        \
> > > +             __kcsan_check_access(ptr, size, true);                 =
        \
> > > +     }                                                              =
        \
> > > +     EXPORT_SYMBOL(__tsan_write##size)
> > > +
> > > +DEFINE_TSAN_READ_WRITE(1);
> > > +DEFINE_TSAN_READ_WRITE(2);
> > > +DEFINE_TSAN_READ_WRITE(4);
> > > +DEFINE_TSAN_READ_WRITE(8);
> > > +DEFINE_TSAN_READ_WRITE(16);
> > > +
> > > +/*
> > > + * Not all supported compiler versions distinguish aligned/unaligned=
 accesses,
> > > + * but e.g. recent versions of Clang do.
> > > + */
> > > +#define DEFINE_TSAN_UNALIGNED_READ_WRITE(size)                      =
           \
> > > +     void __tsan_unaligned_read##size(void *ptr)                    =
        \
> > > +     {                                                              =
        \
> > > +             __kcsan_check_access(ptr, size, false);                =
        \
> > > +     }                                                              =
        \
> > > +     EXPORT_SYMBOL(__tsan_unaligned_read##size);                    =
        \
> > > +     void __tsan_unaligned_write##size(void *ptr)                   =
        \
> > > +     {                                                              =
        \
> > > +             __kcsan_check_access(ptr, size, true);                 =
        \
> > > +     }                                                              =
        \
> > > +     EXPORT_SYMBOL(__tsan_unaligned_write##size)
> > > +
> > > +DEFINE_TSAN_UNALIGNED_READ_WRITE(2);
> > > +DEFINE_TSAN_UNALIGNED_READ_WRITE(4);
> > > +DEFINE_TSAN_UNALIGNED_READ_WRITE(8);
> > > +DEFINE_TSAN_UNALIGNED_READ_WRITE(16);
> > > +
> > > +void __tsan_read_range(void *ptr, size_t size)
> > > +{
> > > +     __kcsan_check_access(ptr, size, false);
> > > +}
> > > +EXPORT_SYMBOL(__tsan_read_range);
> > > +
> > > +void __tsan_write_range(void *ptr, size_t size)
> > > +{
> > > +     __kcsan_check_access(ptr, size, true);
> > > +}
> > > +EXPORT_SYMBOL(__tsan_write_range);
> > > +
> > > +/*
> > > + * The below are not required KCSAN, but can still be emitted by the=
 compiler.
> > > + */
> > > +void __tsan_func_entry(void *call_pc)
> > > +{
> > > +}
> > > +EXPORT_SYMBOL(__tsan_func_entry);
> > > +void __tsan_func_exit(void)
> > > +{
> > > +}
> > > +EXPORT_SYMBOL(__tsan_func_exit);
> > > +void __tsan_init(void)
> > > +{
> > > +}
> > > +EXPORT_SYMBOL(__tsan_init);
> > [...]

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2ntP8ACgkQSXnow7UH
+rj4IwgAr1ZTnb6a5VMzzEFJsOsttb8ZWdPW5m/sNmxxMh6TIPZzl1rWAzFMMC7R
52lRrsSAQ+3JsII8i8lMPGPFo4Fc4g1ivQa604Zf+KjqHPtM4bBOigkNgRmFkM5r
gsrimY5mX0B4O0hg7CtV0kn3FAJKsFTE+daVXj6W0p18pshZ3HgulHPKDH7qrMnh
Hc/9JhxxvcnRAN9uUuukBr4vGHq+iDJqqGZqOuykwTufSRnGNlQk9BoGczLX+7+2
zJ+dLh8nSVw+R2tV8eVAZ+84dHfNRTFa+iBPMSW1UQ27RFR0iqY9UmwAgYmUU3YD
4F9k35sBc8/lxL1IGFblpg3dSS/4CQ==
=9czZ
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
