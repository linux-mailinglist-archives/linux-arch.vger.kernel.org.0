Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD922C72AD
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgK1VuP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgK1Sw7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:52:59 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8179FC061A4F;
        Fri, 27 Nov 2020 21:57:01 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t3so5892903pgi.11;
        Fri, 27 Nov 2020 21:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9pljJYqBFFJMT23aRvOkmjosrfPaZRUoII94EEjK9qU=;
        b=pAWIgWzJiDXbACtUw0Rf9V31klbqZp0donc49T3DevUTgr5yZc7iqIvDFEwKYQ19yX
         YzR6RuMRHh/QbKr75FfabgQCEuRWVuYDyMXcsJaHZ9bm6HrGaZuPDO9pw7UWKR4n6tDm
         fXg/8UpA3r6drmwFG5YN7M0kk6TDwLaVQ8j6IqnUqhvRQICO9/XSElMRefZKgYnFLxsq
         4UdGXA8XtmKglxID6DMAtZuulzWC7KD5+bd7Lcbo+q1LleNMFOBE2brIQRZSnhL2jz4s
         7ozmachgSuSCf4E5p1X9njmjDhVSiesKbXHXfVW51ZbpXRjalYE+Ywbd3ETl5b7A8Of1
         7P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9pljJYqBFFJMT23aRvOkmjosrfPaZRUoII94EEjK9qU=;
        b=eQrBrVL8QMoXzuivbWVaC1jTAmh4vH2XPLGt67h9Ojqs6veFDwV7NRwpD/OQydBeF9
         WWRpt0I6pI9ucPXH2iOdP5NI+8SsPZ9icgYg9Z7/ZyijaS/MG7QEbX6rubntm5bB+4tA
         L7AlzoepWqLrzWBrDFipr4n1iliK1b3vSRAS00bxBee/uF7bfcFvtknEMZ1WppP+fyH5
         luZ32SXyeUS0G9waC+lO8LhmzsXqL2YrSIfqMvsZr50uTQvWpS1xyyoW6OBSXaw+4G3n
         znjTwP8F5cbqBA2KLCjU9j8jxe/UCh9Kl4xB8gQrP9LtP3OBTvOnYoL9jgpXYT4Ked2m
         8bKQ==
X-Gm-Message-State: AOAM531f1slpq8YO3ZK/VEdqANfsJaspVuitMGEJNcWeQY/CaLDjIreg
        xAK8Y1vzG4gfvFbLLBSF/xU=
X-Google-Smtp-Source: ABdhPJzalDvif4YtaXVkhN9LAKKZUXXwCXAnRSqCKLQYo2zGE3B4VQsH2gjUeE+MBVvy3uCxJ8WVtw==
X-Received: by 2002:a17:90b:1811:: with SMTP id lw17mr14391926pjb.105.1606543020911;
        Fri, 27 Nov 2020 21:57:00 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i10sm9550637pfk.206.2020.11.27.21.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 21:57:00 -0800 (PST)
Subject: Re: [PATCH memory-model 6/8] tools/memory-model: Add types to litmus
 tests
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-6-paulmck@kernel.org>
 <12e0baf4-b1c9-d674-1d4c-310e0a9b6343@gmail.com>
 <20201105225605.GQ3249@paulmck-ThinkPad-P72>
 <2acf8de5-efe9-a205-cb62-04c4774008c0@gmail.com>
 <20201127154652.GU1437@paulmck-ThinkPad-P72>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <78e1ccaf-9d35-b2a5-1865-fb0a76b3e57e@gmail.com>
Date:   Sat, 28 Nov 2020 14:56:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201127154652.GU1437@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 27 Nov 2020 07:46:52 -0800, Paul E. McKenney wrote:
> On Wed, Nov 25, 2020 at 08:34:47PM +0900, Akira Yokosawa wrote:
[...]
>> Hi Paul,
>>
>> I'm seeing this patch still alive in the updated for-mingo-lkmm branch.
>> Have you got some objection?
> 
> From git, which was not able to trivially revert.

;-) ;-)

>                                                   If you send me a
> patch on top that removes the uneeded declarations and if someone
> tests it with a klitmus run, I will take it for the merge window
> following the upcoming one.

Got it!
I'm submitting a patch set in reply to this mail.

1/2 is the removal of those redundant type declarations.
2/2 is an obvious fix of typo I made in the klitmus7 compat table.

        Thanks, Akira

> 
> 							Thanx, Paul
> 
>>         Thanks, Akira
>>

