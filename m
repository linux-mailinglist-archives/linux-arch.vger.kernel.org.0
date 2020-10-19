Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A5292D42
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 19:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgJSR7c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 13:59:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:40218 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbgJSR7c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Oct 2020 13:59:32 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09JHt4hN012442;
        Mon, 19 Oct 2020 12:55:05 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09JHt2nP012434;
        Mon, 19 Oct 2020 12:55:02 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Oct 2020 12:55:02 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm-generic: Force inlining of get_order() to work around gcc10 poor decision
Message-ID: <20201019175502.GO2672@gate.crashing.org>
References: <96c6172d619c51acc5c1c4884b80785c59af4102.1602949927.git.christophe.leroy@csgroup.eu> <CACPK8XfgK0Bj3sLjKCi80jS6vK34FN5BTkU8FvBGcMR=RQn4Xw@mail.gmail.com> <0bd0afae-f043-2811-944b-c94d90e231d2@csgroup.eu> <20201019083225.GN2672@gate.crashing.org> <188e00e1-ae41-693e-1d05-f8d87e7ee696@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <188e00e1-ae41-693e-1d05-f8d87e7ee696@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 19, 2020 at 10:54:40AM +0200, Christophe Leroy wrote:
> Le 19/10/2020 à 10:32, Segher Boessenkool a écrit :
> >The kernel should just use __always_inline if that is what it *wants*;
> >that is true here most likely.  GCC could perhaps improve its heuristics
> >so that it no longer thinks these functions are often too big for
> >inlining (they *are* pretty big, but not after basic optimisations with
> >constant integer arguments).
> 
> Yes I guess __always_inline is to be added on functions like this defined 
> in headers for exactly that, and that's the purpose of this patch.
> 
> However I find it odd that get_order() is outlined by GCC even in some 
> object files that don't use it at all, for instance in fs/pipe.o

It is (arguably) too big too always inline if you do not consider that
__builtin_constant_p will remove half of the function one way or
another.  Not sure if that is what happens here, but now we have a PR
(thanks!) and we will find out.


Segher
