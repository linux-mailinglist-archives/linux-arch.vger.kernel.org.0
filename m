Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1630A324174
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 17:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhBXP43 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 10:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbhBXPpD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 10:45:03 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38697C06178C;
        Wed, 24 Feb 2021 07:44:19 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id b3so1694415qtj.10;
        Wed, 24 Feb 2021 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fItWJT45gxeZmehLDl9MQvbAFXnDt+Npfk0rq2z6/Gs=;
        b=AG7c4wQ5+wpzdAg0XrcwfkbS1trFVNCcx/cuRADHgkh88LjGDRnVEZTnQ4WyWdElom
         Yy5ES4Lk1b+WioJwvV/FJt8pj5AKwQ6DkU6+E/iV8A29YKsstXc4Hc8B9fpbb6u33rgK
         omtU/He9/MtbCCro2MnDNsD20TYRkm56q61jDi/b8xt/3tksrF/7CjfYbYKRRhFDf9Vz
         PCAThKb1FyowOxBb9FH4ysw61gJzBPY02hp5NhdWwnpKQlpdRhs1ziJpk5w781uEx2xO
         KwKMZL7WfSMDhohoZ3QgmzvKq0SCEd7irv4ZMicPt46xupc+FsIHnxpPfOTgDeh9HjXG
         DyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fItWJT45gxeZmehLDl9MQvbAFXnDt+Npfk0rq2z6/Gs=;
        b=KWvC22QidUWIgZ4VUR6Wuj4EbBIwFKrDhhnVvFbTzZs5D/fe0GoTEWJlsju2D7MWeE
         74kH+MK6oSnUu+XZiWZMhi7S0Xhvou+UDqrHfr6IWoEWFK9lo3BZBG1a6uLgggf6oNhz
         UuidwKsv6wYfOTtohdgM86pJ4TgCayFqOcO920pCe4Yjy+oFLWRbf8NqK4Ip/jg6FBsP
         WvWNLKldI3Mzk3WBlAnqHrV1J1wcRa4M46oUGUffU6MqpGFPHK7YBMfMA+Wz3dEueOwD
         1bvEjyC5vMaqNINzFZFdLscSa8N07YiO40bgH9H/TZGt+g98YwYutkojvyc/93fMi1HC
         3Uew==
X-Gm-Message-State: AOAM530PkxauFaeW6EDAmG/Mbr/RyO7rHv5XJ06tsaKsexryKy1aFdVL
        UfL0OgyOHv9/xlloZ9mYU7I=
X-Google-Smtp-Source: ABdhPJyTZqxs22JUW66YxOkmHqfYrrrtccArQCKwcAP8XHLmFOZeWT8qUOmGIAtgw4W5RG4wKYCXRg==
X-Received: by 2002:ac8:7383:: with SMTP id t3mr29164779qtp.242.1614181458203;
        Wed, 24 Feb 2021 07:44:18 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id 16sm1461749qtp.38.2021.02.24.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 07:44:17 -0800 (PST)
Date:   Wed, 24 Feb 2021 07:44:16 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH] arm64: enable  GENERIC_FIND_FIRST_BIT
Message-ID: <20210224154416.GA1181413@yury-ThinkPad>
References: <20201205165406.108990-1-yury.norov@gmail.com>
 <20210224115247.1618-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224115247.1618-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 24, 2021 at 11:52:55AM +0000, Alexander Lobakin wrote:
