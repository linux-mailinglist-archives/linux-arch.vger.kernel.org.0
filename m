Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5914909A
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 23:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAXWAZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 17:00:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXWAZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 17:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EHG6Q1AO3iuT6O0CXN+hQkY2MviKsXG45P08g3eUA9c=; b=XxSKomYe9qO2pHUJ4g7F1egF8
        OgnONfKVG8tW+PkImifBcGdo/lXupljgt8slZrTeik8u+eSsfMIX4CAjPc/XYd9ZMc/mUp7LmrTwb
        JpdAJulhZ0CABJTU5zKI6ou6Snfxih/bM1V77We8ZJEYde4+fRZHEG8BssTOsmQnR4r2SHln/Jqnm
        Ao/GbN7p1DZYOss+cgDc3U9lY4V1k4suTJ4TVEAIwB+g3tREepaqhkTix0x1XrWnv5YNZ+MpyR2wx
        uoI66X9rt1Hhf5zPqMHqJ/zbpTZRhHQh6bjKa7eLmrHwyM1vp/TGXp+f0igWG7iRvAwizy04Dx42w
        ljPPZs2aA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iv6zr-00014k-16; Fri, 24 Jan 2020 22:00:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 316FF980E48; Fri, 24 Jan 2020 23:00:08 +0100 (CET)
Date:   Fri, 24 Jan 2020 23:00:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Message-ID: <20200124220008.GS11457@worktop.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com>
 <20200124082443.GY14914@hirez.programming.kicks-ass.net>
 <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 09:36:54AM -0800, Linus Torvalds wrote:
> On Fri, Jan 24, 2020 at 12:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Just for curiosity's sake. What does clang actually do in that case?
> 
> This shouldn't necessarily be clang-specific. If the variable itself
> is 'const', it might go into a read-only section. So trying to modify
> it will quite possibly hit a SIGSEGV in user space (and in kernel
> space cause an oops).

Quite; but I worried clang would use the UB to omit the access entirely,
and therefore rob us of the well deserved crash or something.

Let me go read Nick's email tho, see what it actually does.
