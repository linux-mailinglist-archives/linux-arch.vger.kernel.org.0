Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8005288DB8
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389409AbgJIQGO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:06:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32528C0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:06:14 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQuuC-002MvD-Cf; Fri, 09 Oct 2020 18:06:04 +0200
Message-ID: <945d17982b92801dc4a8d61d9fed91e0e60b0105.camel@sipsolutions.net>
Subject: Re: [RFC v7 08/21] um: add nommu mode for UML library mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Date:   Fri, 09 Oct 2020 18:06:03 +0200
In-Reply-To: <m2r1q83w6x.wl-thehajime@gmail.com> (sfid-20201009_053855_635026_E66EA959)
References: <cover.1601960644.git.thehajime@gmail.com>
         <ac5a99db869705b284307dea21b37068ee5ae7d2.1601960644.git.thehajime@gmail.com>
         <a7d49bb4cecb14559faaedf7e875d86f2cd81d8b.camel@sipsolutions.net>
         <m2r1q83w6x.wl-thehajime@gmail.com> (sfid-20201009_053855_635026_E66EA959)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-10-09 at 12:38 +0900, Hajime Tazaki wrote:
> 
> > > +++ b/arch/um/nommu/Makefile.um
> > 
> > [...]
> > 
> > > +ifeq ($(shell uname -s), Linux)
> > > +NPROC=$(shell nproc)
> > > +else # e.g., FreeBSD
> > > +NPROC=$(shell sysctl -n hw.ncpu)
> > > +endif
> > 
> > That seems very inappropriate here.
> 
> Will cut the FreeBSD part.

But even the NPROC and -j flag mangling seems ... awful?

> > > --- /dev/null
> > > +++ b/arch/um/nommu/include/asm/atomic64.h
> > 
> > That doesn't make sense to me, you can control CONFIG_GENERIC_ATOMIC64
> > to be on, and don't need the ifdef and this file?
> 
> We were suggested to not use GENERIC_ATOMIC64 on 64bit build during
> our v3 patchset.  So we actually control CONFIG_GENERIC_ATOMIC64 to be
> on only when !64BIT, and thus need atomic64.h for the 64BIT build.
> 
> https://lwn.net/ml/linux-arch/20200205093454.GG14879@hirez.programming.kicks-ass.net/

Well, yeah, but your architecture _is_ a piece of crap in needing
atomic64 emulation? :-)

How about just using the real atomic64 implementation like UML normally
does? I mean, falling back to the actual underlying CPU. Or even gcc
intrinsics?

You've basically re-implemented CONFIG_GENERIC_ATOMIC64, so perhaps
you've hidden it from PeterZ's view now because you're no longer
touching the real generic atomic64 (which is for 32-bit machines), but
that doesn't actually make this any *better*. Arguably *worse* since
you've just copied it ...

> > > +++ b/arch/um/nommu/um/delay.c
> > 
> > why the double um/ path?
> 
> This is because now in arch/um/Makefile,
> 
>  - SUBARCH := um/nommu
>  - HEADER_ARCH := $(SUBARCH)
>  - HOST_DIR := arch/$(HEADER_ARCH)
>  - core-y += $(HOST_DIR)/um
> 
> the last line expands as arch/um/nommu/um.

But is there a reason for it? Couldn't it be changed?

Anyway, we're still debating the whole build system and layout so not
much point in going into the details now ...

johannes

