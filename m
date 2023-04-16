Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F256E35B1
	for <lists+linux-arch@lfdr.de>; Sun, 16 Apr 2023 09:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDPHYM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Apr 2023 03:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDPHYM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Apr 2023 03:24:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182BC90;
        Sun, 16 Apr 2023 00:24:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50508810c8bso2672965a12.3;
        Sun, 16 Apr 2023 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629849; x=1684221849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WzApRNmLj/C3OG/CHM2LgsaZWOMDJjJGhX2jIgFh5iQ=;
        b=ZzGoJ8Ob6wDQiTectXDiaEkTh5bRHklVWginnSvk8wNf5X3+mXGfkkyW/o7oaIoqTb
         20bjGhupgHK5yAlaeS5jTRbVd1AzlO7jepKjx+YVjZMgiy6sr5Uc95ognkhCWzJQXCci
         0urW3ObSU9WN3EVaCCsT+IhK/1Xf+38PmrRCTDkZpf6382bzOfSZeLzFwP5Ti6lG62Z0
         TBEmvEFHzefbPLGLzSdaC/NTmstevmzg6R4F8OKFseD0Gi3NTMLu4/VuyelDbUNCH2of
         cqjlSSmYEqRaReg6Xm/655MPnIP9GqteNUoJKATPlVOip++HCP7KiOWyscb25HyOAWyz
         ixtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629849; x=1684221849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzApRNmLj/C3OG/CHM2LgsaZWOMDJjJGhX2jIgFh5iQ=;
        b=L0bgMPXUbwtAJIDbaxaFUoSo9y27y7dy86ef+LHni3qEOKS3QnLuSVL6R/9kBz1bp0
         2xfYdtyuIi2E2nnIOWz3DRzsoT9z0tPzBkfj/ycVxX4iMKmkvidstK2EMWVFQD1nazo6
         tFJ2jpQrtQrQglXLhgPMmutNFGg8Xpk4oZDZ493Xn7DV+kZ4W8Atx70leKj/ciORy2PO
         f/VhvhC5Cr5jLH0uiOs8MbxBWh27frNTdqXy2UCk6Nk2SFC/6BxFkRl53oQQtcPTh+6v
         oztpQKyOxd+jjyoUXoQv/kezxmgOGUVxmHn6mAjAfPf3UthnCH2GFS4uASqXg4+x8QrN
         SX2A==
X-Gm-Message-State: AAQBX9eTb+LzMbCBGQVkRyd60vyVUjlmy+AjiiwO8luCFYne3nfJFRr8
        Q8yjf/+30nducRzoeZ+JI3yVf4B4kmjddAKv77M=
X-Google-Smtp-Source: AKy350bovBnK6IYlQYXJJeOhlweH+duu5L0amN8OVVWuh88RlMjNoRuoFYcuEEXdzYGPozQ8Hs03V+iTqVA8M93Bpq0=
X-Received: by 2002:a50:ab15:0:b0:504:eb61:b4eb with SMTP id
 s21-20020a50ab15000000b00504eb61b4ebmr5491982edc.7.1681629849148; Sun, 16 Apr
 2023 00:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230403174406.4180472-1-ltykernel@gmail.com> <20230403174406.4180472-9-ltykernel@gmail.com>
 <BYAPR21MB1688DB1442B486A8DEBEF821D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688DB1442B486A8DEBEF821D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   sky free <ltykernel@gmail.com>
Date:   Sun, 16 Apr 2023 15:23:33 +0800
Message-ID: <CAMvTesC42Rf=r6fsi6PVB+WgtRxWOXSeTY7RvyHZizFJkDRSyg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Cc:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/12/2023 10:39 PM, Michael Kelley (LINUX) wrote:
>> +    /* Read processor number and memory layout. */
>> +    processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
>> +    entry = (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR)
>> +                    + sizeof(struct memory_map_entry));
> Why is the first map entry being skipped?

The first entry is populated with processor count by Hyper-V.
