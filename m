Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B959B6367FC
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 19:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbiKWSC2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 13:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiKWSCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 13:02:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DADA9371F
        for <linux-arch@vger.kernel.org>; Wed, 23 Nov 2022 10:02:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so2525998pjc.2
        for <linux-arch@vger.kernel.org>; Wed, 23 Nov 2022 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBAHsDOjy5OO4Ngubx5UMoEA0/sDtPMwp6OMmJM5Kq8=;
        b=j0pjNho9RlZm19Tehr3FVjo7Db8885B4Y7xkdDdUAoWctaEVu0QXpeH4dAhlT+H/66
         rXShciLYPKXX/As5ej1NnFhKVYsgqZOAIM86zq/8g4IoL0rpFkAis4hyMIxH32ObpzTD
         q12ac2q20Bq/175aKSlrDsis/kh1ZErXHlsfXaFF0vLM0VKl7Q/KOGrAwfHxRNQmXI/O
         driosPsB+7yejIXs59Nh7GScXFt/2qGI69bVfBSTlUwjFNjy1R5omvxslKZApaKKy6Vb
         bCz1WtnxHp4F2zgsQTYD/KhQpB2n22TuYLklkc67sIj+R3YF0oMYZg8xQcjMBvZBgqVR
         chmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBAHsDOjy5OO4Ngubx5UMoEA0/sDtPMwp6OMmJM5Kq8=;
        b=S92FJLVINiTfscBjyzLewMLdGUmRLIWhu8FvOF8GOMSfo8WY9+mxe26WRDDZjk/jss
         3ZkTHtF2wdrA/KTDbDrIHi8Kckyi6h9unOw5ne3f29q+PwxKyC5EBHiXFZ2MitxkspcG
         cRoFu3L09VQXvQ9h3HZRc63Y1X7lK5U9KqJN30rhwmeD2xpoOd0Ov/8l4XAlWyXmmJ/L
         gNyzUqeZsLmLXQUJ8AFrLlDbMlkkGZSWapTBCPrK1bAo++w5KfnXKbtceJesIEiDL85N
         L/x1HqGSiM7tTkRsDjygxXZ9pJVTFBaaTVrtzR81I7CJHAJGMK6V8o8F2CKih3wuuBOm
         0BJw==
X-Gm-Message-State: ANoB5pnejXW/KvYG53Wf5zIuig3/CamScysOPl6tXNjh+8rzskS/J9ls
        ZxbwyuKoUk2pYuvZtgKEsptqYSEPwWkIjA==
X-Google-Smtp-Source: AA0mqf4h/eDzvGfQmUc/ZjBSomm7vgT2Crg1NblOZpQoP8uNf60lMXpAkbUo70CvheBSDG5J9lpZAg==
X-Received: by 2002:a17:902:da89:b0:189:8b2:b069 with SMTP id j9-20020a170902da8900b0018908b2b069mr10756414plx.13.1669226535720;
        Wed, 23 Nov 2022 10:02:15 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w26-20020a63475a000000b00462612c2699sm11075143pgk.86.2022.11.23.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:15 -0800 (PST)
Date:   Wed, 23 Nov 2022 18:02:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <Y35gI0L8GMt9+OkK@google.com>
References: <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <87cz9o9mr8.fsf@linaro.org>
 <20221116031441.GA364614@chaop.bj.intel.com>
 <87mt8q90rw.fsf@linaro.org>
 <20221117134520.GD422408@chaop.bj.intel.com>
 <87a64p8vof.fsf@linaro.org>
 <20221118013201.GA456562@chaop.bj.intel.com>
 <87o7t475o7.fsf@linaro.org>
 <Y3er0M5Rpf1X97W/@google.com>
 <20221122095022.GA617784@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122095022.GA617784@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 22, 2022, Chao Peng wrote:
> On Fri, Nov 18, 2022 at 03:59:12PM +0000, Sean Christopherson wrote:
> > On Fri, Nov 18, 2022, Alex Benn?e wrote:
> > > > We don't actually need a new bit, the opposite side of private is
> > > > shared, i.e. flags with KVM_MEMORY_EXIT_FLAG_PRIVATE cleared expresses
> > > > 'shared'.
> > > 
> > > If that is always true and we never expect a 3rd type of memory that is
> > > fine. But given we are leaving room for expansion having an explicit bit
> > > allows for that as well as making cases of forgetting to set the flags
> > > more obvious.
> > 
> > Hrm, I'm on the fence.
> > 
> > A dedicated flag isn't strictly needed, e.g. even if we end up with 3+ types in
> > this category, the baseline could always be "private".
> 
> The baseline for the current code is actually "shared".

Ah, right, the baseline needs to be "shared" so that legacy code doesn't end up
with impossible states.

> > I do like being explicit, and adding a PRIVATE flag costs KVM practically nothing
> > to implement and maintain, but evetually we'll up with flags that are paired with
> > an implicit state, e.g. see the many #PF error codes in x86.  In other words,
> > inevitably KVM will need to define the default/base state of the access, at which
> > point the base state for SHARED vs. PRIVATE is "undefined".  
> 
> Current memory conversion for confidential usage is bi-directional so we
> already need both private and shared states and if we use one bit for
> both "shared" and "private" then we will have to define the default
> state, e.g, currently the default state is "shared" when we define
> 
> 	KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)

...

> > So I would say if we add an explicit READ flag, then we might as well add an explicit
> > PRIVATE flag too.  But if we omit PRIVATE, then we should omit READ too.
> 
> Since we assume the default state is shared, so we actually only need a
> PRIVATE flag, e.g. there is no SHARED flag and will ignore the RWX for now.

Yeah, I'm leading towards "shared" being the implied default state.  Ditto for
"read" if/when we need to communicate write/execute information  E.g. for VMs
that don't support guest private memory, the "shared" flag is in some ways
nonsensical.  Worst case scenario, e.g. if we end up with variations of "shared",
we'll need something like KVM_MEMORY_EXIT_FLAG_SHARED_RESTRICTIVE or whatever,
but the basic "shared" default will still work.
