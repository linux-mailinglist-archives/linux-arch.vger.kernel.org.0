Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8DE6D4FF1
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjDCSGZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjDCSGS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 14:06:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5430DB;
        Mon,  3 Apr 2023 11:06:16 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4AA121EC0441;
        Mon,  3 Apr 2023 20:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680545174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3qbeYlzZ5htD71+eg/aidybPGnpGWtpXGTldFE6cOCs=;
        b=aFa6Bxnm+HGQQmVd6mveiKBmSFclraqZ+peS0OJ2kP8rVAWlygNljqRN0947B3NWgK+PUI
        c/kvL+sNVHt4tAdAhx1OnFKx1g6B7vHj9Gea3YHCMp5ItNo3HS4j+lSj18xASRR/Uukjpi
        n2CxFvWcQTACKO2WQ8NDz0L30TNBFkA=
Date:   Mon, 3 Apr 2023 20:06:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V4 12/17] x86/sev: Add a #HV exception handler
Message-ID: <20230403180608.GBZCsVkMSSClY/qgns@fat_crate.local>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-13-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403174406.4180472-13-ltykernel@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 03, 2023 at 01:44:00PM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Add a #HV exception handler that uses IST stack.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V2:
>        * Remove unnecessary line in the change log.
> ---
>  arch/x86/entry/entry_64.S             | 60 +++++++++++++++++++++++++++
>  arch/x86/include/asm/cpu_entry_area.h |  6 +++
>  arch/x86/include/asm/idtentry.h       | 39 ++++++++++++++++-
>  arch/x86/include/asm/page_64_types.h  |  1 +
>  arch/x86/include/asm/trapnr.h         |  1 +
>  arch/x86/include/asm/traps.h          |  1 +
>  arch/x86/kernel/cpu/common.c          |  1 +
>  arch/x86/kernel/dumpstack_64.c        |  9 +++-
>  arch/x86/kernel/idt.c                 |  1 +
>  arch/x86/kernel/sev.c                 | 53 +++++++++++++++++++++++
>  arch/x86/kernel/traps.c               | 40 ++++++++++++++++++
>  arch/x86/mm/cpu_entry_area.c          |  2 +
>  12 files changed, 211 insertions(+), 3 deletions(-)

Same comment as here:

https://lore.kernel.org/r/20230331155714.GCZCcC2pHVZgIHr8k8@fat_crate.local

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
