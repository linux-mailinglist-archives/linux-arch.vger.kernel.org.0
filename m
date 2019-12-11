Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD89B11A866
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 10:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfLKJ7s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 04:59:48 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:29350 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfLKJ7s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 04:59:48 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xBB9xb32031689;
        Wed, 11 Dec 2019 10:59:37 +0100
Date:   Wed, 11 Dec 2019 10:59:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com,
        linux-arch@vger.kernel.org, security@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191211095937.GB31670@1wt.eu>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
 <20191211072225.GB3700@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211072225.GB3700@avx2>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 10:22:25AM +0300, Alexey Dobriyan wrote:
> On Tue, Dec 10, 2019 at 05:47:26PM -0800, Andrew Morton wrote:
> > On Sun, 8 Dec 2019 20:19:18 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 
> > > There were few episodes of silent downgrade to an executable stack over
> > > years:
> > > 
> > > 1) linking innocent looking assembly file will silently add executable
> > >    stack if proper linker options is not given as well:
> > > 
> > > 	$ cat f.S
> > > 	.intel_syntax noprefix
> > > 	.text
> > > 	.globl f
> > > 	f:
> > > 	        ret
> > > 
> > > 	$ cat main.c
> > > 	void f(void);
> > > 	int main(void)
> > > 	{
> > > 	        f();
> > > 	        return 0;
> > > 	}
> > > 
> > > 	$ gcc main.c f.S
> > > 	$ readelf -l ./a.out
> > > 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
> > >                          0x0000000000000000 0x0000000000000000  RWE    0x10
> > > 			 					 ^^^
> > > 
> > > 2) converting C99 nested function into a closure
> > > https://nullprogram.com/blog/2019/11/15/
> > > 
> > > 	void intsort2(int *base, size_t nmemb, _Bool invert)
> > > 	{
> > > 	    int cmp(const void *a, const void *b)
> > > 	    {
> > > 	        int r = *(int *)a - *(int *)b;
> > > 	        return invert ? -r : r;
> > > 	    }
> > > 	    qsort(base, nmemb, sizeof(*base), cmp);
> > > 	}
> > > 
> > > will silently require stack trampolines while non-closure version will not.
> > > 
> > > Without doubt this behaviour is documented somewhere, add a warning so that
> > > developers and users can at least notice. After so many years of x86_64 having
> > > proper executable stack support it should not cause too many problems.
> > 
> > hm, OK, let's give it a trial run.
> > 
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -761,6 +761,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
> > >  		goto out_unlock;
> > >  	BUG_ON(prev != vma);
> > >  
> > > +	if (unlikely(vm_flags & VM_EXEC)) {
> > > +		pr_warn_once("process '%pD4' started with executable stack\n",
> > > +			     bprm->file);
> > > +	}
> > > +
> > >  	/* Move stack pages down in memory. */
> > >  	if (stack_shift) {
> > >  		ret = shift_arg_pages(vma, stack_shift);
> > 
> > What are poor users supposed to do if this message comes out? 
> > Hopefully google the message and end up at this thread.  What do you
> > want to tell them?
> 
> Me? Nothing :-) They hopefully should file tickets against distros and ISV,
> post egregious examples to oss-security.
> 
> Like they already do against this warning!
> > ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored

Alexey, Andrew is right. Your message gives no instruction and users are
already flooded with messages they got used to ignore. A warning is made
to catch attention so it should give instructions. It can either say
"this application relies on insecure capabilities and might not work
anymore in the future, you should report this to its author", or "report
this to kernel developers if you think this warning is inappropriate".
Otherwise it will just go to /dev/null with all warning about bad blocks
on USB sticks and CPU core throttling under high temperature.

Willy
