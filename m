Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DEE259DC1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgIAR6a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:58:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:21068 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIAR63 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 13:58:29 -0400
IronPort-SDR: tsaXhVb5DH2Pqio5lfj0Dj4oJhOMtQMkHO/iirC3pO/QCkzQ1DxXAJobuqs34X4DY9dRa1Mcc8
 IukZZxe/vxKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="144922321"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="144922321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 10:58:27 -0700
IronPort-SDR: XwMESqPFxr04kLMfyQaui9VPnLF/D1itQuPP2/9KGJduUhBwiqOg07SfbLgLhc4VMmOKQNhS4d
 WGuXhXSy4f2Q==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="477293602"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.241.30]) ([10.212.241.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 10:58:25 -0700
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
 <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com>
 <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
 <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
 <20200826164604.GW6642@arm.com> <87ft892vvf.fsf@oldenburg2.str.redhat.com>
 <20200826170841.GX6642@arm.com> <87tuwow7kg.fsf@oldenburg2.str.redhat.com>
 <CAMe9rOrhjLSaMNABnzd=Kp5UeVot1Qkx0_PnMng=sT+wd9Xubw@mail.gmail.com>
 <873648w6qr.fsf@oldenburg2.str.redhat.com>
 <CAMe9rOqpLyWR+Ek7aBiRY+Kr6sRxkSHAo2Sc6h0YCv3X3-3TuQ@mail.gmail.com>
 <CAMe9rOpuwZesJqY_2wYhdRXMhd7g0a+MRqPtXKh7wX5B5-OSbA@mail.gmail.com>
 <3c12b6ee-7c93-dcf4-fbf7-2698003386dd@intel.com>
 <87o8mpqtcn.fsf@oldenburg2.str.redhat.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b84e6fae-5d51-b0a0-d917-76f86b3186b7@intel.com>
Date:   Tue, 1 Sep 2020 10:58:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87o8mpqtcn.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/2020 10:50 AM, Florian Weimer wrote:
> * Yu-cheng Yu:
> 
>> Like other arch_prctl()'s, this parameter was 'unsigned long'
>> earlier. The idea was, since this arch_prctl is only implemented for
>> the 64-bit kernel, we wanted it to look as 64-bit only.  I will change
>> it back to 'unsigned long'.
> 
> What about x32?  In general, long is rather problematic for x32.

The problem is the size of 'long', right?
Because this parameter is passed in a register, and only the lower bits 
are used, x32 works as well.
