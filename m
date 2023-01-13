Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86FE66A603
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jan 2023 23:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjAMWht (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Jan 2023 17:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjAMWhq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jan 2023 17:37:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E40877D38
        for <linux-arch@vger.kernel.org>; Fri, 13 Jan 2023 14:37:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso25815735pjf.1
        for <linux-arch@vger.kernel.org>; Fri, 13 Jan 2023 14:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYGGpY3c8wYSsolPP7oPQ187xmYhIxXfoDRmESiHutM=;
        b=tgwARpR6oX7pIqiIfedVsEF9/fVdX7R++KsquyR9ziZ7UzwRxscaS5kujj2zHNYPAs
         HesOuR7Sx5qOtSVwO3krm9uRXR5UTvzOqDPwLsoUS2mCaA5ph+KP9eBNBsRpd0A9L435
         C78pBQlFmakDJoSXEeoufowua/fVMOTGqx3NtP2NIvaMzedd/pr1PLOYbQsS6dFkx5/5
         kwCkXGYgxwKfF8lpKdpuKcjcpYVGyJ9gllu5qeMUhB05/Ix+APK3DiMQF2xJm40Kxo/a
         rgTKeVYwqHKt8DoSnIFSclpMZ4e19SkFrGNJvf/OTxDBdTMTbfjsPlmc3hwEOi/a1hX7
         bWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYGGpY3c8wYSsolPP7oPQ187xmYhIxXfoDRmESiHutM=;
        b=ySl7xMRh93vNCvVQt0m2+OnBWpWhW6pIftf6wW2YxOPWN547sP3nC9zTCg4yoFV8MY
         SuROZO6agVMvBYmlCQyfUL4vEvYrEiz5pch8hvspJOybd2qytXYwVT90jlVn7FdPyuZU
         8QJ3+rVzgMMQm94AvDv5fzsz8a7S2XR6APgJY4bceuvrHQylO871r0Xb0WW3xBIB48R1
         OmLZHAAACGXsbnZ3l7UEN10Z3NyXpHdS1EKrWWl6O+OgexMtvSB3rB2owN7yHQE9MJc2
         bp4razK9k3fYuODkIXBpRdsjB2lEUF337vzB5kNUCnUJkkau0t7NKj/oqaP58VwQiACA
         LGAQ==
X-Gm-Message-State: AFqh2kp9KlSwGm0i40olRRDWOrF26LpDo7GrjInbf63s4IU/a51IQQf7
        vdc/iY4ZMZGbrtu8ef6SqegVnA==
X-Google-Smtp-Source: AMrXdXt5stBpwIEJwVXkUT6AxYk7gqWiLYnlxJx1z/r5PInmsD3i+NPQ2hSxNQ6Dxd7BftBMBypz9g==
X-Received: by 2002:a17:90a:d148:b0:229:1e87:365f with SMTP id t8-20020a17090ad14800b002291e87365fmr580615pjw.2.1673649464636;
        Fri, 13 Jan 2023 14:37:44 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090ad78700b002270155254csm10626708pju.24.2023.01.13.14.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 14:37:43 -0800 (PST)
Date:   Fri, 13 Jan 2023 22:37:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <Y8HdMzlNFhFwlkGS@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <Y7azFdnnGAdGPqmv@kernel.org>
 <20230106094000.GA2297836@chaop.bj.intel.com>
 <Y7xrtf9FCuYRYm1q@google.com>
 <20230110091432.GA2441264@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110091432.GA2441264@chaop.bj.intel.com>
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

On Tue, Jan 10, 2023, Chao Peng wrote:
> On Mon, Jan 09, 2023 at 07:32:05PM +0000, Sean Christopherson wrote:
> > On Fri, Jan 06, 2023, Chao Peng wrote:
> > > On Thu, Jan 05, 2023 at 11:23:01AM +0000, Jarkko Sakkinen wrote:
> > > > On Fri, Dec 02, 2022 at 02:13:41PM +0800, Chao Peng wrote:
> > > > > To make future maintenance easy, internally use a binary compatible
> > > > > alias struct kvm_user_mem_region to handle both the normal and the
> > > > > '_ext' variants.
> > > > 
> > > > Feels bit hacky IMHO, and more like a completely new feature than
> > > > an extension.
> > > > 
> > > > Why not just add a new ioctl? The commit message does not address
> > > > the most essential design here.
> > > 
> > > Yes, people can always choose to add a new ioctl for this kind of change
> > > and the balance point here is we want to also avoid 'too many ioctls' if
> > > the functionalities are similar.  The '_ext' variant reuses all the
> > > existing fields in the 'normal' variant and most importantly KVM
> > > internally can reuse most of the code. I certainly can add some words in
> > > the commit message to explain this design choice.
> > 
> > After seeing the userspace side of this, I agree with Jarkko; overloading
> > KVM_SET_USER_MEMORY_REGION is a hack.  E.g. the size validation ends up being
> > bogus, and userspace ends up abusing unions or implementing kvm_user_mem_region
> > itself.
> 
> How is the size validation being bogus? I don't quite follow.

The ioctl() magic embeds the size of the payload (struct kvm_userspace_memory_region
in this case) in the ioctl() number, and that information is visible to userspace
via _IOCTL_SIZE().  Attempting to take a larger size can mess up sanity checks,
e.g. KVM selftests get tripped up on this assert if KVM_SET_USER_MEMORY_REGION is
passed an "extended" struct.

	#define kvm_do_ioctl(fd, cmd, arg)						\
	({										\
		kvm_static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == _IOC_SIZE(cmd));	\
		ioctl(fd, cmd, arg);							\
	})

> Then we will use kvm_userspace_memory_region2 as the KVM internal alias,
> right?

Yep.

> I see similar examples use different functions to handle different versions
> but it does look easier if we use alias for this function.
> 
> > 
> > It feels absolutely ridiculous, but I think the best option is to do:
> > 
> > #define KVM_SET_USER_MEMORY_REGION2 _IOW(KVMIO, 0x49, \
> > 					 struct kvm_userspace_memory_region2)
> 
> Just interesting, is 0x49 a safe number we can use? 

Yes?  So long as its not used by KVM, it's safe.  AFAICT, it's unused.
