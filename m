Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0706716F236
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 22:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgBYVw2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 16:52:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33744 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgBYVw1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 16:52:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so386745plb.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=67FIIq1D+V+asq39t76M7ReKeHhVxdkAMjdLa3hjO4A=;
        b=WMlJ8w13eGrO7Kbvy/9m9s0u5Yu0HmI3lHoSYEAYxlrTLRzW/t99dMlQdrxXWUTA0D
         zKAmdbiNd8kRXlpySjM2lvvcC2Hrmo0HP4YW9rpS6oFMjb29MVFYxZGh5TjKHEklLotV
         /G3J3usnTgzRuBApWWMw7tLWKjHmtDNeTGVBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=67FIIq1D+V+asq39t76M7ReKeHhVxdkAMjdLa3hjO4A=;
        b=tZXkbAHfzmBSNl3cP12UkY3Weh7MzwbgiNrU/2sH2oltBTb8meplKvRGsqp76BF1SQ
         KG7aTuZPagrwqhHWkgB1JBMdcMhmSp/l+aAfq4eBtdXObsfuAQbXPj/ctq9sUVqdTbJW
         K5U4uMjEWd0LMlu8hoAbpFvQ83T/FTqkeboprjneiPUYtsiyaVKsaNqrO94Ln4ZpTGqP
         rWhANocspPXP0zPiY3K1AbLP2oZblI33ZD0RyomdV8IaESlSZnnYmIgonRaPkqZI50Kc
         0pSGLNk6mr2jxXiE1VBGdr8GLa1KqZ/Byi2HO6kR/utI45B9a36Ql1uRFxDSy+cjid/U
         kiKQ==
X-Gm-Message-State: APjAAAVDUEoRAZjDGQmkp0FzAfawlCdh/u4RavGpTjImRrUWrm0e0gQ6
        UweGIH2VPnLHXztk5CX37A8+eg==
X-Google-Smtp-Source: APXvYqytfJllWL3kvVcykyzU2VtupNrDrUaLjpP3rd5JD3s1hTnEWkeZBgHal8imd07uv+qMVVQhdg==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr1311964pjq.5.1582667545448;
        Tue, 25 Feb 2020 13:52:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f18sm7161pgn.2.2020.02.25.13.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:52:24 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:52:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, dan.carpenter@oracle.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Ben Hutchings <ben@decadent.org.uk>, will@kernel.org,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        security@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <202002251341.48BC06E@keescook>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 10, 2019 at 05:47:26PM -0800, Andrew Morton wrote:
> On Sun, 8 Dec 2019 20:19:18 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > There were few episodes of silent downgrade to an executable stack over
> > years:
> > 
> > 1) linking innocent looking assembly file will silently add executable
> >    stack if proper linker options is not given as well:
> > 
> > 	$ cat f.S
> > 	.intel_syntax noprefix
> > 	.text
> > 	.globl f
> > 	f:
> > 	        ret
> > 
> > 	$ cat main.c
> > 	void f(void);
> > 	int main(void)
> > 	{
> > 	        f();
> > 	        return 0;
> > 	}
> > 
> > 	$ gcc main.c f.S
> > 	$ readelf -l ./a.out
> > 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
> >                          0x0000000000000000 0x0000000000000000  RWE    0x10
> > 			 					 ^^^
> > 
> > 2) converting C99 nested function into a closure
> > https://nullprogram.com/blog/2019/11/15/
> > 
> > 	void intsort2(int *base, size_t nmemb, _Bool invert)
> > 	{
> > 	    int cmp(const void *a, const void *b)
> > 	    {
> > 	        int r = *(int *)a - *(int *)b;
> > 	        return invert ? -r : r;
> > 	    }
> > 	    qsort(base, nmemb, sizeof(*base), cmp);
> > 	}
> > 
> > will silently require stack trampolines while non-closure version will not.
> > 
> > Without doubt this behaviour is documented somewhere, add a warning so that
> > developers and users can at least notice. After so many years of x86_64 having
> > proper executable stack support it should not cause too many problems.
> 
> hm, OK, let's give it a trial run.

So, I'm a fan of the sentiment here, but this check is bogus for
several architectural and programmatic combinations. Sometimes
it's an intentional choice, not an "accident". e.g. klibc
uses trampolines for its setjmp implementation:
https://lists.zytor.com/archives/klibc/2020-February/004271.html

So now all the klibc initrds are throwing this warning (and then never
warning again, so it's extra pointless for such machines as "legitimate"
cases will never be discovered).

I've got a series up to fix the much sneakier version of this
(READ_IMPLIES_EXEC[1]), but at this point, I think this problem is well
addressed by distros scanning for this kind of thing in their repos.
For example, Ubuntu did this years ago (and flagged klibc as having
this condition):
https://wiki.ubuntu.com/SecurityTeam/Roadmap/ExecutableStacks

> 
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -761,6 +761,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
> >  		goto out_unlock;
> >  	BUG_ON(prev != vma);
> >  
> > +	if (unlikely(vm_flags & VM_EXEC)) {
> > +		pr_warn_once("process '%pD4' started with executable stack\n",
> > +			     bprm->file);
> > +	}
> > +
> >  	/* Move stack pages down in memory. */
> >  	if (stack_shift) {
> >  		ret = shift_arg_pages(vma, stack_shift);
> 
> What are poor users supposed to do if this message comes out? 
> Hopefully google the message and end up at this thread.  What do you
> want to tell them?

And that's the other problem (for which I see there is a thread). The
user can't actually do anything here.

I would really like something like this check, but maintaining a whitelist
of architectures or binaries to ignore is going to be awful, and there
is a very non-zero amount of software is built this way intentionally...

-Kees

[1] https://lore.kernel.org/lkml/20200225051307.6401-1-keescook@chromium.org/#r

-- 
Kees Cook
