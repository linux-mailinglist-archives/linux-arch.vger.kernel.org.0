Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36362387208
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhERGnF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbhERGnE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 02:43:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED15C061573;
        Mon, 17 May 2021 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dWGhCQRTKQ7yccRLGUQNnETO9ChctiK/g8rLylI0oJA=; b=egmZl1PT7u82JatkbyGXeH/9NN
        jhaKyX5We5mWcOM/lDZ5RxzGup4x8GVqidK0TN7wKRRvQP8IGmxzvVq0CAp6l4XeQH75hggx3bu48
        UG6KWUgY+fOzytBC13USeGiBkRM6ecCNYUGMBajkM3mo3i5jKFWuwF95EbJjRnXQe7Xq/bQE33CN9
        1caA4At3YDa1pGcKMU632544oIlZuT82e8wACee+qtmIxrzV5Y98nOwQgDulW9uUF8p6mjwUjxLef
        s53WeXzYmmPZYoVHIRWyTWZZj6DhnqOUNohCzE69HpOT4zEqE+i1t2LBkBr8o5EjiwRS7qOX4NKAo
        Mctg6q7w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1litP3-00Dika-IP; Tue, 18 May 2021 06:40:47 +0000
Date:   Tue, 18 May 2021 07:40:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
Message-ID: <YKNhXQ883lRbqQGA@infradead.org>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
 <m1y2cc3d97.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y2cc3d97.fsf@fess.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 17, 2021 at 10:57:24PM -0500, Eric W. Biederman wrote:
> We open ourselves up to bugs whenever we lie to the type system.
> 
> Skimming through the code it looks like it should be possible
> to not need the in_compat_syscall and the casts to the wrong
> type by changing the order of the code a little bit.

What kind of bug do you expect?  We must only copy from user addresses
once anyway.  I've never seen bugs due the use of in_compat_syscall,
but plenty due to cruft code trying to avoid it.
