Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16942705262
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 17:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjEPPir (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjEPPio (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 11:38:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB30D30E3
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 08:38:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f38824a025so1845101cf.0
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684251520; x=1686843520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N2CRyxNmsdznR8/fBUCCYBNG767y6htOcJe+Dq978O0=;
        b=ky99+SCHVfnCmAJnGMGv+XVy+Y/5w5Oriop+D60VXZbCJ46gh+BY4W/UCSx8Jw6A1Y
         WeM0aEvIRgrM2jDStmfPFfmthOHniHIbD6BBAkMqS2rRLZbeZZIgdXCCOoRBUnvSevIu
         mGuNBL4Mr3wXiwPb659vYj/tqLRCY8VqO+w/QgMqd5eX9Uw6OGg4SA2MO9aKFK9RIRvU
         tNCGIHM+6q9QmYMsDDHzkOg7i/4XX2pKHtb2C+hHmMlevY63HKwLMDWrQseSHQPXXPBX
         PZhvWIyZ0rkWNQ7lzVI/RMghiVJsnssJd/v656xW56cjCjuc8HUMmcZXCCBDdfbZ3RxZ
         SnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251520; x=1686843520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2CRyxNmsdznR8/fBUCCYBNG767y6htOcJe+Dq978O0=;
        b=lCusX67BxLoibWDMzBCXvJd93gLuj+tTwElELVbyDX1wC/Oz9oa7AcuGslinVvyk1G
         p3yeG4uCQyQPGYURn+1OOiuLH+4spqZq+yUeczWrVVVA5PEn5Zlkh86rEzFiH745Txb7
         cI1nbxcA3goEXoxb0xM4/EXJvT2b/jtGVtYZ+7lD6zQ1OuWBd4uTtssRY7xxp4IJ72ei
         Y9cuzSCFTvyKEwjcnwRh3+ynzqS/ZXh4UdQY+vU31jbyOOlH/3RT3oG07G46QvutRjWR
         PNUEKoGOOpjjsYTZg1+DeVdTsEW+qzX3ymC7BR8SfE09ycfXQkoqf5ki6bqCXwF7++hu
         MvGw==
X-Gm-Message-State: AC+VfDxZa+pGWikPtFJmQhf/OmBq8CKWNMt4bRG5K8smDR57/olKlITC
        1wQb2Nj1B5mAL6RNp9bWJTUWCqtVUzQe8xd4NNJbtg==
X-Google-Smtp-Source: ACHHUZ6fQp/lKGz1+t36Q6XsaElEPIWiVg1TuKslqyo6sEc8QdbtTlLU6AEW4d5yZVI5PwZB9goyJxoyJD4Dogeldhw=
X-Received: by 2002:ac8:4e86:0:b0:3f5:4eb4:414f with SMTP id
 6-20020ac84e86000000b003f54eb4414fmr44516qtp.13.1684251519819; Tue, 16 May
 2023 08:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230515165917.1306922-1-ltykernel@gmail.com> <20230515165917.1306922-4-ltykernel@gmail.com>
 <20230516094048.GE2587705@hirez.programming.kicks-ass.net>
In-Reply-To: <20230516094048.GE2587705@hirez.programming.kicks-ass.net>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 16 May 2023 08:38:28 -0700
Message-ID: <CAAH4kHZvSDNeRsiCCJ-DyBEj2MxGdmGuZeuofL0y=RP19cqfVw@mail.gmail.com>
Subject: Re: [RFC PATCH V6 03/14] x86/sev: Add AMD sev-snp enlightened guest
 support on hyperv
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, pangupta@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>
> WTF is this supposed to do and why is this the right way to achieve the
> desired result?
>
> Your changelog gives me 0 clues -- guess how much I then care about your
> patches?

Excuse me? No. This is incredibly rude and violates the community code
of conduct. Please review examples of creating a positive environment
here https://docs.kernel.org/process/code-of-conduct.html

-- 
-Dionna Glaze, PhD (she/her)
