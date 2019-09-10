Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5BAE627
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2019 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfIJI7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Sep 2019 04:59:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42428 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfIJI7d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Sep 2019 04:59:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so11146455pfi.9
        for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2019 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BVZkeB8kcfbAhGWCwFmsi+Af79YcNd2rTDIYMad/gaM=;
        b=GMqgtLrwt3KM8f3wheWQ7WpLBzaMDWSTCw5oTy8E406J0B6emHLl1jKtsM+6vYT72P
         VweUtZAmpCf6H/wVVMayc3KsdLLcGrydwRc+pZKkjJZPadftpD6K7raTMiVSPhaLV+dr
         PdGEZMyKA66nEZoTsUqvbTm1f6HMlCuf8pNeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BVZkeB8kcfbAhGWCwFmsi+Af79YcNd2rTDIYMad/gaM=;
        b=NQ10FdBoCHlme1gNlZCIv6aQu7hvDrfDaj/qC27ZwB55lxSfGBP+oLD+eO8+GcEUc3
         rwhvReDgaA7tRuDE2dgndnDbDVC/RpfQUNhT1ZK+z/8O3B3xZASA4wHxayQqdLRi87E5
         oYdqn/DWhjXAqSJ4/M7vJEccLHvewVOpf4yGFmtdDhGQC/hMK/e/AWcDTWJ7d8hkj7aW
         rlvF0gHdRO3xzj2fCRBlODKpORAF87pxg9Uc3V1E/Lf230YJlNbF1yp99QlEMELBAFiD
         w8PEVlVMIBn4ta9LcMbvvQRviebhlF/WQoRYBP7WNbf5MMqHf+hyMHE3wnUYFdz1bdKm
         wSXw==
X-Gm-Message-State: APjAAAUi3vCwyESk8GKiBxIFIrmfJbk56gSg8lNGlIOJ0kzF21i9FLWt
        kLEQvSD2VpEuW2BKNnk2EYDTZA==
X-Google-Smtp-Source: APXvYqzK0Ttf4/Xi57wL2oeea0djC4HNgeahFaJrMzpGlfeG86fQuDKcRSHD3yi1HIq4tDv9kNpaSA==
X-Received: by 2002:a63:6888:: with SMTP id d130mr25498575pgc.197.1568105972826;
        Tue, 10 Sep 2019 01:59:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 127sm34965672pfw.6.2019.09.10.01.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 01:59:31 -0700 (PDT)
Date:   Tue, 10 Sep 2019 01:59:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     20190819234111.9019-8-keescook@chromium.org,
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
Message-ID: <201909100157.CEE99802C@keescook>
References: <201908200943.601DD59DCE@keescook>
 <20190909160539.GA989@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909160539.GA989@tigerII.localdomain>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 10, 2019 at 01:05:39AM +0900, Sergey Senozhatsky wrote:
> On (08/20/19 09:47), Kees Cook wrote:
> [..]
> > @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * BUG() and WARN_ON() families don't print a custom debug message
> > +	 * before triggering the exception handler, so we must add the
> > +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > +	 * extra debugging message it writes before triggering the handler.
> > +	 */
> > +	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
> > +		printk(KERN_DEFAULT CUT_HERE);
> 
> Shouldn't this be pr_warn() or pr_crit()?

The pr_* helpers here would (potentially) add unwanted prefixes, so
those aren't used. KERN_DEFAULT is used here because that's how it's
always been printed. I didn't want to change that for this refactoring
work. I'm not opposed to it, generally speaking, though. :)

-- 
Kees Cook
