Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A288197E6
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 07:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfEJFHP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 01:07:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45334 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfEJFHO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 01:07:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so2226545pls.12;
        Thu, 09 May 2019 22:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FjMDX6OXptCPbOEPZorERjXrFHT+sQLeZXg4fcoOVO4=;
        b=c0UMDkfB6tTjOuuL7w77f9bWKLRAazsReBhnmqpNGDM0k59e6X/kl3C4Pe6J9eHUen
         VFAkbAqGjUIJBx7hvW7Fh6dqtrYSHH9XX2PvuEVj32Jy9VNtfv95QPZNAgVJgPRL3BKO
         OyB6K6sIcnJOt80RK+9Kgdu4JyMQCO4sdI1JvFP7WzWDVWm7oHYsqPIL5NCA8RM1tJ12
         ggKw4hwLADwL4j8sXY2gT6/wneNWSju7qCVIsYvNXQPH+QrW25KdR1AYG7U4Rz8in6rI
         qNWUTknwUpjjpgfRE8r4QpfQla/BLjPtT0IOYTbpCwB99LwTtNvLRfDE7OPzwXu3cz1B
         Lx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FjMDX6OXptCPbOEPZorERjXrFHT+sQLeZXg4fcoOVO4=;
        b=qP0NRHx+jxEvRyzVqhIgI8yrfGIw9S+AyBlNh6wYpKYOvQAkGiCRNOWtPUIEvl9Yz3
         pDPrg5z4P6992n747ySDUd7zKsScagwK1PLzctMf6g0LUoJM0y/ehmrCa67P3IbSDspq
         p0X+fDRdju5GguLGKLJ0Y+I0IkHpWqSu5e6+rsHeQx5xyVfEbRyJw6Y9ersmj50DBkA+
         qTgyWJVlP0Y+AZj+yWUKCATyO9xvtdl/vLyfOdRua+1efSLtRrVOOZuN0dY5criaXAg5
         zHgdB4+fbG22Hbd9dSUxW9Li6zeyasWejB80NjnhBQ9eWouTemxtLZ/yYKo4zAgi+i+S
         x78g==
X-Gm-Message-State: APjAAAVRjkQ4g/n489TF531osDJFiVkMdMixsQCctb6etXmiNbU8gqvf
        ZPtNBWsQYjT3PuuDvLZkw0g=
X-Google-Smtp-Source: APXvYqzNL5x5L+kA/IjbOlsUuaCt+dnLaiieinMh/bSrZ4GSD+ciNLFNHlYGUDHIszX5LplSP6e0cA==
X-Received: by 2002:a17:902:8c85:: with SMTP id t5mr10664151plo.23.1557464834204;
        Thu, 09 May 2019 22:07:14 -0700 (PDT)
Received: from localhost ([39.7.15.25])
        by smtp.gmail.com with ESMTPSA id d67sm5741186pfa.35.2019.05.09.22.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 22:07:13 -0700 (PDT)
Date:   Fri, 10 May 2019 14:07:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20190510050709.GA1831@jagdpanzerIV>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190510043200.GC15652@jagdpanzerIV>
 <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (05/09/19 21:47), Linus Torvalds wrote:
>    [ Sorry about html and mobile crud, I'm not at the computer right now ]
>    How about we just undo the whole misguided probe_kernel_address() thing?

But the problem will remain - %pS/%pF on PPC (and some other arch-s)
do dereference_function_descriptor(), which calls probe_kernel_address().
So if probe_kernel_address() starts to dump_stack(), then we are heading
towards stack overflow. Unless I'm totally missing something.

	-ss
