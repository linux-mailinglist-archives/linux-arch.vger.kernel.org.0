Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B146214C8F2
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2020 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgA2Kt3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jan 2020 05:49:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgA2Kt3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jan 2020 05:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ekaLsCwMQDEgP33Uu27b/1osxPW25kXxN7+YpOV4y48=; b=bsgyrNxkkQgAoQHj/4H9VWg0N
        BYsLqJysTjNSgmBABm8S5YQWI1DcUZk6nleemESGdQWJv3wIzq3sGGupizG+s/cDiTtI/UvIctZiG
        5k6FiuO4Mup1k9l46KybgPMSMk5EwE/5FwToNuFO5vIAhvKlfjwU7rL1awecWueGMETKAFlNbfSCI
        A8eAUwTGuUolJB7vMZPCOAr6pXlnj0XVsA4fCZSLO1WL8ZoJWx3DlfuWa10UuvPGTwZtMSXMVGA1d
        UyjylwaWinAr3GjMyBmqlkRgbwz4DakMbxKbC3JioBuZyr2/OkwP38aDlFAZ33INLQT0aRSOnBnRV
        BNhN/+TgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwkuN-0001y9-RH; Wed, 29 Jan 2020 10:49:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85D05300606;
        Wed, 29 Jan 2020 11:47:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B7A82B49B91B; Wed, 29 Jan 2020 11:49:17 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:49:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        ying.huang@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 05/10] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Message-ID: <20200129104917.GN14946@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-6-will@kernel.org>
 <20200125082746.GT11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125082746.GT11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 25, 2020 at 09:27:46AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 23, 2020 at 03:33:36PM +0000, Will Deacon wrote:
> > {READ,WRITE}_ONCE() cannot guarantee atomicity for arbitrary data sizes.
> > This can be surprising to callers that might incorrectly be expecting
> > atomicity for accesses to aggregate structures, although there are other
> > callers where tearing is actually permissable (e.g. if they are using
> > something akin to sequence locking to protect the access).
> > 
> > Linus sayeth:
> > 
> >   | We could also look at being stricter for the normal READ/WRITE_ONCE(),
> >   | and require that they are
> >   |
> >   | (a) regular integer types
> >   |
> >   | (b) fit in an atomic word
> >   |
> >   | We actually did (b) for a while, until we noticed that we do it on
> >   | loff_t's etc and relaxed the rules. But maybe we could have a
> >   | "non-atomic" version of READ/WRITE_ONCE() that is used for the
> >   | questionable cases?
> > 
> > The slight snag is that we also have to support 64-bit accesses on 32-bit
> > architectures, as these appear to be widespread and tend to work out ok
> > if either the architecture supports atomic 64-bit accesses (x86, armv7)
> > or if the variable being accesses represents a virtual address and
> > therefore only requires 32-bit atomicity in practice.
> > 
> > Take a step in that direction by introducing a variant of
> > 'compiletime_assert_atomic_type()' and use it to check the pointer
> > argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE_ONCE}() variants
> > which are allowed to tear and convert the two broken callers over to the
> > new macros.
> 
> The build robot is telling me we also need this for m68k; they have:
> 
>   arch/m68k/include/asm/page.h:typedef struct { unsigned long pmd[16]; } pmd_t;

Fixed that with these patches:

  https://lkml.kernel.org/r/20200129103941.304769381@infradead.org
