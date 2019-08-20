Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9266C96673
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHTQd1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 12:33:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40750 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfHTQd1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Aug 2019 12:33:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so3018292pls.7
        for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2019 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sA90vJz/rbgCroFZTlA5Yw1nyMDsyVq6b6DiHDXrFY0=;
        b=cYzXk3DwZRgs8EAm1g3fVOu+Z4tn7HOv+jpf9QjbsWzX4NXP/Z29Kf/EIhyFPgdmft
         Si0gk/LKQoYihhNVviMseqNHT7bZIno7OfUiaUQT8FNXEofq/Hb8qW2iYXeJRTGao4nM
         GzveFF2KwG+Ju5sJ4Qx1kUpEovl+vjfCLefZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sA90vJz/rbgCroFZTlA5Yw1nyMDsyVq6b6DiHDXrFY0=;
        b=BzgSYFzL9cYo/ep9Kn6hKlyGnmuwqQo/xs75h64ovDYX9fCXRHBVXteJqii6K5AqhP
         9pWwvhYff32sp647Ep6xr7A5Prc+OfJJ9LwFcqbxmeYKW4TnYvVkRbHRIeQ79D02E5km
         pj1PBdQr8E7MrghxZBi2GRpTW0FNYGlBb9x7fcy37v8JoDsZE/L2sbhqXdCXh0PvO1AK
         kheXjkDPFfi/9iNJ+Rvn6B4CDoPsWYPKnJuOYHFgoljls77tjuV6oNnUZpxWUW/nnbcx
         t9PUe2xkO0VXNuGQ86TSROeKARaFHi07Advfj7wvNtIv3MCiF1o5rcvVUNpWTihHm55H
         xDVw==
X-Gm-Message-State: APjAAAWNUCSIy5HkCBG4jndpG8D4RJZ5oFlvdXdzUbKTcXWwjLVTvC/3
        iG+7UmCobsJ9HXDQn/3zQlVLiw==
X-Google-Smtp-Source: APXvYqx4X45g/9btjXSwOQ8+vS4u4nyT4b+SMjnqVb14XmUKxYG0eultJtMyH7UZAgK2dx58sZ7n0A==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr29689291plo.267.1566318807022;
        Tue, 20 Aug 2019 09:33:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 33sm17723932pgy.22.2019.08.20.09.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 09:33:26 -0700 (PDT)
Date:   Tue, 20 Aug 2019 09:33:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception handler
Message-ID: <201908200908.6437DF5@keescook>
References: <20190819234111.9019-1-keescook@chromium.org>
 <20190819234111.9019-8-keescook@chromium.org>
 <20190820100638.GK2332@hirez.programming.kicks-ass.net>
 <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 20, 2019 at 12:58:49PM +0200, Christophe Leroy wrote:
> Le 20/08/2019 à 12:06, Peter Zijlstra a écrit :
> > On Mon, Aug 19, 2019 at 04:41:11PM -0700, Kees Cook wrote:
> > 
> > > diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> > > index 588dd59a5b72..da471fcc5487 100644
> > > --- a/include/asm-generic/bug.h
> > > +++ b/include/asm-generic/bug.h
> > > @@ -10,6 +10,7 @@
> > >   #define BUGFLAG_WARNING		(1 << 0)
> > >   #define BUGFLAG_ONCE		(1 << 1)
> > >   #define BUGFLAG_DONE		(1 << 2)
> > > +#define BUGFLAG_PRINTK		(1 << 3)
> > >   #define BUGFLAG_TAINT(taint)	((taint) << 8)
> > >   #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
> > >   #endif
> > 
> > > diff --git a/lib/bug.c b/lib/bug.c
> > > index 1077366f496b..6c22e8a6f9de 100644
> > > --- a/lib/bug.c
> > > +++ b/lib/bug.c
> > > @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> > >   		}
> > >   	}
> > > +	/*
> > > +	 * BUG() and WARN_ON() families don't print a custom debug message
> > > +	 * before triggering the exception handler, so we must add the
> > > +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > > +	 * extra debugging message it writes before triggering the handler.
> > > +	 */
> > > +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> > > +		printk(KERN_DEFAULT CUT_HERE);
> > 
> > I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> > sense to me.

That's fine -- easy rename. :)

> Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not
> using the generic macros will have to add the flag to get the "cut here"
> line.

I am testing for the lack of the flag (so that only the
CONFIG_GENERIC_BUG with __WARN_FLAGS case needs to set it). I was
thinking of the flag to mean "this reporting flow has already issued
cut-here". It sounds like it would be more logical to have it named
BUGFLAG_NO_CUT_HERE to mean "do not issue a cut-here; it has already
happened"? I will update the patch.

Thanks!

-- 
Kees Cook
