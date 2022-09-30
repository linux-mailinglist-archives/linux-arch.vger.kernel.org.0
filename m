Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D25F13C9
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 22:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiI3UiA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 16:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiI3Uh7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 16:37:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3BF1CE635;
        Fri, 30 Sep 2022 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664570277; x=1696106277;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dQJ+pcysW2VFlAp5bziLeT5jCGvnyB3q28WBZP0NsgM=;
  b=B6murgglVUVTaIXn/Tui6i32801TVWpMup79vZJ+9dQP/vRpjZIVa+Lf
   DnF++bYEBBbRSfBdQIJb8UWqmwsLfUPolTrXipp12kq9IthAOG83SqfTv
   hgRY5YQGaW2j5utupqsjv1M+HX05kgfgpQqcA05pW12Qf9DjSJebY/XxQ
   7rLBxyNynaFdo/9I5LR+kQ2qoCdSDwgt1OWT0p4fyKrVcV+Q8+uMs33PQ
   3AaT5Y74wQZGY+KOd8RQ8X19D1SKtkz577splgDwtfc1o7T2qAKp6giBh
   Taxi87MaHo0OGdOd/bt//HVlQ24DgTCf5fX8Ue0MXnY3h0Yzb5l4dlMFq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="299883896"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="299883896"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 13:37:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="951683520"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="951683520"
Received: from lzearing-mobl.amr.corp.intel.com (HELO [10.209.49.67]) ([10.209.49.67])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 13:37:55 -0700
Message-ID: <5994adb0-12b7-b8f1-ecdc-ebf56af48947@intel.com>
Date:   Fri, 30 Sep 2022 13:37:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-23-rick.p.edgecombe@intel.com>
 <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
 <44314145f644ab822ac36cc8c78520d5f34d5bd8.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <44314145f644ab822ac36cc8c78520d5f34d5bd8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/30/22 13:30, Edgecombe, Rick P wrote:
> On Fri, 2022-09-30 at 12:16 -0700, Dave Hansen wrote:
>> On 9/29/22 15:29, Rick Edgecombe wrote:
>>> @@ -1633,6 +1633,9 @@ static inline bool
>>> __pte_access_permitted(unsigned long pteval, bool write)
>>>   {
>>>        unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
>>>
>>> +     if (write && (pteval & (_PAGE_RW | _PAGE_DIRTY)) ==
>>> _PAGE_DIRTY)
>>> +             return 0;
>> Do we not have a helper for this?  Seems a bit messy to open-code
>> these
>> shadow-stack permissions.  Definitely at least needs a comment.
> It's because pteval is an unsigned long. We could create a pte_t, and
> use the helpers, but then we would be using pte_foo() on pmd's, etc. So
> probably comment is the better option?

Yeah, a comment is probably best.

This is one of those "generic" page table functions that doesn't work
well with the p{te,md,ud}_* types.  It's either this or cast over to a
pteval_t for pmd/pud and pretend this is a pte-only function.

