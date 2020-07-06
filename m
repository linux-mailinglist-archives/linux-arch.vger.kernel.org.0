Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047F1215E50
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgGFS3p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbgGFS3p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 14:29:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38180C061755;
        Mon,  6 Jul 2020 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Do5ubF9fSscGPClrokRq/R+dJR1UND+xOUqU52LNcLY=; b=qbfi+0eUNgOUvrS/172K4oJy+c
        +6cvYoTiN6i7rxY2lKCxArxd7eY83amayJ59D8O1py/4d9s6P4RqhHn1YxV7zVXeTetbIlRbo28Ie
        gCd9otH5ECaPEhZ8Ge/IBJo3+RpoisW5Ms4DZ89U+kQmjoKqC/4gOLn1rpAjmh910g68gBREeN853
        D9OutRrJ3YidRcvHov/mXEAHK/teWgqK5dRcbklwPj7Zu+LAUPsEALJWfBtbZMLbt9OhdAf3SVyqB
        t12O6B1a3TCkvPr8cZa7kIvTauI0iVcGCIWrMpjaav/KQZRjPDPGe/rm2UlYyWtRnwA22XnbRhDgo
        CON822NQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsVrx-0007O5-Sd; Mon, 06 Jul 2020 18:29:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13EBC3013E5;
        Mon,  6 Jul 2020 20:29:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06776213912F6; Mon,  6 Jul 2020 20:29:26 +0200 (CEST)
Date:   Mon, 6 Jul 2020 20:29:26 +0200
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
Message-ID: <20200706182926.GH4800@hirez.programming.kicks-ass.net>
References: <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
 <20200703144228.GF9247@paulmck-ThinkPad-P72>
 <20200706162633.GA13288@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706162633.GA13288@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 06, 2020 at 09:26:33AM -0700, Paul E. McKenney wrote:

> And perhaps more constructively, we do need to prioritize address and data
> dependencies over control dependencies.  For one thing, there are a lot
> more address/data dependencies in existing code than there are control
> dependencies, and (sadly, perhaps more importantly) there are a lot more
> people who are convinced that address/data dependencies are important.

If they do not consider their Linux OS running correctly :-)

> For another (admittedly more theoretical) thing, the OOTA scenarios
> stemming from control dependencies are a lot less annoying than those
> from address/data dependencies.
> 
> And address/data dependencies are as far as I know vulnerable to things
> like conditional-move instructions that can cause problems for control
> dependencies.
> 
> Nevertheless, yes, control dependencies also need attention.

Today I added one more \o/
