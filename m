Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B6F63C39C
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 16:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiK2PWy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 10:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiK2PWe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 10:22:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEDF1031;
        Tue, 29 Nov 2022 07:22:33 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E8A51EC04AD;
        Tue, 29 Nov 2022 16:22:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669735351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LujzV/tLtq9Iu7+knxQAJu5JqCU1GbpY29Rl6FN1clw=;
        b=hWnlw+QvI0934jj1dZydvMzk8MdEobqfSccw8KPjtnurrHDTHMqO7x9hfND1W6yDjmyE8q
        cGMH2TANtBQP2+Ob/pfSHto8caOciyQV7tnABhIp30/x3mMui1gjDo32rnU8q/9DRN0bpo
        rv13PgzRaDL73tBO4LW/2bWZh4txdLE=
Date:   Tue, 29 Nov 2022 16:22:31 +0100
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
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for
 decompressing kernel
Message-ID: <Y4Yjt0rOzsSoosEj@zn.tnic>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-2-ltykernel@gmail.com>
 <Y4YBfk3lyUJie4bR@zn.tnic>
 <6b3bdbbd-d381-3e52-57ec-729c8ab2d042@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b3bdbbd-d381-3e52-57ec-729c8ab2d042@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 29, 2022 at 10:42:48PM +0800, Tianyu Lan wrote:
> Thanks for your review. sev_snp_enabled() is used after sev_status
> was initialized in sev_enable() while pvalidate_for_startup_ 64() is
> called before sev_enable().

Then you're going to have to change the code so that sev_status is
initialized before you need it. And not break others in the process.

And lemme save you some time - I won't accept sloppy code. You need to
integrate the functionality you need in the code paths properly - not
bolt it on in complete disregard of the flow just because it is easier.

> This is for Linux direct boot mode and so it needs to do such check
> here.

I don't know what "Linux direct boot mode" is so until you define it
properly and explain everything in detail, this is not going anywhere.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
