Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE352A63ED
	for <lists+linux-arch@lfdr.de>; Wed,  4 Nov 2020 13:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKDMKz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Nov 2020 07:10:55 -0500
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:46204 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbgKDMKz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Nov 2020 07:10:55 -0500
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 07:10:54 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id D8635180188D5
        for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2020 12:04:05 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 66BDE180A7FE2;
        Wed,  4 Nov 2020 12:04:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6691:6742:7903:7974:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21325:21433:21451:21627:30003:30054:30055:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: turn90_630e8ab272c1
X-Filterd-Recvd-Size: 2099
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Nov 2020 12:04:01 +0000 (UTC)
Message-ID: <92d39ff1408078a656c43bee24e7e9b3e3815e72.camel@perches.com>
Subject: Re: get_maintainer.pl bug? (was: Re: [PATCH 0/8] linker-section
 array fix and clean ups)
From:   Joe Perches <joe@perches.com>
To:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date:   Wed, 04 Nov 2020 04:04:00 -0800
In-Reply-To: <20201104091625.GP4085@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
         <20201104091625.GP4085@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-11-04 at 10:16 +0100, Johan Hovold wrote:
> Running scrips/get_maintainer.pl on this series [1] gave the wrong
> address for Nick Desaulniers:
> 
> 	Nick Desaulniers <ndesaulniers@gooogle.com> (commit_signer:1/2=50%,commit_signer:1/8=12%)
> 
> It seems he recently misspelled his address in a reviewed-by tag to
> commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
> to __section("foo")") and that is now being picked up by the script.
> 
> I guess that's to be considered a bug?

No, that's a feature.  If it's _really_ a problem, (and I don't
think it really is), that's what .mailmap is for.


