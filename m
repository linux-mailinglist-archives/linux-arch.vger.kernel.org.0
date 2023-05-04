Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11596F6F78
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 17:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjEDP6l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEDP6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 11:58:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6ED468B;
        Thu,  4 May 2023 08:58:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2a8dc09e884so1372171fa.1;
        Thu, 04 May 2023 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683215918; x=1685807918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYBoD42fi0Qo48RQvnR/5/xNrxWUbWiP9dXKPNjnGZc=;
        b=bXqQqAH97aZqNoW6tYHPqjwasg8isVEvVzYfRdDnYi4bHmmJhsUuyRBPiS2DzfvxXD
         OkKoXvNDeUw28Ry1YuZw4XZPfa7wUHL/CgMgF3Kimqe5+qtPFYQmumgVSK98O899FiVH
         v/P9iNpcNC/SOB9HpRDQ5orjOCJWxgCPr/JegUbpxIaZmi3qZxzFbCd+L1clGiNGUzWx
         EGyp6pvCTGbrOx70ztLvOpmxkwCCVEt+Emo1fDgdZqjlkA4+L6/y9IZykRvAXchVlDQY
         tc6RpHqPRrxJXZgK5zRcDV3FR7A0J5jqmFY1oFkkDKXqxImmafAVTg0lh1wzdKap+IVS
         p6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215918; x=1685807918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYBoD42fi0Qo48RQvnR/5/xNrxWUbWiP9dXKPNjnGZc=;
        b=HsJe6qFg2u/O8pJZTWL0MxFlvrSogGxxkEDPeZkv6nKnyTLsZ3QwgIrs7UJ6LRNrML
         bBDaRmtlhg8MQUD0sHERzhV1aF+aLWHGffH+G45BhawNXxFZgO7hKfTYg7y4I366q7gM
         xb/aAeNVEqex8QQHX5aDSd/1BAQTxvX1qgZw21RgoSYpDPmNNZkit7HVrSzUJ+im32QI
         uyvn0SNDABPOOQDXmtRsE4CYZq/pZC2nTk7mFKp+1SmiP5xrCZtfFiTrO/lZMK4xWwuM
         dG7ahO+/u4efx55t0mWW3k/Z7mUahL36a5bK0A5cqNZGstEbmDMLWsfNqBrgVobNAHnb
         8dIg==
X-Gm-Message-State: AC+VfDz99NtXESOTB9SKAzRMOLecJAzPfjYDCThxo12BWS8WSEiqoy8W
        2Fx7HCnw0IglO5jZ8mJ80p8=
X-Google-Smtp-Source: ACHHUZ7lf9SJwpLxOd9zE09fOQJ6fYIObPElS6/ynR+3eECh6A5+PBp3kvB9rprdiMPydNUiRBzNvA==
X-Received: by 2002:a2e:a261:0:b0:2ac:7237:d5bf with SMTP id k1-20020a2ea261000000b002ac7237d5bfmr1342238ljm.2.1683215917713;
        Thu, 04 May 2023 08:58:37 -0700 (PDT)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id v5-20020a2e9245000000b002a8ecae9567sm6629014ljg.84.2023.05.04.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 08:58:37 -0700 (PDT)
Date:   Thu, 4 May 2023 18:58:14 +0300
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
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
Subject: Re: [RFC PATCH V5 03/15] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
Message-ID: <20230504185814.00005792.zhi.wang.linux@gmail.com>
In-Reply-To: <4db13429-ffb0-debc-cec4-e37d0e526934@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
        <20230501085726.544209-4-ltykernel@gmail.com>
        <20230502223041.00000240.zhi.wang.linux@gmail.com>
        <4db13429-ffb0-debc-cec4-e37d0e526934@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 4 May 2023 08:38:46 -0700
Tianyu Lan <ltykernel@gmail.com> wrote:

> On 5/2/2023 12:30 PM, Zhi Wang wrote:
> > On Mon,  1 May 2023 04:57:13 -0400
> > Tianyu Lan <ltykernel@gmail.com> wrote:
> > 
> >> From: Tianyu Lan <tiala@microsoft.com>
> >>
> >> sev-snp guest provides vtl(Virtual Trust Level) and
> >> get it from hyperv hvcall via HVCALL_GET_VP_REGISTERS.
> >> Set target vtl in the VMBus init message.
> >>
> >> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> >> ---
> >> Change since RFC v4:
> >>         * Use struct_size to calculate array size.
> >>         * Fix some coding style
> >>
> >> Change since RFC v3:
> >>         * Use the standard helper functions to check hypercall result
> >>         * Fix coding style
> >>
> >> Change since RFC v2:
> >>         * Rename get_current_vtl() to get_vtl()
> >>         * Fix some coding style issues
> >> ---
> >>   arch/x86/hyperv/hv_init.c          | 36 ++++++++++++++++++++++++++++++
> >>   arch/x86/include/asm/hyperv-tlfs.h |  7 ++++++
> >>   drivers/hv/connection.c            |  1 +
> >>   include/asm-generic/mshyperv.h     |  1 +
> >>   include/linux/hyperv.h             |  4 ++--
> >>   5 files changed, 47 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> >> index 9f3e2d71d015..331b855314b7 100644
> >> --- a/arch/x86/hyperv/hv_init.c
> >> +++ b/arch/x86/hyperv/hv_init.c
> >> @@ -384,6 +384,40 @@ static void __init hv_get_partition_id(void)
> >>   	local_irq_restore(flags);
> >>   }
> >>   
> >> +static u8 __init get_vtl(void)
> >> +{
> >> +	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> >> +	struct hv_get_vp_registers_input *input;
> >> +	struct hv_get_vp_registers_output *output;
> >> +	u64 vtl = 0;
> >> +	u64 ret;
> >> +	unsigned long flags;
> >> +
> >> +	local_irq_save(flags);
> >> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> +	output = (struct hv_get_vp_registers_output *)input;
> > 
> > ===
> >> +	if (!input) {
> >> +		local_irq_restore(flags);
> >> +		goto done;
> >> +	}
> >> +
> > ===
> > Is this really necessary?
> > 
> > drivers/hv/hv_common.c:
> > 
> >          hyperv_pcpu_input_arg = alloc_percpu(void  *);
> >          BUG_ON(!hyperv_pcpu_input_arg);
> > 
> > 
> 
> Hi Zhi:
> 	The hyperv_pcpu_input_arg is a point to address of input arg
> pages and these pages are allocated in the hv_common_cpu_init(). If
> it failed to allocate these pages, the value pointed by 
> hyperv_pcpu_input_arg will be NULL.
> 	

Sorry, it seems my email editor dropped some text. I was wondering that
if the check above is necessary as there is a BUG_ON() when allocating
hyperv_pcpu_input_arg.

So when coming to get_vtl(), the hyperv_pcpu_input_arg should not be NULL.
(Guarded by the BUG_ON() in the allocation)?
