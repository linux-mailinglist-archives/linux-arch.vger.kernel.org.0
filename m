Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C81D6A99AE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 15:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjCCOjU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 09:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCCOjS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 09:39:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F9199;
        Fri,  3 Mar 2023 06:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677854355; x=1709390355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=enM9fqPmmUCNjfregnTQTxVlem+fBlV9uM7hLOVjTZk=;
  b=iGukCSG/XG0XV1D3/JTNKtdG1Ju8ZK/9q51a0ZhBFgHkMNkbLcXj/Jiu
   QhqckyOkLQlr/8dMMknzU4EaRzrUkIegMkMR89NHRaq5rDD06eIIygVJV
   w/J73+hqIYFWhBs31DQ9VAJog0ysjMnxnFpbEhilq7rHXIcTVChwDBawD
   qRPlX3gml7V7Qfv0uBq9f59eP5FQru96erxQEUHCCvegev0ZStQzeUPY/
   OgsuHkgsAju3yWhNkbNAPV0FmDfZ3GnYGW8M6aOpL7OOYh1lC3xO5uuTx
   SH/C3PNx3wKM1xvsHZk1iDrDucpl+AFjB6hn66o9Fau5BtUHqvZI7nFOF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="315454031"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="315454031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 06:39:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="818491545"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="818491545"
Received: from ppatil1-mobl3.amr.corp.intel.com (HELO [10.252.140.187]) ([10.252.140.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 06:39:11 -0800
Message-ID: <e237d765-3d18-3188-33fa-74b0bef95ac4@intel.com>
Date:   Fri, 3 Mar 2023 06:39:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 19/41] x86/mm: Check shadow stack page fault errors
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        david@redhat.com, debug@rivosinc.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-20-rick.p.edgecombe@intel.com>
 <ZAH9dhFGtbR5J8j+@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZAH9dhFGtbR5J8j+@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/3/23 06:00, Borislav Petkov wrote:
> On Mon, Feb 27, 2023 at 02:29:35PM -0800, Rick Edgecombe wrote:
>> @@ -1310,6 +1324,23 @@ void do_user_addr_fault(struct pt_regs *regs,
>>  
>>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>>  
>> +	/*
>> +	 * For conventionally writable pages, a read can be serviced with a
>> +	 * read only PTE. But for shadow stack, there isn't a concept of
>> +	 * read-only shadow stack memory. If it a PTE has the shadow stack
> s/it //
> 
>> +	 * permission, it can be modified via CALL and RET instructions. So
>> +	 * core MM needs to fault in a writable PTE and do things it already
>> +	 * does for write faults.
>> +	 *
>> +	 * Shadow stack accesses (read or write) need to be serviced with
>> +	 * shadow stack permission memory, which always include write
>> +	 * permissions. So in the case of a shadow stack read access, treat it
>> +	 * as a WRITE fault. This will make sure that MM will prepare
>> +	 * everything (e.g., break COW) such that maybe_mkwrite() can create a
>> +	 * proper shadow stack PTE.

I ended up just chopping that top paragraph out and rewording it a bit.  I think this still expresses the intent in a lot less space:

        /*
         * Read-only permissions can not be expressed in shadow stack PTEs.
         * Treat all shadow stack accesses as WRITE faults. This ensures
         * that the MM will prepare everything (e.g., break COW) such that
         * maybe_mkwrite() can create a proper shadow stack PTE.
         */

