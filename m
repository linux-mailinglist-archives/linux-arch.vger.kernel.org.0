Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33407251D00
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHYQNG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 12:13:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:44149 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgHYQNF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 12:13:05 -0400
IronPort-SDR: 9NIxVUSSNiWyZsVFz/+W3io5YEp74TN/9dLbGB4Ofej96Vx4zm9F8Vn+AgXcliX9AAfMbSxmoW
 r7GSBlsWtQ4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143919874"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="143919874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 09:13:04 -0700
IronPort-SDR: Ayx+5KGXwIMIpz5Ych1zslMFk2ol3MLNgYL8uPEqGYGgeDR4sC9Y44KVhWwFN5Cs3BdUQ4pu4c
 C7UzGVkTdx+A==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="499911294"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.162.112]) ([10.213.162.112])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 09:13:03 -0700
Subject: Re: [PATCH v11 8/9] x86/vdso: Insert endbr32/endbr64 to vDSO
To:     Andy Lutomirski <luto@kernel.org>
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
References: <20200825002645.3658-1-yu-cheng.yu@intel.com>
 <20200825002645.3658-9-yu-cheng.yu@intel.com>
 <CALCETrWo5kNeQd=cfU647_htcDNJpVPKv2d8JqdjeLRFCb1wXA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <d0415682-f722-d60d-1d40-f29e6dffa218@intel.com>
Date:   Tue, 25 Aug 2020 09:13:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWo5kNeQd=cfU647_htcDNJpVPKv2d8JqdjeLRFCb1wXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/24/2020 5:33 PM, Andy Lutomirski wrote:
> On Mon, Aug 24, 2020 at 5:30 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> From: "H.J. Lu" <hjl.tools@gmail.com>
>>
>> When Indirect Branch Tracking (IBT) is enabled, vDSO functions may be
>> called indirectly, and must have ENDBR32 or ENDBR64 as the first
>> instruction.  The compiler must support -fcf-protection=branch so that it
>> can be used to compile vDSO.
>>
>> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> I revoke my Ack.  Please don't repeat the list of object files.  Maybe
> add the option to CFL?

I will update the patch.

Yu-cheng
