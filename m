Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAC6ACF35
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 21:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCFUbV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 15:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCFUbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 15:31:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E374DE36;
        Mon,  6 Mar 2023 12:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678134678; x=1709670678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MN+GxIeY2P/7LeJfofnw1WkCJjn6/4HPi9GyDps07Uw=;
  b=nNdHBgYrsxl+IC3oNKJstTV+5fZwgofyZUTlQOfWWUAdUH0b2H2Lt3U2
   bgnpcrPC+StD64Kw4V8kJhPtUd7d6httUHkWDD2KCykSmwPULNFznbTsL
   PkS6iXu6rCNNd1clilxI5lPwtU2Hh3cJ5Ig3kDagmO+BFjRafhiRekyoO
   GwTQ8JXsDfIbhsQTYBmsD9uO6CKuXN5ve7neEIaDl6BzTR1cZcvfAly6A
   lq5zTZ1yyd7D1GcttOTZvhlAXv3Ta6YzD+5+DMQO5pkmZA4KWqesGOJZJ
   d9THrPHqUwNS2QbrggGqOdGeR0w94luV7k8FKjdFULSg1QrzBkaLyXHqU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400491887"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="400491887"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 12:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626287541"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626287541"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 06 Mar 2023 12:31:17 -0800
Received: from [10.251.28.138] (kliang2-mobl1.ccr.corp.intel.com [10.251.28.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0EED558097C;
        Mon,  6 Mar 2023 12:31:11 -0800 (PST)
Message-ID: <f22c3d6a-1468-74d0-1bca-74091f0c1eff@linux.intel.com>
Date:   Mon, 6 Mar 2023 15:31:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "Liang, Kan" <kan.liang@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
 <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
 <ZADQISkczejfgdoS@arm.com>
 <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
 <ZAYS6CHuZ0MiFvmE@arm.com>
 <7b571c394839073cdc338b6718a363f44c9ba072.camel@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <7b571c394839073cdc338b6718a363f44c9ba072.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023-03-06 1:05 p.m., Edgecombe, Rick P wrote:
> +Kan for shadow stack perf discussion.
> 
> On Mon, 2023-03-06 at 16:20 +0000, szabolcs.nagy@arm.com wrote:
>> The 03/03/2023 22:35, Edgecombe, Rick P wrote:
>>> I think I slightly prefer the former arch_prctl() based solution
>>> for a
>>> few reasons:
>>>   - When you need to find the start or end of the shadow stack can
>>> you
>>> can just ask for it instead of searching. It can be faster and
>>> simpler.
>>>   - It saves 8 bytes of memory per shadow stack.
>>>
>>> If this turns out to be wrong and we want to do the marker solution
>>> much later at some point, the safest option would probably be to
>>> create
>>> new flags.
>>
>> i see two problems with a get bounds syscall:
>>
>> - syscall overhead.
>>
>> - discontinous shadow stack (e.g. alt shadow stack ends with a
>>   pointer to the interrupted thread shadow stack, so stack trace
>>   can continue there, except you don't know the bounds of that).
>>
>>> But just discussing this with HJ, can you share more on what the
>>> usage
>>> is? Like which backtracing operation specifically needs the marker?
>>> How
>>> much does it care about the ucontext case?
>>
>> it could be an option for perf or ptracers to sample the stack trace.
>>
>> in-process collection of stack trace for profiling or crash reporting
>> (e.g. when stack is corrupted) or cross checking stack integrity may
>> use it too.
>>
>> sometimes parsing /proc/self/smaps maybe enough, but the idea was to
>> enable light-weight backtrace collection in an async-signal-safe way.
>>
>> syscall overhead in case of frequent stack trace collection can be
>> avoided by caching (in tls) when ssp falls within the thread shadow
>> stack bounds. otherwise caching does not work as the shadow stack may
>> be reused (alt shadow stack or ucontext case).
>>
>> unfortunately i don't know if syscall overhead is actually a problem
>> (probably not) or if backtrace across signal handlers need to work
>> with alt shadow stack (i guess it should work for crash reporting).
> 
> There was a POC done of perf integration. I'm not too knowledgeable on
> perf, but the patch itself didn't need any new shadow stack bounds ABI.
> Since it was implemented in the kernel, it could just refer to the
> kernel's internal data for the thread's shadow stack bounds.
> 
> I asked about ucontext (similar to alt shadow stacks in regards to lack
> of bounds ABI), and apparently perf usually focuses on the thread
> stacks. Hopefully Kan can lend some more confidence to that assertion.

The POC perf patch I implemented tries to use the shadow stack to
replace the frame pointer to construct a callchain of a user space
thread. Yes, it's in the kernel, perf_callchain_user(). I don't think
the current X86 perf implementation handle the alt stack either. So the
kernel internal data for the thread's shadow stack bounds should be good
enough for the perf case.

Thanks,
Kan
