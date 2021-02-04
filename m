Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCA3100DD
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 00:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBDXnz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 18:43:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:19290 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhBDXnu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 18:43:50 -0500
IronPort-SDR: paq73y+XUm9y5jV86oLfy3XQCor3hz9emY1clRXp4YE1QIUTnIPuLVOPe+lVU567RoH/pK/xE5
 QkOPp/xRXpbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="177841889"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="177841889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 15:42:03 -0800
IronPort-SDR: 6wbv918hvG4kwN5PthBfgEyPKVZYOVgV2Zh9AsIF6FZ0wwxkwPSieawgpnXjfujFsc4GNhN/d5
 xzDq58RPrx2A==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="483749298"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.100.6]) ([10.209.100.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 15:42:00 -0800
Subject: Re: [PATCH v19 24/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-25-yu-cheng.yu@intel.com>
 <202102041235.BA6C4982F@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <6d7dd90f-dc03-06ce-57a2-57e4c2f803f3@intel.com>
Date:   Thu, 4 Feb 2021 15:41:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102041235.BA6C4982F@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/2021 12:35 PM, Kees Cook wrote:
> On Wed, Feb 03, 2021 at 02:55:46PM -0800, Yu-cheng Yu wrote:
>> arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
>>      Get CET feature status.
>>
>>      The parameter 'args' is a pointer to a user buffer.  The kernel returns
>>      the following information:
>>
>>      *args = shadow stack/IBT status
>>      *(args + 1) = shadow stack base address
>>      *(args + 2) = shadow stack size
> 
> What happens if this needs to grow in the future? Should the first u64
> contain the array size?
> 
> Otherwise, looks sensible.
> 
> -Kees
> 

The first item is a bitmap, and there are two possible bits.  Should 
there be a need, we can then do things about it.  My thought at the 
moment is, we may not meet the situation.  Can we keep this for now?

--
Yu-cheng
