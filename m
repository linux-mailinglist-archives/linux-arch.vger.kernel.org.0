Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A071375BF
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 19:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgAJSB0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 13:01:26 -0500
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:54524 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgAJSB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 13:01:26 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 13:01:25 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id BB9A31813CB82
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2020 17:54:32 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 32B71180008AC;
        Fri, 10 Jan 2020 17:54:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4384:5007:6119:6120:7901:7903:9025:10004:10400:11232:11658:11914:12043:12297:12555:12698:12737:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:14880:21080:21627:21740:21987:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: food82_7e88326182d0f
X-Filterd-Recvd-Size: 2379
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Jan 2020 17:54:29 +0000 (UTC)
Message-ID: <8fe4f81699517758b44afbe0e1a53bc080f64a62.camel@perches.com>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Fri, 10 Jan 2020 09:53:36 -0800
In-Reply-To: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org>
         <20200110165636.28035-2-will@kernel.org>
         <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-01-10 at 18:35 +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > discarding the 'volatile' qualifier:
> > 
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > 
> > We've been working around this using some nasty hacks which make
> > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > kernel builds now, emit a warning if we detect it during the build.
> 
> No objection to recommending gcc-4.8, but I think this should either
> just warn once during the kernel build instead of for every file, or
> it should become a hard requirement.

It might as well be a hard requirement as
gcc 4.8.0 is already nearly 7 years old.

gcc 4.6.0 released 2011-03-25
gcc 4.8.0 released 2013-03-22

Perhaps there are exceedingly few to zero new
instances using gcc compiler versions < 4.8


