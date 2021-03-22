Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA95344834
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 15:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCVOyG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 10:54:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:16678 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhCVOwz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Mar 2021 10:52:55 -0400
IronPort-SDR: PDZrzvMtyWpyPIHFH/Twk0eFOzWvkUpPcqhagvRHpupWi4PVRTdXsfeMImN3naPaAquc//CzEf
 an1nOr6NAE0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="187962997"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="187962997"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 07:52:32 -0700
IronPort-SDR: AcDswo0o5vJUZRQnv7Qgq4FfRiJvce9xEXN0iZXavHHDTiu8NLkg8XL3qJb8K0JAMd3q/9W2Pq
 cGiyP/W0DPkQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="390502622"
Received: from xzhan86-mobl.amr.corp.intel.com (HELO [10.209.39.64]) ([10.209.39.64])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 07:52:30 -0700
Subject: Re: [PATCH v23 07/28] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-8-yu-cheng.yu@intel.com>
 <20210322091351.ulemcluuhqkzuwkm@box>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <81fa71ee-3b0b-b959-b8c2-19e1a5adc4c4@intel.com>
Date:   Mon, 22 Mar 2021 07:52:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322091351.ulemcluuhqkzuwkm@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/22/2021 2:13 AM, Kirill A. Shutemov wrote:
> On Tue, Mar 16, 2021 at 08:10:33AM -0700, Yu-cheng Yu wrote:
>> The x86 family of processors do not directly create read-only and Dirty
>> PTEs.  These PTEs are created by software.  One such case is that kernel
>> read-only pages are historically setup as Dirty.
>>
>> New processors that support Shadow Stack regard read-only and Dirty PTEs as
>> shadow stack pages.  This results in ambiguity between shadow stack and
>> kernel read-only pages.  To resolve this, removed Dirty from kernel read-
>> only pages.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> Looks good to me.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Thanks for reviewing.

Yu-cheng
