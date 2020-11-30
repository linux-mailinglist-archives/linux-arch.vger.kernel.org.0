Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5232C8F3F
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 21:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgK3UbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 15:31:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:5061 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbgK3UbX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 15:31:23 -0500
IronPort-SDR: FEh/qT8gvB0WXdK0b5pcQbJ8vkby91BVjqxItEqrAGXNm2Y/Fo0h6ihWVPLYSSx+3Zz4o63MGF
 ZfxpTffjRAiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="152537882"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="152537882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:30:42 -0800
IronPort-SDR: yLA9PNQjHBgTUN90l8qgEkxgXoJuvUXG27s/rwGWPeH2Arxi9GbWUONoWVSPYmAvV7tpspKqWC
 LQD5AD69mzKw==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="549251245"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.122.22]) ([10.212.122.22])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:30:39 -0800
Subject: Re: [PATCH v15 05/26] x86/cet/shstk: Add Kconfig option for user-mode
 Shadow Stack
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dave.Martin@arm.com, arnd@arndb.de, bp@alien8.de,
        bsingharora@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        esyr@redhat.com, fweimer@redhat.com, gorcunov@gmail.com,
        hjl.tools@gmail.com, hpa@zytor.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mike.kravetz@oracle.com, mingo@redhat.com, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        peterz@infradead.org, ravi.v.shankar@intel.com,
        rdunlap@infradead.org, tglx@linutronix.de,
        vedvyas.shanbhogue@intel.com, weijiang.yang@intel.com,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20201110162211.9207-6-yu-cheng.yu@intel.com>
 <20201130195602.331842-1-ndesaulniers@google.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <746c920b-01e2-b299-b5a1-8a29a5a2052d@intel.com>
Date:   Mon, 30 Nov 2020 12:30:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201130195602.331842-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/30/2020 11:56 AM, Nick Desaulniers wrote:
> In response to https://lore.kernel.org/lkml/20201110162211.9207-6-yu-cheng.yu@intel.com/.
> 
> Hi Yu-cheng,
> This feature reminds me very much of
> ARCH_SUPPORTS_SHADOW_CALL_STACK/CC_HAVE_SHADOW_CALL_STACK implemented in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5287569a790d2546a06db07e391bf84b8bd6cf51.
> 
> Do you think it would be worthwhile to share the same config name between x86
> and aarch64?

The CET series has ARCH_HAS_SHADOW_STACK.  In response to Boris' earlier 
comment, I think this maybe eliminated.  In case it is still needed, I 
think it is better to have different names (but I am open to changing it).

> 
> (Though, it seems on x86 there will be a distinction between kernel mode and
> user mode configs, if I understand correctly?)
> 

Yes, on x86, kernel and user-mode can be enabled separately.

Yu-cheng
