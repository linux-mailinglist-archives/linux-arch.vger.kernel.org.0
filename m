Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C562F1EE8DD
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jun 2020 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgFDQty (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jun 2020 12:49:54 -0400
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:39834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729115AbgFDQtx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2020 12:49:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5E9B0503E9;
        Thu,  4 Jun 2020 16:49:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2915:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6742:10004:10400:10848:11026:11232:11473:11658:11914:12296:12297:12555:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:14659:14721:21080:21627:21990:30054:30060:30069:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: field18_4511ff726d98
X-Filterd-Recvd-Size: 2054
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jun 2020 16:49:49 +0000 (UTC)
Message-ID: <28b33db24b1dbd15cd6711cd473f1c0e5f801e74.camel@perches.com>
Subject: Re: [PATCH] linux/bits.h: fix unsigned less than zero warnings
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kbuild test robot <lkp@intel.com>
Date:   Thu, 04 Jun 2020 09:49:46 -0700
In-Reply-To: <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
References: <20200603215314.GA916134@rikard>
         <20200603220226.916269-1-rikard.falkeborn@gmail.com>
         <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-06-04 at 09:41 +0300, Andy Shevchenko wrote:
> I think there is still a possibility to improve (as I mentioned there
> are test cases that are absent right now).
> What if we will have unsigned long value 0x100000001? Would it be 1
> after casting?
> 
> Maybe cast to (long) or (long long) more appropriate?

Another good mechanism would be to compile-time check the use
of constants in BITS and BITS_ULL and verify that:

range of BITS is:
	>= 0 && < (BITS_PER_BYTE * sizeof(unsigned int))
range of BITS_ULL is:
	>= 0 && < (BITS_PER_BYTE * sizeof(unsigned long long))

There would be duplication similar to the GENMASK_INPUT_CHECK
macros.