> From: Yury Norov <yury.norov@gmail.com>
> Date: Sat, 5 Dec 2020 08:54:06 -0800
> 
> Hi,
> 
> > ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
> > enable it in config. It leads to using find_next_bit() which is less
> > efficient:
> >
> > 0000000000000000 <find_first_bit>:
> >    0:	aa0003e4 	mov	x4, x0
> >    4:	aa0103e0 	mov	x0, x1
> >    8:	b4000181 	cbz	x1, 38 <find_first_bit+0x38>
> >    c:	f9400083 	ldr	x3, [x4]
> >   10:	d2800802 	mov	x2, #0x40                  	// #64
> >   14:	91002084 	add	x4, x4, #0x8
> >   18:	b40000c3 	cbz	x3, 30 <find_first_bit+0x30>
> >   1c:	14000008 	b	3c <find_first_bit+0x3c>
> >   20:	f8408483 	ldr	x3, [x4], #8
> >   24:	91010045 	add	x5, x2, #0x40
> >   28:	b50000c3 	cbnz	x3, 40 <find_first_bit+0x40>
> >   2c:	aa0503e2 	mov	x2, x5
> >   30:	eb02001f 	cmp	x0, x2
> >   34:	54ffff68 	b.hi	20 <find_first_bit+0x20>  // b.pmore
> >   38:	d65f03c0 	ret
> >   3c:	d2800002 	mov	x2, #0x0                   	// #0
> >   40:	dac00063 	rbit	x3, x3
> >   44:	dac01063 	clz	x3, x3
> >   48:	8b020062 	add	x2, x3, x2
> >   4c:	eb02001f 	cmp	x0, x2
> >   50:	9a829000 	csel	x0, x0, x2, ls  // ls = plast
> >   54:	d65f03c0 	ret
> >
> >   ...
> >
> > 0000000000000118 <_find_next_bit.constprop.1>:
> >  118:	eb02007f 	cmp	x3, x2
> >  11c:	540002e2 	b.cs	178 <_find_next_bit.constprop.1+0x60>  // b.hs, b.nlast
> >  120:	d346fc66 	lsr	x6, x3, #6
> >  124:	f8667805 	ldr	x5, [x0, x6, lsl #3]
> >  128:	b4000061 	cbz	x1, 134 <_find_next_bit.constprop.1+0x1c>
> >  12c:	f8667826 	ldr	x6, [x1, x6, lsl #3]
> >  130:	8a0600a5 	and	x5, x5, x6
> >  134:	ca0400a6 	eor	x6, x5, x4
> >  138:	92800005 	mov	x5, #0xffffffffffffffff    	// #-1
> >  13c:	9ac320a5 	lsl	x5, x5, x3
> >  140:	927ae463 	and	x3, x3, #0xffffffffffffffc0
> >  144:	ea0600a5 	ands	x5, x5, x6
> >  148:	54000120 	b.eq	16c <_find_next_bit.constprop.1+0x54>  // b.none
> >  14c:	1400000e 	b	184 <_find_next_bit.constprop.1+0x6c>
> >  150:	d346fc66 	lsr	x6, x3, #6
> >  154:	f8667805 	ldr	x5, [x0, x6, lsl #3]
> >  158:	b4000061 	cbz	x1, 164 <_find_next_bit.constprop.1+0x4c>
> >  15c:	f8667826 	ldr	x6, [x1, x6, lsl #3]
> >  160:	8a0600a5 	and	x5, x5, x6
> >  164:	eb05009f 	cmp	x4, x5
> >  168:	540000c1 	b.ne	180 <_find_next_bit.constprop.1+0x68>  // b.any
> >  16c:	91010063 	add	x3, x3, #0x40
> >  170:	eb03005f 	cmp	x2, x3
> >  174:	54fffee8 	b.hi	150 <_find_next_bit.constprop.1+0x38>  // b.pmore
> >  178:	aa0203e0 	mov	x0, x2
> >  17c:	d65f03c0 	ret
> >  180:	ca050085 	eor	x5, x4, x5
> >  184:	dac000a5 	rbit	x5, x5
> >  188:	dac010a5 	clz	x5, x5
> >  18c:	8b0300a3 	add	x3, x5, x3
> >  190:	eb03005f 	cmp	x2, x3
> >  194:	9a839042 	csel	x2, x2, x3, ls  // ls = plast
> >  198:	aa0203e0 	mov	x0, x2
> >  19c:	d65f03c0 	ret
> >
> >  ...
> >
> > 0000000000000238 <find_next_bit>:
> >  238:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
> >  23c:	aa0203e3 	mov	x3, x2
> >  240:	d2800004 	mov	x4, #0x0                   	// #0
> >  244:	aa0103e2 	mov	x2, x1
> >  248:	910003fd 	mov	x29, sp
> >  24c:	d2800001 	mov	x1, #0x0                   	// #0
> >  250:	97ffffb2 	bl	118 <_find_next_bit.constprop.1>
> >  254:	a8c17bfd 	ldp	x29, x30, [sp], #16
> >  258:	d65f03c0 	ret
> >
> > Enabling this functions would also benefit for_each_{set,clear}_bit().
> > Would it make sense to enable this config for all such architectures by
> > default?
> 
> I confirm that GENERIC_FIND_FIRST_BIT also produces more optimized and
> fast code on MIPS (32 R2) where there is also no architecture-specific
> bitsearching routines.
> So, if it's okay for other folks, I'd suggest to go for it and enable
> for all similar arches.
 
As far as I understand the idea of GENERIC_FIND_FIRST_BIT=n, it's
intended to save some space in .text. But in fact it bloats the
kernel:

        yury:linux$ scripts/bloat-o-meter vmlinux vmlinux.ffb
        add/remove: 4/1 grow/shrink: 19/251 up/down: 564/-1692 (-1128)
        ...

For the next cycle, I'm going to submit a patch that removes the 
GENERIC_FIND_FIRST_BIT completely and forces all architectures to
use find_first{_zero}_bit() 

> (otherwise, I'll publish a separate entry for mips-next after 5.12-rc1
>  release and mention you in "Suggested-by:")

I think it worth to enable GENERIC_FIND_FIRST_BIT for mips and arm now
and see how it works for people. If there'll be no complains I'll remove
the config entirely. I'm OK if you submit the patch for mips now, or we
can make a series and submit together. Works either way.
