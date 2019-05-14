Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD01C094
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2019 04:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfENCZb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 May 2019 22:25:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39400 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfENCZb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 May 2019 22:25:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id w22so7758044pgi.6;
        Mon, 13 May 2019 19:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zi4wszV1L43AeLT0Z8PIOWy38tTYuSZF/HdHyWxecsY=;
        b=UDw1+6HdTlVp15oFELQcYeP5tV9aX4WE2CTmk/VFT9j/uRDSGzkXgwHKipfBdjUcy6
         iWd5TAVfBECyekH1/M3I65DO8JG6bsdwQiYpZPb+IvL2/NRDrhMlO6vl9tfI1DTC2n8V
         ZQObeHztzolzKrcIN2b/9VCj+OdGEtNRTQMUz8nfylBLkUKYFsgCyTvqrBD8JblWqBMs
         2ATuHVX+eMGT7vY3UOYNRORuXGhZjogeHrl6sZejHqhzP1ylwRwstzz6oGskofNicyFJ
         dU04R9JVeM7RaJ6I2pxqlhwoRSiRJyHo8rLCRYT0ThJgyxpnMnnsbjh3cJf1XWqOhld0
         Moqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zi4wszV1L43AeLT0Z8PIOWy38tTYuSZF/HdHyWxecsY=;
        b=ngkw1ElmV3Ih2+FFGHeSO/N27D7B2pFHa8h8UG75bQjbDXSyR3E3A+kFnMfN0I0bx8
         /TaRLjioTI96uLgzIl8WnzgsbiWt5w2mPmgGrSXC+Jc2Pfj+7zRjGmIEKvF0ovPINCbP
         arjb+A1qtTK2Tw+bD3wPqvY6bjLTKdHnfyrRhwr15ETqwj9vwxYRqzOINxoYqu7kZtkU
         KT+lutBEo279VbMcPIwzo+rsTRfRE/Dd3ljZ0XVjreMxPDJ8Et59e7WvMa0VKcOV0S7S
         vRc5uSqhX89OIM7dFOGoMVQMzQjCsGcXiJEFzZqGNdYgcVKlbtwU3u5O8m9YUN/x2XOn
         jxFg==
X-Gm-Message-State: APjAAAWNYCi52dqsHuQ9Foo/GAMRxUgJEReA2CcwkfOq2rUUHFKY1PWr
        Kos/+HKpAbm2TcfIqlsnsW8=
X-Google-Smtp-Source: APXvYqwA6b0Z8MgrtwzlDdj6bF9A8j85qLr4jxGimHQO5UZWJdPr+G2gpISwBf6oV7oS7hzca+w4yw==
X-Received: by 2002:a62:6d47:: with SMTP id i68mr37943522pfc.189.1557800730620;
        Mon, 13 May 2019 19:25:30 -0700 (PDT)
Received: from localhost ([39.7.55.172])
        by smtp.gmail.com with ESMTPSA id g83sm19072131pfb.158.2019.05.13.19.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 19:25:29 -0700 (PDT)
Date:   Tue, 14 May 2019 11:25:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        'christophe leroy' <christophe.leroy@c-s.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190514022526.GA6683@jagdpanzerIV>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
 <20190514020730.GA651@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514020730.GA651@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (05/14/19 11:07), Sergey Senozhatsky wrote:
> How about this:
> 
> 	if ptr < PAGE_SIZE		-> "(null)"

No, this is totally stupid. Forget about it. Sorry.


> 	if IS_ERR_VALUE(ptr)		-> "(fault)"

But Steven's "(fault)" is nice.

	-ss
