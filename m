Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB7147952
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 09:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgAXIZC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 03:25:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXIZB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 03:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MfZNgigap++SfcaKWRzfoqJPEpL+dov/O+r0KNAVxwQ=; b=uBLKCo33khmwALe/1RXZcFcwk
        v9dGORHO68bVdfVE7Xqu3Xq4h0tBy7dKMAgtK6R2pAPhSyuhD15UDyu5APvU8PY7FbPl4ptgiaYDT
        VqvpfyCBk1RLWedPG5+nenFO2snsyblPPL3G5ci+SfDYNkZ0KxjfH6gioAn/ywsxMoER9H6MRwzWw
        e7YiSRfdSAN0GsCsalOVa3GsoGwfrWBEb2/67wCvC78cI8CBtcAxtc37wYs++HoGUdDSyswEOrXMB
        ogDk4glPVUBACG7RNuEJzZ07dbz++lo6HUM2Z77yTlvYItaDKRfI4+vK+Ic6SJW3g0DmMvRbg20KE
        MzRR0SP0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuuGl-0007yU-3M; Fri, 24 Jan 2020 08:24:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31B113012DC;
        Fri, 24 Jan 2020 09:23:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D3D02B713683; Fri, 24 Jan 2020 09:24:43 +0100 (CET)
Date:   Fri, 24 Jan 2020 09:24:43 +0100
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
        Masahiro Yamada <masahiroy@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Message-ID: <20200124082443.GY14914@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 11:07:59AM -0800, Nick Desaulniers wrote:

> Good thing it's the variable being modified was not declared const; I
> get spooked when I see -Wdiscarded-qualifiers because of Section
> 6.7.3.6 of the ISO C11 draft spec:
> 
> ```
> If an attempt is made to modify an object defined with a
> const-qualified type through use
> of an lvalue with non-const-qualified type, the behavior is undefined.
> If an attempt is
> made to refer to an object defined with a volatile-qualified type
> through use of an lvalue
> with non-volatile-qualified type, the behavior is undefined.133)
> 
> 133) This applies to those objects that behave as if they were defined
> with qualified types, even if they are
> never actually defined as objects in the program (such as an object at
> a memory-mapped input/output
> address).
> ```
> 
> Which is about the modification of a const-declared variable (explicit
> UB which Clang actively exploits), 

Just for curiosity's sake. What does clang actually do in that case?

