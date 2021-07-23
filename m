Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA763D34D8
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhGWGMV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 02:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhGWGMU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 02:12:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D293C061575
        for <linux-arch@vger.kernel.org>; Thu, 22 Jul 2021 23:52:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 9-20020a05600c26c9b02901e44e9caa2aso957520wmv.4
        for <linux-arch@vger.kernel.org>; Thu, 22 Jul 2021 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ya9He3mx+An+H38g4cAl4dPts2pG7l+SCmDziNdLGEs=;
        b=K7BNHZvkbpI4ObAoYJCPjTiyeTupZsbfXqqy18slasuejtC6liOlPJ6R/nKdJL6+O+
         sBadQhK9t1+7voDdPSpRW+vU9Fn8e4VGJs8gyDvdVaxJw6frbzV5LVaZRzyy0o5jiU/p
         tU1lnYsRjOurKvMo8gezHPxxx26LNKUZZCLoSYcOtQasone0o/nBplzzP9EWvLYUh2aX
         ayTIZgEF84h9pL1xktIi0Fk0X5opexpzrYIACyB1CBugo1ZNaajol8aP4uwDwWEFp539
         VGrViJm6tTAo3Wugl8lNBLtsNNC0uBY7mcigR3M4NBDWzENe82N5cqYrfA2sfs1eR8ip
         jLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ya9He3mx+An+H38g4cAl4dPts2pG7l+SCmDziNdLGEs=;
        b=crnAV+scQRAuZkJBPqRSuIa9t2HlZ/zVm/RfafdTPnSeuzfhiesDNfCBQ7kwefPM7K
         xGYU5hiUxyrj7uqOVej9TI9wr6PO1tJUgIrwgqMvtCW4paWEU9TS1piPh8zk6Kh+YUeA
         Xyrqza/PFQaZojZffHFPND5yGgw0x8lDLb4W7f8q4+ftGv2jtnlfncmTsDQVmWzYTQHV
         ijSRAUyqYMz6NkUP8EQVS4lBXp67qCZppg2OyQiFPVOzoxTgvxBpgtelEOwv2K57Z4gl
         8MHY4+N/22q+iuHxLnrO/Sbn5rHgYct+0z3x/4EOaFT2O8Vu10GdZ9BD5A1TufMB/dH+
         tPSw==
X-Gm-Message-State: AOAM533jTfNOSprq7mEsVZJApDasUufJNTSpznrQbB67K+qKVsgc190A
        6SXjXmrt5c9D5+n2J8m7V5CksQ==
X-Google-Smtp-Source: ABdhPJwbn1Fmn5Kv6/nTg6stKWf5mYcYve8PSphU/nVpcw1z69gxKcVuivQo+691wgUQvxPn/b/CQQ==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr12402603wmo.91.1627023172935;
        Thu, 22 Jul 2021 23:52:52 -0700 (PDT)
Received: from localhost.localdomain (p200300d997074400a6b220f1eb1d11cd.dip0.t-ipconnect.de. [2003:d9:9707:4400:a6b2:20f1:eb1d:11cd])
        by smtp.googlemail.com with ESMTPSA id l2sm24496706wms.21.2021.07.22.23.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 23:52:52 -0700 (PDT)
Subject: Re: [PATCH memory-model 2/4] tools/memory-model: Add example for
 heuristic lockless reads
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
 <20210721211003.869892-2-paulmck@kernel.org>
 <20210723020846.GA26397@rowland.harvard.edu>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <e4aa3346-ba2c-f6cc-9f3c-349e22cd6ee8@colorfullife.com>
Date:   Fri, 23 Jul 2021 08:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723020846.GA26397@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alan,

