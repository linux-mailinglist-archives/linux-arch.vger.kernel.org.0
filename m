Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D8028273E
	for <lists+linux-arch@lfdr.de>; Sun,  4 Oct 2020 00:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgJCWvF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgJCWvF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 18:51:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED7C0613D0;
        Sat,  3 Oct 2020 15:51:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j8so1418150pjy.5;
        Sat, 03 Oct 2020 15:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ojz49Zt+s6mkb4TtFbOzKw4PVPVKDTdnn7U+S7XnkKE=;
        b=OZKaVM/UYxBu5IQYFDJJ1lYZNi1mqeBpf0EM+OkBKCzFSoDsVvkLVTsFcZdkMWLpoa
         2/MbzdvfuRu4DyuijQZHSjvg3vHk5pR/JQTs0UgbIdMJq0Qp/ns1YLLEEoMsVPskdTUR
         1ffqrfWrkEbWfEBtp7H9Je9yT8FnEftyQ10aKz5c0aR/KEj2sGM2uv7jnSWIz+Y/tSVU
         A8es+QWcr1YspCL4KlyahjNeA9VcUlqL7lH8+RZf+Y3E3u5Y4ZZFhKx5DlScz59lzMke
         2SPavtAOqQ3JflozKyMFxinAiJlfD1QlxMGRHzYYzlr2SCLapPXQuVl0NXL4e+tDRtVw
         GEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ojz49Zt+s6mkb4TtFbOzKw4PVPVKDTdnn7U+S7XnkKE=;
        b=f2xWbLt6l1RBmtMKNUCZ1v+H4ihddFjJQ2xWK1Zpy4JhQSFDuahJUQwWJqT/RtfmTl
         fxckTg/c7FBsHOsw3IDtVxdZ6Tuj1kIZ4ptf+skqNkNTHQl9UsJAEK8RhX5+KAEqNHrm
         OGS75Xh24b3TJ33Y6+/zRZZ3dDMo0C45hWfnb7Dy51cSprR5LJeVvzdyRPgT+ncg/IVF
         v+L6Rw+Azog535MEf5WMGJVu8y7YNrfzGZJ6Z22wvhPQC11SHMOWT/tAZo5NGpgOVzVF
         UDC+Z/V4RK+MxcpUmtZpeGsHKmmunaOtMABy4QiH/HG77Djdjyy+bitMzH8pixblgKdU
         vO7Q==
X-Gm-Message-State: AOAM532OBPf/cjgIJBDcYIxEgDZjRNHDaYiisFoi16sSA3ijCipPcbx1
        M9dY6RqGmsfiRHWQSglTfIHXLrFuJJg=
