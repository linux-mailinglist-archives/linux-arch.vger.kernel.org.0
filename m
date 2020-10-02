Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2655B281EB9
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 00:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgJBW5v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 18:57:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:51107 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBW5v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Oct 2020 18:57:51 -0400
IronPort-SDR: 6E3CBGdn2TiL+0oCBx5AjnG/pemuMVHasGtUEwDBUmnJ6c49+izILvrZClzPTprVz2Wo2ROdGq
 qqhdwkYeuX1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="247845122"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="247845122"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 15:57:50 -0700
IronPort-SDR: ruK8toO1JApRr4j9R8fvZ1krjdTqDA1CkS3DByaCSS070zVex6WTvU5ybmxD24W982oG/OEZUI
 uXqNV2Jb8nhg==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="346604277"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.143.131]) ([10.212.143.131])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 15:57:48 -0700
Subject: Re: [PATCH v13 19/26] mm: Re-introduce do_mmap_pgoff()
To:     Peter Collingbourne <pcc@google.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200925145649.5438-1-yu-cheng.yu@intel.com>
 <20200925145649.5438-20-yu-cheng.yu@intel.com>
 <CAMn1gO4cxSt8-8qVbAei0jPErTtARdsEY4js6Fi=kzozAuE3yQ@mail.gmail.com>
 <00a409f0-1e2e-0bd7-83e7-f21a47878916@intel.com>
 <CAMn1gO5H4thZQMKvbWs82DCrXJM1Fu9z1hwt1G_kNwDVGcxeTA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <4da742d8-983e-ff24-c74e-3c2de1590a51@intel.com>
Date:   Fri, 2 Oct 2020 15:57:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAMn1gO5H4thZQMKvbWs82DCrXJM1Fu9z1hwt1G_kNwDVGcxeTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/2/2020 3:52 PM, Peter Collingbourne wrote:
> On Fri, Oct 2, 2020 at 8:58 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>
>> On 10/1/2020 7:06 PM, Peter Collingbourne wrote:
>>> On Fri, Sep 25, 2020 at 7:57 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>>
>>>> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
>>>> removed from the function's input by:
>>>>
>>>>       commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
>>>>
>>>> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
>>>> do_mmap().  Re-introduce the vm_flags and do_mmap_pgoff().
>>>
>>> I would prefer to change the callers to pass the additional 0 argument
>>> instead of bringing the wrapper function back, but if we're going to
>>> bring it back then we should fix the naming (both functions take a
>>> pgoff argument, so the previous name do_mmap_pgoff() was just plain
>>> confusing).
>>>
>>> Peter
>>>
>>
>> Thanks for your feedback.  Here is the updated patch.  I will re-send
>> the whole series later.
>>
>> Yu-cheng
>>
>> ======
>>
>>   From 6a9f1e6bcdb6e599a44d5f58cf4cebd28c4634a2 Mon Sep 17 00:00:00 2001
>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Date: Wed, 12 Aug 2020 14:01:58 -0700
>> Subject: [PATCH 19/26] mm: Re-introduce do_mmap_pgoff()
> 
> The subject line of the commit message needs to be updated, but aside from that:
> 
> Reviewed-by: Peter Collingbourne <pcc@google.com>
> 
> Peter

Thanks for reviewing.  I will fix the subject line.

Yu-cheng
