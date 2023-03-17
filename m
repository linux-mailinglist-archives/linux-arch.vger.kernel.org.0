Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559096BEF54
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 18:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCQRQZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCQRQX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 13:16:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738E02E0D9;
        Fri, 17 Mar 2023 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679073381; x=1710609381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=94pw9rxhjDC1X+hebb6ss2+DW8AEYbcU3bNVKEnzNSw=;
  b=Ouw2qDrE3dp6B+qN1zUjJ+OBvrVPOsUycbq7cCyfPN5cmvmk6NUH1Z+P
   pZw/0JEUzEF6GEyTk3afqgUP4xrwS8aHCfeq/Mx8JXQsEm4OfAR9q5t1E
   EpOO+s2VLw7PL1EdJCmZwQKGk0GaOevr1JJvSb/YkIErQigHEubMix4Nr
   X+qF5fT8rvQZQ7ZKVgEpXucbCdDSxYKH8jV6ybdHf2qbjhqLzI4Gkc2Sv
   w3q4mMjW7dv8n7GYbf/p+t0xAS0zSdMy5Do9MWZ4AZNfPzie9IYHlAqDf
   qnhjs/VWG2yz/yUlRO11x4BAslCcIRLvq74YPV0abdo8pVtRfI+ItuQlP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="403185767"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="403185767"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="682751665"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="682751665"
Received: from dlacbain-mobl.amr.corp.intel.com (HELO [10.209.46.45]) ([10.209.46.45])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:16:18 -0700
Message-ID: <236ae66c-fafb-80e9-d58b-6b18a22071c1@intel.com>
Date:   Fri, 17 Mar 2023 10:16:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Content-Language: en-US
To:     Deepak Gupta <debug@rivosinc.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-23-rick.p.edgecombe@intel.com>
 <CAKC1njQ+resjS-O8vAVLhRfLHEdgta09faEr5zwi1JTNSWK0Fw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAKC1njQ+resjS-O8vAVLhRfLHEdgta09faEr5zwi1JTNSWK0Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/17/23 10:12, Deepak Gupta wrote:
>>  /*
>> - * Stack area - automatically grows in one direction
>> + * Stack area
>>   *
>> - * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
>> - * do_mmap() forbids all other combinations.
>> + * VM_GROWSUP, VM_GROWSDOWN VMAs are always private
>> + * anonymous. do_mmap() forbids all other combinations.
>>   */
>>  static inline bool is_stack_mapping(vm_flags_t flags)
>>  {
>> -       return (flags & VM_STACK) == VM_STACK;
>> +       return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
> Same comment here. `VM_SHADOW_STACK` is an x86 specific way of
> encoding a shadow stack.
> Instead let's have a proxy here which allows architectures to have
> their own encodings to represent a shadow stack.

This doesn't _preclude_ another architecture from coming along and doing
that, right?  I'd just prefer that shadow stack architecture #2 comes
along and refactors this in precisely the way _they_ need it.
