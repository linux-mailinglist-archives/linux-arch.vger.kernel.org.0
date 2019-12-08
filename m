Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0FB116311
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2019 17:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfLHQoC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Dec 2019 11:44:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55805 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfLHQoC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Dec 2019 11:44:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so12891083wmj.5;
        Sun, 08 Dec 2019 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YsC4VL3hPPyF8yikA3yMdaZ2+eqzptOmxulvBrArtJE=;
        b=UHipSOXSn1N8tow/cvdoLRr9pGdTcx+s38aEwDjGIa51Qn9NstA/POb71jU/Jl151/
         ZKi1clsNJmJrfth1evbBfLkLXW2ZcELFsx75X1jweZImSQhCo75hhUYn3yKA5ucuKGh2
         4qI/ecC7o/XpqVZGWyov2KTQ+46ODK4vXH8dbbRwHTo5jAu0b5w6bfl1H9UYEyB5g597
         H7eHvGZYzmgBCdTXj4qfHYlaQ5tAcGyECnfxRGMX5GzqBvL12D04DvwcvncPy41Rrv0b
         lutcWdyYJwmztvHuYj715qatY6ijtFaZkOhCQdoMyZ1D0OEhTPrV67IcIMAHdnnuBPUS
         h/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsC4VL3hPPyF8yikA3yMdaZ2+eqzptOmxulvBrArtJE=;
        b=WCe4ktXHx93dAy4niPHfX05EuBAhcS3gbe9qDLU8VDAT+o+hWjcdmkHQ4ogD4+pW02
         4CXXYwvx+79ZhPz0wp7HtHBEHSo497yAeU/MUB3WCbdkFg+qZAP8WJiALz2Jk/2BByvW
         gyRlwOd9Wqgm6IbIBhgoUMC6tdMo2EgmppSFbx1X0rrcVFfvgH3k2D1qavNoromeWKvt
         dkhj/MA1N1xJCZ0OoygohCqB7XsJ0qpwnfoPMGLbSuL7R8Xu5j5u1F79u4CCnHPBRQ6w
         fiUAGUjOq0ewnXMPM83+CbJK0zQwgm8f4KVaqECnnzfVMCWHy5dbNhPXxfsgdpZ7+XEM
         e+MQ==
X-Gm-Message-State: APjAAAWiC8VF4ZIR4pZ9iazQoQEznI74EGkuFTHZR84nyoWUdy58qojl
        pcMyq2XeErTTG5A0uI1P3Q==
X-Google-Smtp-Source: APXvYqx4wweyoQS5uKppNq7DwG7hBgGKXuojTSZBkDyJeEZF9c7vCRqramCs2BbfdjAPmBAiI11Oww==
X-Received: by 2002:a1c:4884:: with SMTP id v126mr13053455wma.64.1575823439504;
        Sun, 08 Dec 2019 08:43:59 -0800 (PST)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id f16sm10714035wrm.65.2019.12.08.08.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 08:43:58 -0800 (PST)
Date:   Sun, 8 Dec 2019 19:43:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org, ben.dooks@codethink.co.uk
Subject: Re: [PATCH] exec: warn if process starts with executable stack
Message-ID: <20191208164354.GA19908@avx2>
References: <20191118145114.GA9228@avx2>
 <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
 <20191118215227.GA24536@avx2>
 <20191120191752.GC4799@willie-the-truck>
 <87d0dm47ii.fsf@x220.int.ebiederm.org>
 <20191121093806.GB1091@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191121093806.GB1091@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 21, 2019 at 09:38:06AM +0000, Will Deacon wrote:
> On Wed, Nov 20, 2019 at 02:28:37PM -0600, Eric W. Biederman wrote:
> > Will Deacon <will@kernel.org> writes:
> > 
> > > On Tue, Nov 19, 2019 at 12:52:27AM +0300, Alexey Dobriyan wrote:
> > >> There were few episodes of silent downgrade to an executable stack:
> > >> 
> > >> 1) linking innocent looking assembly file
> > >> 
> > >> 	$ cat f.S
> > >> 	.intel_syntax noprefix
> > >> 	.text
> > >> 	.globl f
> > >> 	f:
> > >> 	        ret
> > >> 
> > >> 	$ cat main.c
> > >> 	void f(void);
> > >> 	int main(void)
> > >> 	{
> > >> 	        f();
> > >> 	        return 0;
> > >> 	}
> > >> 
> > >> 	$ gcc main.c f.S
> > >> 	$ readelf -l ./a.out
> > >> 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
> > >>                          0x0000000000000000 0x0000000000000000  RWE    0x10
> > >> 
> > >> 2) converting C99 nested function into a closure
> > >> https://nullprogram.com/blog/2019/11/15/
> > >> 
> > >> 	void intsort2(int *base, size_t nmemb, _Bool invert)
> > >> 	{
> > >> 	    int cmp(const void *a, const void *b)
> > >> 	    {
> > >> 	        int r = *(int *)a - *(int *)b;
> > >> 	        return invert ? -r : r;
> > >> 	    }
> > >> 	    qsort(base, nmemb, sizeof(*base), cmp);
> > >> 	}
> > >> 
> > >> will silently require stack trampolines while non-closure version will not.
> > >> 
> > >> While without a double this behaviour is documented somewhere, add a warning
> > >> so that developers and users can at least notice. After so many years of x86_64
> > >> having proper executable stack support it should not cause too much problems.
> > >> 
> > >> If the system is old or CPU is old, then there will be an early warning
> > >> against init and/or support personnel will write that "uh-oh, our Enterprise
> > >> Software absolutely requires executable stack" and close tickets and customers
> > >> will nod heads and life moves on.
> > >> 
> > >> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > >> ---
> > >> 
> > >>  fs/exec.c |    5 +++++
> > >>  1 file changed, 5 insertions(+)
> > >> 
> > >> --- a/fs/exec.c
> > >> +++ b/fs/exec.c
> > >> @@ -762,6 +762,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
> > >>  		goto out_unlock;
> > >>  	BUG_ON(prev != vma);
> > >>  
> > >> +	if (vm_flags & VM_EXEC) {
> > >> +		pr_warn_once("process '%s'/%u started with executable stack\n",
> > >> +			     current->comm, current->pid);
> > >> +	}
> > >
> > > Given that this is triggerable by userspace, is there a concern about PID
> > > namespaces here?
> > 
> > In what sense?  Are you thinking about the printing of the pid?
> > 
> > Pretty much by fiat and by definition the kernel log always print things
> > in the initial pid namespace.  Which this printk does.
> 
> Ok, fair enough. Just wanted to make sure it was ok, since we're not using
> a task_pid_nr*() accessor and it might have been overlooked.

PID is printed both as ->pid and a task_pid_vnr().
I'll just print filename, so that executable can be easily found.