X-Google-Smtp-Source: ABdhPJxZf1jkuycgPp6N8XlRtSqJ9+E2VRUKWARZYaOO278FWhJGPEuDMzcRUUVKO7sauABIsSrSRw==
X-Received: by 2002:a17:90a:cb92:: with SMTP id a18mr1918106pju.136.1601765463152;
        Sat, 03 Oct 2020 15:51:03 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j9sm6644519pfc.175.2020.10.03.15.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2020 15:51:02 -0700 (PDT)
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <73e74c29-c804-f83c-d9a1-f8b479d0ab75@gmail.com>
Date:   Sun, 4 Oct 2020 07:50:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003171338.GA323226@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 3 Oct 2020 13:13:38 -0400, Alan Stern wrote:
> On Sun, Oct 04, 2020 at 12:16:31AM +0900, Akira Yokosawa wrote:
>> Hi Alan,
>>
>> Just a minor nit in the litmus test.
>>
>> On Sat, 3 Oct 2020 09:22:12 -0400, Alan Stern wrote:
>>> To expand on my statement about the LKMM's weakness regarding control 
>>> constructs, here is a litmus test to illustrate the issue.  You might 
>>> want to add this to one of the archives.
>>>
>>> Alan
>>>
>>> C crypto-control-data
>>> (*
>>>  * LB plus crypto-control-data plus data
>>>  *
>>>  * Expected result: allowed
>>>  *
>>>  * This is an example of OOTA and we would like it to be forbidden.
>>>  * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
>>>  * control-dependent on the preceding READ_ONCE.  But the dependencies are
>>>  * hidden by the form of the conditional control construct, hence the 
>>>  * name "crypto-control-data".  The memory model doesn't recognize them.
>>>  *)
>>>
>>> {}
>>>
>>> P0(int *x, int *y)
>>> {
>>> 	int r1;
>>>
>>> 	r1 = 1;
>>> 	if (READ_ONCE(*x) == 0)
>>> 		r1 = 0;
>>> 	WRITE_ONCE(*y, r1);
>>> }
>>>
>>> P1(int *x, int *y)
>>> {
>>> 	WRITE_ONCE(*x, READ_ONCE(*y));
>>
>> Looks like this one-liner doesn't provide data-dependency of y -> x on herd7.
> 
> You're right.  This is definitely a bug in herd7.
> 
> Luc, were you aware of this?
> 
>> When I changed P1 to
>>
>> P1(int *x, int *y)
>> {
>> 	int r1;
>>
>> 	r1 = READ_ONCE(*y);
>> 	WRITE_ONCE(*x, r1);
>> }
>>
>> and replaced the WRITE_ONCE() in P0 with smp_store_release(),
>> I got the result of:
>>
>> -----
>> Test crypto-control-data Allowed
>> States 1
>> 0:r1=0;
>> No
>> Witnesses
>> Positive: 0 Negative: 3
>> Condition exists (0:r1=1)
>> Observation crypto-control-data Never 0 3
>> Time crypto-control-data 0.01
>> Hash=9b9aebbaf945dad8183d2be0ccb88e11
>> -----
>>
>> Restoring the WRITE_ONCE() in P0, I got the result of:
>>
>> -----
>> Test crypto-control-data Allowed
>> States 2
>> 0:r1=0;
>> 0:r1=1;
>> Ok
>> Witnesses
>> Positive: 1 Negative: 4
>> Condition exists (0:r1=1)
>> Observation crypto-control-data Sometimes 1 4
>> Time crypto-control-data 0.01
>> Hash=843eaa4974cec0efae79ce3cb73a1278
>> -----
> 
> What you should have done was put smp_store_release in P0 and left P1 in 
> its original form.  That test should not be allowed, but herd7 says that 
> it is.

Yea, that was what I tried first, expecting the result of "Never".

> 
>> As this is the same as the expected result, I suppose you have missed another
>> limitation of herd7 + LKMM.
> 
> It would be more accurate to say that we all missed it.  :-)  (And it's 
> a bug in herd7, not a limitation of either herd7 or LKMM.)  How did you 
> notice it?

:-) :-) :-)

Well, I thought I had never seen a litmus test with such one-liner.
So I split the READ_ONCE() and WRITE_ONCE() into two lines and
got the expected result.

I don't expect much from herd7's C mode in the first place.
(No offense intended!)

 
>> By the way, I think this weakness on control dependency + data dependency
>> deserves an entry in tools/memory-model/Documentation/litmus-tests.txt.
>>
>> In the LIMITATIONS section, item #1 mentions some situation where
>> LKMM may not recognize possible losses of control-dependencies by
>> compiler optimizations.
>>
>> What this litmus test demonstrates is a different class of mismatch.
> 
> Yes, one in which LKMM does not recognize a genuine dependency because 
> it can't tell that some optimizations are not valid.
> 
> This flaw is fundamental to the way herd7 works.  It examines only one 
> execution at a time, and it doesn't consider the code in a conditional 
> branch while it's examining an execution where that branch wasn't taken.  
> Therefore it has no way to know that the code in the unexecuted branch 
> would prevent a certain optimization.  But the compiler does consider 
> all the code in all branches when deciding what optimizations to apply.

I see.

> 
> Here's another trivial example:
> 
> 	r1 = READ_ONCE(*x);
> 	if (r1 == 0)
> 		smp_mb();
> 	WRITE_ONCE(*y, 1);
> 
> The compiler can't move the WRITE_ONCE before the READ_ONCE or the "if" 
> statement, because it's not allowed to move shared memory accesses past 
> a memory barrier -- even if that memory barrier isn't always executed.  
> Therefore the WRITE_ONCE actually is ordered after the READ_ONCE, but 
> the memory model doesn't realize it.> 
>> Alan, can you come up with an update in this regard?
> 
> I'll write something.

Thanks!

        Akira

> 
> Alan
> 
