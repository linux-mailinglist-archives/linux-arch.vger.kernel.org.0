Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F434840AE
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiADLTg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 06:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiADLTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 06:19:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D407C061761;
        Tue,  4 Jan 2022 03:19:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z9so77215126edm.10;
        Tue, 04 Jan 2022 03:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0xXZTc9fZWT+WzOM7EsRWouZq5pxfXz9JRFezikdzi8=;
        b=XOQZBgJQXhp7jwaK2xQJOnQocHO7sVVeZ17LRxyrjjlPKp4kgtQllUd08nXq2qyvdY
         qOkQPbb2/IDzTjoTkEpJqdNgGivi8Hz03zGoaGRNpBxu+B8yTwUsmnXnzNS7y9aRiYYl
         24tym24j/qZ2SepQWI1M0dOTdOx8UEJTgdlOyElMJ0uJx+0l7Ex2SJK12kTtVh5mNhJy
         RXF0a+xohxyo4bDSe8PBUPfPr8ckoTjB74A6M2aYrvgZVXK4jJDg4fE2miX6fNN3DNPe
         QDi0O6YoCf8YbBhCw4wt205ND/SRJfbvaPAnWbmUo92+yQDkBOf7DN27ElBoQIujvVwz
         dOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0xXZTc9fZWT+WzOM7EsRWouZq5pxfXz9JRFezikdzi8=;
        b=picLgJqSyFyJwsJPtT/8mbBAJFaonbLCEvg5FfeVIM7vENyED2kpRNS10IiAekh7zf
         Whx9v/i6wDVDR8kwlYcI9QUYXz9keQVTn/Y6S7AqavsK8ElYWiD9+cW7XLcxiEb5QIZV
         WRsjK6ulthiQ6xEY1F09M7T12XLtg3g1S+fSZycrYHg/PF2KXjzqt2x5m6NiV/fU4/T1
         oJlr6JDGeVuKKk74OR2s6BLxMXXpJ7EKR4MuFJimkTisQd658RttlIrGa5KfaVwYAl6Q
         s/6vh9TY+MUEzxjhTbGI9yTsKXQmD7BjaONAUlpnnlT0qYDfBsTYcSC9x+xxvKjnR9nE
         Zz/w==
X-Gm-Message-State: AOAM5334sO+LE8QeBBmt148IkmXKRA4KwXUyQlMUJXVC73MxSNbaXFzc
        KlSyGsKHWKq2Kd8ZhGuswFk=
X-Google-Smtp-Source: ABdhPJzU1LTAvRzkzrJngNHQhrjxV8d54FMAeTWjQQomqnVon080q8WJJt+KWIac9eYzcQuhDCEQKw==
X-Received: by 2002:a05:6402:424f:: with SMTP id g15mr49013361edb.316.1641295171204;
        Tue, 04 Jan 2022 03:19:31 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id b4sm7711322ejb.131.2022.01.04.03.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:19:30 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 4 Jan 2022 12:19:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: [TREE] "Fast Kernel Headers" Tree WIP/development branch
Message-ID: <YdQtQRMLWvsyIeFn@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdQlwnDs2N9a5Reh@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > ########################################################################
> > 
> > I am very excited to see where this goes, it is a herculean effort but 
> > I think it will be worth it in the long run. Let me know if there is 
> > any more information or input that I can provide, cheers!
> 
> Your testing & patch sending efforts are much appreciated!! You'd help me 
> most by continuing on the same path with new fast-headers releases as 
> well, whenever you find the time. :-)
> 
> BTW., you can always pick up my latest Work-In-Progress branch from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
> 
> The 'master' branch will carry the release.
> 
> The sched/headers branch is already rebased to -rc8 and has some other 
> changes as well. It should normally work, with less testing than the main 
> releasees, but will at times have fixes at the tail waiting to be 
> backmerged in a bisect-friendly way.

Ok, broke out the sched/headers WIP branch into a separate announcement, in 
case others want to test:

    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers

Note that I sometimes will update the 'master' branch as well, without a 
standalone announcement, if there's some important fix or the previous 
version moved away too much.

Also, where I backmerged your fixes to manual commits I credited you with:

   [ Fixes by Nathan Chancellor ]

   Fixed-by: Nathan Chancellor <nathan@kernel.org>

The (rare) exception would be straight dependency additions such as the 
<linux/string.h> additions, which are auto-generated from scratch to keep 
it maintainable & reviewable - if that's fine with you.

Thanks,

	Ingo
