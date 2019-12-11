Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C911A504
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 08:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfLKHWb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 02:22:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfLKHWb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 02:22:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so1321584wro.9;
        Tue, 10 Dec 2019 23:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s971EL/Y1pn75DzMBKpBweiCyai7sbjJumnqOBIgASs=;
        b=GTb2+vnVPJNBPRaQmu2PQDhFmjs586KKg+WCWQfPIRbNTu0701+Li5yw4nFk0gXoAf
         VnSX/TchRJp02YlS+uvQxaBYPWl4kDNLacpLD1mn1ovaVTR4aXnKM8iAkwy2aivzVw0l
         aBvJADaqccTojENxuugf6r7S+HiiQ4adcArDFVapuHzIJevl+Pf9Udo9aWCmCRttltFP
         5lhNWqNAuJ3RaxwYbNeqylM+LUoNWyfq/Ai3ksGbldL0zI9dGko6W0LKkpfihCkgFmE9
         h7lGcI/n2GuD6nSx1mNytMqSDWf2m72+BPWPOPv7bRk/m1lgDKYg10/qhEpT0/Q1lpMT
         6xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s971EL/Y1pn75DzMBKpBweiCyai7sbjJumnqOBIgASs=;
        b=rT8GGDa+kcWluJZ64gtN4MBwT+NVT/0AyqrQ/HB09tD/2P2ftD7wx0t7EDg45HjhJt
         T9EXmqPA2PGdScPzgwYhm1QDffOZOr6eJ/Bqlp8u3fGOwfCxf3F+Qk45szIhjYlZ3xv7
         Rq09VCH5WdPS5vB0LjvbrXAiAX6ZCvdyAuWuV9na2VPBgZISsTeQ5KZYJ6C9Br/7jd2I
         21mfL2HSoCDcspKZALRF+l6wOgkkHDbbZI/ov2GM4/36UD+21D0oUiWy2SAMcEER52C/
         18xLiRvNBZAcczeZns/pTjjeWCMOJCRrBtvbu9HsjSK7VXfHycaRae1EDHw0kKhwrJ/2
         +QVg==
X-Gm-Message-State: APjAAAVDftVPySfRoz4Pi7L3nQjxxvP7J1jEod1nSN4y09LhV1RZA6vS
        GSOaNSoS+Z7z1V0DTfI7yg==
X-Google-Smtp-Source: APXvYqzDS0RdO89bubq0N7qVfg1e12NN3BYU+DkaCM7bkek5LOVJBTI41FdUWEB4h1dtclONLIMTfw==
X-Received: by 2002:adf:e591:: with SMTP id l17mr1821693wrm.139.1576048948872;
        Tue, 10 Dec 2019 23:22:28 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id n8sm1204151wrx.42.2019.12.10.23.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 23:22:28 -0800 (PST)
Date:   Wed, 11 Dec 2019 10:22:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com,
        linux-arch@vger.kernel.org, security@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191211072225.GB3700@avx2>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Me? Nothing :-) They hopefully should file tickets against distros and ISV,
post egregious examples to oss-security.

Like they already do against this warning!
> ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
