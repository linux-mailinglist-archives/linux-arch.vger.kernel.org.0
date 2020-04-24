Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8AB1B7D2E
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgDXRoS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727049AbgDXRoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 13:44:18 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A84AC09B047;
        Fri, 24 Apr 2020 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+je/+5kxZIoIQnbkwLglonBV4JK5dKADqvUN+mdCKic=; b=MRvBqARKPVSGhrXD2OdOuvfH1p
        aDOeFf9k3OpEhJZBx72lZ3D7fLT43vTqx8IJq+Jj8Ifdz/rVMC0Uf8whFQtbVwqEAKPlr+lEO11/f
        cftLVJ70AAPqO/YBU+e4hEH7T0D/VSX6uDctvTWZTb79/ssK+Zq8cgaxXeDwtybq0SfBDYkPxieyX
        fynZ3E8gEvNpThC8UyI1qEpjPw/RhazzrLbQOPG2Ch86WtiZWxRijb6vMCQPdkD83Lomn2+fMwa2y
        y+H79req+9UGe/LHV7H1lvsmYPVuPRM3/167myXhOiCwfQY/mOhqo1AA2wSfZ4aZ7m+0QE/ebBt8T
        cJkThxcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jS2MU-0000Bu-QL; Fri, 24 Apr 2020 17:43:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 100F73010C8;
        Fri, 24 Apr 2020 19:43:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED6E42BA49057; Fri, 24 Apr 2020 19:43:34 +0200 (CEST)
Date:   Fri, 24 Apr 2020 19:43:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 07/11] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Message-ID: <20200424174334.GB13592@hirez.programming.kicks-ass.net>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-8-will@kernel.org>
 <CAG48ez2n6g6nenHM8uB5U+e-Zo1PSA6n9LOBHeqG2HdUnwFpSQ@mail.gmail.com>
 <20200424171135.GJ21141@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424171135.GJ21141@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 24, 2020 at 06:11:35PM +0100, Will Deacon wrote:
> My apologies, you're completely right. I thought that PAE mandated 64-bit
> atomicity, like it does on 32-bit ARM, but that's apparently not the case
> and looking at the 32-bit x86 pgtable code they have to be really careful
> there.

They added CMPXCHG8B for PAE, but then we never used it for that because
it's dead slow (MS did use it I think). Instead we play horrible split
word games, grep for CONFIG_GUP_GET_PTE_LOW_HIGH.
