Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837A42C3F2A
	for <lists+linux-arch@lfdr.de>; Wed, 25 Nov 2020 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgKYLfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Nov 2020 06:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgKYLfI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Nov 2020 06:35:08 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E201C0613D4;
        Wed, 25 Nov 2020 03:34:55 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so2178034pgg.13;
        Wed, 25 Nov 2020 03:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HA2I20xKBkjo5X/zoMlwNqCRuZAlFMNaMasPdgcRlNQ=;
        b=WZeRpq/wZIHaKf/qnSsukUDP51gXNA1a5lQ0KeufZX6FUbfsNWVxXCaWX5Dv+TRLvw
         tHj8DsWanhor7py0K0Alk905X+4l8OJ6gMH0X/rSQDW15EfqmNB6O/AgreOGOeR7JuxR
         6x/2W/AAlSfX6DNoetCmlwCHSwJIRX9w5mORxUgnxEF8acCuspztMo2yCOiHjuTvUX6v
         R7Cre/4umBGVP64o8qYzsLZ83kZX3FguX3siQviPDSpPbnZRL9+rp+44adDfpRSUH+Wj
         8PBfcP/xtyIg7T+hXJCOmEPTOZvhiw8l2ihWFipVVGZova2L8t8qpFlukK4vS0K3ghqq
         EMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HA2I20xKBkjo5X/zoMlwNqCRuZAlFMNaMasPdgcRlNQ=;
        b=cHtJEZ+BpXLS731sOmGP2SPR4S7kDgeP9yFbvDpPZeoN41NWiTy8F00u0vG/JkoP0w
         Lf9CYwbXo90Cy/i1TWZit4yZaMoNloRoUDIyNIlaq3i0Q0IRs85QdtWvhP54IItERQ2o
         Npy87P4gJxC9Li5I/GyIMt2fq4Rz8fXzCRYTGgYg9M3mgX/jgjSFv5NOHXKxBdRkrdhz
         TMz0kbwKU/q1oG9MEEETH8yN6HzU+So3fH+EcbKuA4dmGY2Kvl1iPNeuFs5hD+kpyEFX
         qHpYisvRptrr/Y8kpUtmZwDNgebdMUZTI+59VyzEgm8soIrSRS9GXVMYp+/V0biiflDY
         n3MA==
X-Gm-Message-State: AOAM5327zOjim3I7nkZVk/a/bMCp8WTGR6VZEnCUisHXsniGZ8F1AHJI
        i8u/sHGD5Ba/ZRkMhhiIH2U=
X-Google-Smtp-Source: ABdhPJzpSvFy+r6AUAXhOHHbjN/2lOnAGFv65pPygJszvdrAfDSGFUukaHc4uE4N0iHuesaj+b/vZg==
X-Received: by 2002:a17:90a:1746:: with SMTP id 6mr3768096pjm.104.1606304094852;
        Wed, 25 Nov 2020 03:34:54 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w66sm1965327pff.171.2020.11.25.03.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 03:34:54 -0800 (PST)
Subject: Re: [PATCH memory-model 6/8] tools/memory-model: Add types to litmus
 tests
To:     paulmck@kernel.org
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
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <2acf8de5-efe9-a205-cb62-04c4774008c0@gmail.com>
Date:   Wed, 25 Nov 2020 20:34:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105225605.GQ3249@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 5 Nov 2020 14:56:05 -0800, Paul E. McKenney wrote:
> On Fri, Nov 06, 2020 at 07:41:48AM +0900, Akira Yokosawa wrote:
>> Hi Paul,
>>
>> On 2020/11/06 7:00, paulmck@kernel.org wrote:
>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>>>
>>> This commit adds type information for global variables in the litmus
>>> tests in order to allow easier use with klitmus7.
>>
>> IIUC, klitmus7 is happy with existing litmus tests under tools/memory-model.
>> So I don't think this change is necessary.
>>
>> As a matter of fact, I was preparing a patch set to empty most of the
>> initialization blocks in perfbook's CodeSamples/formal/ litmus tests.
> 
> Heh!  Someone asked for this change several months back, and I failed
> to record who it was.  If they don't object, I will remove this patch.

