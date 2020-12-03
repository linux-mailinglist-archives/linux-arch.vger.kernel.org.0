Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAB2CDA7D
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 16:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbgLCP5d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 10:57:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:37124 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbgLCP5c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Dec 2020 10:57:32 -0500
IronPort-SDR: POaqQrNEu1R/xqUCFxYZViCqgp3vAy4i7gAw0+3dTVRe8xMIKqgHBXvsXd17x2jWMEGx949qR8
 6hihZFcZvR6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="173309989"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="173309989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 07:56:52 -0800
IronPort-SDR: QTXfd0UHBF2xxeJDIPK47vgt29cm5V2RiGcTsfVJv4BzxpNEjVu0qx77u4M0SX02qmWYZpZdGW
 iEBaSxNFZ05g==
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="550534058"
Received: from sshellma-mobl.amr.corp.intel.com (HELO [10.212.138.60]) ([10.212.138.60])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 07:56:50 -0800
Subject: Re: [PATCH v15 06/26] x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-7-yu-cheng.yu@intel.com> <20201203091910.GE3059@zn.tnic>
 <93eb0255-df5c-5cb3-654f-e74c1af956b2@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <585009b4-537e-0fc9-ea4a-79210c96a514@intel.com>
Date:   Thu, 3 Dec 2020 07:56:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <93eb0255-df5c-5cb3-654f-e74c1af956b2@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/3/2020 7:12 AM, Dave Hansen wrote:
> On 12/3/20 1:19 AM, Borislav Petkov wrote:
>> On Tue, Nov 10, 2020 at 08:21:51AM -0800, Yu-cheng Yu wrote:
>>> Before introducing _PAGE_COW for non-hardware memory management purposes in
>>> the next patch, rename _PAGE_DIRTY to _PAGE_DIRTY_HW and _PAGE_BIT_DIRTY to
>>> _PAGE_BIT_DIRTY_HW to make meanings more clear.  There are no functional
>>> changes from this patch.
>> There's no guarantee for "next" or "this" patch when a patch gets
>> applied so reword your commit message pls.
>>
>> Also, I fail to understand here what _PAGE_DIRTY_HW makes more clear?
>> The page dirty bit is clear enough to me so why the churn?
> 
> Once upon a time in this set, we had:
> 
> 	_PAGE_DIRTY	(the old hardware bit)
> and
> 	_PAGE_DIRTY_SW	(the new shadow stack necessitated bit)
> 
> In *that* case, it made sense to change the name of the hardware one to
> help differentiate them.  But, over time, we changed _PAGE_DIRTY_SW to
> _PAGE_COW.
> 
> I think you're right.  The renaming is just churn now with the current
> naming.
> 

Ok, I will drop this patch.
