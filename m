Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5C0493A4B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jan 2022 13:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbiASMbq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jan 2022 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiASMbq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2022 07:31:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D36C061574;
        Wed, 19 Jan 2022 04:31:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id p12so10406588edq.9;
        Wed, 19 Jan 2022 04:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cart7+xdbC9Wk/XNJI6gWqPHuAafijktc2+SQt11tWM=;
        b=CxRWZSeKB4Zuz0VG9PkxoTpXop87diAvrviV55D0/OFfJ7W7PE7ZWrOotbHjuDSvhS
         kUKrEFLFufOKW4p3QS6sxtLt1wo+lEi8gRNLymD7NeAMb5BrIE4kPw605iy5/zPGo/dd
         ldbLL0HG3+cbGhMRiyaeoZkZw0upR/ZAVE2vhzHRZb+plcdgGRM1hESBrOREbfqxhH9D
         aMMlar47sbHHfGd3SO2aq/j/CkhrmdoPRuHHO5d1CeBjD0/WLH/AedoQ/ETeVxZhZAeg
         lxNz13Zd/rzfGdQjqRNpRlAmBPuS44epfVZhwLcsLTcu2zUHThb1+LE6byOdB0osUnDd
         ckuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cart7+xdbC9Wk/XNJI6gWqPHuAafijktc2+SQt11tWM=;
        b=Wqqb9nwnJ75MERdZqqM764y2ITycAudwpBISxdKY7wjEWG33Btx0De2R1/H+e6mH8E
         lfnBMzlspNiaYQYJFBvtufytrlzsM8pLNGDrKzQ5OpuOzjnOHwUbfwiY60RpD+rxU3zn
         cHSBSZ3yQ7mUP8jCuydmbn2iKT2AwFa1loRrRx6IMoAJMRXMGEobj1fvj8xKNkqct4+L
         udRQ6mNTme8dWYgjyBmjystBKfQqMFggi+RNkqW3vfa8vECAQuI/4wqNNVkIF2EWHDgj
         IoNwTOlWNtMOAH75Alw4pjZf9wOLneG82CzsnkixqWjW5fsVUQKwLmsXZsRs5+dKtnsV
         bS8w==
X-Gm-Message-State: AOAM532M7wtU+J4iQ/EacsRWXd6KKlJBGYJtOHn5GNsjuwiT+3UlLMpo
        2iE/Y41WZFO+8hlevLQqmkbyQWFIPglwfA==
X-Google-Smtp-Source: ABdhPJxTSOvvr82F5EeTmdDfNroEDGRfI2M3XpoMX6XJfJUUd4oxpWqLMGMOrpdJmn2M4faKhrP16A==
X-Received: by 2002:a17:906:dc95:: with SMTP id cs21mr15082558ejc.709.1642595504081;
        Wed, 19 Jan 2022 04:31:44 -0800 (PST)
Received: from gmail.com (563BB7FA.dsl.pool.telekom.hu. [86.59.183.250])
        by smtp.gmail.com with ESMTPSA id f16sm1173877eds.6.2022.01.19.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:31:43 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 19 Jan 2022 13:31:41 +0100
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
Message-ID: <YegErRbP+cT42oOC@gmail.com>
References: <Ydm7ReZWQPrbIugn@gmail.com>
 <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
 <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
 <Yd/idffvv8QIQcEU@gmail.com>
 <CAK8P3a3FahVogb3wfbXSaCpnUsRBGmO9M56M+Cay=skc9rUzjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3FahVogb3wfbXSaCpnUsRBGmO9M56M+Cay=skc9rUzjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> > I tried to avoid as many low level headers as possible from the main 
> > types headers - and the get_order() functionality also brings in bitops 
> > definitions, which I'm still hoping to be able to reduce from its 
> > current ~95% utilization in a distro kernel ...
> 
> Agreed, I think reducing bitops.h and atomic.h usage is fairly important, 
> I think these are even bigger on arm64 than on x86.

So what I'm using for 'header complexity metrics' is rather simple: passing 
-P -H to the preprocessor: stripping comments & not generating 
line-markers, and then counting linecount.

Line-markers should *probably* remain, because the real build is generating 
them too - but I wanted to gain a crude & easily available metric to 
measure 'first-pass parsing complexity'. That's I think where most of the 
header bloat is concentrated: later passes don't really get any of the 
unused header definitions passed along. (But maybe this is an invalid 
assumption, because compiler warnings do get generated by later passes, and 
they are generated for mostly-unused header inlines too.)

If we include comments & line-markers then the bloat goes up by another 
~2x:

 kepler:~/mingo.tip.git> ./st include/linux/sched.h 
  #include <linux/sched.h>                | LOC:  2,186 | headers:  118
 kepler:~/mingo.tip.git> ./st include/linux/sched.h 
  #include <linux/sched.h>                | LOC:  4,092 | headers:    0


> > We could add <linux/page_api.h> as well, as a standardized header. We 
> > already have page_types.h and et_order() is a page types API.
> 
> More generally speaking, do you have a plan for how to document which 
> header to include for getting a particular symbol that is provided by a 
> header we don't want to include directly? I think iwyu has a particular 
> notation for it, but when I looked at using that in 2020 I decided it 
> wouldn't scale to the size of the kernel. I did my own shell script with 
> a long list of regex patterns, but I'm not convinced about that approach 
> either.

Yeah, I don't think we should do much that hurts general usability of 
headers: each symbol has a primary "natural" header, and .c code and other 
headers are encouraged but not strictly required to include that.

Thanks,

	Ingo
