Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02492100DCF
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2019 22:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKRVgJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Nov 2019 16:36:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37818 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVgJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2019 16:36:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so1005683wmj.2;
        Mon, 18 Nov 2019 13:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3U41JlNG7bmxOGHw7h3r5PhFdgBWCIWUMpCYBIyDX5g=;
        b=LLKAsm3rpD9z4ttlmsVYBZB0RM5zgfviHGTvw9h3rNevt9PO2W7pC69F55PWExC5or
         xKTpurUY/Pe9PN5ERR9oct08+jkVImbmiNwqn5edtTzEzKVMVK0Ee4rgbQ5gB7XQQDZp
         Bp7k58/kfQJxRA4F5Bgesg/0CWjUs3kcM3Tw4AGJ0az2GnW15QEhg4C1izybBN6yMwxV
         nBBndV3fuZdkD9dyaRTaNMMQkEGx0HmT7eSZdd9SpJyc7NzL0pa1ExLbC0pcCXFhSBE2
         IVwMB/NSYYQcjqDeyfmzKz5jIu9fL1mY63i0lfb8YPtVatTq9w9IJjpUnQFpH5+IPhRH
         F8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3U41JlNG7bmxOGHw7h3r5PhFdgBWCIWUMpCYBIyDX5g=;
        b=OGhz694dunIhuDIwOB9V+lWKQEGU7/1dzbzsKhduRdoodN1B8UzO3lGofhHGBteQd6
         F/85BJpjcKYNOFDK/T59kd4Rl/nvmvOeNlKLMx/idnCw2U8f3KNMauHQGqStsVozjK6X
         dR31i1fVfpXhMVPZUxgbB6W0uSTXTySqOpstBp6URU2QcPare+rojie9gDV1H3I7Ohq4
         0blCuwjblU0Biw95MLFxRn4qU8wvj/NWNCaoc5EZzPMbbypjPzBeaIKHFm+qdX4XiVdE
         5/lEIWMNc02714xTYrkKd30XdZ5RbZoPUOkgPM91hTsqb4fZ/MhRGWxs7Y4o/RlHh4rK
         dHhw==
X-Gm-Message-State: APjAAAV+LfVzEpnQbixQSzNBzKwFg+98p/wy2oJoMh/Wge9FgsqXQ+TJ
        4O8p/rv4Zn8GZTO5bl9TbVZB3Os=
X-Google-Smtp-Source: APXvYqz+FxnF8eL6HtNJrp/JKyCLY4TQWIkK5/lzGWRZ4PSKc9jviQu0xhTt4sFmJ9MoTHBXKHPENg==
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr1542479wme.103.1574112967007;
        Mon, 18 Nov 2019 13:36:07 -0800 (PST)
Received: from avx2 ([46.53.249.232])
        by smtp.gmail.com with ESMTPSA id u18sm25048020wrp.14.2019.11.18.13.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 13:36:06 -0800 (PST)
Date:   Tue, 19 Nov 2019 00:36:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org, ben.dooks@codethink.co.uk
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
Message-ID: <20191118213603.GA24086@avx2>
References: <20191118145114.GA9228@avx2>
 <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 18, 2019 at 12:54:57PM -0800, Andrew Morton wrote:
> On Mon, 18 Nov 2019 17:51:15 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > PT_GNU_STACK is fail open design,
> 
> Not sure what this means.  Please expand on the motivation for this
> change.
> 
> > at least warn people that something
> > isn't right.
> 
> People who use an executable stack get a kernel splat.  How is that
> useful?

There were two stories about silent downgrade to an executable stack:

1)
compiling .S file and linking it to normal code:

	$ cat f.S
	.intel_syntax noprefix
	.text
	.globl f
	f:
	        ret

will silently add PT_GNU_STACK segment with RWE permissions

2)
closures with nested functions will require executable stack
https://nullprogram.com/blog/2019/11/15/

> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
> >  		goto out_unlock;
> >  	BUG_ON(prev != vma);
> >  
> > +#ifdef CONFIG_MMU

This code is already under CONFIG_MMU. I'll resend.
