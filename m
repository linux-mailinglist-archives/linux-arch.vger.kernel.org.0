Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3E4B2C27
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbiBKRyP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 12:54:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiBKRyO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 12:54:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43DCD5;
        Fri, 11 Feb 2022 09:54:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFBD2B82B67;
        Fri, 11 Feb 2022 17:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD776C340E9;
        Fri, 11 Feb 2022 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644602049;
        bh=FsUOrelQNqNyH3UASN+ZGpPm+zrcDvNiCyxLZ2cOLHU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bA8qmWpkMliRzgJ3/D9pIM4YRzkVL/VClVeC1kecwl9UuEu9syCd/L1k3aZIdb/Am
         yJzGeOckMjikcxRadLMZQOTt7482bDcDmr5xONcdduo38eNseusJ5YGl01Ba8r8uq+
         a78UFF2SXihbjHiopc9bXzu2qEamaXka5zQH2+tjJPjec1yKSU4p9OMPYD6Q5XzQoM
         h90D38uKF3vQCcxPEFHtZvTcp2hrfQtuQmLQcS9gswYckPW/dGTzmWWKMG/V1nez9W
         ith2h10B661UAiRqaSjRW3oYRJpETjWEcruoh5PyobYIhQ+5YwXBOS8m9vM00Ixt+J
         5F6X4GojvoE3g==
Message-ID: <c1f159ef-a010-c356-e633-66cce859fdd5@kernel.org>
Date:   Fri, 11 Feb 2022 09:54:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-19-rick.p.edgecombe@intel.com>
 <4c216532-2b68-dd95-93f1-542df4786d7a@intel.com>
 <CALCETrWmiNi2+sPKWDUjGtGWtP9XNryfFe-dG4fTQkXyqGqpzQ@mail.gmail.com>
 <e16fcf166d8304b0b9358e8413ec4a7ffc1de147.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <e16fcf166d8304b0b9358e8413ec4a7ffc1de147.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/10/22 15:40, Edgecombe, Rick P wrote:
> On Thu, 2022-02-10 at 15:07 -0800, Andy Lutomirski wrote:
>> On Thu, Feb 10, 2022 at 2:44 PM Dave Hansen <dave.hansen@intel.com>
>> wrote:
>>>
>>> On 1/30/22 13:18, Rick Edgecombe wrote:
>>>> INCSSP(Q/D) increments shadow stack pointer and 'pops and
>>>> discards' the
>>>> first and the last elements in the range, effectively touches
>>>> those memory
>>>> areas.
>>>>
>>>> The maximum moving distance by INCSSPQ is 255 * 8 = 2040 bytes
>>>> and
>>>> 255 * 4 = 1020 bytes by INCSSPD.  Both ranges are far from
>>>> PAGE_SIZE.
>>>> Thus, putting a gap page on both ends of a shadow stack prevents
>>>> INCSSP,
>>>> CALL, and RET from going beyond.
>>>
>>> What is the downside of not applying this patch?  The shadow stack
>>> gap
>>> is 1MB instead of 4k?
>>>
>>> That, frankly, doesn't seem too bad.  How badly do we *need* this
>>> patch?
> 
> Like just using VM_SHADOW_STACK | VM_GROWSDOWN to get a regular stack
> sized gap? I think it could work. It also simplifies the mm->stack_vm
> accounting.

Seems not crazy.  Do we want automatically growing shadow stacks?  I 
don't really like the historical unix behavior where the main thread has 
a sort-of-infinite stack and every other thread has a fixed stack.

> 
> It would no longer get a gap at the end though. I don't think it's
> needed.
> 

I may have missed something about the oddball way the mm code works, but 
it seems if you have a gap at one end of every shadow stack, you 
automatically have a gap at the other end.


