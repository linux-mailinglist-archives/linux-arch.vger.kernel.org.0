Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8415710DBE1
	for <lists+linux-arch@lfdr.de>; Sat, 30 Nov 2019 01:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK3AAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Nov 2019 19:00:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53126 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfK3AAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Nov 2019 19:00:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so661464wmc.2;
        Fri, 29 Nov 2019 16:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UHVrDc4hE+bdlqMttAIsSmzHC+8hrXCIgOJb3P4TvLg=;
        b=OrFT8zpE3v3GDudv1Fk+4KcLjatZs0qg4OT7XnUw4f7XTSAS8lf3fB4EwXwNvRd87M
         TNyOujOVySBZ6fGDh3kt/yfM1c6Ns7kyNuFwKXn3leFnkQbnSYDjVDHPkHW3Ws3z0z0U
         dZIMoadJtqb9YgrDuRxsq6ywjuQBeRCG+Q6RA9QuO+AWgIoy2f/MZvJv60xm8RopSHBC
         xL98JOdwfMLX6sxHW4qXzLS0F43JBtgTtYWgERCRHuTycvFlhPPu8/Mtf+Vb0FjjQTy8
         RursYHl7JSWKp48tfjmpb5huxFSrg9czRE/926dw2tpeS4Wbqjbut+D1LRpF8NY91jeR
         2QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UHVrDc4hE+bdlqMttAIsSmzHC+8hrXCIgOJb3P4TvLg=;
        b=sWHEABQUCKH5hQQfMWgUxDat4WJ+tNuFX57PC/ZIsTAT/dMGPG2ZBNdaKjIz71PA21
         oDmQmBTULa3ZTPTzLbDGD8/gr3XuBAgs9w4Hl1UHfFZ+Y38oeIvFvdb5wy6VBFjf++cF
         9ZOe2c/AzP61mFUzaBf9bFLH3vmORAZpGCy0hS9CHRmfmhOFsyeKamyBc2p61pskH1vQ
         qjVhhC9VtdrCplkWmFGI+lffNWpnCw81QzcXAVdFwyY6mR3ndebQIrYyvIq1qs4q5BmM
         g9yY/TDWUP17mu4cEijaKBuhzxPUot5XxNkbU7IY8I2WX93FBhgev26S//fUySSHo9JS
         vGyQ==
X-Gm-Message-State: APjAAAUSR9q0ECxIln2ARAmYTusBO9cNu/5Jxrn3/eLdH+PHezqYf5dz
        6ncoChA3SHu91w3Ii5ka7As=
X-Google-Smtp-Source: APXvYqz5KzQ+FZoAA4g+4din9ZXFVuMvaxxxUIEVPzdxknXGtDPaFdjeBr1kYaadZpvw3f2LjBUtiA==
X-Received: by 2002:a1c:9d8d:: with SMTP id g135mr13328699wme.114.1575072040868;
        Fri, 29 Nov 2019 16:00:40 -0800 (PST)
Received: from ltop.local ([2a02:a03f:404e:f500:cdc6:e155:f3db:f2f3])
        by smtp.gmail.com with ESMTPSA id n14sm2755045wmi.26.2019.11.29.16.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 16:00:39 -0800 (PST)
Date:   Sat, 30 Nov 2019 01:00:37 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20191130000037.zsendu5pk7p75xqf@ltop.local>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 29, 2019 at 06:11:59PM +0000, Christopher Lameter wrote:
> On Wed, 27 Nov 2019, Luc Van Oostenryck wrote:
> 
> > 1) it would strip any address space, not just __percpu, so:
> >    it would need to be combined with __verify_pcpu_ptr() or,
> >    * a better name should be used,
> 
> typeof_cast_kernel() to express the fact that it creates a kernel pointer
> and ignored the attributes??

typeof_strip_address_space() would, I think, express this better. 
It's not obvious at all to me that 'kernel' in 'typeof_cast_kernel()'
relates to the (default) kernel address space.
Maybe it's just me. I don't know.

> >    * it should be defined in a generic header, any idea where?
> 
> include/linux/compiler-types.h

Yes, OK.

> > 2) while I find the current solution:
> > 	typeof(T) __kernel __force *ptr = ...;
> 
> It would be
> 
>    typeof_cast_kernel(&T) *xx = xxx
> 
> or so?

No, it would not. __percpu, and more generally, the address space
is a property of the object, not of its address.
For example, let's say T is a __percpu object:
	int __percpu obj;
then '&T' is just a 'normal'/__kernel pointer to it:
	int __percpu *;
There is nothing to strip (it would be if the __percpu
would be 'on the other side of the *': int * __percpu).
It's exactly the same as with 'const': a 'const char *'
is not const, only a pointer to const.

The situation with raw_cpu_generic_add_return() is:
- pcp is a lvalue of of a __percpu object of type T, so:
	typeof(pcp)  := T __percpu
- pcp's address is given to raw_cpu_ptr(), so
	typeof(&pcp) := T __percpu *
- raw_cpu_ptr() return the corresponding __kernel pointer
  (adjusted for the current percu offset), so:
	typeof(raw_cpu_ptr(&pcp)) := T *
- so, the macro needs to declare a variable __p of type T*
  hence:
	typeof(pcp) __kernel __force *__p;
  or, with this new macro:
	typeof_cast_kernel(pcp) *__p;

Maybe a better solution would be to directly play at pointer
level and thus have something like this:
	typeof_<some good name>(&pcp) __p = raw_cpu_ptr(&pcp);
or even:
	__kernel_pointer(&pcp) __p = raw_cpu_ptr(&pcp);
I dunno.

Note: at implementation level, it complicates things slightly
      to want this 'strip_percpu' macro to behaves like typeof()
      because it means that it can take in argument either an
      expression or a type. And if it's a type, you can't do a
      simple cast on it, you need to declare an intermediate
      variable, hence the horrible:
	  typeof(({ typeof(T) __kernel __force __fakename; __fakename; }))

Note: it would be much much nicer to do all these type generic
      macros with '__auto_type' (only supported in GCC 4.9 IIUC
      and supported in sparse but it shouldn't be very hard to do)..


-- Luc
