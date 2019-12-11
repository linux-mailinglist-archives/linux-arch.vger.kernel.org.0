Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1282311BB8C
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfLKSTk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:19:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38400 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfLKSTk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 13:19:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so25153348wrh.5;
        Wed, 11 Dec 2019 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZvEWA84zsl3Zd00Qi6CACToTskjkn2lyDqowo+OS5Jc=;
        b=sOklkJD+p6i1tiIaQ9hoC9yBIhFUNxluuhEP0NmFiXWhtjKofdSJa1/fYEzHC35P0H
         k11QSnrKulyrO3bcFW8uv5Smrdt5OOE7wl3y9CsRlsAYjVSxpRFZR9vx/URbKhWsXUkg
         hLBWVhH9/CAbw3hF+q+9eja4DCeY5cxgAaA2g6mrndmIA8RgS9VAx1dLwv2OvjJCFolx
         LXou2U3477yCxqWYSD7IbJ4kajjOZqPGbIhHHCTgD3WJGtByzuIY/WmA+8nSHQWpeOjV
         95gOKo734BQmBHlPxpaLhCNJNDJbElyFQgarkrPs+il6d61cu0is8eMAXkYRIpQsvHJT
         HHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZvEWA84zsl3Zd00Qi6CACToTskjkn2lyDqowo+OS5Jc=;
        b=pSG6bQUyy/pJCTgxJEcT/Klm/QQgE4g2XKG/4SBKe0w44zLUFTmEC3g+AFyMfEeLKN
         A8gvlgFwgg/PuvDCeDhR3/Xk2Q4GiSqnqoPo4GvsUJ/q78t1a9mFu/9wDFnx5CGp7sVt
         C4+Hbu9qJJUMEk0gta2xz4jiKmQIvqK6IYDTd6bSrlsKunb0bck5jucbBHsNlC53fXkD
         ZcaTjo0lPfMKJjgSf1GBO5ik/eYhEUQ7xKq3JTyXBNWIaIa0MTCsYlgRvhKP1n1Tv7RY
         gj+6ZAGJy1sQAyjkw/r7LY6aZ3CqO7AzJb82kSc7hTdKBWP0FN5z61469HyCEIwzjbHZ
         Uf+Q==
X-Gm-Message-State: APjAAAXsH8NN3qC07Ci1CN8K9lCQQjHtqJtMBx2CrcR59TqBzdmrUB/D
        SAwCeByLM47mRH5o0hoQzmrCC1A=
X-Google-Smtp-Source: APXvYqwAeMTuM68qxqMbmAO+P6uiRaUjPPd7rPJ0MA+6lb7zTv/OyPD9YKnuxZAbyQfNTwiDGJgIpA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr1321644wru.382.1576088376749;
        Wed, 11 Dec 2019 10:19:36 -0800 (PST)
Received: from avx2 ([46.53.248.54])
        by smtp.gmail.com with ESMTPSA id v3sm3082984wru.32.2019.12.11.10.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:19:36 -0800 (PST)
Date:   Wed, 11 Dec 2019 21:19:33 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com,
        linux-arch@vger.kernel.org, security@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191211181933.GA3919@avx2>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
 <20191211072225.GB3700@avx2>
 <20191211095937.GB31670@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191211095937.GB31670@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 10:59:37AM +0100, Willy Tarreau wrote:
> On Wed, Dec 11, 2019 at 10:22:25AM +0300, Alexey Dobriyan wrote:
> > On Tue, Dec 10, 2019 at 05:47:26PM -0800, Andrew Morton wrote:
> > > On Sun, 8 Dec 2019 20:19:18 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > 
> > > > There were few episodes of silent downgrade to an executable stack over
> > > > years:
> > > > 
> > > > 1) linking innocent looking assembly file will silently add executable
> > > >    stack if proper linker options is not given as well:
> > > > 
> > > > 	$ cat f.S
> > > > 	.intel_syntax noprefix
> > > > 	.text
> > > > 	.globl f
> > > > 	f:
> > > > 	        ret
> > > > 
> > > > 	$ cat main.c
> > > > 	void f(void);
> > > > 	int main(void)
> > > > 	{
> > > > 	        f();
> > > > 	        return 0;
> > > > 	}
> > > > 
> > > > 	$ gcc main.c f.S
> > > > 	$ readelf -l ./a.out
> > > > 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
> > > >                          0x0000000000000000 0x0000000000000000  RWE    0x10
> > > > 			 					 ^^^
> > > > 
> > > > 2) converting C99 nested function into a closure
> > > > https://nullprogram.com/blog/2019/11/15/
> > > > 
> > > > 	void intsort2(int *base, size_t nmemb, _Bool invert)
> > > > 	{
> > > > 	    int cmp(const void *a, const void *b)
> > > > 	    {
> > > > 	        int r = *(int *)a - *(int *)b;
> > > > 	        return invert ? -r : r;
> > > > 	    }
> > > > 	    qsort(base, nmemb, sizeof(*base), cmp);
> > > > 	}
> > > > 
> > > > will silently require stack trampolines while non-closure version will not.
> > > > 
> > > > Without doubt this behaviour is documented somewhere, add a warning so that
> > > > developers and users can at least notice. After so many years of x86_64 having
> > > > proper executable stack support it should not cause too many problems.
> > > 
> > > hm, OK, let's give it a trial run.
> > > 
> > > > --- a/fs/exec.c
> > > > +++ b/fs/exec.c
> > > > @@ -761,6 +761,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
> > > >  		goto out_unlock;
> > > >  	BUG_ON(prev != vma);
> > > >  
> > > > +	if (unlikely(vm_flags & VM_EXEC)) {
> > > > +		pr_warn_once("process '%pD4' started with executable stack\n",
> > > > +			     bprm->file);
> > > > +	}
> > > > +
> > > >  	/* Move stack pages down in memory. */
> > > >  	if (stack_shift) {
> > > >  		ret = shift_arg_pages(vma, stack_shift);
> > > 
> > > What are poor users supposed to do if this message comes out? 
> > > Hopefully google the message and end up at this thread.  What do you
> > > want to tell them?
> > 
> > Me? Nothing :-) They hopefully should file tickets against distros and ISV,
> > post egregious examples to oss-security.
> > 
> > Like they already do against this warning!
> > > ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> 
> Alexey, Andrew is right. Your message gives no instruction and users are
> already flooded with messages they got used to ignore. A warning is made
> to catch attention so it should give instructions. It can either say
> "this application relies on insecure capabilities and might not work
> anymore in the future, you should report this to its author",

"Insecure" is an accusation and baseless until source code is seen.
This program is secure despite having executable stack.

	.globl _start
	_start:
		mov	eax, 60
		xor	edi, edi
		syscall

"Might not work" is false, because PT_GNU_STACK is not going anywhere and
the default is not flipped and applications with executable stack aren't
going to become rejected. This patch is not about starting deprecation
executable stacks programme.

Ideally distros which don't have post build check implement one after
seeing few reports and someone reports few cases to ISV who aren't
clueless as well.

> or "report
> this to kernel developers if you think this warning is inappropriate".

Reports are better be done by people who know what they are doing, as in
understand what executable stack is and what does it mean in reality.

> Otherwise it will just go to /dev/null with all warning about bad blocks
> on USB sticks and CPU core throttling under high temperature.

That's fine. You don't want bugreports from people who don't know what
is executable stack. Every security bug bounty program is flooded by
such people. This is why message is worded in a neutral way.
