Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91223A1B56
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFIQ5f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 12:57:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:24289 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhFIQ5e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 12:57:34 -0400
IronPort-SDR: FS6a65XK6wC4EioOUgqAbU/JoBF6JVvpEB+XpqV2gTvk2gJDpvnSfO+HPxITgQWe6/IKr2eAom
 UjjIo1OdyOow==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="204928031"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="204928031"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:55:37 -0700
IronPort-SDR: pJc/qyiR6bDGeiUYimzZmGMKNw08Bh6dfU7tWOXSti3VIyvPOxFDFRaXes3wHI2fTOxq3vG6iB
 Sd5drJFXHa5A==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="469931412"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.151.26]) ([10.251.151.26])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:55:37 -0700
Subject: Re: [PATCH v2 3/3] elf: Remove has_interp property from
 arch_adjust_elf_prot()
To:     Dave Martin <Dave.Martin@arm.com>, Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-4-broonie@kernel.org> <20210609151724.GM4187@arm.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <6e0b1dbd-688c-aba6-e376-91ce9440d741@intel.com>
Date:   Wed, 9 Jun 2021 09:55:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609151724.GM4187@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/9/2021 8:17 AM, Dave Martin wrote:
> On Fri, Jun 04, 2021 at 12:24:50PM +0100, Mark Brown wrote:
>> Since we have added an is_interp flag to arch_parse_elf_property() we can
>> drop the has_interp flag from arch_elf_adjust_prot(), the only user was
>> the arm64 code which no longer needs it and any future users will be able
>> to use arch_parse_elf_properties() to determine if an interpreter is in
>> use.
> 
> So far so good, but can we also drop the has_interp argument from
> arch_parse_elf_properties()?
> 
> Cross-check with Yu-Cheng Yu's series, but I don't see this being used
> any more (except for passthrough in binfmt_elf.c).
> 
> Since we are treating the interpreter and main executable orthogonally
> to each other now, I don't think we should need a has_interp argument to
> pass knowledge between the interpreter and executable handling phases
> here.
> 

For CET, arch_parse_elf_property() needs to know has_interp and 
is_interp.  Like the following, on top of your patches:

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 607b782afe2c..9e6f142b5cef 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -837,8 +837,15 @@ unsigned long KSTK_ESP(struct task_struct *task)
  }

  int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
-			    bool compat, struct arch_elf_state *state)
+			    bool compat, bool has_interp, bool is_interp,
+			    struct arch_elf_state *state)
  {
+	/*
+	 * Parse static-linked executable or the loader.
+	 */
+	if (has_interp != is_interp)
+		return 0;
+
  	if (type != GNU_PROPERTY_X86_FEATURE_1_AND)
  		return 0;

Thanks,
Yu-cheng
