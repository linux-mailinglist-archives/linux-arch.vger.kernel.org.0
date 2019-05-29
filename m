Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA012E8A1
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfE2XA0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 19:00:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34143 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2XA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 19:00:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id c14so194812pfi.1
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mZDm1kAKgU0IhEGbB++jzmktRAbr4Q0cIPFXqDEyagM=;
        b=A+UGu35rAnrltsa65R7VI1+bvaLfoGq5ejnoxdsD3zYpAcgF2pfHPSObDmbmOWfteh
         41QdlFgg7R3pRwbx2xtJi0B+k27nu/g2/BqQStCoemBh8HKxCuPZeiL7cQd1W0Ryxtgy
         knRcGmMBGQdYM2+CUA5H6fwPt7UoApSYMspWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZDm1kAKgU0IhEGbB++jzmktRAbr4Q0cIPFXqDEyagM=;
        b=fr/zxSMIbAINHId0bAgpmjgFIcU4uslD2k6peCWHX4olUXhghKTAY2VmS6oB6/z1gJ
         2RGyxPKerOLHQ0KrEnnvSVyUl2W14g9uFhMNjudbnfs45crtX2HLjbMrWX8A5wqNM9I/
         mjyPmJydVyA52Jxi7HxhLRIeYbYvis6ICM+9imtI1EfxcckqRzsuR2R9OppraCzwyu5n
         0MmSHQ/wTLwLnldzbf7JRdyTKAOwSk3v3/HKVWSTmgOZWODEhoM8K2278D8N7Hivg4P1
         JL4VWPQf+lSaxJTuLYHt5UBhosCH+alLEJMG/efX1Rcbz5OenqjlY4ZH/0g1gx2sm3/8
         KlZg==
X-Gm-Message-State: APjAAAVm89nwTb7JBgNXMPTDC4XncSFeJr5TAnMtwaRdsgqIUFOOHF+Q
        DraLYTJPwH0kwvyOoITJ7X+nXw==
X-Google-Smtp-Source: APXvYqxBsGzFdEFFHE9ZZiZzg2iQiXe5Qj3DcWZv7aDHSpfnAhwMXj2Rx0f/hyPuR7+Z9T3sjOH5Pg==
X-Received: by 2002:a62:2b82:: with SMTP id r124mr102112pfr.235.1559170825907;
        Wed, 29 May 2019 16:00:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm769994pfo.8.2019.05.29.16.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 16:00:25 -0700 (PDT)
Date:   Wed, 29 May 2019 16:00:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] elf: align AT_RANDOM bytes
Message-ID: <201905291559.87E96F79@keescook>
References: <20190529213708.GA10729@avx2>
 <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 29, 2019 at 03:20:20PM -0700, Andrew Morton wrote:
> On Thu, 30 May 2019 00:37:08 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > AT_RANDOM content is always misaligned on x86_64:
> > 
> > 	$ LD_SHOW_AUXV=1 /bin/true | grep AT_RANDOM
> > 	AT_RANDOM:       0x7fff02101019
> > 
> > glibc copies first few bytes for stack protector stuff, aligned
> > access should be slightly faster.
> 
> I just don't understand the implications of this.  Is there
> (badly-behaved) userspace out there which makes assumptions about the
> current alignment?
> 
> How much faster, anyway?  How frequently is the AT_RANDOM record
> accessed?
> 
> I often have questions such as these about your performance/space
> tweaks :(.  Please try to address them as a matter of course when
> preparing changelogs?
> 
> And let's Cc Kees, who wrote the thing.
> 
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -144,11 +144,15 @@ static int padzero(unsigned long elf_bss)
> >  #define STACK_ALLOC(sp, len) ({ \
> >  	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
> >  	old_sp; })
> > +#define STACK_ALIGN(sp, align)	\
> > +	((typeof(sp))(((unsigned long)sp + (int)align - 1) & ~((int)align - 1)))
> 
> I suspect plain old ALIGN() could be used here.
> 
> >  #else
> >  #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
> >  #define STACK_ROUND(sp, items) \
> >  	(((unsigned long) (sp - items)) &~ 15UL)
> >  #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
> > +#define STACK_ALIGN(sp, align)	\
> > +	((typeof(sp))((unsigned long)sp & ~((int)align - 1)))
> 
> And maybe there's a helper which does this, dunno.
> 
> >  #endif
> >  
> >  #ifndef ELF_BASE_PLATFORM
> > @@ -217,6 +221,12 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
> >  			return -EFAULT;
> >  	}
> >  
> > +	/*
> > +	 * glibc copies first bytes for stack protector purposes
> > +	 * which are misaligned on x86_64 because strlen("x86_64") + 1 == 7.
> > +	 */
> > +	p = STACK_ALIGN(p, sizeof(long));
> > +

I have no objection to eating some bytes here. Though perhaps things could just
be reordered to leave all the aligned things together and put all the
strings later?

-Kees

> >  	/*
> >  	 * Generate 16 random bytes for userspace PRNG seeding.
> >  	 */
> 

-- 
Kees Cook
