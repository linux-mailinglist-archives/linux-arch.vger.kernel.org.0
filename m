Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D591B4362
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgDVLha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 07:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgDVLha (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 07:37:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B9C03C1A8;
        Wed, 22 Apr 2020 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=js1Zyy8BIVwm7dXq/z2cFwiQcL5H3VEJb75X+ObOHy0=; b=si7drRH+3Qj4mrA77klXk9QyQL
        7bxV6TMaNDF91zyCSY45V7w9RPD2n1UAvKhYQu1lpZMA0Mcotn+AOAHjgvkEsxDiw+c9H3xRbYsVZ
        yAA9fjjvm3HYEI9JumzLK02x7EsqinSd8nT2EfRDC+2BK+uokrXb11aP67/hX8c10W/siQtBM/B0U
        fGtR+GVh5HL+SqL0ShYHAx+Ug9RcvM3cf7r8f4kFwwTjajY/W2TkSCSJO/LWPAEPFFIc2ub6XPn2P
        qs+dOv2EUBRiRL60MNgV4JtMgxw+TJYAVWdpL8JkrlbIl3Ni0pDCE9v7oTCEaD4SSI5I7AbUJo1Qf
        j0bp07ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDgy-0002eM-2Z; Wed, 22 Apr 2020 11:37:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C708C30477A;
        Wed, 22 Apr 2020 13:37:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9933C20280194; Wed, 22 Apr 2020 13:37:21 +0200 (CEST)
Date:   Wed, 22 Apr 2020 13:37:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Message-ID: <20200422113721.GA20730@hirez.programming.kicks-ass.net>
References: <20200421151537.19241-1-will@kernel.org>
 <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
 <20200422081838.GA29541@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422081838.GA29541@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 22, 2020 at 09:18:39AM +0100, Will Deacon wrote:
> On Tue, Apr 21, 2020 at 11:42:56AM -0700, Linus Torvalds wrote:
> > On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > It's me again. This is version four of the READ_ONCE() codegen improvement
> > > patches [...]
> > 
> > Let's just plan on biting the bullet and do this for 5.8. I'm assuming
> > that I'll juet get a pull request from you?
> 
> Sure thing, thanks. I'll get it into -next along with the arm64 bits for
> 5.8, but I'll send it as a separate pull when the time comes. I'll also
> include the sparc32 changes because otherwise the build falls apart and
> we'll get an army of angry robots yelling at us (they seem to form the
> majority of the active sparc32 user base afaict).

So I'm obviously all for these patches; do note however that it collides
most mighty with the KCSAN stuff, which I believe is still pending.
