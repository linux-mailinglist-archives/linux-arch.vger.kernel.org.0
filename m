Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7AE3B55C4
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 01:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhF0XC0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Jun 2021 19:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhF0XC0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Jun 2021 19:02:26 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C3C061574;
        Sun, 27 Jun 2021 16:00:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e22so13735842pgv.10;
        Sun, 27 Jun 2021 16:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oObwvXsaqAUb8vB6GzYedHdtF/WzC8DIfOegRYh4rG0=;
        b=JDL39NDUlYiMBJb05P0yCWBqka4BZu9M034XP0rS24lT7mC1/+6Bw7ZJXTU+AG6o8M
         RNaOpJ1TaN1Cw7Xa+URDriIEFX6eK3YfA4pRlrQKAf7FcAPbE6QVbcrZdf112ya9IfIR
         9A0jlmgONyxJgsH19758eWPXScyJCCK7nQ5UJXXw6LSFD4SlpY5NZDwjwkbiylTmOUKl
         95+ELqsdWyUdc+A9eQ61PlfMibeJELEdciMmKIJ2QPBvZ/H+F+s73NQcvdmkoZEjpSbj
         qJr//yVEMeRnbrzxKzZIxksmMkz4doZDdDWS5Qt/QJMxanzgZVtvjHRpfzH+m+J3T/yx
         S6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oObwvXsaqAUb8vB6GzYedHdtF/WzC8DIfOegRYh4rG0=;
        b=cjcSLvN74CmTeFndnWivKx5oFgBPiXOJ7jnwyl62kSCHxZKhX7S7J9+wUzxsSa8fZ5
         fnJX4yYnR3lqKMV78tXtQzPsukWa8u3BI7q67Pb3Zj0GqkeCNgmsaLBWQzu0TV6to72F
         ODYHzGV39SARIN8l47e9AGV4e+yp8CxAI+x/cRCO55tmxCytmTzLmn6RnmyPPXx68h++
         ojdfF6CsAB3WKIvA7oY7kKuz36PQfNJ990RsEFFKpf65LnS78vrs1A2QfO0FHcdtfHr4
         7lQvWENfH4onNVNRZZNHCLXcsMVPYHGO2OZ1yu0U/W1ERLAaH5hZa0k3ssNc6BEnWAue
         NRnw==
X-Gm-Message-State: AOAM532tmQNlwWAw6+FmOXLeVXEpAncCTWDcw7swpv+IdFhy95XrMajR
        Aa0fqovkTxFX/HwR2XTtyOc=
X-Google-Smtp-Source: ABdhPJzcHQPh4e+dugJRImDobQenA34an/On5VmG4UE2Be3WljLZZBLB0S4hUWgVr8QL2V05Wa7jPQ==
X-Received: by 2002:a63:171e:: with SMTP id x30mr20899976pgl.368.1624834800983;
        Sun, 27 Jun 2021 16:00:00 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:34c6:84ea:412f:b792? ([2001:df0:0:200c:34c6:84ea:412f:b792])
        by smtp.gmail.com with ESMTPSA id c24sm10061304pfn.86.2021.06.27.15.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 16:00:00 -0700 (PDT)
Subject: Re: [PATCH 0/9] Refactoring exit
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133>
 <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133>
 <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
 <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
Date:   Mon, 28 Jun 2021 10:59:51 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 28/06/21 10:13 am, Al Viro wrote:

> On Thu, Jun 24, 2021 at 10:45:23PM +0000, Al Viro wrote:
>
>> 13) there's bdflush(1, whatever), which is equivalent to exit(0).
>> IMO it's long past the time to simply remove the sucker.
> Incidentally, calling that from ptraced process on alpha leads to
> the same headache for tracer.  _If_ we leave it around, this is
> another candidate for "hit yourself with that special signal" -
> both alpha and m68k have that syscall, and IMO adding an asm
> wrapper for that one is over the top.
>
> Said that, we really ought to bury that thing:
>
> commit 2f268ee88abb33968501a44368db55c63adaad40
> Author: Andrew Morton <akpm@digeo.com>
> Date:   Sat Dec 14 03:16:29 2002 -0800
>
>      [PATCH] deprecate use of bdflush()
> 	
>      Patch from Robert Love <rml@tech9.net>
> 		
>      We can never get rid of it if we do not deprecate it - so do so and
>      print a stern warning to those who still run bdflush daemons.
>
> Deprecated for 18.5 years by now - I seriously suspect that we have
> some contributors younger than that...

Haven't found that warning in over 7 years' worth of console logs, and 
I'm a good candidate for running the oldest userland in existence for m68k.

Time to let it go.

Cheers,

     Michael


