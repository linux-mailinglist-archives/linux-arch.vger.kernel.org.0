Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33540149212
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 00:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAXXaH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 18:30:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAXXaH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 18:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GQD3BQz3vSPm3PJCcPo+ZtpbdrNbmpXcX6AYSCSwISE=; b=RR7oUSIYp+FOJFH5abXvOvxm0
        u6RKkgum/CPfS4XL6VtVX11m1X6UVi8fMgeatVLtp9w8i/YIysZa9sRSSZN6sTZILwal8WFZkGtyO
        fF12c2B8zDJ/Sjx9+C3ZIHxeqbOh8hIn/sMcHZ0fp2kfh/iTItAmonIfVWViXFn6Fm2FMmpFm77Qh
        J8chmJpScK2YujFuwqCuYdCsT180uDmF1VLeIkpBfPt+XPP7p4UN9bVJdhqtg8rF3XoRo2/R3q5mo
        F+XHHOlkV59VgIrP2eYvgFHkIlC+89YgnSY91yUQW6FCr0toXPDUcaGE9A2Jg9qBFL9BOBwfbruwK
        TjiRYOq3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iv8Oa-0006Ec-FT; Fri, 24 Jan 2020 23:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FB85302526;
        Sat, 25 Jan 2020 00:28:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECBEE209DB0E3; Sat, 25 Jan 2020 00:29:44 +0100 (CET)
Date:   Sat, 25 Jan 2020 00:29:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 09/10] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
Message-ID: <20200124232944.GD14914@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-10-will@kernel.org>
 <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com>
 <20200124082637.GZ14914@hirez.programming.kicks-ass.net>
 <CAKwvOdmFMnCgr3rP5vNkj_H1SnBJ6drdBP1RSGxzfYzSiWGfLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmFMnCgr3rP5vNkj_H1SnBJ6drdBP1RSGxzfYzSiWGfLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 09:05:27AM -0800, Nick Desaulniers wrote:

> Ack. Do maintainers have tools for fetching patch series and
> automating collecting Reviewed-by tags, or is it all extremely manual?

Both; I'm currently still doing it manually, but I know that for example
Thomas's scripts are a lot smarter and do it for him.

I'm meaning to switch to his scripts, but I suppose there's some inertia
at play :-)

