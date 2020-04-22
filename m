Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46561B45F9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDVNLg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 09:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgDVNLf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 09:11:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6185206EC;
        Wed, 22 Apr 2020 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587561095;
        bh=Tu2PhKwHoYwGdCMbzyqBBm0RFMgjXtqVtWkHT7kOUgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6jRO1wqjLWNb15qOHzZPEh06O5wuzuJ6stgN9cO44T8aCtBV74dCkm9xQU3/jxmh
         ZfyIYbNNNjpeqEBnsZjgmGaQYC9+8QKkkvWMyjOFORT6GUk2ocvRg1btJSjKFB36Hk
         NuonA+CD6aDAtMRoDAs3KegQJoCcz74fIi3x3wdk=
Date:   Wed, 22 Apr 2020 14:11:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 08/11] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Message-ID: <20200422131129.GC676@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-9-will@kernel.org>
 <6cbc8ae1-8eb1-a5a0-a584-2081fca1c4aa@rasmusvillemoes.dk>
 <20200422114807.GW26902@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422114807.GW26902@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 22, 2020 at 06:48:07AM -0500, Segher Boessenkool wrote:
> On Wed, Apr 22, 2020 at 12:25:03PM +0200, Rasmus Villemoes wrote:
> > On 21/04/2020 17.15, Will Deacon wrote:
> > > Unfortunately, dropping pointer qualifiers inside the macro poses quite
> > > a challenge, especially since the pointed-to type is permitted to be an
> > > aggregate, and this is relied upon by mm/ code accessing things like
> > > 'pmd_t'. Based on numerous hacks and discussions on the mailing list,
> > > this is the best I've managed to come up with.
> > 
> > Hm, maybe this can be brought to work, only very lightly tested. It
> > basically abuses what -Wignored-qualifiers points out:
> > 
> >   warning: type qualifiers ignored on function return type
> > 
> > Example showing the idea:
> > 
> > const int c(void);
> > volatile int v(void);
> > 
> > int hack(int x, int y)
> > {
> > 	typeof(c()) a = x;
> > 	typeof(v()) b = y;
> > 
> > 	a += b;
> > 	b += a;
> > 	a += b;
> > 	return a;
> > }
> 
> Nasty.  I like it :-)
> 
> > Since that compiles, a cannot be const-qualified, and the generated code
> > certainly suggests that b is not volatile-qualified. So something like
> > 
> > #define unqual_type(x) _unqual_type(x, unique_id_dance)
> > #define _unqual_type(x, id) typeof( ({
> >   typeof(x) id(void);
> >   id();
> > }) )
> > 
> > and perhaps some _Pragma("GCC diagnostic push")/_Pragma("GCC diagnostic
> > ignored -Wignored-qualifiers")/_Pragma("GCC diagnostic pop") could
> > prevent the warning (which is in -Wextra, so I don't think it would
> > appear in a normal build anyway).
> > 
> > No idea how well any of this would work across gcc versions or with clang.
> 
> https://gcc.gnu.org/legacy-ml/gcc-patches/2016-05/msg01054.html
> 
> This is defined to work this way in ISO C since C11.
> 
> But, it doesn't work with GCC before GCC 7 :-(

Damn, that's quite a cool hack! Maybe we'll be able to implement it in a
few years time ;)

WIll
