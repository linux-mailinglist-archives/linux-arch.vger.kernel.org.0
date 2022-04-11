Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642FC4FB97B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbiDKK0x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 06:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbiDKK0a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 06:26:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12E7143AC6;
        Mon, 11 Apr 2022 03:22:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDBF7169C;
        Mon, 11 Apr 2022 03:22:57 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407723F5A1;
        Mon, 11 Apr 2022 03:22:55 -0700 (PDT)
Date:   Mon, 11 Apr 2022 11:22:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, gcc@gcc.gnu.org,
        catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, szabolcs.nagy@arm.com, f.fainelli@gmail.com,
        opendmb@gmail.com, Andrew Pinski <pinskia@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        andrew.cooper3@citrix.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: GCC 12 miscompilation of volatile asm (was: Re: [PATCH]
 arm64/io: Remind compiler that there is a memory side effect)
Message-ID: <YlQBe5KbKogNU4vt@FVFF77S0Q05N>
References: <20220401164406.61583-1-jeremy.linton@arm.com>
 <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
 <Ykw7UnlTnx63z/Ca@FVFF77S0Q05N>
 <YkxMov3qpHxFa/n3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkxMov3qpHxFa/n3@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 05, 2022 at 04:05:22PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 05, 2022 at 01:51:30PM +0100, Mark Rutland wrote:
> > Hi all,
> > 
> > [adding kernel folk who work on asm stuff]
> > 
> > As a heads-up, GCC 12 (not yet released) appears to erroneously optimize away
> > calls to functions with volatile asm. Szabolcs has raised an issue on the GCC
> > bugzilla:  
> > 
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105160
> > 
> > ... which is a P1 release blocker, and is currently being investigated.
> > 
> > Jemery originally reported this as an issue with {readl,writel}_relaxed(), but
> > the underlying problem doesn't have anything to do with those specifically.
> > 
> > I'm dumping a bunch of info here largely for posterity / archival, and to find
> > out who (from the kernel side) is willing and able to test proposed compiler
> > fixes, once those are available.
> > 
> > I'm happy to do so for aarch64; Peter, I assume you'd be happy to look at the
> > x86 side?
> 
> Sure..

FWIW, compiler explorer now have a trunk build with the fix, and my x86-64
example now gets compiled to something which looks correct:

  https://godbolt.org/z/cveff9hq5

Thanks,
Mark.
