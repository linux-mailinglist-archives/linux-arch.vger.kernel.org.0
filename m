Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7662510EFCD
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2019 20:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfLBTHW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Dec 2019 14:07:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39999 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfLBTHW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Dec 2019 14:07:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id a137so655570qkc.7;
        Mon, 02 Dec 2019 11:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7ISo08j0woPGIeQrxmAiB+QIg6bs6djut0LfpSDf04=;
        b=cKsMsIhQgKiiPEwxCObsVjWuQO/CF5L0v54SkJmNox7nauCBqgIqhiwYWoBj0zGh5D
         mmQBm+I6TYJAzAULj+jeukFlPnaoFILP5plS7Z/akBZlLX8Ja5ZtWw9MlTf5XLlAaVrt
         L8AWfcGtgFU1/1Q2G8lphU2IkJbL0+2LKePeUrvIlnVXQWLpDwGL/idOSO4ObMc39ijE
         Ea81P9N6OcwsWi+L9hQVEdZjlLRrV3ObRanmRswBiId/ixIrNNjGMt9YZ7jyPB6KitmY
         uWepid7isbXTWCVMuFUixktUaMBNjJsT36o6+C8Q0vrZ5Ra9Efb2RZDyvw3rNv9dIxpU
         vSKQ==
X-Gm-Message-State: APjAAAXjhkxhAm8QgRNDO9pELx2qdanyc8QCYcaXJ8Dkmyman21JjTDH
        w6taKrih4eEDI9T0UNh4J2c=
X-Google-Smtp-Source: APXvYqzoOtrVbRoTfSKHHVRxjDKIVWvY+rV01LuQk3IlHmigMqeKeJw1aBzCBZJcWaaAbb3eNrgC9w==
X-Received: by 2002:a37:6c6:: with SMTP id 189mr367618qkg.179.1575313641203;
        Mon, 02 Dec 2019 11:07:21 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::3:2086])
        by smtp.gmail.com with ESMTPSA id x68sm273045qkc.22.2019.12.02.11.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 11:07:20 -0800 (PST)
Date:   Mon, 2 Dec 2019 14:07:18 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20191202190718.GA18019@dennisz-mbp>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130000037.zsendu5pk7p75xqf@ltop.local>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 30, 2019 at 01:00:37AM +0100, Luc Van Oostenryck wrote:
> On Fri, Nov 29, 2019 at 06:11:59PM +0000, Christopher Lameter wrote:
> > On Wed, 27 Nov 2019, Luc Van Oostenryck wrote:
> > 
> > > 1) it would strip any address space, not just __percpu, so:
> > >    it would need to be combined with __verify_pcpu_ptr() or,
> > >    * a better name should be used,
> > 
> > typeof_cast_kernel() to express the fact that it creates a kernel pointer
> > and ignored the attributes??
> 
> typeof_strip_address_space() would, I think, express this better. 
> It's not obvious at all to me that 'kernel' in 'typeof_cast_kernel()'
> relates to the (default) kernel address space.
> Maybe it's just me. I don't know.
> 

I think typeof_cast_kernel() or typeof_force_kernel() are reasonable
names. I kind of like the idea of cast/force over strip because we're
really still moving address spaces even if it is moving it back.

> > >    * it should be defined in a generic header, any idea where?
> > 
> > include/linux/compiler-types.h
> 
> Yes, OK.
> 
> > > 2) while I find the current solution:
> > > 	typeof(T) __kernel __force *ptr = ...;
> > 
> > It would be
> > 
> >    typeof_cast_kernel(&T) *xx = xxx
> > 
> > or so?
> 
> No, it would not. __percpu, and more generally, the address space
> is a property of the object, not of its address.

Maybe for other address spaces that's true, but for percpu, __percpu is
a property of the address. An object can be referenced both from a
percpu address (via accessors) and the kernel address which is the
actual object.

> For example, let's say T is a __percpu object:
> 	int __percpu obj;

This can't exist. __percpu denotes address space not object.

> then '&T' is just a 'normal'/__kernel pointer to it:
> 	int __percpu *;
> There is nothing to strip (it would be if the __percpu
> would be 'on the other side of the *': int * __percpu).
> It's exactly the same as with 'const': a 'const char *'
> is not const, only a pointer to const.
> 
> The situation with raw_cpu_generic_add_return() is:
> - pcp is a lvalue of of a __percpu object of type T, so:
> 	typeof(pcp)  := T __percpu
> - pcp's address is given to raw_cpu_ptr(), so
> 	typeof(&pcp) := T __percpu *
> - raw_cpu_ptr() return the corresponding __kernel pointer
>   (adjusted for the current percu offset), so:
> 	typeof(raw_cpu_ptr(&pcp)) := T *
> - so, the macro needs to declare a variable __p of type T*
>   hence:
> 	typeof(pcp) __kernel __force *__p;
>   or, with this new macro:
> 	typeof_cast_kernel(pcp) *__p;
> 
> Maybe a better solution would be to directly play at pointer
> level and thus have something like this:
> 	typeof_<some good name>(&pcp) __p = raw_cpu_ptr(&pcp);
> or even:
> 	__kernel_pointer(&pcp) __p = raw_cpu_ptr(&pcp);
> I dunno.
> 
> Note: at implementation level, it complicates things slightly
>       to want this 'strip_percpu' macro to behaves like typeof()
>       because it means that it can take in argument either an
>       expression or a type. And if it's a type, you can't do a
>       simple cast on it, you need to declare an intermediate
>       variable, hence the horrible:
> 	  typeof(({ typeof(T) __kernel __force __fakename; __fakename; }))
> 
> Note: it would be much much nicer to do all these type generic
>       macros with '__auto_type' (only supported in GCC 4.9 IIUC
>       and supported in sparse but it shouldn't be very hard to do)..
> 
> 
> -- Luc

Thanks for debugging this. I'm still inclined to have a macro for either
cast/force. I do agree it could be misused, but it's no different doing
it in a macro than by just adding __force __kernel.

Thanks,
Dennis
