Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7E3880B6
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 21:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351947AbhERTqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 15:46:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:27039 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351956AbhERTqm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 15:46:42 -0400
IronPort-SDR: zQ0X6kd8P7C2v7/dKEdhUyu6nZleqfLe8HoacyZY7sYuZ1fXWE5a2cmr8gd6dxhn85RNBWp2dZ
 dVA1Hj5RFtvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="264720044"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="264720044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 12:45:18 -0700
IronPort-SDR: tYQi2B82XedKDm6qGiBjeEUdZVyLSN3ijHw1VG6+3/gOUcVnRwKduMlDNvjLJFTLm5urO60hXJ
 V5q6mwSq98IA==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439600915"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.166.158]) ([10.209.166.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 12:45:16 -0700
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
To:     Borislav Petkov <bp@alien8.de>,
        Eugene Syromiatnikov <esyr@redhat.com>
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-25-yu-cheng.yu@intel.com> <YKIfIEyW+sR+bDCk@zn.tnic>
 <e225e357-a1d5-9596-8900-79e6b94cf924@intel.com>
 <20210518001316.GR15897@asgard.redhat.com> <YKQATkbU4DJ/nC3T@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <10f74571-f8c4-9b08-0157-1570b30a1a6d@intel.com>
Date:   Tue, 18 May 2021 12:45:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKQATkbU4DJ/nC3T@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/18/2021 10:58 AM, Borislav Petkov wrote:
> On Tue, May 18, 2021 at 02:14:14AM +0200, Eugene Syromiatnikov wrote:
>> Speaking of which, I wonder what would happen if a 64-bit process makes
>> a 32-bit system call (using int 0x80, for example), and gets a signal.
> 
> I guess that's the next patch. And I see amluto has some concerns...
> 
> /me goes read.
> 

In the next revision, there will be no "signal context extension" 
struct.  However, the flow for 64, ia32 and x32 will be similar.  I will 
send that out after some testing.

Thanks,
Yu-cheng
