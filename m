Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EA11A0B3
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 02:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLKBr2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 20:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfLKBr1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 20:47:27 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021B2205ED;
        Wed, 11 Dec 2019 01:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576028847;
        bh=aJEBHOJgbmW5u/PI+IDmgyBqpJA+BGn7BUCYF8lBBXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a4TeTJ8lJl8q2dLF6mL0GpmczoEuiJsnjXjb9qT5uG5YEyb5hp2C9lNnNhFyLBLB2
         031Y12L8dQGuzjXBTdQPX+qPEUotS1ySZN21FJ3Zx0yaT5gq3Tjon5oFgMy6hOLPph
         knl2US3pMczsLrw/0BNFyQN54wFMElQ3kUNz4c4k=
Date:   Tue, 10 Dec 2019 17:47:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com,
        linux-arch@vger.kernel.org, security@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-Id: <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
In-Reply-To: <20191208171918.GC19716@avx2>
References: <20191208171918.GC19716@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 8 Dec 2019 20:19:18 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> There were few episodes of silent downgrade to an executable stack over
> years:
> 
> 1) linking innocent looking assembly file will silently add executable
>    stack if proper linker options is not given as well:
> 
> 	$ cat f.S
> 	.intel_syntax noprefix
> 	.text
> 	.globl f
> 	f:
> 	        ret
> 
> 	$ cat main.c
> 	void f(void);
> 	int main(void)
> 	{
> 	        f();
> 	        return 0;
> 	}
> 
> 	$ gcc main.c f.S
> 	$ readelf -l ./a.out
> 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                          0x0000000000000000 0x0000000000000000  RWE    0x10
> 			 					 ^^^
> 
> 2) converting C99 nested function into a closure
> https://nullprogram.com/blog/2019/11/15/
> 
> 	void intsort2(int *base, size_t nmemb, _Bool invert)
> 	{
> 	    int cmp(const void *a, const void *b)
> 	    {
> 	        int r = *(int *)a - *(int *)b;
> 	        return invert ? -r : r;
> 	    }
> 	    qsort(base, nmemb, sizeof(*base), cmp);
> 	}
> 
> will silently require stack trampolines while non-closure version will not.
> 
> Without doubt this behaviour is documented somewhere, add a warning so that
> developers and users can at least notice. After so many years of x86_64 having
> proper executable stack support it should not cause too many problems.

hm, OK, let's give it a trial run.

> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -761,6 +761,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
>  		goto out_unlock;
>  	BUG_ON(prev != vma);
>  
> +	if (unlikely(vm_flags & VM_EXEC)) {
> +		pr_warn_once("process '%pD4' started with executable stack\n",
> +			     bprm->file);
> +	}
> +
>  	/* Move stack pages down in memory. */
>  	if (stack_shift) {
>  		ret = shift_arg_pages(vma, stack_shift);

What are poor users supposed to do if this message comes out? 
Hopefully google the message and end up at this thread.  What do you
want to tell them?