On 7/23/21 4:08 AM, Alan Stern wrote:
> On Wed, Jul 21, 2021 at 02:10:01PM -0700, Paul E. McKenney wrote:
>> This commit adds example code for heuristic lockless reads, based loosely
>> on the sem_lock() and sem_unlock() functions.
>>
>> Reported-by: Manfred Spraul <manfred@colorfullife.com>
>> [ paulmck: Update per Manfred Spraul and Hillf Danton feedback. ]
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> ---
>>   .../Documentation/access-marking.txt          | 94 +++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>
>> diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
>> index 58bff26198767..be7d507997cf8 100644
>> --- a/tools/memory-model/Documentation/access-marking.txt
>> +++ b/tools/memory-model/Documentation/access-marking.txt
>> @@ -319,6 +319,100 @@ of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
>>   concurrent lockless write.
>>   
>>   
>> +Lock-Protected Writes With Heuristic Lockless Reads
>> +---------------------------------------------------
>> +
>> +For another example, suppose that the code can normally make use of
>> +a per-data-structure lock, but there are times when a global lock
>> +is required.  These times are indicated via a global flag.  The code
>> +might look as follows, and is based loosely on nf_conntrack_lock(),
>> +nf_conntrack_all_lock(), and nf_conntrack_all_unlock():
>> +
>> +	bool global_flag;
>> +	DEFINE_SPINLOCK(global_lock);
>> +	struct foo {
>> +		spinlock_t f_lock;
>> +		int f_data;
>> +	};
>> +
>> +	/* All foo structures are in the following array. */
>> +	int nfoo;
>> +	struct foo *foo_array;
>> +
>> +	void do_something_locked(struct foo *fp)
>> +	{
>> +		bool gf = true;
>> +
>> +		/* IMPORTANT: Heuristic plus spin_lock()! */
>> +		if (!data_race(global_flag)) {
>> +			spin_lock(&fp->f_lock);
>> +			if (!smp_load_acquire(&global_flag)) {
>> +				do_something(fp);
>> +				spin_unlock(&fp->f_lock);
>> +				return;
>> +			}
>> +			spin_unlock(&fp->f_lock);
>> +		}
>> +		spin_lock(&global_lock);
>> +		/* Lock held, thus global flag cannot change. */
>> +		if (!global_flag) {
> How can global_flag ever be true at this point?  The only line of code
> that sets it is in begin_global() below, it only runs while global_lock
> is held, and global_flag is set back to false before the lock is
> released.

It can't be true. The code is a simplified version of the algorithm in 
ipc/sem.c.

For the ipc/sem.c, global_flag can remain true even after dropping 
global_lock.

When transferring the approach to nf_conntrack_core, I didn't notice 
that nf_conntrack doesn't need a persistent global_flag.

Thus the recheck after spin_lock(&global_lock) is not needed.


>> +			spin_lock(&fp->f_lock);
>> +			spin_unlock(&global_lock);
>> +			gf = false;
>> +		}
>> +		do_something(fp);
>> +		if (fg)
> Should be gf, not fg.
>
>> +			spin_unlock(&global_lock);
>> +		else
>> +			spin_lock(&fp->f_lock);
>> +	}
>> +
>> +	void begin_global(void)
>> +	{
>> +		int i;
>> +
>> +		spin_lock(&global_lock);
>> +		WRITE_ONCE(global_flag, true);
> Why does this need to be WRITE_ONCE?  It still races with the first read
> of global_flag above.
>
>> +		for (i = 0; i < nfoo; i++) {
>> +			/* Wait for pre-existing local locks. */
>> +			spin_lock(&fp->f_lock);
>> +			spin_unlock(&fp->f_lock);
> Why not acquire all the locks here and release all of them in
> end_global()?  Then global_flag wouldn't need acquire-release
> sychronization.

 From my understanding:
spin_lock contains preempt_count_add, thus you can't acquire more than 
255 spinlocks (actually 245, the warning limit is 10 below 255)

>> +		}
>> +	}
>> +
>> +	void end_global(void)
>> +	{
>> +		smp_store_release(&global_flag, false);
>> +		/* Pre-existing global lock acquisitions will recheck. */
> What does that comment mean?  How can there be any pre-existing global
> lock acquisitions when we hold the lock right now?

>> +		spin_unlock(&global_lock);
>> +	}
>> +
>> +All code paths leading from the do_something_locked() function's first
>> +read from global_flag acquire a lock, so endless load fusing cannot
>> +happen.
>> +
>> +If the value read from global_flag is true, then global_flag is rechecked
>> +while holding global_lock, which prevents global_flag from changing.
>> +If this recheck finds that global_flag is now false, the acquisition
> Again, how can't global_flag be false now?
>
> Did you originally have in mind some sort of scheme in which
> begin_global() would release global_lock before returning and
> end_global() would acquire global_lock before clearing global_flag?  But
> I don't see how that could work without changes to do_something_locked().
>
>> +of ->f_lock prior to the release of global_lock will result in any subsequent
>> +begin_global() invocation waiting to acquire ->f_lock.
>> +
>> +On the other hand, if the value read from global_flag is false, then
>> +global_flag, then rechecking under ->f_lock combined with synchronization
> ---^^^^^^^^^^^^^^^^^^
>
> Typo?
>
>> +with begin_global() guarantees than any erroneous read will cause the
>> +do_something_locked() function's first do_something() invocation to happen
>> +before begin_global() returns.  The combination of the smp_load_acquire()
>> +in do_something_locked() and the smp_store_release() in end_global()
>> +guarantees that either the do_something_locked() function's first
>> +do_something() invocation happens after the call to end_global() or that
>> +do_something_locked() acquires global_lock() and rechecks under the lock.
> This last sentence also makes no sense unless you imagine dropping
> global_lock between begin_global() and end_global().

ipc/sem.c does that and needs that, nf_conntrack doesn't use this.


--

     Manfred