Hi Paul,

I'm seeing this patch still alive in the updated for-mingo-lkmm branch.
Have you got some objection?

        Thanks, Akira

> 
> 							Thanx, Paul
> 
>>>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>  tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus        | 4 +++-
>>>  tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus        | 4 +++-
>>>  tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus        | 4 +++-
>>>  tools/memory-model/litmus-tests/CoWW+poonceonce.litmus             | 4 +++-
>>>  .../litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus             | 5 ++++-
>>>  tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus   | 5 ++++-
>>>  .../litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus        | 7 ++++++-
>>>  tools/memory-model/litmus-tests/ISA2+poonceonces.litmus            | 6 +++++-
>>>  .../ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus       | 6 +++++-
>>>  .../litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus            | 5 ++++-
>>>  .../litmus-tests/LB+poacquireonce+pooncerelease.litmus             | 5 ++++-
>>>  tools/memory-model/litmus-tests/LB+poonceonces.litmus              | 5 ++++-
>>>  .../litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus       | 5 ++++-
>>>  tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus     | 5 +++--
>>>  .../litmus-tests/MP+polockmbonce+poacquiresilsil.litmus            | 2 ++
>>>  .../memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus | 2 ++
>>>  tools/memory-model/litmus-tests/MP+polocks.litmus                  | 6 +++++-
>>>  tools/memory-model/litmus-tests/MP+poonceonces.litmus              | 5 ++++-
>>>  .../litmus-tests/MP+pooncerelease+poacquireonce.litmus             | 5 ++++-
>>>  tools/memory-model/litmus-tests/MP+porevlocks.litmus               | 6 +++++-
>>>  tools/memory-model/litmus-tests/R+fencembonceonces.litmus          | 5 ++++-
>>>  tools/memory-model/litmus-tests/R+poonceonces.litmus               | 5 ++++-
>>>  .../litmus-tests/S+fencewmbonceonce+poacquireonce.litmus           | 5 ++++-
>>>  tools/memory-model/litmus-tests/S+poonceonces.litmus               | 5 ++++-
>>>  tools/memory-model/litmus-tests/SB+fencembonceonces.litmus         | 5 ++++-
>>>  tools/memory-model/litmus-tests/SB+poonceonces.litmus              | 5 ++++-
>>>  tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus  | 5 ++++-
>>>  tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus        | 5 ++++-
>>>  .../litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus    | 5 ++++-
>>>  .../litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus        | 7 ++++++-
>>>  .../litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus        | 7 ++++++-
>>>  .../Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus     | 6 +++++-
>>>  32 files changed, 130 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
>>> index 967f9f2..772544f 100644
>>> --- a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
>>> +++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
>>> @@ -7,7 +7,9 @@ C CoRR+poonceonce+Once
>>>   * reads from the same variable are ordered.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +}
>>>  
>>>  P0(int *x)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
>>> index 4635739..5faae98 100644
>>> --- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
>>> +++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
>>> @@ -7,7 +7,9 @@ C CoRW+poonceonce+Once
>>>   * a given variable and a later write to that same variable are ordered.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +}
>>>  
>>>  P0(int *x)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
>>> index bb068c9..77c9cc9 100644
>>> --- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
>>> +++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
>>> @@ -7,7 +7,9 @@ C CoWR+poonceonce+Once
>>>   * given variable and a later read from that same variable are ordered.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +}
>>>  
>>>  P0(int *x)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
>>> index 0d9f0a9..85ef746 100644
>>> --- a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
>>> @@ -7,7 +7,9 @@ C CoWW+poonceonce
>>>   * writes to the same variable are ordered.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +}
>>>  
>>>  P0(int *x)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
>>> index e729d27..87aa900 100644
>>> --- a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
>>> +++ b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
>>> @@ -10,7 +10,10 @@ C IRIW+fencembonceonces+OnceOnce
>>>   * process?  This litmus test exercises LKMM's "propagation" rule.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
>>> index 4b54dd6..f84022d 100644
>>> --- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
>>> +++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
>>> @@ -10,7 +10,10 @@ C IRIW+poonceonces+OnceOnce
>>>   * different process?
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
>>> index 094d58d..398f624 100644
>>> --- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
>>> @@ -7,7 +7,12 @@ C ISA2+pooncelock+pooncelock+pombonce
>>>   * (in P0() and P1()) is visible to external process P2().
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	spinlock_t mylock;
>>> +	int x;
>>> +	int y;
>>> +	int z;
>>> +}
>>>  
>>>  P0(int *x, int *y, spinlock_t *mylock)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
>>> index b321aa6..212a432 100644
>>> --- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
>>> @@ -9,7 +9,11 @@ C ISA2+poonceonces
>>>   * of the smp_load_acquire() invocations are replaced by READ_ONCE()?
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +	int z;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
>>> index 025b046..7afd856 100644
>>> --- a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
>>> @@ -11,7 +11,11 @@ C ISA2+pooncerelease+poacquirerelease+poacquireonce
>>>   * (AKA non-rf) link, so release-acquire is all that is needed.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +	int z;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
>>> index 4727f5a..c8a93c7 100644
>>> --- a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
>>> @@ -11,7 +11,10 @@ C LB+fencembonceonce+ctrlonceonce
>>>   * another control dependency and order would still be maintained.)
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
>>> index 07b9904..2fa0295 100644
>>> --- a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
>>> +++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
>>> @@ -8,7 +8,10 @@ C LB+poacquireonce+pooncerelease
>>>   * to the other?
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
>>> index 74c49cb..2107306 100644
>>> --- a/tools/memory-model/litmus-tests/LB+poonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
>>> @@ -7,7 +7,10 @@ C LB+poonceonces
>>>   * be prevented even with no explicit ordering?
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
>>> index a273da9..e04b71b 100644
>>> --- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
>>> @@ -8,7 +8,10 @@ C MP+fencewmbonceonce+fencermbonceonce
>>>   * is usually better to use smp_store_release() and smp_load_acquire().
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
>>> index 97731b4..18df682 100644
>>> --- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
>>> @@ -10,8 +10,9 @@ C MP+onceassign+derefonce
>>>   *)
>>>  
>>>  {
>>> -y=z;
>>> -z=0;
>>> +	int x;
>>> +	int *y=z;
>>> +	int z=0;
>>>  }
>>>  
>>>  P0(int *x, int **y)
>>> diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
>>> index 50f4d62..b1b1266 100644
>>> --- a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
>>> +++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
>>> @@ -11,6 +11,8 @@ C MP+polockmbonce+poacquiresilsil
>>>   *)
>>>  
>>>  {
>>> +	spinlock_t lo;
>>> +	int x;
>>>  }
>>>  
>>>  P0(spinlock_t *lo, int *x)
>>> diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
>>> index abf81e7..867c75d 100644
>>> --- a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
>>> +++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
>>> @@ -11,6 +11,8 @@ C MP+polockonce+poacquiresilsil
>>>   *)
>>>  
>>>  {
>>> +	spinlock_t lo;
>>> +	int x;
>>>  }
>>>  
>>>  P0(spinlock_t *lo, int *x)
>>> diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
>>> index 712a4fcd..63e0f67 100644
>>> --- a/tools/memory-model/litmus-tests/MP+polocks.litmus
>>> +++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
>>> @@ -11,7 +11,11 @@ C MP+polocks
>>>   * to see all prior accesses by those other CPUs.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	spinlock_t mylock;
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y, spinlock_t *mylock)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
>>> index 172f014..68180a4 100644
>>> --- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
>>> @@ -7,7 +7,10 @@ C MP+poonceonces
>>>   * no ordering at all?
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
>>> index d52c684..19f3e68 100644
>>> --- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
>>> @@ -8,7 +8,10 @@ C MP+pooncerelease+poacquireonce
>>>   * pattern.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
>>> index 72c9276..4ac189a 100644
>>> --- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
>>> +++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
>>> @@ -11,7 +11,11 @@ C MP+porevlocks
>>>   * see all prior accesses by those other CPUs.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	spinlock_t mylock;
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y, spinlock_t *mylock)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
>>> index 222a0b8..af9463b 100644
>>> --- a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
>>> @@ -9,7 +9,10 @@ C R+fencembonceonces
>>>   * cause the resulting test to be allowed.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
>>> index 5386f12..bcd5574e 100644
>>> --- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
>>> @@ -8,7 +8,10 @@ C R+poonceonces
>>>   * store propagation delays.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
>>> index 1847982..c36341d 100644
>>> --- a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
>>> @@ -7,7 +7,10 @@ C S+fencewmbonceonce+poacquireonce
>>>   * store against a subsequent store?
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
>>> index 8c9c2f8..7775c23 100644
>>> --- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
>>> @@ -9,7 +9,10 @@ C S+poonceonces
>>>   * READ_ONCE(), is ordering preserved?
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
>>> index ed5fff1..833cdfe 100644
>>> --- a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
>>> @@ -9,7 +9,10 @@ C SB+fencembonceonces
>>>   * suffice, but not much else.)
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
>>> index 10d5507..c92211e 100644
>>> --- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
>>> @@ -8,7 +8,10 @@ C SB+poonceonces
>>>   * variable that the preceding process reads.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
>>> index 04a1660..84344b4 100644
>>> --- a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
>>> +++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
>>> @@ -6,7 +6,10 @@ C SB+rfionceonce-poonceonces
>>>   * This litmus test demonstrates that LKMM is not fully multicopy atomic.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
>>> index 6a2bc12..4314947 100644
>>> --- a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
>>> +++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
>>> @@ -8,7 +8,10 @@ C WRC+poonceonces+Once
>>>   * test has no ordering at all.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
>>> index e994725..554999c 100644
>>> --- a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
>>> +++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
>>> @@ -10,7 +10,10 @@ C WRC+pooncerelease+fencermbonceonce+Once
>>>   * is A-cumulative in LKMM.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +}
>>>  
>>>  P0(int *x)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
>>> index 415248f..265a95f 100644
>>> --- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
>>> @@ -9,7 +9,12 @@ C Z6.0+pooncelock+poonceLock+pombonce
>>>   * by CPUs not holding that lock.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	spinlock_t mylock;
>>> +	int x;
>>> +	int y;
>>> +	int z;
>>> +}
>>>  
>>>  P0(int *x, int *y, spinlock_t *mylock)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
>>> index 10a2aa0..0c9aea8 100644
>>> --- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
>>> @@ -8,7 +8,12 @@ C Z6.0+pooncelock+pooncelock+pombonce
>>>   * seen as ordered by a third process not holding that lock.
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	spinlock_t mylock;
>>> +	int x;
>>> +	int y;
>>> +	int z;
>>> +}
>>>  
>>>  P0(int *x, int *y, spinlock_t *mylock)
>>>  {
>>> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
>>> index 88e70b8..661f9aa 100644
>>> --- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
>>> +++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
>>> @@ -14,7 +14,11 @@ C Z6.0+pooncerelease+poacquirerelease+fencembonceonce
>>>   * involving locking.)
>>>   *)
>>>  
>>> -{}
>>> +{
>>> +	int x;
>>> +	int y;
>>> +	int z;
>>> +}
>>>  
>>>  P0(int *x, int *y)
>>>  {
>>>
