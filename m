Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC2AE677
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2019 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfIJJQY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Sep 2019 05:16:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34529 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfIJJQY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Sep 2019 05:16:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id r12so11207653pfh.1;
        Tue, 10 Sep 2019 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfhBlXbTlTMX4E76VadOfA+hOSSFiVKlUr5WhybwN6Y=;
        b=Ix5XIq52ojuczz2WFlndYuPyvegA1xBDLqKlQinxNi/ddwwT7aSp4BE52bdpTtvBZU
         VGccYwG2QB+jUEvkPdfe009RtiB9HEycmrhIrWHM2Wz5mmZhS9Z/AETPcWfTFmwV3RVr
         LmnHyXpoIlqloJ3oDoCuKVs3wIKH02w1f1IqNKPq+VKN2iVFQ8lY97MeHbb7nlrdDQjZ
         a1vYuEugpJMWHAut3i/uQueEv43jrugOrhortyg2TB6eWDbzer1PjupJpjCNdPR/GRIV
         TFhVK+cu/PfSgVeGkWYqYzXVF/xBJikC6YUBWbu1BJHOGROPTjsqrh8eNAkwfDzk1T8t
         KXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfhBlXbTlTMX4E76VadOfA+hOSSFiVKlUr5WhybwN6Y=;
        b=qVutd7aMe3kzHOynRAvUyp4RXnsCk2k13NO3v7MXVegLU8M6bx0N3nR9VoHjhYUK9e
         AOGSi3eLE2vAzf63NM+x/sbZOW3eAlgdN7kog1wlih/hUh4UE2y1g84jyym+Ijfvw1wQ
         fGyYk4Mw6Einaj4JDuSVT1WR/6puoUWSaMktOqSY8kMl+/Oj5UJBP6Q2xGDCrI57rfSL
         u432VeCwExz8H/6mz13zoAm85xn7oOcsT+xDAohmFkd/BpbqUUG3TsM4FH6oXCNzG9u2
         E09j/PBgRRl78/selUIcSG9j64Q2p4RvcDCdRhE9KzkHcYben3gP6Pe6VAKuThCNX9V7
         SN6g==
X-Gm-Message-State: APjAAAWK5rtNKzRmOxqg2YZskMw+NokgPEd65l+V1hmNMgU0bGrfVhQ/
        z5ylOapIXRh/4Ux6+PExiMzf3DwF
X-Google-Smtp-Source: APXvYqzHxaQmBpWgS74sUCr55Qt//D6scXpE7mF2noH5yrUuPhN0dejzlnIbbX8R57D9IIvydGR9/g==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr27422854pgt.365.1568106983856;
        Tue, 10 Sep 2019 02:16:23 -0700 (PDT)
Received: from localhost ([39.7.19.227])
        by smtp.gmail.com with ESMTPSA id l26sm20389698pgb.90.2019.09.10.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 02:16:23 -0700 (PDT)
Date:   Tue, 10 Sep 2019 18:16:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <20190910091619.GA207290@jagdpanzerIV>
References: <201908200943.601DD59DCE@keescook>
 <20190909160539.GA989@tigerII.localdomain>
 <201909100157.CEE99802C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909100157.CEE99802C@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (09/10/19 01:59), Kees Cook wrote:
> On Tue, Sep 10, 2019 at 01:05:39AM +0900, Sergey Senozhatsky wrote:
> > On (08/20/19 09:47), Kees Cook wrote:
> > [..]
> > > +	/*
> > > +	 * BUG() and WARN_ON() families don't print a custom debug message
> > > +	 * before triggering the exception handler, so we must add the
> > > +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > > +	 * extra debugging message it writes before triggering the handler.
> > > +	 */
> > > +	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
> > > +		printk(KERN_DEFAULT CUT_HERE);
> > 
> > Shouldn't this be pr_warn() or pr_crit()?
> 
> The pr_* helpers here would (potentially) add unwanted prefixes, so
> those aren't used. KERN_DEFAULT is used here because that's how it's
> always been printed. I didn't want to change that for this refactoring
> work. I'm not opposed to it, generally speaking, though. :)

I just glanced through CUT_HERE users

warn_slowpath_fmt()    pr_warn(CUT_HERE)
__warn_printk()        pr_warn(CUT_HERE)
rdma_restrack_clean()  pr_err("restrack: %s", CUT_HERE)
rdma_restrack_clean()  pr_err("restrack: %s", CUT_HERE)

+ oops/panic end markers are of pr_warn() or pr_crit() log levels.
So I thought that maybe we can make it more or less similar.

But if it has always been this way (KERN_DEFAULT) then OK.

	-ss
