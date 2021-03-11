Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF133785D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhCKPpG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 10:45:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:61146 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234096AbhCKPok (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Mar 2021 10:44:40 -0500
IronPort-SDR: qWK9aRE2TTZXTnoGQ6XadpIdaUrWHZIrBladi08rhh9Bhd46bi94+w+pNYdIORre8+gcMBXe4+
 4SNLXEpDnd0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="186305781"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="186305781"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 07:44:40 -0800
IronPort-SDR: lVQmY3uuvk0SUoyAiiYU6+ijNeIsC7r6XEJxTl3KcWvFb7zk/HRdoWsUdZ7GfcLk9Ooudiw5o4
 51RFWl0wayEQ==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="404106966"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.103.95]) ([10.212.103.95])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 07:44:39 -0800
Subject: Re: [PATCH v22 8/8] x86/vdso: Add ENDBR64 to __vdso_sgx_enter_enclave
To:     Peter Zijlstra <peterz@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com> <YElKjT2v628tidE/@kernel.org>
 <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
 <YEmQJjwjs8UCEO2F@kernel.org>
 <YEnX3Zn0FXPt7pcM@hirez.programming.kicks-ass.net>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <afd769ac-dd09-0c1f-1ffa-b8f68f48113f@intel.com>
Date:   Thu, 11 Mar 2021 07:44:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEnX3Zn0FXPt7pcM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/11/2021 12:42 AM, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 05:36:06AM +0200, Jarkko Sakkinen wrote:
>> Does it do any harm to put it there unconditionally?
> 
> Blows up your text footprint and I$ pressure. These instructions are 4
> bytes each.
> 
> Aside from that, they're a NOP, so only consume front-end resources
> (hopefully) on older CPUs and when IBT is disabled.
> 

Thanks Peter.  I think probably we'll do the macro Boris suggested. 
That takes care of the visual clutter, and eliminates the need of using 
.byte when the assembler is outdated.

--
Yu-cheng
