Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980A711AC9D
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 14:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLKN6G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 08:58:06 -0500
Received: from foss.arm.com ([217.140.110.172]:59152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKN6F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 08:58:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25FC31FB;
        Wed, 11 Dec 2019 05:58:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83FF83F67D;
        Wed, 11 Dec 2019 05:58:04 -0800 (PST)
Date:   Wed, 11 Dec 2019 13:58:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>
Subject: Re: [PATCH v3 02/12] ELF: Add ELF program property parsing support
Message-ID: <20191211135803.GD3870@sirena.org.uk>
References: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
 <1571419545-20401-3-git-send-email-Dave.Martin@arm.com>
 <201910291611.69822D5E04@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <201910291611.69822D5E04@keescook>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2019 at 04:14:47PM -0700, Kees Cook wrote:
> On Fri, Oct 18, 2019 at 06:25:35PM +0100, Dave Martin wrote:

A bit of a delay, sorry - I've taken this series over from Dave and
wasn't on the CC so only just saw this.

> > +#ifndef ELF_COMPAT
> > +#define ELF_COMPAT 0
> > +#endif

> Why is "compat" interesting for the arch_ callback? Shouldn't just the
> unsigned long size be needed?

The set of properties handled or how they should be handled may vary
depending on the ABI.  For example arm64 supports BTI only for AArch64
but not for AArch32 so we should only handle the property for BTI for
AArch64 binaries.

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3w9eoACgkQJNaLcl1U
h9BmBgf+NNNCMclmwLDa2ZSVlL0/OBQcMH0ymsvXlLz6O8/LVbh/6UcTv2gnLRbZ
4/onE8sI1dHBBZCYuiHk3LVyQElzoci7ntsEO96/Ej4HGEGddSJcy841btZcJF+o
qJD7ZnkU9MR6mk+9QNiJ1Op5JbHinr42IhFw7jdgMDzjc3/BRzOCATyUibraciEN
bocm5+nKJVPYNXiWolMgRER+8JH8w7I52Agj6Ob0zjZOZi9SBuxFIXTMzVqrvnyX
iLIi/RIUpxLAdnb0ZRnyowuwgMFQdX38HKBxi6WLO2hcK4HUtytWbgez6KjRpnga
K5oQP5sxINKD2ERveqnVOuVM/CNbJA==
=RBvh
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
