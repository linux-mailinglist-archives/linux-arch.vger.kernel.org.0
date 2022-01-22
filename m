Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9E496B3B
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jan 2022 10:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiAVJSR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Jan 2022 04:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiAVJSP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jan 2022 04:18:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87729C06173D;
        Sat, 22 Jan 2022 01:18:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u24so1036857eds.11;
        Sat, 22 Jan 2022 01:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pGa1w/JcNr5+C19JPD1ltZ3i6oBHm/zkLviRyQMY3Zg=;
        b=h20HOSwvJblo2l9fGhQ5FY6wn7Yv91o6AqUUM4F69oJRPq03gVw93d3iavKGCeNCpi
         WcPfQSETbx+aNJAMcU5EqaYiHYdFLwgjX0NHQ/5D6Lmz5RUm4nWD/BG8wPe0/moJjxBX
         Nh8LT5bW8Wy5jLthdDGuqX3HK8+v9aNVZ+sN/ZvM3V7LGnypGjRq5iTplVNKaEQFMPHD
         bMEGUdTqYT0ckoY5ZmOYT34qvWlOwYCEf6q8i/Ve1EZa20Y5ItQiJG97Ar2qjnHuEYiN
         9P31oaeKdUKmSRmz/Ygzwf4YyOGEgB+/ciRBdRRY7a/hJIenhPlW0NSN+34E6TipPhvP
         V+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pGa1w/JcNr5+C19JPD1ltZ3i6oBHm/zkLviRyQMY3Zg=;
        b=avYW+e1GprZ55SX+I3gvzLhKest8Htcx8eHeTDL1k03YRjdxWKVVK6i39O/9RwNP3Q
         sevDQOAhHYfgDNisycQpBHLeMtyk/+IwWir1rUEqQ+KyfPWFVdAMjdzVFANm5cWa5xYn
         EyAIXrLwNi7V5v/uo9AOwehEhWXyZiF5eyqdYwSyHng6m0PKf/vMi355+O2nq9XGLXdU
         jTGBXL/zKYJC6xbIOhyWD7iN2StjwiyYjGytbrn2n1kZQ2YbvI2jYJMc2hdl4D2RHtrM
         v9+3a6V1alEte0CB5YlNLMONvapo4quhRmTPnl5SNQF6JWwL0CUEGDr1Flv28wOfF1k3
         qgAQ==
X-Gm-Message-State: AOAM532OJwWrAsrG+IfLx6hb8hJcFaZzZKRwRNNdIPPmxgzUP20lQKPc
        lC6v519zu1d73ug2ryOG2l4=
X-Google-Smtp-Source: ABdhPJyuBYAw6WJM3rWvv22siSOxVD36q1fzNUAMVNR6nb2bzbGMW5akmGt7jRl65KH3HgEt39Hzsg==
X-Received: by 2002:a05:6402:d0e:: with SMTP id eb14mr6555396edb.81.1642843092759;
        Sat, 22 Jan 2022 01:18:12 -0800 (PST)
Received: from gmail.com (563BB7FA.dsl.pool.telekom.hu. [86.59.183.250])
        by smtp.gmail.com with ESMTPSA id cr8sm3454129edb.47.2022.01.22.01.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:12 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 22 Jan 2022 10:18:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
Message-ID: <YevL0IdQB0tVlcgf@gmail.com>
References: <Ydm7ReZWQPrbIugn@gmail.com>
 <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
 <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
 <Yd/idffvv8QIQcEU@gmail.com>
 <CAK8P3a3FahVogb3wfbXSaCpnUsRBGmO9M56M+Cay=skc9rUzjw@mail.gmail.com>
 <YegErRbP+cT42oOC@gmail.com>
 <CAK8P3a2XPwG7rP+TFdEYH7tutE7Zat5vf7PuV2idESZsrxBXyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2XPwG7rP+TFdEYH7tutE7Zat5vf7PuV2idESZsrxBXyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> > If we include comments & line-markers then the bloat goes up by another
> > ~2x:
> >
> >  kepler:~/mingo.tip.git> ./st include/linux/sched.h
> >   #include <linux/sched.h>                | LOC:  2,186 | headers:  118
> >  kepler:~/mingo.tip.git> ./st include/linux/sched.h
> >   #include <linux/sched.h>                | LOC:  4,092 | headers:    0
> 
> The metric I've been focusing on is bytes of the preprocessed header, 
> which is more sensitive to function definitions that get generated from 
> macros, and I multiply this by the number of inclusions (from scanning 
> the .file.o.cmd files). It probably helps to have a couple of metrics and 
> look at all of them occasionally to not miss something important.

Actual inclusions don't just depend on .file.o.cmd files though, that won't 
catch indirect inclusions, right?

> In the meantime, I have made some progress on reducing the headers
> for arm64, on top of your tree from Jan 8, but I have not looked at
> later changes from your side, and I need to work on this a bit more
> to ensure this doesn't break other architectures.

Sure & great!

> For an arm64 allmodconfig build, my additional improvements on top
> of yours are significant but not as good as I had hoped for, this
> can still improve I hope:
> 
> 5.16-rc8-vanilla  32640 seconds user, 3286 seconds sys
> 5.16-rc8-mingo  22990 seconds user, 2304 seconds sys
> 5.16-rc8-arnd   19007 seconds user, 1853 seconds sys

~71% build throughput speedup for allmodconfig is very impressive to me. :-)

> As my tree builds any randconfig cleanly, [...]

Yeah, same here - having a few thousand randconfig build tests is normal 
for each version:

  /* This file is auto generated, version 3288 */
  #define UTS_MACHINE "x86_64"
  #define UTS_VERSION "#3288 Fri Jan 14 18:20:14 CET 2022"

My testing is mostly concentrated on x86 - but I often test ARM64 
randconfig as well.

> I keep looking at different configs and find that this has a big impact, 
> some options end up eliminating most of the benefits until I add further 
> changes to clean up certain files. This happened with kasan, kprobes, and 
> lse-atomics for instance. After eliminating all circular includes, I was 
> also able to revisit my old script to visualize the inclusions, see[1] 
> for the current arm64 defconfig output. This version uses my arbitrary 
> metric as font-size, and uses labels for the number of inclusions.

This is really nice!

I was concentrating on optimizing a generic distro config - which doesn't 
include the tons of extreme instrumentation measures that allmodconfig 
includes but production distro kernels rarely do.

allmodconfig definitely needs more work, but 71% is a pretty good starting 
point ...

Feel free to send in patches, I can help with the testing too.

Thanks,

	Ingo
