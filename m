Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D3484B88
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 01:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiAEALJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 19:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiAEALJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 19:11:09 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC994C061761;
        Tue,  4 Jan 2022 16:11:08 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u25so33521037edf.1;
        Tue, 04 Jan 2022 16:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3vvIpsgXbZgWWzXm7KzAmbmgTQBrk3dhKKJZISsV6s8=;
        b=TNE0J7CImv7F9A50m31nlkd0NZDnJ5bqEaasfTqAWRPp9pAel1lVnyv3u4t67TSbYj
         R5l81t+LHrNC6VcOZ2zZMezDRc6msOhZwIiWx4THrc4pv7xOTcN4lxq9qeugYSQauUbF
         uyw/fZrwG/TNivyzUqsI9OR6b/NPpkNOQhNvCA+l9sevgapf4jA3eY/1ttwSFA4xj6xk
         8Wb0JVVTDorZWsSPOL5FXc2JoPcfFh39dgQQw5ZCb81hr9kF6teqDF08mWaSP9zEUuZJ
         WIDa44U9XTrk2kc/efmAF4QOI98jbBmHFNP6N8X6pgwsit8PV/yrM57qjYBtejnHv1TN
         uGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3vvIpsgXbZgWWzXm7KzAmbmgTQBrk3dhKKJZISsV6s8=;
        b=Y+x5xEpIcG6fTTvhPdf0O8l7q/Z4+RB/55J2cYrKL64s3buH0j7DzxVH+PEjzuUuGu
         rrTZKlYS/uZX6uqj96xsWkPhq/VB0t52GUtUnU0vyGrohDXF8cTP1KU3LJRbY4Ixk2NB
         EjOKJmJZXxj1QJYX69vNJQEbnAhmbmXpca4qL+y1mahDndw1QNgdkf7bjQmi6pMxri+U
         BuguzJ1l5nFwE4qc7HJyvuPFm03EgbllvsIQ4eGY0q1Do1rN4m9seigog0RpHOedaCSl
         ZKPheGAPhxANTn1BqjyiK7gzDdfIYD4rYUQN6n7uX0M7XNMrmn+3GqActolmeFGoUbMy
         Dehw==
X-Gm-Message-State: AOAM5316P1Jv965lhjJFCVxeRdTKgNVSZX3cUnCOz0hYQH1IPulHeY+t
        wwsmE9Vqpl8miyGNTQMbZeE=
X-Google-Smtp-Source: ABdhPJxgnN8lY8PFaKsz/jOTVvlJLHir8PhS1dnXJ6VDvhOay612+jquIdph3FE6Ud6hD5wF6S5rUA==
X-Received: by 2002:a17:907:7e9e:: with SMTP id qb30mr39505541ejc.348.1641341467532;
        Tue, 04 Jan 2022 16:11:07 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id d1sm11981894ejo.176.2022.01.04.16.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:11:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 01:11:03 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] headers/uninline: Uninline single-use function:
 kobject_has_children()
Message-ID: <YdTiF5dVeizYtIDS@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
 <YdQnfyD0JzkGIzEN@gmail.com>
 <YdRM7I9E2WGU4GRg@kroah.com>
 <YdRRl+jeAm/xfU8D@gmail.com>
 <YdRjRWHgvnqVe8UZ@kroah.com>
 <YdRkZqGuKCZcRbov@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdRkZqGuKCZcRbov@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Jan 04, 2022 at 04:09:57PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 04, 2022 at 02:54:31PM +0100, Ingo Molnar wrote:
> > > 
> > > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Tue, Jan 04, 2022 at 11:54:55AM +0100, Ingo Molnar wrote:
> > > > > There's one happy exception though, all the uninlining patches that 
> > > > > uninline a single-call function are probably fine as-is:
> > > > 
> > > > <snip>
> > > > 
> > > > >  3443e75fd1f8 headers/uninline: Uninline single-use function: kobject_has_children()
> > > > 
> > > > Let me go take this right now, no need for this to wait, it should be
> > > > out of kobject.h as you rightfully show there is only one user.
> > > 
> > > Sure - here you go!
> > 
> > I just picked it out of your git tree already :)
> > 
> > Along those lines, any objection to me taking at least one other one?
> > 3f8757078d27 ("headers/prep: usb: gadget: Fix namespace collision") and

Ack.

> > 6fb993fa3832 ("headers/deps: USB: Optimize <linux/usb/ch9.h>

Ack.

> > dependencies, remove <linux/device.h>") look like I can take now into my
> > USB tree with no problems.
> 
> Also these look good to go now:
> 	bae9ddd98195 ("headers/prep: Fix non-standard header section: drivers/usb/cdns3/core.h")

Ack.

> 	c027175b37e5 ("headers/prep: Fix non-standard header section: drivers/usb/host/ohci-tmio.c")

Ack.

Note that these latter two patches just simplified the task of my 
(simplistic) tooling, which is basically a shell script that inserts
header dependencies to the head of .c and .h files, right in front of
the first #include line it encounters.

These two patches do have some marginal clean-up value too, so I'm not 
opposed to merging them - just wanted to declare their true role. :-)

Thanks,

	Ingo
