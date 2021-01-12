Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19B2F245D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jan 2021 02:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhALAYh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jan 2021 19:24:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:29965 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404238AbhALAK0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Jan 2021 19:10:26 -0500
IronPort-SDR: 4WkjVdCVtSs4tpYTIl+Oru/a85CxppNMem/874N/QAWKFowtW91gsdxpnkxHf6q9HiJ2x3jM9/
 wWCRfLfdI+Jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177183523"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="177183523"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:09:46 -0800
IronPort-SDR: MZ6o279zdJ2hukSqNJAelzE0N3EoPSuST80JVMJ0lG7cLsw+cOmSn4be9Fxg2PwEjeSvp7bcPZ
 612cCvl1Cu1Q==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352799931"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.197.241]) ([10.212.197.241])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:09:43 -0800
Subject: Re: [PATCH v17 04/26] x86/cpufeatures: Introduce X86_FEATURE_CET and
 setup functions
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201229213053.16395-5-yu-cheng.yu@intel.com>
 <20210111230900.5916-1-yu-cheng.yu@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <f88d2211-d314-5d9c-9471-a54c412525e0@intel.com>
Date:   Mon, 11 Jan 2021 16:09:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111230900.5916-1-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a minor revision of the original [PATCH v17 04/26] patch.  The 
purpose of the revision is to address Boris' comment earlier by doing 
setup_force_cpu_cap(X86_FEATURE_CET) in bsp_init_intel().

--
Yu-cheng
