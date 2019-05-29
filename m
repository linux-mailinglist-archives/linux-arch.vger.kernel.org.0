Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACB52D9CA
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfE2J61 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 05:58:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2J61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 05:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=40Ww1U6jHSA8ZmRiYmC+C6BB0Qna+KOdSYwCoTc6YjQ=; b=C+ffkDjw2i3zSjdGxEQOsrfOH
        jSMeUDcWszjB+A92PhqCZvDq+vh8wGldURKlX1YAQwKZgkhMMvYqkFq8LGqKX8jva0zDJ3ORzSlsX
        MaKjQ+Ieoxv81e+y4Gsz6mFjtUNC0f3v1/DhP5Y8NWHiXxW3EGcVX3joDeTLdstcEjqZo0QRU5B+w
        EULJ8NsytdoVUO5LK8rAjtJr+wk4SofyiE316JL3oLdW1tsoiK9SEbFhTETQlgLJn6Z5HEyhBUWct
        VrDUO50e+8JUivouEmG0dgWrpCgem4+W55v+t5/wR9jl2mmkrTaXLluOEmoUTZgXHtK2lL7IbWt6I
        M1nRZeIBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVvLc-0002EX-JV; Wed, 29 May 2019 09:58:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22A822065C636; Wed, 29 May 2019 11:58:15 +0200 (CEST)
Date:   Wed, 29 May 2019 11:58:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
Subject: Re: [PATCH 2/3] tools/objtool: add kasan_check_* to uaccess whitelist
Message-ID: <20190529095815.GL2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-2-elver@google.com>
 <20190528171942.GV2623@hirez.programming.kicks-ass.net>
 <CACT4Y+ZK5i0r0GSZUOBGGOE0bzumNor1d89W8fvphF6EDqKqHg@mail.gmail.com>
 <CANpmjNP7nNO36p03_1fksx1O2-MNevHzF7revUwQ3b7+RR0y+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP7nNO36p03_1fksx1O2-MNevHzF7revUwQ3b7+RR0y+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 29, 2019 at 11:46:10AM +0200, Marco Elver wrote:
> On Wed, 29 May 2019 at 10:55, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, May 28, 2019 at 7:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, May 28, 2019 at 06:32:57PM +0200, Marco Elver wrote:
> > > > This is a pre-requisite for enabling bitops instrumentation. Some bitops
> > > > may safely be used with instrumentation in uaccess regions.
> > > >
> > > > For example, on x86, `test_bit` is used to test a CPU-feature in a
> > > > uaccess region:   arch/x86/ia32/ia32_signal.c:361
> > >
> > > That one can easily be moved out of the uaccess region. Any else?
> >
> > Marco, try to update config with "make allyesconfig" and then build
> > the kernel without this change.
> >
> 
> Done. The only instance of the uaccess warning is still in
> arch/x86/ia32/ia32_signal.c.
> 
> Change the patch to move this access instead? Let me know what you prefer.

Yes, I think that might be best. The whitelist should be minimal.
