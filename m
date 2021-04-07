Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28015357272
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354368AbhDGQzN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 12:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354367AbhDGQzN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 12:55:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D76C061756;
        Wed,  7 Apr 2021 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PJEGDTfx4FpHUfzm/IRlkyDCU12YvWeK1NxNzYl/AlY=; b=IuK+PUXsE0Q27Z+WJZY5fVgKZd
        jBBDFbH+TO4Kuw/DGmuRbqBZAkScBp4b4IEEuaduuYruDLfTOg4xSHn+nPCdPXTiKWBfVw8GtMbpu
        eibVSjdAooE/oCCFJ9i7VNHhqde2OWycjWHa1A/Ek6dBGd4E22/GbH6z0XDVTCvebNvzLmqbsb04z
        oh/m3/o6ffBGwiYBbqDMXv7mJScMbc3t839fHnb1DCwFu8u7UiJ7DGG497/+izZDMNIQgUQF/SC9c
        ayx70l8lQidfnNLmdGyJZVkt9ZzXsum0ZBoqo1EChaX7MgWdaOhI5KBct919YT6+iCK/vgUwUnErn
        pwDsDA1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUBS5-005W26-Ah; Wed, 07 Apr 2021 16:54:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8A5C3001FB;
        Wed,  7 Apr 2021 18:54:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 867582BC07BA6; Wed,  7 Apr 2021 18:54:46 +0200 (CEST)
Date:   Wed, 7 Apr 2021 18:54:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YG3j1j/MNCszy12w@hirez.programming.kicks-ass.net>
References: <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
 <YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net>
 <20210407094224.GA3393992@infradead.org>
 <CAHB2gtROGuoNzv5f9QrhWX=3ZtZmUM=SAjYhKqP7dTiTTQwkqA@mail.gmail.com>
 <YG3VRIUjjaK+pfES@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG3VRIUjjaK+pfES@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 05:52:36PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 04:29:12PM +0200, Christoph Müllner wrote:
> > The comparison with sparc64 is not applicable, as sparc64 does not
> > have LL/SC instructions.
> 
> Sparc64 has CAS, without hardware fwd progress. It has to do software
> backoff for failed CAS in order to do software fwd progress.

Again, the longer answer is that this applies identically to LL/SC and
I'm sure we actually have (or had) an architecture in tree that did just
that. I just cannot remember which architecture that was.
