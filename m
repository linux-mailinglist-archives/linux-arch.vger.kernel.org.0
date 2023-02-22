Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7240569FA87
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjBVRyo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 12:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBVRyn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 12:54:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093537F1A;
        Wed, 22 Feb 2023 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677088482; x=1708624482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M12BjQLqEYzHJwO6ma963tynHN4v+JrRV2MFQkyV3mQ=;
  b=kGB2nsC+ZfvslNREx5zt6Do1ffpc/I5Leb4z85NzDBpTgbpPaY+7sahq
   XbD2kX4eOWzzVupef312r1NQMNJ8ijAstBClwksXM6YK0o6ybjVZDdzxR
   e4ObBQUdiNDzahCeXyNgdu4iI+w29mWgiAsOtTwN9XXl2tPpZrnxQ56oO
   gF9nMadJaSskwXwUNb+RyBnu0M+wmHBlL8GnHvcVHdlHX8JSPmHdjR0XA
   /HsvMsgUmnUt/zWreNIVDPoLEIWijyDuHvsbMc7au1Xdafj4ydw/ERrdE
   Bst2v1/5r4F8VWa6iYSyj9esNApwq8jgAKKpne1AuvLSCpKvZBPsFyein
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="334356519"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="334356519"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 09:54:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="917641246"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="917641246"
Received: from tzinser-mobl.amr.corp.intel.com (HELO [10.209.49.182]) ([10.209.49.182])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 09:54:37 -0800
Message-ID: <b09efb91-d41c-012e-7d99-fdbcf3e92661@intel.com>
Date:   Wed, 22 Feb 2023 09:54:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
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
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-15-rick.p.edgecombe@intel.com>
 <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
 <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com>
 <6e1201f5-da25-6040-8230-c84856221838@redhat.com>
 <273414f5-2a7c-3cc0-dc27-d07baaa5787b@intel.com>
 <52f001ef-a409-4f33-f28f-02e806ef305a@redhat.com>
 <74b91f3e-17f7-6d89-a7d1-7373101bf8b7@intel.com>
 <62b48389-0e61-17da-6a72-d4a16e003352@redhat.com>
 <279E91DE-D152-4996-BBD2-BB310AD38620@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <279E91DE-D152-4996-BBD2-BB310AD38620@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/22/23 09:42, Kees Cook wrote:
> On February 22, 2023 9:27:35 AM PST, David Hildenbrand <david@redhat.com> wrote:
>> On 22.02.23 18:23, Dave Hansen wrote:
>>> On 2/22/23 01:05, David Hildenbrand wrote:
>>>> This series wasn't in -next and we're in the merge window. Is the plan
>>>> to still include it into this merge window?
>>> No way.  It's 6.4 material at the earliest.
>>>
>>> I'm just saying to Rick not to worry _too_ much about earlier feedback
>>> from me if folks have more recent review feedback.
>> Great. So I hope we can get this into -next soon and that we'll only get non-earth-shattering feedback so this can land in 6.4.
> Yes please. Who's going to take it? 😄

I'm more than happy to queue it in x86/mm.  I'll plan to queue Rick's
next version that he posts and then we can do any fixes or minor changes
on top of that.
