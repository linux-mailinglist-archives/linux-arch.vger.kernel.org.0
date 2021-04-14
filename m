Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD68F35F0FF
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhDNJqb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 05:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233030AbhDNJqa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 05:46:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0CE960FF0;
        Wed, 14 Apr 2021 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618393569;
        bh=trdMx4gzacIt7BqghFve/bsnRTsL7U3osL99J8IdDs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiCEG2KZJ1+Pd2CPHWymWoB0GyNLlqqwmVvY8mw0pvh05K+J2EeoyVopFNMYd8Gq8
         J9L6yx8kQVGNsp5+rW4dsxlKRPUavH+v4dr6B226D4rHFVIq+s4i6eIdkhAya4YIfp
         ZTxorEARSM7p75izlNFc+riLmCNkMU+cb9zii5HSaULmZ/Osfc++FOknFfsQW9455u
         mRHJOMLtFb0X9QbJOH+euFRRtbAsp52wMviO0WiW9y5pJY1vxyyTsFMfpCV0V1mDTr
         swjBNnH8xV9kUTLEr1/8aOo1OmG3OJ4PSNzdcblW21n4Ssr26NPr1b092LtR+Yc4bQ
         gLvgswbPCtawg==
Date:   Wed, 14 Apr 2021 12:46:01 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] Documentation: syscalls: add a note about  ABI-agnostic
 types
Message-ID: <YHa52ddAzcRGOB/m@kernel.org>
References: <20210409204304.1273139-1-yury.norov@gmail.com>
 <20210414044020.GA44464@yury-ThinkPad>
 <20210414081422.5a9d0c4b@coco.lan>
 <20210414084605.pdlnjkwa3h47jxno@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414084605.pdlnjkwa3h47jxno@wittgenstein>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 14, 2021 at 10:46:05AM +0200, Christian Brauner wrote:
> On Wed, Apr 14, 2021 at 08:14:22AM +0200, Mauro Carvalho Chehab wrote:
> > Em Tue, 13 Apr 2021 21:40:20 -0700
> > Yury Norov <yury.norov@gmail.com> escreveu:
> > 
> > > Ping?
> > > 
> > > On Fri, Apr 09, 2021 at 01:43:04PM -0700, Yury Norov wrote:
> > > > Recently added memfd_secret() syscall had a flags parameter passed
> > > > as unsigned long, which requires creation of compat entry for it.
> > > > It was possible to change the type of flags to unsigned int and so
> > > > avoid bothering with compat layer.
> > > > 
> > > > https://www.spinics.net/lists/linux-mm/msg251550.html
> > > > 
> > > > Documentation/process/adding-syscalls.rst doesn't point clearly about
> > > > preference of ABI-agnostic types. This patch adds such notification.
> > > > 
> > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > ---
> > > >  Documentation/process/adding-syscalls.rst | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> > > > index 9af35f4ec728..46add16edf14 100644
> > > > --- a/Documentation/process/adding-syscalls.rst
> > > > +++ b/Documentation/process/adding-syscalls.rst
> > > > @@ -172,6 +172,13 @@ arguments (i.e. parameter 1, 3, 5), to allow use of contiguous pairs of 32-bit
> > > >  registers.  (This concern does not apply if the arguments are part of a
> > > >  structure that's passed in by pointer.)
> > > >  
> > > > +Whenever possible, try to use ABI-agnostic types for passing parameters to
> > > > +a syscall in order to avoid creating compat entry for it. Linux supports two
> > > > +ABI models - ILP32 and LP64. 
> > 
> > > > + The types like ``void *``, ``long``, ``size_t``,
> > > > +``off_t`` have different size in those ABIs;
> > 
> > In the case of pointers, the best is to use __u64. The pointer can then
> > be read on Kernelspace with something like this:
> > 
> > 	static inline void __user *media_get_uptr(__u64 arg)
> > 	{
> > 		return (void __user *)(uintptr_t)arg;
> > 	}
> > 
> > 
> > > > types like ``char`` and  ``int``
> > > > +have the same size and don't require a compat layer support. For flags, it's
> > > > +always better to use ``unsigned int``.
> > > > +
> > 
> > I don't think this is true for all compilers on userspace, as the C
> > standard doesn't define how many bits an int/unsigned int has. 
> > So, even if this is today's reality, things may change in the future.
> > 
> > For instance, I remember we had to replace "int" and "enum" by "__u32" 
> > and "long" by "__u64" at the media uAPI in the past, when we start
> > seeing x86_64 Kernels with 32-bits userspace and when cameras started 
> > being supported on arm32.
> > 
> > We did have some real bugs with "enum", as, on that time, some
> > compilers (gcc, I guess) were optimizing them to have less than
> > 32 bits on certain architectures, when it fits.
> 
> Fwiw, Aleksa and I have written extended syscall documentation
> documenting the agreement that we came to in a dedicated session with a
> wide range of kernel folks during Linux Plumbers last year. We simply
> never had time to actually send this series but fwiw here it is. It also
> mentions the use of correct types. If people feel it's worth it I can
> send as a proper series:

Yes, please.
 
> From 9035258aaa23c5e1bb5bc2242f97221a3e5b9a87 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Fri, 4 Sep 2020 14:27:47 +0200
> Subject: [PATCH 1/6] docs: split extensibility section into two subsections

...

-- 
Sincerely yours,
Mike.
