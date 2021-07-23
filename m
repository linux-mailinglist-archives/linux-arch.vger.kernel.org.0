Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E83D3B84
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhGWNQn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhGWNQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 09:16:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1021CC061757
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 06:57:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w12so2401399wro.13
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=v5QzT0eQTS6nyU0BB8Gyy3vQ5uM5RyHUdVuAlNWQzlg=;
        b=xKu9ud3E5jXcgwk2127yeFEUlp6Hv/hOhQ/v1+gfr4E33VaAmxY9zQF9yjgZItJHsR
         CDjethkWpqlXFg2gkwu6wQ2GcJDdUaMSuRE4WN5cYPYMaadCVheAxy5+HXLYF75/5k+0
         ij68FL9nvbzyEWFX9dbHm5wkJCjtXHH3X6cBal3u0EGXrgbUP2cyen0bl64y7MlBA0Sr
         kCiTaAkRj1NGT6BNNBY28cxBHWzMEJ1LlgOBe5ozQSuqm/nyijvNwrZKEuNO0ZLBXWWZ
         g5nzQxZYrZ56OAbhbZH7t75OR0l836XQ6p0jSWRKfsk0D2sYk+iWKLArGaJinSMU1ZrM
         Fkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v5QzT0eQTS6nyU0BB8Gyy3vQ5uM5RyHUdVuAlNWQzlg=;
        b=c1Aal5VrU1m7a36oM/zmIDD8f/ubXi+FxPcSnyx+oDxRLkKpzhgGcm28z4J39VM2S9
         ZvH4RsO9RBwwdSMWDLSAg0WZ3/hZrvQT8NZPJ/GxKmIshwbEK1BoNylfHNo6A0y2aopy
         CDRupd1+PLeQ44Z6QNgxz0UszKoe9WiSlrsl/YXMPhCL1sWiB0yKPYIY0KHOey8sSKSP
         ELocP5MKVYNaWl+NIpmdq294GvYW16Y1cf0kLtXvPq78RZdvRcAdHHY6Uu8QEFP50ox0
         3IZ9/PCr4f170hIHlKK2DXR8f3995rbBI485X5WDorAbpnQ23PSZZf/xO+MHP4nNadBF
         0P5A==
X-Gm-Message-State: AOAM532J7oYYMCv5hJXhRdwJudd2l52VJXfbpz9WvW5HNHjkCaDzb8lK
        I55822k8Mq7886xthAxBnbosrg==
X-Google-Smtp-Source: ABdhPJzKURPqdGis9jm3/NLpkQkM5glrZhmoP9DguNmpIIE73bbQeXRNDc87Ni88i5JfSR9TpDXcng==
X-Received: by 2002:a5d:6d89:: with SMTP id l9mr5347522wrs.371.1627048634627;
        Fri, 23 Jul 2021 06:57:14 -0700 (PDT)
Received: from localhost.localdomain (p200300d9972721003352be6dfa1c7751.dip0.t-ipconnect.de. [2003:d9:9727:2100:3352:be6d:fa1c:7751])
        by smtp.googlemail.com with ESMTPSA id f2sm32803256wrq.69.2021.07.23.06.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 06:57:14 -0700 (PDT)
Subject: Re: [PATCH memory-model 2/4] tools/memory-model: Add example for
 heuristic lockless reads
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
 <20210721211003.869892-2-paulmck@kernel.org>
 <20210723020846.GA26397@rowland.harvard.edu>
 <e4aa3346-ba2c-f6cc-9f3c-349e22cd6ee8@colorfullife.com>
 <20210723130554.GA38923@rowland.harvard.edu>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <aaef6bbb-0711-7900-7cbc-cb3bb19bd25c@colorfullife.com>
Date:   Fri, 23 Jul 2021 15:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723130554.GA38923@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alan,

On 7/23/21 3:05 PM, Alan Stern wrote:
> On Fri, Jul 23, 2021 at 08:52:50AM +0200, Manfred Spraul wrote:
>> Hi Alan,
> Hi.
>
>> On 7/23/21 4:08 AM, Alan Stern wrote:
>>> On Wed, Jul 21, 2021 at 02:10:01PM -0700, Paul E. McKenney wrote:
>>>> This commit adds example code for heuristic lockless reads, based loosely
>>>> on the sem_lock() and sem_unlock() functions.
>>>>
>>>> Reported-by: Manfred Spraul <manfred@colorfullife.com>
>>>> [ paulmck: Update per Manfred Spraul and Hillf Danton feedback. ]
>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>> ---
>>>>    .../Documentation/access-marking.txt          | 94 +++++++++++++++++++
>>>>    1 file changed, 94 insertions(+)
>>>>
>>>> diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
>>>> index 58bff26198767..be7d507997cf8 100644
>>>> --- a/tools/memory-model/Documentation/access-marking.txt
>>>> +++ b/tools/memory-model/Documentation/access-marking.txt
>>>> @@ -319,6 +319,100 @@ of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
>>>>    concurrent lockless write.
>>>> +Lock-Protected Writes With Heuristic Lockless Reads
>>>> +---------------------------------------------------
>>>> +
>>>> +For another example, suppose that the code can normally make use of
>>>> +a per-data-structure lock, but there are times when a global lock
>>>> +is required.  These times are indicated via a global flag.  The code
>>>> +might look as follows, and is based loosely on nf_conntrack_lock(),
>>>> +nf_conntrack_all_lock(), and nf_conntrack_all_unlock():
>>>> +
>>>> +	bool global_flag;
>>>> +	DEFINE_SPINLOCK(global_lock);
>>>> +	struct foo {
>>>> +		spinlock_t f_lock;
>>>> +		int f_data;
>>>> +	};
>>>> +
>>>> +	/* All foo structures are in the following array. */
>>>> +	int nfoo;
>>>> +	struct foo *foo_array;
>>>> +
>>>> +	void do_something_locked(struct foo *fp)
>>>> +	{
>>>> +		bool gf = true;
>>>> +
>>>> +		/* IMPORTANT: Heuristic plus spin_lock()! */
>>>> +		if (!data_race(global_flag)) {
>>>> +			spin_lock(&fp->f_lock);
>>>> +			if (!smp_load_acquire(&global_flag)) {
>>>> +				do_something(fp);
>>>> +				spin_unlock(&fp->f_lock);
>>>> +				return;
>>>> +			}
>>>> +			spin_unlock(&fp->f_lock);
>>>> +		}
>>>> +		spin_lock(&global_lock);
>>>> +		/* Lock held, thus global flag cannot change. */
>>>> +		if (!global_flag) {
>>> How can global_flag ever be true at this point?  The only line of code
>>> that sets it is in begin_global() below, it only runs while global_lock
>>> is held, and global_flag is set back to false before the lock is
>>> released.
>> It can't be true. The code is a simplified version of the algorithm in
>> ipc/sem.c.
>>
>> For the ipc/sem.c, global_flag can remain true even after dropping
>> global_lock.
>>
>> When transferring the approach to nf_conntrack_core, I didn't notice that
>> nf_conntrack doesn't need a persistent global_flag.
>>
>> Thus the recheck after spin_lock(&global_lock) is not needed.
> In fact, since global_flag is true if and only if global_lock is locked,
> perhaps it can be removed entirely and replaced with
> spin_is_locked(&global_lock).

I try to avoid spin_is_locked():

- spin_is_locked() is no memory barrier

- spin_lock() is an acquire memory barrier - for the read part. There is 
no barrier at all related to the write part.

With an explicit variable, the memory barriers can be controlled much 
better - and it is guaranteed to work in the same way on all architectures.


--

     Manfred

