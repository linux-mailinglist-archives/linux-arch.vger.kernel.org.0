Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62E595BFE
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfHTKHO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 06:07:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35232 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfHTKHO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Aug 2019 06:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RUVsS3C5PVRVD/3Ci7OzOKjzjEi6jtHtjm1up0/Wduc=; b=oB3AP+9GWs/aEEahebgMXd4/D
        UsamlvUvtqK96zapMTtGsPvoeqpI7wyZtQ4ehHuDKKrQbNWgpP/3pODfh/92kakNS40DCj9APC0nv
        Ji5hOp7mExcBghyuyE69W2Muk6WrGOwDlDiMXG6lWgmN4eX0S+esHyxaPxKx7eBv0oFi/B3n+OqXA
        hAyx1ZUE5dk/vyNzCfS9KzKGJoFPo4IJLyT3IQfG3R2/crHlnYqCxU4oSaO+qTXkAHcp/0UPITcQs
        CHlFjMGoFCOgFOlVq/699G2mrjqnozPpPWyw0lv+IfwU+WkV4qgXWC5WJWRJtQ9pE74gRqTfAr2Ux
        byqt4pAFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i012H-0006JA-0H; Tue, 20 Aug 2019 10:06:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99B7F3075FF;
        Tue, 20 Aug 2019 12:06:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C057120CE7753; Tue, 20 Aug 2019 12:06:38 +0200 (CEST)
Date:   Tue, 20 Aug 2019 12:06:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
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
Message-ID: <20190820100638.GK2332@hirez.programming.kicks-ass.net>
References: <20190819234111.9019-1-keescook@chromium.org>
 <20190819234111.9019-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819234111.9019-8-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 19, 2019 at 04:41:11PM -0700, Kees Cook wrote:

> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 588dd59a5b72..da471fcc5487 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -10,6 +10,7 @@
>  #define BUGFLAG_WARNING		(1 << 0)
>  #define BUGFLAG_ONCE		(1 << 1)
>  #define BUGFLAG_DONE		(1 << 2)
> +#define BUGFLAG_PRINTK		(1 << 3)
>  #define BUGFLAG_TAINT(taint)	((taint) << 8)
>  #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
>  #endif

> diff --git a/lib/bug.c b/lib/bug.c
> index 1077366f496b..6c22e8a6f9de 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>  		}
>  	}
>  
> +	/*
> +	 * BUG() and WARN_ON() families don't print a custom debug message
> +	 * before triggering the exception handler, so we must add the
> +	 * "cut here" line now. WARN() issues its own "cut here" before the
> +	 * extra debugging message it writes before triggering the handler.
> +	 */
> +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> +		printk(KERN_DEFAULT CUT_HERE);

I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
sense to me.
