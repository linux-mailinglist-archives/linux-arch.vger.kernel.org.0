Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1742628C261
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 22:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgJLUaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 16:30:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:31318 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbgJLUaB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 16:30:01 -0400
IronPort-SDR: FgyIRCx2kFq6mOo2jW7M0DM+o4ZM7PkL0CedglDPnfHKE44Pf0DZNTVYiH6VZT5EhRWx9S4Hro
 /RRpgol7FWMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="153631193"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="153631193"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:29:59 -0700
IronPort-SDR: Q3TMmJJfFdzOben8LhYKlvy2Lf9ifmccyfK46qxXdTv68g+iC/y3Dbe8lzuVbqqJFOCGX9WdEK
 BE8Pg6hROcLw==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="356739364"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.167.7]) ([10.209.167.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:29:58 -0700
Subject: Re: [PATCH v14 1/7] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201012154530.28382-1-yu-cheng.yu@intel.com>
 <20201012154530.28382-2-yu-cheng.yu@intel.com> <20201012191511.GC14048@grain>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c1bb9728-95a8-2fc2-6a28-ea37f2b50e7b@intel.com>
Date:   Mon, 12 Oct 2020 13:29:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201012191511.GC14048@grain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/12/2020 12:15 PM, Cyrill Gorcunov wrote:
> On Mon, Oct 12, 2020 at 08:45:24AM -0700, Yu-cheng Yu wrote:
> ...
>> +	  the application support it.  When this feature is enabled,
>> +	  legacy non-IBT applications continue to work, but without
>> +	  IBT protection.
>> +	  Support for this feature is only known to be present on
>> +	  processors released in 2020 or later.  CET features are also
>> +	  known to increase kernel text size by 3.7 KB.
> 
> It seems the last sentence is redundant - new features always bloat
> the kernel code and precise size may differ depending on compiler
> and options. Surely this can be patched on top.
> 

This was added after some discussion in v12 about kernel text size [1]. 
I think these few extra words can help people who have older machines 
and want to save some space.  Yes, like you said, if later we don't want 
this sentence, I will be happy to add a patch to remove it.  Thanks for 
the feedback.

Yu-cheng

[1] 
https://lore.kernel.org/linux-api/5e0a4005-45e3-3e88-e6e0-4ec31aad7eb9@intel.com/
