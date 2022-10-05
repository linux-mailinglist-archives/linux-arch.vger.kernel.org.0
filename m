Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C75F5623
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJEOIU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJEOIT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 10:08:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFD978220;
        Wed,  5 Oct 2022 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664978898; x=1696514898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x4Mh62nAwfxY8Pita2q5xFpK6rXI3Y7xCTC5ET9xbaw=;
  b=XcTwy1mMYhYXdFfO2Qgg+9lKnVqZndVhZ18vjTduP9uH7FtsHn98Cg6L
   GnaTrTqb6cMAgsAZauttLwNoWrDtmNGZc7EjN1Oo9R0+DGamG75tnG8Il
   U31OTZ5GQiag9xEgMmehLNK8WCmur0jMQPlpfP/wRqs5SZa4jFkh09S7S
   wTyerpFd0n8nJbwpKwCPdLOa+xcOJtNyoiWLEF3upOn2hPi4XxkZ0r6QK
   yrMsXJBO8alhlXpT3/nUKnHVp6kJs0uWTumOcov9a88Rmk4XaXCilcmus
   Hc78CZ6+XJd+Pg3G0xUraWPRjKf8ap+aIYdnmF4yCMt/ZILl+0CPKlq2g
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="389454804"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="389454804"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 07:08:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="602018913"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="602018913"
Received: from mghender-mobl.amr.corp.intel.com (HELO [10.209.6.185]) ([10.209.6.185])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 07:08:16 -0700
Message-ID: <715095e6-6c4e-62dd-6631-b096db2cd92c@intel.com>
Date:   Wed, 5 Oct 2022 07:08:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-11-rick.p.edgecombe@intel.com>
 <54cdad9f-b810-7966-5928-9320d970a43d@citrix.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <54cdad9f-b810-7966-5928-9320d970a43d@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/4/22 19:17, Andrew Cooper wrote:
> On 29/09/2022 23:29, Rick Edgecombe wrote:
>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>
>> There is essentially no room left in the x86 hardware PTEs on some OSes
>> (not Linux). That left the hardware architects looking for a way to
>> represent a new memory type (shadow stack) within the existing bits.
>> They chose to repurpose a lightly-used state: Write=0,Dirty=1.
> How does "Some OSes have a greater dependence on software available bits
> in PTEs than Linux" sound?
> 
>> The reason it's lightly used is that Dirty=1 is normally set _before_ a
>> write. A write with a Write=0 PTE would typically only generate a fault,
>> not set Dirty=1. Hardware can (rarely) both set Write=1 *and* generate the
>> fault, resulting in a Dirty=0,Write=1 PTE. Hardware which supports shadow
>> stacks will no longer exhibit this oddity.
> Again, an interesting anecdote but not salient information here.

As much as I like the sound of my own voice (and anecdotes), I agree
that this is a bit oblique for the patch.  Maybe this anecdote should
get banished elsewhere.

The changelog here could definitely get to the point faster.
