Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502852A9E7E
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 21:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgKFUOm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 15:14:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:42963 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgKFUOm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 15:14:42 -0500
IronPort-SDR: Y6Ovxtu1O3kFT57jOSnhIXXZLZTrUFDb43pNzs/c2x5S+pc2R23tdL/2pJXUcIEkJYcHrioVZR
 ENh7LgOpUlkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="148876450"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="148876450"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 12:14:41 -0800
IronPort-SDR: gb3VigMZvI6OslzAgoAMGhz8CeLyOjLRNF5MdPKlrAPBsCNBgaKXnxWPNdVwN1YIIhBjsXGVk6
 5lRKYopeCPaw==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="528469179"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.221.127]) ([10.212.221.127])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 12:14:39 -0800
Subject: Re: [PATCH v14 02/26] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Pengfei Xu <pengfei.xu@intel.com>, Borislav Petkov <bp@suse.de>
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-3-yu-cheng.yu@intel.com>
 <20201106184953.GI14914@zn.tnic>
 <94e82db0-381b-a140-ab74-f23b7c35949e@intel.com>
 <20201106201152.GJ14914@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a7ffcbf1-96ef-f4c1-6b2e-72b2fa21046d@intel.com>
Date:   Fri, 6 Nov 2020 12:14:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201106201152.GJ14914@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/6/2020 12:11 PM, Borislav Petkov wrote:
> On Fri, Nov 06, 2020 at 11:48:26AM -0800, Yu, Yu-cheng wrote:
>> I will drop it.  It has been re-based many times, and probably I
>> accidentally introduced something else?
> 
> Yah, I think I added my tag to this version:
> 
> https://lkml.kernel.org/lkml/20181119214809.6086-3-yu-cheng.yu@intel.com/
> 
> Do you need to refresh on when tags get dropped?
> 
> See here: Documentation/process/submitting-patches.rst
> 
> You should verify the rest of the patchset too - tags are not
> sticked to a patch forever.
> 

I will do that.

Yu-cheng
