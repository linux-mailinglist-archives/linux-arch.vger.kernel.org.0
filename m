Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57AB31400F
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 21:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhBHUMi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 15:12:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:26309 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236599AbhBHUMT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 15:12:19 -0500
IronPort-SDR: /2UpJp6CCowbRitHjeLFTPCOKK5ar+DwkpPiUpRwTJZd/YqgecYhafHP3bbJh11R89zyTwwT2N
 PonpbnHMdbVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="178262980"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="178262980"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 12:11:36 -0800
IronPort-SDR: FvGwoSxWRzF4E22TLsPk5Oq5ub9aCuUNYVsQ16qDvTKMmDkANo5/BNExWtb6eKkve17QuOBXbk
 Inp+fnpUwetw==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="374625160"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.11.33]) ([10.251.11.33])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 12:11:34 -0800
Subject: Re: [PATCH v19 06/25] x86/cet: Add control-protection fault handler
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-7-yu-cheng.yu@intel.com>
 <20210205135927.GH17488@zn.tnic>
 <2d829cba-784e-635a-e0c5-a7b334fa9b40@intel.com>
 <20210208182009.GE18227@zn.tnic>
 <690bc3b9-2890-e68d-5e4b-cda5c21b496b@intel.com>
 <20210208185341.GF18227@zn.tnic>
 <0e0c9e9d-aee1-ad1e-6c63-21b58a52163f@intel.com>
 <20210208194854.GI18227@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <f5a24814-4e94-3e40-db0a-463b469283d2@intel.com>
Date:   Mon, 8 Feb 2021 12:11:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208194854.GI18227@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/8/2021 11:48 AM, Borislav Petkov wrote:
> On Mon, Feb 08, 2021 at 11:23:18AM -0800, Yu, Yu-cheng wrote:
>> exc_general_protection() and do_trap() both call show_signal(), which
>> then calls printk_ratelimit().
> 
> You could've done some git archeology and could've found
> 
>    abd4f7505baf ("x86: i386-show-unhandled-signals-v3")
> 
> which explains why that ratelimiting is needed.
> 
>> For example, if a shell script, in a loop re-starts an app when it
>> exits, and the app is causing control-protection fault. The log
>> messages should be rate limited.
> 
> I think you should be able to get where I'm going with this, by now:
> please put a comment over the ratelimiting to explain why it is there,
> just like the above commit explains.

I will add that.

> 
> Thx.
> 

