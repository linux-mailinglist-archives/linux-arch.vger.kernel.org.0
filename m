Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9AEB19968
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfEJIQk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 04:16:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44720 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfEJIQk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 04:16:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so2633034pgv.11;
        Fri, 10 May 2019 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmrArLlqX0+g8dO65H9KErVBV4iwBC4vplgVby2I7tY=;
        b=pi676OP1FRhqbBbpb7fOeUNTiVaJG652h+lbTMGFhbLW2aHAPornrN8wTMZXVlgNxl
         W4BB6oJI8eT5ewIiyVGrzKYVuW9DRSSPWxGnbWSW+Ndedu6GJoUyQ3y/PgWW77qlcw6G
         2K3ngsOj1EzudIqLQY3Pv3bW/Uo8QOE0RKDM/G2n2MKLlvq5G32CQmiJ4tJt1eVKKfw2
         FJNt9YkI8VdNggOxd10ie4KY7+2hyQwHe618/y9gJGoXaaVC7tu0mkaM1DcSD7DR1e/1
         pQQgGtrSt/riF+FkuY9LeHLXQkZAa87ftpIW1dZnvIkh0uDIpIWMkZzfDlrKxKmq2uc4
         zYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmrArLlqX0+g8dO65H9KErVBV4iwBC4vplgVby2I7tY=;
        b=DqjzEFB4qwr/2GvaPg1eEUKtEJ1st/L4oNasNNHK+x81owz4TjRps+D0e67CG7n9z6
         NnU30/IYvZqlY+yJ2TZ6TcPruEqeQTFUpXuohZmy0lYqjmnBpNVeHC4YI40Bu65d6pIS
         ZF8P/l3im755kbk1hxW3VOlL0D/AIRcJ+rMk1eZLe9y+Ve47cfDcDZqgiuLhZTdw86C5
         Ega4M3XRNIx8LSmEcZ4I3IWMPlqs6KczWW7PNVVbaTXAPXU44lO9qU7nUzeMbjdNhR5t
         ypWgze77luaGW32FXLGHSY6sYkjspPEi/ldYLyiBs/UIqYsYjAQeUnznOV+4RkGWv/Yz
         TPUg==
X-Gm-Message-State: APjAAAVlYISH7+gofqkqdnkgxYj8nx0esH1vXv8CQUMkNRHX1UYEgtML
        ZG9td1l8tSs4ymAY12bDrEs=
X-Google-Smtp-Source: APXvYqwOHP1arI/G1HtdqJ0tQ0k3aIkPVbkmDhzh/AFABpPSUF5dUQqIu8sQTWKyE8OeI4KXFIElPQ==
X-Received: by 2002:a63:246:: with SMTP id 67mr11946180pgc.145.1557476199809;
        Fri, 10 May 2019 01:16:39 -0700 (PDT)
Received: from localhost ([39.7.15.25])
        by smtp.gmail.com with ESMTPSA id h1sm8999019pfq.3.2019.05.10.01.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 01:16:38 -0700 (PDT)
Date:   Fri, 10 May 2019 17:16:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190510081635.GA4533@jagdpanzerIV>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190510043200.GC15652@jagdpanzerIV>
 <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
 <20190510050709.GA1831@jagdpanzerIV>
 <20190510080602.mdfk54f6lpyg6unw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510080602.mdfk54f6lpyg6unw@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (05/10/19 10:06), Petr Mladek wrote:
[..]
> I am going to send a patch replacing probe_kernel_address() with
> a simple check:
> 
> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> 		return "(efault)";

I'm OK with this.
Probing ptrs was a good idea, it just didn't work out.

	-ss
