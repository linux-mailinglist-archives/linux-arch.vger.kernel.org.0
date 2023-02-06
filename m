Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C068C74E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 21:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBFULT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 15:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFULS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 15:11:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAEF1C7EB;
        Mon,  6 Feb 2023 12:11:17 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E10931EC049C;
        Mon,  6 Feb 2023 21:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675714275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NO2OKPr7wr2p13RctitFXtUfIp/VTkMxyyxHS6ADsbQ=;
        b=Sm+d+Pd2WkMEsQW6TzOesuFGIsHrhq7eX6+iZB5j4NWN3JEaUIzaauN0LFBPvqdyTC829B
        HD5EkTeEAQpHhG3fdrNBNUyWFTK3gnn5mdemufDsELvcUkBwH+x/aiy6rsLZd3uZ5ELF1G
        JJRH/x4EpFPnlPkx/dfCiVL0xRTZu3A=
Date:   Mon, 6 Feb 2023 21:11:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, jgross@suse.com, tiala@microsoft.com,
        kirill@shutemov.name, jiangshan.ljs@antgroup.com,
        peterz@infradead.org, ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V3 10/16] x86/hyperv: Add smp support for sev-snp
 guest
Message-ID: <Y+Fe390kWFnAh6gC@zn.tnic>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-11-ltykernel@gmail.com>
 <62ffd8b2-3d88-499e-ba13-1da26f664c6f@amd.com>
 <ce9b4a79-b877-211d-aee8-bbc02e6805b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce9b4a79-b877-211d-aee8-bbc02e6805b5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 03, 2023 at 03:00:44PM +0800, Tianyu Lan wrote:
> > For the bits definition, use:
> > 
> >              u64 sev_feature_snp            : 1,
> >                  sev_feature_vtom            : 1,
> >                  sev_feature_reflectvc        : 1,
> >                  ...
> > 
> 
> Good suggestion. Thanks.

Actually, I'd prefer if you used a named union and drop all this
"sev_feature_" prefixes everywhere:

        union {
                struct {
                        u64 snp                     : 1;
                        u64 vtom                    : 1;
                        u64 reflectvc               : 1;
                        u64 restrict_injection      : 1;
                        u64 alternate_injection     : 1;
                        u64 full_debug              : 1;
                        u64 reserved1               : 1;
                        u64 snpbtb_isolation        : 1;
                        u64 resrved2                : 56;
                };
                u64 val;
        } sev_features;



so that you can do in code:

	struct sev_es_save_area *sev;

	...

	sev->sev_features.snp = ...

and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
