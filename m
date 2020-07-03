Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1208213AEB
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 15:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGCNZe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 09:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCNZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jul 2020 09:25:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF4C08C5C1;
        Fri,  3 Jul 2020 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mTUdInrl0UZ5/CAUTtR8K6FDHzAHWr9fq3pJX4MJ7Gs=; b=zDmqGVF3FOX7aSDK4H8sAB/UGf
        KrxUneT0wbec5AHPOWFWgsQ58J7O+x9kLSh6PJJns7NSEVQU5N9HLWo16vbkLGQakk7aa0dWh7QcL
        grhzH9Vhd13yLmAKDlzxBAGgMJUMhc2N63hyENk4ip1OBwF3lMnThKgxhGjHOf93UVGDhIJabxxdh
        PUNVs3yxqSKjZQoFoCbxqN8YldUcpszlAWVdmsX979wqXUgCBvBmOoPH/nHcee/NLh6hdRgtBFf9u
        OxuXx54Xhpa+MCreoZf20laWaE2S6iSRhTAi9+Q78S4yOV4Vk9Mo0GC1/n+tL0uvPfxff2DnoUFjs
        DrqF4xAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrLgy-0002iy-Rt; Fri, 03 Jul 2020 13:25:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 718DD301124;
        Fri,  3 Jul 2020 15:25:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F59B20A9E7A6; Fri,  3 Jul 2020 15:25:23 +0200 (CEST)
Date:   Fri, 3 Jul 2020 15:25:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200703132523.GM117543@hirez.programming.kicks-ass.net>
References: <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703131330.GX4800@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 03, 2020 at 03:13:30PM +0200, Peter Zijlstra wrote:
> > The prototype for GCC is here: https://github.com/AKG001/gcc/
> 
> Thanks! Those test cases are somewhat over qualified though:
> 
>        static volatile _Atomic (TYPE) * _Dependent_ptr a;     		\

One question though; since its a qualifier, and we've recently spend a
whole lot of effort to strip qualifiers in say READ_ONCE(), how does,
and how do we want, this qualifier to behave.

C++ has very convenient means of manipulating qualifiers, so it's not
much of a problem there, but for C it is, as we've found, really quite
cumbersome. Even with _Generic() we can't manipulate individual
qualifiers afaict.
