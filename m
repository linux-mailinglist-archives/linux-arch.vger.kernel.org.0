Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD8282090
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 04:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgJCCgU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgJCCgT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Oct 2020 22:36:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED3C0613D0
        for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2020 19:36:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so4349928qtp.13
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2020 19:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qMmWF6ubbtV92w199K+3UInTe5FQZJe6gLAHz49PtPo=;
        b=hgtENHPHkh6zTxcjGbJwuue7p57lIA8ne9nOJ1+/l6pP7Zcl6TJqSOv28eF1SDxvGc
         LOSH4nWYb2h9hSO6fPFS6g5rasN7bByaO6G6K/ZGw3XJQWFk5ZANfVTE37q0qHuqy/YM
         vJH/YrYTz/ixZ+s7ijdactefIJ6fuHxMpSNTquWRLOrOEzKv2kL/+vhcVd2RV+i6FeiL
         oECIQD3M8o7VPBRt3Gllq7t90m9lvSoIIGIedLW4bA344IvlxIiURTPfpMrl5CbO5o7t
         X7ecq/K9tunmN2mighMN2KPioNXZuQ5mbE30U60dZVYQOI/rQ59lLQBuHkKd2v0gUi3O
         CjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qMmWF6ubbtV92w199K+3UInTe5FQZJe6gLAHz49PtPo=;
        b=BWCbbwZ/jbWfRD6GMAHn6BWsRFcORKn0qDuPamS3F+fu/SUZ0Ocrtts+SZ0OGKcVyN
         FkMycPvxIEQpGAfW6pqhhOjiqz4KO92/a9MEdU13I67Hn5nJz7uneQxkYQZ26l1dlt9A
         3o/ZUTM5eyCCm8u9pK1x4NKi9cIRPSj2E0LXejLK8r6GidMFI06Z2AMxsHb9u1PZoB4/
         lH6Lfewua2bj9jASgaRCcDnsOY/IU2XBYVfbf1Eif7w9qyP+w5z6feOhjFVw5/UwtOT2
         KaVMTyLYoW3qt6f3t2HfCoI+1/7MmeC/aLXzPYZeYczJgeT1fHmBl9IhaoAUbVfmsbjA
         W+/w==
X-Gm-Message-State: AOAM533uXFBIPjVDWLqc7oVqMx0B73HCW3YSIumEi+Qo1XnamQ6V3Zje
        Zhp8wnJNb7KsrRFsQxO/SWX/mYnCcF2tlXp/Zyw=
X-Google-Smtp-Source: ABdhPJx6XKrmxmn9ZlBAljfHP0pP+/JKsDRxA0KCLSnuk0rE/oe+59Oh8fyJKbF3HtrelUDipbsYeg==
X-Received: by 2002:ac8:3fd4:: with SMTP id v20mr5104744qtk.210.1601692577156;
        Fri, 02 Oct 2020 19:36:17 -0700 (PDT)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id e1sm2547440qtb.0.2020.10.02.19.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 19:36:16 -0700 (PDT)
Subject: Re: Litmus test for question from Al Viro
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <17935342-e927-284c-9a2b-ca75dd2398ad@jonmasters.org>
Date:   Fri, 2 Oct 2020 22:35:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201001161529.GA251468@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/1/20 12:15 PM, Alan Stern wrote:
> On Wed, Sep 30, 2020 at 09:51:16PM -0700, Paul E. McKenney wrote:
>> Hello!
>>
>> Al Viro posted the following query:
>>
>> ------------------------------------------------------------------------
>>
>> <viro> fun question regarding barriers, if you have time for that
>> <viro>         V->A = V->B = 1;
>> <viro>
>> <viro> CPU1:
>> <viro>         to_free = NULL
>> <viro>         spin_lock(&LOCK)
>> <viro>         if (!smp_load_acquire(&V->B))
>> <viro>                 to_free = V
>> <viro>         V->A = 0
>> <viro>         spin_unlock(&LOCK)
>> <viro>         kfree(to_free)
>> <viro>
>> <viro> CPU2:
>> <viro>         to_free = V;
>> <viro>         if (READ_ONCE(V->A)) {
>> <viro>                 spin_lock(&LOCK)
>> <viro>                 if (V->A)
>> <viro>                         to_free = NULL
>> <viro>                 smp_store_release(&V->B, 0);
>> <viro>                 spin_unlock(&LOCK)
>> <viro>         }
>> <viro>         kfree(to_free);
>> <viro> 1) is it guaranteed that V will be freed exactly once and that
>> 	  no accesses to *V will happen after freeing it?
>> <viro> 2) do we need smp_store_release() there?  I.e. will anything
>> 	  break if it's replaced with plain V->B = 0?
> 
> Here are my answers to Al's questions:
> 
> 1) It is guaranteed that V will be freed exactly once.  It is not
> guaranteed that no accesses to *V will occur after it is freed, because
> the test contains a data race.  CPU1's plain "V->A = 0" write races with
> CPU2's READ_ONCE; if the plain write were replaced with
> "WRITE_ONCE(V->A, 0)" then the guarantee would hold.  Equally well,
> CPU1's smp_load_acquire could be replaced with a plain read while the
> plain write is replaced with smp_store_release.
> 
> 2) The smp_store_release in CPU2 is not needed.  Replacing it with a
> plain V->B = 0 will not break anything.

This was my interpretation also. I made the mistake of reading this 
right before trying to go to bed the other night and ended up tweeting 
at Paul that I'd regret it if he gave me scary dreams. Thought about it 
and read your write up and it is still exactly how I see it.

Jon.

-- 
Computer Architect
