Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8B35ED0A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 08:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbhDNGO5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 02:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349130AbhDNGOv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 02:14:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A0B60FD8;
        Wed, 14 Apr 2021 06:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618380870;
        bh=QUwhG1aEuYUYzpTX5r+cTxe2OtqIgKW7ZzBKXbUv0qE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=thusl7s/bxHLGdsAmgh+pH+X9REzuDPhBdzVl1RfGWSvGH0esOhhO4XNPANmqOQLX
         xamcSotJXglVS6YhmGa8nLoVDcdUwC9bE7FdYX4hue7yEiFXhVHGvqenqDq4roJ6Sc
         A/YaT/EFd2fN8q12udBhBJFgvTs2S7aVxIb5BWB7OGt4h3U1q/VY9pjyQP+55c0wM0
         cb76MI26cMoEf8s1YmbLXaz2CzB5NnsRRPIUJdvCYB/GoxzXCFkwc2Sz28M9a/PWXq
         EBIy9On512F83Z+NtuJzgkiz0e+LXrm9oQqDMTxYRYQNG3ppWwoONaNrqKxXlfs+ph
         bmu4zyqOrQALQ==
Date:   Wed, 14 Apr 2021 08:14:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] Documentation: syscalls: add a note about  ABI-agnostic
 types
Message-ID: <20210414081422.5a9d0c4b@coco.lan>
In-Reply-To: <20210414044020.GA44464@yury-ThinkPad>
References: <20210409204304.1273139-1-yury.norov@gmail.com>
        <20210414044020.GA44464@yury-ThinkPad>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Tue, 13 Apr 2021 21:40:20 -0700
Yury Norov <yury.norov@gmail.com> escreveu:

> Ping?
> 
> On Fri, Apr 09, 2021 at 01:43:04PM -0700, Yury Norov wrote:
> > Recently added memfd_secret() syscall had a flags parameter passed
> > as unsigned long, which requires creation of compat entry for it.
> > It was possible to change the type of flags to unsigned int and so
> > avoid bothering with compat layer.
> > 
> > https://www.spinics.net/lists/linux-mm/msg251550.html
> > 
> > Documentation/process/adding-syscalls.rst doesn't point clearly about
> > preference of ABI-agnostic types. This patch adds such notification.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  Documentation/process/adding-syscalls.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> > index 9af35f4ec728..46add16edf14 100644
> > --- a/Documentation/process/adding-syscalls.rst
> > +++ b/Documentation/process/adding-syscalls.rst
> > @@ -172,6 +172,13 @@ arguments (i.e. parameter 1, 3, 5), to allow use of contiguous pairs of 32-bit
> >  registers.  (This concern does not apply if the arguments are part of a
> >  structure that's passed in by pointer.)
> >  
> > +Whenever possible, try to use ABI-agnostic types for passing parameters to
> > +a syscall in order to avoid creating compat entry for it. Linux supports two
> > +ABI models - ILP32 and LP64. 

> > + The types like ``void *``, ``long``, ``size_t``,
> > +``off_t`` have different size in those ABIs;

In the case of pointers, the best is to use __u64. The pointer can then
be read on Kernelspace with something like this:

	static inline void __user *media_get_uptr(__u64 arg)
	{
		return (void __user *)(uintptr_t)arg;
	}


> > types like ``char`` and  ``int``
> > +have the same size and don't require a compat layer support. For flags, it's
> > +always better to use ``unsigned int``.
> > +

I don't think this is true for all compilers on userspace, as the C
standard doesn't define how many bits an int/unsigned int has. 
So, even if this is today's reality, things may change in the future.

For instance, I remember we had to replace "int" and "enum" by "__u32" 
and "long" by "__u64" at the media uAPI in the past, when we start
seeing x86_64 Kernels with 32-bits userspace and when cameras started 
being supported on arm32.

We did have some real bugs with "enum", as, on that time, some
compilers (gcc, I guess) were optimizing them to have less than
32 bits on certain architectures, when it fits.

Thanks,
Mauro
