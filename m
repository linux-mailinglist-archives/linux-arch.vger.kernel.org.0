Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F272A35F8A3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352570AbhDNQG6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346877AbhDNQG5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Apr 2021 12:06:57 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3750C061574;
        Wed, 14 Apr 2021 09:06:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id i6so6205837qti.10;
        Wed, 14 Apr 2021 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/bkJOUEIhQpaarHf9evA1zVpo47yxddsd+vPYgjh8gQ=;
        b=Re9GDJgTKoI18hI072yRMhVtwekN2NXDhFVkYTu2pBUQzR3HVCVRy9GgUDyVQCfKlV
         K/vk1uZ/1ARlT9hP8Ez7OeVG8guK+m5A5uEvYS2TEEVapMZEdPj7oGwAVXHOCYLUahiS
         StKzIgqOL9152HKJYXHdvIKj5IDMGaxXbEbwPrQwiHT5QXNA9dC6ZMS3P1etmf/jYCE9
         Gdiyv1RGeUoG7ZZW07r50rSyhBI0juVuBfB3yAF+DkHnz4Kn23siCv8gZ3XMHv6yoJJN
         UBJjMu5nuRcv+ykZDlk/jluNyL/irO79Hy01l/38KWVXxLbRP9jvxuHcjGn5PMHMM9FQ
         3g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/bkJOUEIhQpaarHf9evA1zVpo47yxddsd+vPYgjh8gQ=;
        b=E9xK86VP+oIHkCGiIzxfqELvQh+zixlsZP201s/9MME69xIxXLsnAVNuuT/i6lXxxH
         bIHS6dD9Fv8k+OJXZXhrqZzL8wOa1jj6mrJN4HCUlusVmGtWnhTSc0nltapKhbXOg6E1
         xAlUAvMLUt8LBQL23zoeR3l4knuyOK7u1X+JsWT5HRnxENLu67n+k0RhJzy3SuElG1w7
         x90M2nebLHGjSdaPisUJawyRTReVLFF0hEJNnRiuqPpHP17MQ++PeDq5qri/LktIIcV0
         93JKJ/xAfFtIc8+2FeKzx7FDpA5b3b0y6HAssBGLnkVJ6NWqZTh548pmYrxmnGpfcgbX
         GYag==
X-Gm-Message-State: AOAM531ei5S6uPUdMfsA7Rmm6l9WKMYE8A9HAAldbeHtsKO/Sf7CRi+g
        wfd9tcoNQLYnas+GGd0E6hkKSOdRN9I=
X-Google-Smtp-Source: ABdhPJxMn73FiGp2dKadUY6T5xb9A1JuWbR/CayZ2UJMBRaXuEfiza2/+6issl1cDKJJ83CLDF7zTA==
X-Received: by 2002:a05:622a:446:: with SMTP id o6mr35757819qtx.257.1618416395016;
        Wed, 14 Apr 2021 09:06:35 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id j6sm12648789qkl.84.2021.04.14.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:06:34 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:06:30 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] Documentation: syscalls: add a note about  ABI-agnostic
 types
Message-ID: <20210414160630.GA61176@yury-ThinkPad>
References: <20210409204304.1273139-1-yury.norov@gmail.com>
 <20210414044020.GA44464@yury-ThinkPad>
 <20210414081422.5a9d0c4b@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414081422.5a9d0c4b@coco.lan>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 14, 2021 at 08:14:22AM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 13 Apr 2021 21:40:20 -0700
> Yury Norov <yury.norov@gmail.com> escreveu:
> 
> > Ping?
> > 
> > On Fri, Apr 09, 2021 at 01:43:04PM -0700, Yury Norov wrote:
> > > Recently added memfd_secret() syscall had a flags parameter passed
> > > as unsigned long, which requires creation of compat entry for it.
> > > It was possible to change the type of flags to unsigned int and so
> > > avoid bothering with compat layer.
> > > 
> > > https://www.spinics.net/lists/linux-mm/msg251550.html
> > > 
> > > Documentation/process/adding-syscalls.rst doesn't point clearly about
> > > preference of ABI-agnostic types. This patch adds such notification.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  Documentation/process/adding-syscalls.rst | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> > > index 9af35f4ec728..46add16edf14 100644
> > > --- a/Documentation/process/adding-syscalls.rst
> > > +++ b/Documentation/process/adding-syscalls.rst
> > > @@ -172,6 +172,13 @@ arguments (i.e. parameter 1, 3, 5), to allow use of contiguous pairs of 32-bit
> > >  registers.  (This concern does not apply if the arguments are part of a
> > >  structure that's passed in by pointer.)
> > >  
> > > +Whenever possible, try to use ABI-agnostic types for passing parameters to
> > > +a syscall in order to avoid creating compat entry for it. Linux supports two
> > > +ABI models - ILP32 and LP64. 
> 
> > > + The types like ``void *``, ``long``, ``size_t``,
> > > +``off_t`` have different size in those ABIs;
> 
> In the case of pointers, the best is to use __u64. The pointer can then
> be read on Kernelspace with something like this:
> 
> 	static inline void __user *media_get_uptr(__u64 arg)
> 	{
> 		return (void __user *)(uintptr_t)arg;
> 	}
 
For 32-bit userspace reserving 64-bit type for pointers looks
excessive, isn't? And anyways, how could this help to prevent
malicious/broken compat userspace from passing pointers with
dirty top 32 bits?

From what I can see, in case of compat ABI, the 'void *' args
are cast to compat_uptr_t in the compat layer, and then passed
to native handlers. Bypassing compat layer in the example above
would break consistency for a syscall.
 
> > > types like ``char`` and  ``int``
> > > +have the same size and don't require a compat layer support. For flags, it's
> > > +always better to use ``unsigned int``.
> > > +
> 
> I don't think this is true for all compilers on userspace, as the C
> standard doesn't define how many bits an int/unsigned int has. 
> So, even if this is today's reality, things may change in the future.

Agree, it's not a standard in C, but this is pretty much a standard in
Linux. Introducing a new ABI nor ILP32, neither LP64 would require huge
amount of work, especially on a maintenance level, and I bet it will be
blocked by Arnd. :) In practice it's correct to recommend using unsigned
int for flags now, and if in future someone will introduce new ABI, it
will be his responsibility to explain us how to design syscalls in a
compatible and unified way.

> For instance, I remember we had to replace "int" and "enum" by "__u32" 
> and "long" by "__u64" at the media uAPI in the past, when we start
> seeing x86_64 Kernels with 32-bits userspace and when cameras started 
> being supported on arm32.
> 
> We did have some real bugs with "enum", as, on that time, some
> compilers (gcc, I guess) were optimizing them to have less than
> 32 bits on certain architectures, when it fits.

I think this example agrees with what I said - if userspace has
nonstandard ABI, it has to use kernel types to communicate with
kernel, which are exposed as __u32-style typedefs. For me, it's
a compatibility layer implemented in userspace.

This patch is about good practices for standard 32, 64 and compat 
ABIs supported by kernel.

(Or if I missed you point, can you please explain in more details?)

Thanks,
Yury
