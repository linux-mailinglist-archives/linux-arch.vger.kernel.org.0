Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E2827080F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIRVVj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:21:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:39891 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIRVVj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 17:21:39 -0400
IronPort-SDR: /YNQjK+3CfGUAwbUQfkGYAZ53dm1qYamVyqqoLDI6HzqIqiodyvlX9vt5N81oy/t1oLXSPX9De
 BQoZU5nCnUdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147718685"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147718685"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:21:24 -0700
IronPort-SDR: cqPmBsZP+6LCDOndU195386/Bgju5YHVNwiypFk5BMbPE9dJG8qo+zu4vjlHNtpOUfjRfXM7d/
 s8nIq35e4evA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="381051016"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.0.248]) ([10.212.0.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:21:13 -0700
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is
 enabled
To:     Pavel Machek <pavel@ucw.cz>, Dave Hansen <dave.hansen@intel.com>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <f02b511d-1d48-6dea-d2e6-84d58e21e6cd@intel.com>
 <20200918210026.GC4304@duo.ucw.cz>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <862eef02-eba2-e13f-ed67-f915f749ebca@intel.com>
Date:   Fri, 18 Sep 2020 14:21:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918210026.GC4304@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/18/2020 2:00 PM, Pavel Machek wrote:
> On Fri 2020-09-18 12:32:57, Dave Hansen wrote:
>> On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
>>> Emulation of the legacy vsyscall page is required by some programs
>>> built before 2013.  Newer programs after 2013 don't use it.
>>> Disable vsyscall emulation when Control-flow Enforcement (CET) is
>>> enabled to enhance security.
>>
>> How does this "enhance security"?
>>
>> What is the connection between vsyscall emulation and CET?
> 
> Boom.
> 
> We don't break compatibility by default, and you should not tell
> people to enable CET by default if you plan to do this.

I would revise the wording if there is another version.  What this patch 
does is:

If an application is compiled for CET and the system supports it, then 
the application cannot do vsyscall emulation.  Earlier we allow the 
emulation, and had a patch that fixes the shadow stack and endbr for the 
emulation code.  Since newer programs mostly do no do the emulation, we 
changed the patch do block it when attempted.

This patch would not block any legacy applications or any applications 
on older machines.

Yu-cheng
