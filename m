Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4B32C86A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbhCDAtU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578569AbhCCSRi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 13:17:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ABCE64EE4;
        Wed,  3 Mar 2021 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614795417;
        bh=AOrfOeNzmKqgCV3QhzN1PwHQin34TBisdVgEG/rfN5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JU0c7LsMblIR5/z1TFN8se4jRW7FE3kakg1n9P4kbsLBCFjGXqHV6ug4bTktO4RZq
         w4tNa3+4oSkml+MAwznFMbaNrrXyikantXWv7d0WndnhfhbVFat2dEfWC1yyU+Th5T
         ynPRtt+JonwZAS21aGAn2OcTP4nOnvkC9KVlGBBKE88ckH7DJf6zkriAFHeM8ELNmp
         MoxKjCIj/TEE7Rk18Z1fdbqXYEHy3TbfZGGq3uepxhxCjyOapHMi1sKuWjMelOiwEX
         r51wZO44eldb++Q7itPvHz8IdYnuyt1fC7oPCkvnXp1nEcLPTvV2AHwnAAcfr6Qm18
         JbEPWkrwnqRYQ==
Date:   Wed, 3 Mar 2021 18:16:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/7] cmdline: Add generic function to build command
 line.
Message-ID: <20210303181651.GE19713@willie-the-truck>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu>
 <20210303172810.GA19713@willie-the-truck>
 <a0cfef11-efba-2e5c-6f58-ed63a2c3bfa0@csgroup.eu>
 <20210303174627.GC19713@willie-the-truck>
 <dc6576ac-44ff-7db4-d718-7565b83f50b8@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc6576ac-44ff-7db4-d718-7565b83f50b8@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 03, 2021 at 06:57:09PM +0100, Christophe Leroy wrote:
> Le 03/03/2021 à 18:46, Will Deacon a écrit :
> > On Wed, Mar 03, 2021 at 06:38:16PM +0100, Christophe Leroy wrote:
> > > Le 03/03/2021 à 18:28, Will Deacon a écrit :
> > > > On Tue, Mar 02, 2021 at 05:25:17PM +0000, Christophe Leroy wrote:
> > > > > This code provides architectures with a way to build command line
> > > > > based on what is built in the kernel and what is handed over by the
> > > > > bootloader, based on selected compile-time options.
> > > > > 
> > > > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > > > ---
> > > > >    include/linux/cmdline.h | 62 +++++++++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 62 insertions(+)
> > > > >    create mode 100644 include/linux/cmdline.h
> > > > > 
> > > > > diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> > > > > new file mode 100644
> > > > > index 000000000000..ae3610bb0ee2
> > > > > --- /dev/null
> > > > > +++ b/include/linux/cmdline.h
> > > > > @@ -0,0 +1,62 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +#ifndef _LINUX_CMDLINE_H
> > > > > +#define _LINUX_CMDLINE_H
> > > > > +
> > > > > +static __always_inline size_t cmdline_strlen(const char *s)
> > > > > +{
> > > > > +	const char *sc;
> > > > > +
> > > > > +	for (sc = s; *sc != '\0'; ++sc)
> > > > > +		; /* nothing */
> > > > > +	return sc - s;
> > > > > +}
> > > > > +
> > > > > +static __always_inline size_t cmdline_strlcat(char *dest, const char *src, size_t count)
> > > > > +{
> > > > > +	size_t dsize = cmdline_strlen(dest);
> > > > > +	size_t len = cmdline_strlen(src);
> > > > > +	size_t res = dsize + len;
> > > > > +
> > > > > +	/* This would be a bug */
> > > > > +	if (dsize >= count)
> > > > > +		return count;
> > > > > +
> > > > > +	dest += dsize;
> > > > > +	count -= dsize;
> > > > > +	if (len >= count)
> > > > > +		len = count - 1;
> > > > > +	memcpy(dest, src, len);
> > > > > +	dest[len] = 0;
> > > > > +	return res;
> > > > > +}
> > > > 
> > > > Why are these needed instead of using strlen and strlcat directly?
> > > 
> > > Because on powerpc (at least), it will be used in prom_init, it is very
> > > early in the boot and KASAN shadow memory is not set up yet so calling
> > > generic string functions would crash the board.
> > 
> > Hmm. We deliberately setup a _really_ early shadow on arm64 for this, can
> > you not do something similar? Failing that, I think it would be better to
> > offer the option for an arch to implement cmdline_*, but have then point to
> > the normal library routines by default.
> 
> I don't think it is possible to setup an earlier early shadow.
> 
> At the point we are in prom_init, the code is not yet relocated at the
> address it was linked for, and it is running with the MMU set by the
> bootloader, I can't imagine being able to setup MMU entries for the early
> shadow KASAN yet without breaking everything.

That's very similar to us; we're not relocated, although we are at least
in control of the MMU (which is using a temporary set of page-tables).

> Is it really worth trying to point to the normal library routines by default
> ? It is really only a few lines of code hence only not many bytes, and
> anyway they are in __init section so they get discarded at the end.

I would prefer to use the normal routines by default and allow architectures
to override them based on their needs, otherwise we'll end up trying to
maintain a "lowest-common-dominator" set of string routines that can be
safely run in whatever different constraints different architectures have.

Will
