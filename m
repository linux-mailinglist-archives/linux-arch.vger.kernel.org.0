Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE82A9C3E
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 19:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgKFScW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 13:32:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:34321 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKFScW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 13:32:22 -0500
IronPort-SDR: Cp74Iq1flIMTKF+H5IKJrARO1I0RmYO/6NXQb86uJliKuaV9kSw7YdwST59G03fLRO+vWVMhdO
 CcRcGcpedCVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="148863646"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="148863646"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 10:32:20 -0800
IronPort-SDR: QSmFF3Phay518UCkCcIx2W5ZdMDtxuhDzkXD52/pILlFfYCbVlk48QwvROMhAgEMgM9IDY1xVI
 h68Cyix7Os1w==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="321681117"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.221.127]) ([10.212.221.127])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 10:32:19 -0800
Subject: Re: [PATCH v14 01/26] Documentation/x86: Add CET description
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-2-yu-cheng.yu@intel.com>
 <20201106173410.GG14914@zn.tnic>
 <ebaff261-f8ad-d184-edd5-8efbd675deeb@intel.com>
 <20201106182822.GH14914@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <dca16efa-4869-d21d-1056-3aa57f396380@intel.com>
Date:   Fri, 6 Nov 2020 10:32:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201106182822.GH14914@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/6/2020 10:28 AM, Borislav Petkov wrote:
> On Fri, Nov 06, 2020 at 10:16:47AM -0800, Yu, Yu-cheng wrote:
>> In the current shell, if GLIBC_TUNABLES variable is set as such,
>> applications started will have CET features disabled.  I can put more
>> details here, or maybe a reference to the GLIBC man pages.
> 
> Why do you keep repeating "the current shell"? You pass it with
> setenv(3) too, can't you?
> 

Ture.  I will revise it.

Yu-cheng
