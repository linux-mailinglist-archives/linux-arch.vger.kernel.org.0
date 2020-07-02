Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A6212BD0
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgGBSAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 14:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgGBSAn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 14:00:43 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832662073E;
        Thu,  2 Jul 2020 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593712842;
        bh=Hak91qzk3x/aeXBK1n/XMiTpR5KSRvENrzPRsP83yxM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QWmK8WMRCdHSwyVK000d5y6dbgLM+MjgvdkwYsTsrjr5LZBrjrxYWW1nMi6rZxccV
         IiaPyrs2F2bjvlZIb4WjffkjC0aKcE/DRPRkmEy2Vz5+fS5gilxXEQzxwjlFv3ETvE
         BcELqK8pbmTnqz6ggKuzaDwzCOlpTPOwyp2kT1xI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6CE89352334B; Thu,  2 Jul 2020 11:00:42 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:00:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Peter Zijlstra' <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200702180042.GW9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <20200701091054.GW4781@hirez.programming.kicks-ass.net>
 <4427b0f825324da4b1640e32265b04bd@AcuMS.aculab.com>
 <20200701160624.GO9247@paulmck-ThinkPad-P72>
 <aeed740a4d86470d84ae7d5f1cf07951@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeed740a4d86470d84ae7d5f1cf07951@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 02, 2020 at 09:37:26AM +0000, David Laight wrote:
> From: Paul E. McKenney
> > Sent: 01 July 2020 17:06
> ...
> > > Would an asm statement that uses the same 'register' for input and
> > > output but doesn't actually do anything help?
> > > It won't generate any code, but the compiler ought to assume that
> > > it might change the value - so can't do optimisations that track
> > > the value across the call.
> > 
> > It might replace the volatile load, but there are optimizations that
> > apply to the downstream code as well.
> > 
> > Or are you suggesting periodically pushing the dependent variable
> > through this asm?  That might work, but it would be easier and
> > more maintainable to just mark the variable.
> 
> Marking the variable requires compiler support.
> Although what 'volatile register int foo;' means might be interesting.
> 
> So I was thinking that in the case mentioned earlier you do:
> 	ptr += LAUNDER(offset & 1);
> to ensure the compiler didn't convert to:
> 	if (offset & 1) ptr++;
> (Which is probably a pessimisation - the reverse is likely better.)

Indeed, Akshat's prototype follows the "volatile" qualifier in many
ways.  https://github.com/AKG001/gcc/

							Thanx, Paul
