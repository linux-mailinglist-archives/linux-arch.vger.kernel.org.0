Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77212A08B8
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfH1RhF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 13:37:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfH1Rge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 13:36:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so109135pgp.4
        for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2019 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H81+yOfZIX+C0OkVOiTOPB8MS8Z/VXRjW2hNsAZ0BmE=;
        b=oIGNA7zeFP/zFnPe/cIum5wdjPrHvoMLsfeTliBiOVxQYlyCXaPqnO3SHVa89WISFB
         80JplJgciW454D9Z5TpezYCuRwcCCHqoHVN2S8lFPm9/skVtCQGYrHlFREHLOshNCxWz
         iyelp2X12cknm0AIsjcusjnLaLUZp55DKAKHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H81+yOfZIX+C0OkVOiTOPB8MS8Z/VXRjW2hNsAZ0BmE=;
        b=WGqacGrNp4cdHcAsjvZ/r2JdlNC5pVQAzraQTKU9X9Jr0HO4K5bxMwg72mdqhftiOG
         z1ao9h/n+H49ZU3+3srzhIo6FNF6NnOfHPpTGDb8ksP/1xozMNS5pfJBq2qND+xbSsqL
         jXN9eyqlHvGTRE9ZT1lghIVQxge8LPNB/3tV6aYAfiGYmkEM23lmGhIfZXPlAYFoaB05
         xngEJP7oVjSZ/ny2+NS4ei8a/ExtYPKVQ44dwxyN/r+7YBMXDOoH7EnVkmDaN4a+uf1y
         uBrif34iDa1wAL03EEQ++RzPpuLA8mNSVqT0jZxDJRenuZxOhVZG0sj7920MDUsHkJke
         90BA==
X-Gm-Message-State: APjAAAXd/LsPf4l5Pz63vEqzMqFf2V1rCodvF8u2vxQ8zInAjOfXqcE+
        CquvCl9Ksy6Z5LEl3Qr31bPTWA==
X-Google-Smtp-Source: APXvYqwfqL1fQunyEe0XwF9IhDZjen+nYUd1RNXPbNXfQoln/hNXyPNFYH0ug0RuWImFxCqV0CT8eA==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr4479374pgc.346.1567013794108;
        Wed, 28 Aug 2019 10:36:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k25sm3212318pgt.53.2019.08.28.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:29 -0700 (PDT)
Date:   Sat, 24 Aug 2019 10:17:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception handler
Message-ID: <201908241016.9DCD43AF1@keescook>
References: <20190819234111.9019-1-keescook@chromium.org>
 <20190819234111.9019-8-keescook@chromium.org>
 <20190820100638.GK2332@hirez.programming.kicks-ass.net>
 <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
 <20190820211429.7030b6f6@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820211429.7030b6f6@oasis.local.home>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 20, 2019 at 09:14:29PM -0400, Steven Rostedt wrote:
> On Tue, 20 Aug 2019 12:58:49 +0200
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
> > >> index 1077366f496b..6c22e8a6f9de 100644
> > >> --- a/lib/bug.c
> > >> +++ b/lib/bug.c
> > >> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> > >>   		}
> > >>   	}
> > >>   
> > >> +	/*
> > >> +	 * BUG() and WARN_ON() families don't print a custom debug message
> > >> +	 * before triggering the exception handler, so we must add the
> > >> +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > >> +	 * extra debugging message it writes before triggering the handler.
> > >> +	 */
> > >> +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> > >> +		printk(KERN_DEFAULT CUT_HERE);  
> > > 
> > > I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> > > sense to me.
> > >   
> > 
> > Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not 
> > using the generic macros will have to add the flag to get the "cut here" 
> > line.
> >
> 
> Perhaps they all should be audited to see if they don't have the same
> problem?

As far as I could tell, all the other combinations end up either using
the slow path bug helpers or the common exception handler.
warn-with-a-fmt-string is the only case that does the "early cut here".

-- 
Kees Cook
