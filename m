Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C472763B4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 00:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIWWUa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 18:20:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:2461 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWWUa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Sep 2020 18:20:30 -0400
IronPort-SDR: MXjZ7ih5XjcnBx22cjXAPtPUXVkoohlskbLyYrXia0ajFSBq327c2NAnGlduzp09GLuDUyxBGs
 NEWAtlyQoTbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="161106788"
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="161106788"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 15:20:29 -0700
IronPort-SDR: ScFqCtUOmw+US+wUw1TR2Z6hwSEliItctbEeWf89Xg2rYaWSpCjEukSkSDwzJ7MseNxfDHqHyW
 zclkQixcybzg==
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="455091297"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.121.128]) ([10.212.121.128])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 15:20:28 -0700
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is
 enabled
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
 <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com>
 <24718de58ab7bc6d7288c58d3567ad802eeb6542.camel@intel.com>
 <CALCETrWssUxxfhPPJZgPOmpaQcf4o9qCe1j-P7yiPyZVV+O8ZQ@mail.gmail.com>
 <20200923212925.GC15101@linux.intel.com>
 <a2e872ef-5539-c7c1-49ca-95d590f3b92a@intel.com>
 <e7c20f4c-23a0-4a34-3895-c4f60993ec41@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a862be68-dc81-6db5-c79b-5bbd87ccddaf@intel.com>
Date:   Wed, 23 Sep 2020 15:20:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e7c20f4c-23a0-4a34-3895-c4f60993ec41@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2020 3:08 PM, Dave Hansen wrote:
> On 9/23/20 3:06 PM, Yu, Yu-cheng wrote:
>> I think I'll add a check here for (r + 8) >= TASK_SIZE_MAX.  It is
>> better than getting a fault.
> 
> There's also wrmsr_safe().
> 
Yes, thanks.

Since I am going to change this to:

fpu__prepare_write(), then write to the XSAVES area.

The kernel does not expect XRSTORS to fail ("Bad FPU state detected..." 
message).  So maybe still check the address first.
