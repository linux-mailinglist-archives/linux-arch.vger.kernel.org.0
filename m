Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2D0104F63
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2019 10:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKUJiN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Nov 2019 04:38:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfKUJiM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Nov 2019 04:38:12 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F0420715;
        Thu, 21 Nov 2019 09:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574329091;
        bh=KDNNSeEp/BN7g6dacCX6F2lPgBB7H7Y/8Sa/tPZGACc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqZK7LSdAcM+PQxrHLccYNczceU1SIE9dSOun8Jjv6CkedQaFc7CQWcq326oPwPQE
         KVg8z5mHngePnmPnofU+JrjAAyM5qehIce0Tm+fpQvfgdgCKISgguZ6eSAhtJ9DPzq
         pT5x9uTotNq5daSwQGy5TFCCrXLLk+VfA/imr0KU=
Date:   Thu, 21 Nov 2019 09:38:06 +0000
From:   Will Deacon <will@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org, ben.dooks@codethink.co.uk
Subject: Re: [PATCH] exec: warn if process starts with executable stack
Message-ID: <20191121093806.GB1091@willie-the-truck>
References: <20191118145114.GA9228@avx2>
 <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
 <20191118215227.GA24536@avx2>
 <20191120191752.GC4799@willie-the-truck>
 <87d0dm47ii.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0dm47ii.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 20, 2019 at 02:28:37PM -0600, Eric W. Biederman wrote:
> Will Deacon <will@kernel.org> writes:
> 
> > On Tue, Nov 19, 2019 at 12:52:27AM +0300, Alexey Dobriyan wrote:
> >> There were few episodes of silent downgrade to an executable stack:
> >> 
> >> 1) linking innocent looking assembly file
> >> 
> >> 	$ cat f.S
> >> 	.intel_syntax noprefix
> >> 	.text
> >> 	.globl f
> >> 	f:
> >> 	        ret
> >> 
> >> 	$ cat main.c
> >> 	void f(void);
> >> 	int main(void)
> >> 	{
> >> 	        f();
> >> 	        return 0;
> >> 	}
> >> 
> >> 	$ gcc main.c f.S
> >> 	$ readelf -l ./a.out
> >> 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
> >>                          0x0000000000000000 0x0000000000000000  RWE    0x10
> >> 
> >> 2) converting C99 nested function into a closure
> >> https://nullprogram.com/blog/2019/11/15/
> >> 
> >> 	void intsort2(int *base, size_t nmemb, _Bool invert)
> >> 	{
> >> 	    int cmp(const void *a, const void *b)
> >> 	    {
> >> 	        int r = *(int *)a - *(int *)b;
> >> 	        return invert ? -r : r;
> >> 	    }
> >> 	    qsort(base, nmemb, sizeof(*base), cmp);
> >> 	}
> >> 
> >> will silently require stack trampolines while non-closure version will not.
> >> 
> >> While without a double this behaviour is documented somewhere, add a warning
> >> so that developers and users can at least notice. After so many years of x86_64
> >> having proper executable stack support it should not cause too much problems.
> >> 
> >> If the system is old or CPU is old, then there will be an early warning
> >> against init and/or support personnel will write that "uh-oh, our Enterprise
> >> Software absolutely requires executable stack" and close tickets and customers
> >> will nod heads and life moves on.
> >> 
> >> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >> ---
> >> 
> >>  fs/exec.c |    5 +++++
> >>  1 file changed, 5 insertions(+)
> >> 
> >> --- a/fs/exec.c
> >> +++ b/fs/exec.c
> >> @@ -762,6 +762,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
> >>  		goto out_unlock;
> >>  	BUG_ON(prev != vma);
> >>  
> >> +	if (vm_flags & VM_EXEC) {
> >> +		pr_warn_once("process '%s'/%u started with executable stack\n",
> >> +			     current->comm, current->pid);
> >> +	}
> >
> > Given that this is triggerable by userspace, is there a concern about PID
> > namespaces here?
> 
> In what sense?  Are you thinking about the printing of the pid?
> 
> Pretty much by fiat and by definition the kernel log always print things
> in the initial pid namespace.  Which this printk does.

Ok, fair enough. Just wanted to make sure it was ok, since we're not using
a task_pid_nr*() accessor and it might have been overlooked.

Will

Will
