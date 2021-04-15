Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDF3612EE
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhDOTfU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 15:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOTfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Apr 2021 15:35:20 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED3AC061574;
        Thu, 15 Apr 2021 12:34:56 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b139so21060343qkc.10;
        Thu, 15 Apr 2021 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZxAIyZXleavtTSyb1uiHKSzHsR5oXHMZ39I12RMRk0=;
        b=onBlYDAhC06cDL6NCqDCllzRfZfQejyllRxcI7+HHvAr08OAllVvSXes8ugbiCzeco
         nLvmgt7W4woTCXaY4fSuBqwLQwwnKJrZQKf8RswhvFmMbaDuJpK8VWmmSINeHftlpEds
         /VfoqjEA0mH3/7vg6iqTRVfKQITDVkJUhjT0vISb0/FOsrc0hUpoiNhEUGh/yTVNw7ps
         jzksFxtGSxBqixWHPUDh5voLqxYbyNMvcSqj1HkobOfuzg9xR0DhHDxlcWo1Lul0MBMa
         zLUPIQGKw8lpzD+T+5cjhR5QpPUmhuwgdxELHRm5rkSO5NrPEbkB/8D69EwdfyIFJBhV
         vklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZxAIyZXleavtTSyb1uiHKSzHsR5oXHMZ39I12RMRk0=;
        b=rizEXgCZ6litIaghNZEMOa2//tGaCmknumeIKCPdA5eGU41D6ysoub+CRoRM2QzHFw
         Hbew4g3xJFNNwVg+UZDkFmcM2+62Z/iv0xnVmU28Fb3QHWwuCe/lPcHL+YmzObRJ6CCr
         Hwcikp7RtuXO9mqni6kaQ1Qa2RBjtn/9hDUSmc8gxKMA3BkGkzMhsQl5SBAYhGE1KUmy
         uuWq5/cLEDg/hjKT6N93JEFwamx1In0gaKDXdBVCOLCA8XszyNq6EaQ/aRgA4/BRA7aI
         rwgoBSkI5+3nWuC4YL8PqjBsncq6FePxejUPZvxpkRelp6gan4/skEY60nL7Z1O7tYwZ
         ZOoA==
X-Gm-Message-State: AOAM530xogskmL88mNEpPRR8fHlfBvu50TypfYSfVWGCfhKTAyilABGv
        NmVWS2K1O7Mq9IlxhYQyTGU=
X-Google-Smtp-Source: ABdhPJzrbYgx8Sdj4iNjPv4xqlMIKmcPlwduxKQ6imfnVGG9ycn0yf5KbiTZVaZ2x9OXPObGAt2ZMw==
X-Received: by 2002:a37:bc43:: with SMTP id m64mr5206130qkf.186.1618515295735;
        Thu, 15 Apr 2021 12:34:55 -0700 (PDT)
Received: from localhost ([2601:4c0:10a:6422:d95c:67f2:e1ae:b4c2])
        by smtp.gmail.com with ESMTPSA id 132sm2651816qkn.52.2021.04.15.12.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:34:55 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:34:53 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] Documentation: syscalls: add a note about  ABI-agnostic
 types
Message-ID: <20210415193453.GA140029@yury-ThinkPad>
References: <20210409204304.1273139-1-yury.norov@gmail.com>
 <20210414044020.GA44464@yury-ThinkPad>
 <20210414081422.5a9d0c4b@coco.lan>
 <20210414084605.pdlnjkwa3h47jxno@wittgenstein>
 <YHa52ddAzcRGOB/m@kernel.org>
 <20210414133847.2gwws46ktuqxkghu@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414133847.2gwws46ktuqxkghu@wittgenstein>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 14, 2021 at 03:38:47PM +0200, Christian Brauner wrote:
> On Wed, Apr 14, 2021 at 12:46:01PM +0300, Mike Rapoport wrote:
> > On Wed, Apr 14, 2021 at 10:46:05AM +0200, Christian Brauner wrote:
> > > On Wed, Apr 14, 2021 at 08:14:22AM +0200, Mauro Carvalho Chehab wrote:
> > > > Em Tue, 13 Apr 2021 21:40:20 -0700
> > > > Yury Norov <yury.norov@gmail.com> escreveu:
> > > > 
> > > > > Ping?
> > > > > 
> > > > > On Fri, Apr 09, 2021 at 01:43:04PM -0700, Yury Norov wrote:
> > > > > > Recently added memfd_secret() syscall had a flags parameter passed
> > > > > > as unsigned long, which requires creation of compat entry for it.
> > > > > > It was possible to change the type of flags to unsigned int and so
> > > > > > avoid bothering with compat layer.
> > > > > > 
> > > > > > https://www.spinics.net/lists/linux-mm/msg251550.html
> > > > > > 
> > > > > > Documentation/process/adding-syscalls.rst doesn't point clearly about
> > > > > > preference of ABI-agnostic types. This patch adds such notification.
> > > > > > 
> > > > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > > > ---
> > > > > >  Documentation/process/adding-syscalls.rst | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> > > > > > index 9af35f4ec728..46add16edf14 100644
> > > > > > --- a/Documentation/process/adding-syscalls.rst
> > > > > > +++ b/Documentation/process/adding-syscalls.rst
> > > > > > @@ -172,6 +172,13 @@ arguments (i.e. parameter 1, 3, 5), to allow use of contiguous pairs of 32-bit
> > > > > >  registers.  (This concern does not apply if the arguments are part of a
> > > > > >  structure that's passed in by pointer.)
> > > > > >  
> > > > > > +Whenever possible, try to use ABI-agnostic types for passing parameters to
> > > > > > +a syscall in order to avoid creating compat entry for it. Linux supports two
> > > > > > +ABI models - ILP32 and LP64. 
> > > > 
> > > > > > + The types like ``void *``, ``long``, ``size_t``,
> > > > > > +``off_t`` have different size in those ABIs;
> > > > 
> > > > In the case of pointers, the best is to use __u64. The pointer can then
> > > > be read on Kernelspace with something like this:
> > > > 
> > > > 	static inline void __user *media_get_uptr(__u64 arg)
> > > > 	{
> > > > 		return (void __user *)(uintptr_t)arg;
> > > > 	}
> > > > 
> > > > 
> > > > > > types like ``char`` and  ``int``
> > > > > > +have the same size and don't require a compat layer support. For flags, it's
> > > > > > +always better to use ``unsigned int``.
> > > > > > +
> > > > 
> > > > I don't think this is true for all compilers on userspace, as the C
> > > > standard doesn't define how many bits an int/unsigned int has. 
> > > > So, even if this is today's reality, things may change in the future.
> > > > 
> > > > For instance, I remember we had to replace "int" and "enum" by "__u32" 
> > > > and "long" by "__u64" at the media uAPI in the past, when we start
> > > > seeing x86_64 Kernels with 32-bits userspace and when cameras started 
> > > > being supported on arm32.
> > > > 
> > > > We did have some real bugs with "enum", as, on that time, some
> > > > compilers (gcc, I guess) were optimizing them to have less than
> > > > 32 bits on certain architectures, when it fits.
> > > 
> > > Fwiw, Aleksa and I have written extended syscall documentation
> > > documenting the agreement that we came to in a dedicated session with a
> > > wide range of kernel folks during Linux Plumbers last year. We simply
> > > never had time to actually send this series but fwiw here it is. It also
> > > mentions the use of correct types. If people feel it's worth it I can
> > > send as a proper series:
> > 
> > Yes, please.
> 
> Ok, I'll try to fix the commit messages and send it out.
> 
> Christian

Could you pelease keep me in CC in your submission?
