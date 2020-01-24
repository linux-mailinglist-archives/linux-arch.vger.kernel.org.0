Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE614795F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 09:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgAXI0w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 03:26:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXI0w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 03:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WVliC4ZkSf65b66McnDSrfnUI5s0aClN3yaQsp8c3S4=; b=Enz23/ShBEd739Cb1q0TjdNPF
        u31eRjOpLEf7w8QZIDRlG2Ur4GerOlVMkA9pIgPVjB8h2kELbwJepW3EHij5lA+2A6CHIiNO+shVd
        zrsKDGmZg6fph9V8nQS2WnulL3Zi8EVH5/NQHobxCnp8AE5+WRW1819I69SQef8Wnga3/spq36Kcf
        payFMU6OCA9KGOpbTHWJHEesURIvXfsR+kWVopijp1dwIklnWXdeZKnbbrIkBwJHkkz7wl8hnHlih
        2wE2ya9r/2OEOft7lfRAlqaNm1aaaAiGKm/OxD8zZ/WCqCKshnNP4Z6JRZ+H65XPOoFIFouZLMrBk
        3pRkKu6uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuuIa-00017E-9S; Fri, 24 Jan 2020 08:26:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B2723008A9;
        Fri, 24 Jan 2020 09:24:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B69B32B713683; Fri, 24 Jan 2020 09:26:37 +0100 (CET)
Date:   Fri, 24 Jan 2020 09:26:37 +0100
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
Message-ID: <20200124082637.GZ14914@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-10-will@kernel.org>
 <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 10:36:37AM -0800, Nick Desaulniers wrote:
> On Thu, Jan 23, 2020 at 7:34 AM Will Deacon <will@kernel.org> wrote:
> >
> > It is very rare to see versions of GCC prior to 4.8 being used to build
> > the mainline kernel. These old compilers are also know to have codegen
> > issues which can lead to silent miscompilation:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >
> > Raise the minimum GCC version for kernel build to 4.8 and remove some
> > tautological Kconfig dependencies as a consequence.
> >
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> 
> Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> I wouldn't mind if this patch preceded the earlier one in the series
> adding the warning, should the series require a v2 and if folks are
> generally ok with bumping the min version.

If I hadn't actually read your reply, I would have never spotted that
reviewed-by tag, hidden in a blob of text like that.

Adding some whitespace before and after, such that it stands out a
little more, might avoid such issues.
