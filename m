Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A6292439
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgJSJDS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 05:03:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:36886 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgJSJDR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Oct 2020 05:03:17 -0400
X-Greylist: delayed 1577 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 05:03:16 EDT
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09J8WSVC005033;
        Mon, 19 Oct 2020 03:32:28 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09J8WPVE005032;
        Mon, 19 Oct 2020 03:32:25 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Oct 2020 03:32:25 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm-generic: Force inlining of get_order() to work around gcc10 poor decision
Message-ID: <20201019083225.GN2672@gate.crashing.org>
References: <96c6172d619c51acc5c1c4884b80785c59af4102.1602949927.git.christophe.leroy@csgroup.eu> <CACPK8XfgK0Bj3sLjKCi80jS6vK34FN5BTkU8FvBGcMR=RQn4Xw@mail.gmail.com> <0bd0afae-f043-2811-944b-c94d90e231d2@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bd0afae-f043-2811-944b-c94d90e231d2@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 19, 2020 at 07:50:41AM +0200, Christophe Leroy wrote:
> Le 19/10/2020 à 06:55, Joel Stanley a écrit :
> >>In the old days, marking a function 'static inline' was forcing
> >>GCC to inline, but since commit ac7c3e4ff401 ("compiler: enable
> >>CONFIG_OPTIMIZE_INLINING forcibly") GCC may decide to not inline
> >>a function.
> >>
> >>It looks like GCC 10 is taking poor decisions on this.

> >1952 bytes smaller with your patch applied. Did you raise this with
> >anyone from GCC?
> 
> Yes I did, see https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97445
> 
> For the time being, it's at a standstill.

The kernel should just use __always_inline if that is what it *wants*;
that is true here most likely.  GCC could perhaps improve its heuristics
so that it no longer thinks these functions are often too big for
inlining (they *are* pretty big, but not after basic optimisations with
constant integer arguments).


Segher
