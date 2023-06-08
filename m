Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF93728450
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjFHPz3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 11:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjFHPz3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 11:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC130CB;
        Thu,  8 Jun 2023 08:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D07BE61864;
        Thu,  8 Jun 2023 15:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD303C433D2;
        Thu,  8 Jun 2023 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239668;
        bh=KC7pc+HuJtxytfEHmhScpNkrZ2PvzCFEU9GQjwsjh4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzlpPucPWYseRIzEorhY5F+Z/bOM2tAu0VrZDhuaaEN844jSZzBC0WfXOaOL0vcnc
         ZLTqPPVB1W8FV3jkuR+N1aFdpO2CSSdm5npKThdGnWd5OgMoeTxbSj48B4j5AN7P+f
         Bww0hEZvrPMNKh0OTg+wXrMN5V/cfaH9nHs9Ya6jN2DHO6FlhvIur8pPeGU2L0/JqB
         YM1iKbTkMnIUk0Mk/u3GTWyYSoTNd6tWKKhWT1787NSAloPpqD2h6uskEeAJk12L8H
         r8BxVLHL//cOrQgx9OG2IBcTcVFw3aag1jznJM6WivgqhnNyJxcl7NOYacXkTxFZPV
         AJjt9g7e5A6wQ==
Date:   Thu, 8 Jun 2023 08:54:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mark.rutland@arm.com, arnd@arndb.de, ndesaulniers@google.com,
        trix@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] percpu: Fix self-assignment of __old in
 raw_cpu_generic_try_cmpxchg()
Message-ID: <20230608155426.GA188192@dev-arch.thelio-3990X>
References: <20230607-fix-shadowing-in-raw_cpu_generic_try_cmpxchg-v1-1-8f0a3d930d43@kernel.org>
 <20230608082940.GF998233@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608082940.GF998233@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 08, 2023 at 10:29:40AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 07, 2023 at 02:20:59PM -0700, Nathan Chancellor wrote:
> > After commit c5c0ba953b8c ("percpu: Add {raw,this}_cpu_try_cmpxchg()"),
> > clang built ARCH=arm and ARCH=arm64 kernels with CONFIG_INIT_STACK_NONE
> > started panicking on boot in alloc_vmap_area():
> > 
> >   [    0.000000] kernel BUG at mm/vmalloc.c:1638!
> >   [    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> >   [    0.000000] Modules linked in:
> >   [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc2-ARCH+ #1
> >   [    0.000000] Hardware name: linux,dummy-virt (DT)
> >   [    0.000000] pstate: 200000c9 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >   [    0.000000] pc : alloc_vmap_area+0x7ec/0x7f8
> >   [    0.000000] lr : alloc_vmap_area+0x7e8/0x7f8
> > 
> > Compiling mm/vmalloc.c with W=2 reveals an instance of -Wshadow, which
> > helps uncover that through macro expansion, '__old = *(ovalp)' in
> > raw_cpu_generic_try_cmpxchg() can become '__old = *(&__old)' through
> > raw_cpu_generic_cmpxchg(), which results in garbage being assigned to
> > the inner __old and the cmpxchg not working properly.
> > 
> > Add an extra underscore to __old in raw_cpu_generic_try_cmpxchg() so
> > that there is no more self-assignment, which resolves the panics.
> > 
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1868
> 
> First time I see Closes; is this an 'official' tag?

It is, but only recently:

https://git.kernel.org/linus/0d828200ad56505a827610af876ca0b138b943a6

checkpatch.pl wants Closes: after Reported-by: so I have just started
getting into the habit of using it even when I am the reporter :)

> > Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
> > Fixes: c5c0ba953b8c ("percpu: Add {raw,this}_cpu_try_cmpxchg()")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Durr, C is such a lovely language :-)

:)

> I'll go stick it in locking/core to go with the bunch that wrecked it.
> Thanks!

Thanks for the quick response!

Cheers,
Nathan
