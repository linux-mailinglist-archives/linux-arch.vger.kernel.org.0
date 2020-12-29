Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF12E7346
	for <lists+linux-arch@lfdr.de>; Tue, 29 Dec 2020 20:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgL2Tq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Dec 2020 14:46:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:39055 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2Tq1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Dec 2020 14:46:27 -0500
IronPort-SDR: cYDMnYjB2cvH0mAUscbu9MKs9IqkRNfLcJUdP3afzdB0dl/w9MHao6N7TSg8wRZJNztI8PCkdu
 LmJifKmX2LQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="240614524"
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="240614524"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 11:45:45 -0800
IronPort-SDR: BJEZM3Pbk1fhqXurox2+kgVnwclIjNFsumkq6n89lXAk4TEX01DnMH683T0nrIkTIGrJeU2oM8
 r1hHjLwUaYFg==
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="344158096"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.0.43]) ([10.251.0.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 11:45:44 -0800
Subject: Re: [PATCH v16 02/26] x86/cet/shstk: Add Kconfig option for user-mode
 control-flow protection
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
References: <20201209222320.1724-1-yu-cheng.yu@intel.com>
 <20201209222320.1724-3-yu-cheng.yu@intel.com>
 <20201229123910.GB29947@zn.tnic>
 <c193c18e-6a3c-e079-67dc-bca35bceee71@intel.com>
 <20201229185422.GC29947@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b6d327fa-8785-fded-8169-295fe235d1c2@intel.com>
Date:   Tue, 29 Dec 2020 11:45:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201229185422.GC29947@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/29/2020 10:54 AM, Borislav Petkov wrote:
> On Tue, Dec 29, 2020 at 08:34:51AM -0800, Yu, Yu-cheng wrote:
>> Thanks!  I will re-base to v5.11-rc1 and send out a new version.
> 
> You don't have to if it still applies and there are no changes pending.
> 

There are some small conflicts, so I will send a new version.

--
Yu-cheng
