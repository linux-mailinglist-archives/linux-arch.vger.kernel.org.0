Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209292DC53
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 14:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE2MBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 08:01:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34914 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2MBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 08:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z74YCGIX51kpVCW0eNEXPC/LPXMVSjCPWicAYebjk78=; b=Pp+auo/BwH9JOmNgGdiVDykt3
        keX1i7Oqb+0o31PRpT9YIYz6piZcH/llYDTlMedY/wKrOOrBhhRUDkQrmObDkjZNf88PAWnfaHQ5A
        zJ34lb7qzFpzQzjCwAw1OAPCx4N7WJzYN38/+6rKJMkk5HPuYHA5crds+86PDvhaXbmqZfi0HbjoG
        PyRDWKR/YAGQlCG+h6bq8KQ7sT9c/RYYhZLQGMixWQK4o4BZS8V1sxbKk+L345JX+WLu4p8XbJje1
        rhJVCd06purgETtnp8ObK1W5VwVg3BZ/qB4m21pnafb17Guaj1y1WPJfEjb17UNQeGTmKtHl5HR8Q
        r+OzHFkKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVxGy-00049Z-I3; Wed, 29 May 2019 12:01:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C456201DA657; Wed, 29 May 2019 14:01:34 +0200 (CEST)
Date:   Wed, 29 May 2019 14:01:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Message-ID: <20190529120134.GR2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net>
 <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net>
 <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
 <377465ba-3b31-31e7-0f9d-e0a5ab911ca4@virtuozzo.com>
 <CACT4Y+ZDmqqM6YW72Q-=kAurta5ctscLT5p=nQJ5y=82yVMq=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZDmqqM6YW72Q-=kAurta5ctscLT5p=nQJ5y=82yVMq=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 29, 2019 at 01:29:51PM +0200, Dmitry Vyukov wrote:
> Thanks. I've filed https://bugzilla.kernel.org/show_bug.cgi?id=203751
> for checking alignment with all the points and references, so that
> it's not lost.

Thanks!
