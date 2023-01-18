Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA2E671A14
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 12:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjARLKn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 06:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjARLKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 06:10:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C3B474CC;
        Wed, 18 Jan 2023 02:17:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k13so3833521plg.0;
        Wed, 18 Jan 2023 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRTfZL3StJ9hOSfK7f1T1cO6UgiEkghPJ6emW6oB5WM=;
        b=VsbaErPgHAtxesL07pT4eodeuGg/45NGQD74kOyycyZvMN11AFd1R05/VQA6pOEOrm
         +zxwrYqU4AmnxiqH+8m27DsZxy6AK2lyLEoY2L28M4Bd8yBmCYgHh6qqWFb9tkmS0Upk
         DFoOiBxzL8mQ3cryHK7mfGOVnB1y4dNKYc8PsriiEHN6yiVjRMiohggmLADpAupAIHf3
         Yi2HIfGfi3OQhsL8QSI6wGsIOnLtWXdGoWzgG1MLLtQqob9avNYEoLlwUaOlAi98M2Ib
         MHSmmsmJvAhaAEurhrEnNaSQnZ90EywrUjC0wuH5ucqXTadVa/72xCkzwOOrmjaqXObR
         zxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRTfZL3StJ9hOSfK7f1T1cO6UgiEkghPJ6emW6oB5WM=;
        b=rGyiVB0O0BuWnRJrsdAC6a7JUfk5vFtysVPd7Dtfwj++bfiurCIvxKL0zvKnRR58Xn
         +wL0tAWajyLY0iQNQXP9x+5ZUqE+G6rIva4FIW4XHiUgOCnvlExebvraLr6MOkFR7Bz2
         /IqWDTvXTbvui4U+iCPsB2VDRwTl7G5yaaq6Zndf9N7TSgnu5x5q1he8TxcA/69W2K8Y
         Ha10jHD1Nznly30e0cPR7EOHA8WvNufiDO0jEd4uIYNdia6uvjKRnCnMUVd6EadMtslf
         aTbqrmxxQDRRn3MAC99cMtzhRpROXb3su1D3bGxteWLL/6OOo3Ibpt5En0uWy/F+fnlh
         07+Q==
X-Gm-Message-State: AFqh2kol8eVWxWhbFdHHzc8c/0unvI2W+nA0WC0PsE59s7fedacQVjOV
        RgsaZpZ0m7MBqcpS6GuDd6o=
X-Google-Smtp-Source: AMrXdXtImpvJaJmae2KKbZNPInmobBwC1DDHiHeiMYJcL206cw9Ph82inhT00Ujzu8CjORCOM7ER7Q==
X-Received: by 2002:a17:902:ce82:b0:194:84ef:5f9c with SMTP id f2-20020a170902ce8200b0019484ef5f9cmr22922601plg.29.1674037046738;
        Wed, 18 Jan 2023 02:17:26 -0800 (PST)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709026b0a00b001898ee9f723sm22814641plk.2.2023.01.18.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:17:26 -0800 (PST)
Date:   Wed, 18 Jan 2023 02:17:23 -0800
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
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
        wei.w.wang@intel.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20230118101723.GA2976263@ls.amr.corp.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <Y8HTITl1+Oe0H7Gd@google.com>
 <20230117124107.GA273037@chaop.bj.intel.com>
 <Y8bOB7VuVIsxoMcn@google.com>
 <20230118081641.GA303785@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118081641.GA303785@chaop.bj.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 18, 2023 at 04:16:41PM +0800,
Chao Peng <chao.p.peng@linux.intel.com> wrote:

> On Tue, Jan 17, 2023 at 04:34:15PM +0000, Sean Christopherson wrote:
> > On Tue, Jan 17, 2023, Chao Peng wrote:
> > > On Fri, Jan 13, 2023 at 09:54:41PM +0000, Sean Christopherson wrote:
> > > > > +	list_for_each_entry(notifier, &data->notifiers, list) {
> > > > > +		notifier->ops->invalidate_start(notifier, start, end);
> > > > 
> > > > Two major design issues that we overlooked long ago:
> > > > 
> > > >   1. Blindly invoking notifiers will not scale.  E.g. if userspace configures a
> > > >      VM with a large number of convertible memslots that are all backed by a
> > > >      single large restrictedmem instance, then converting a single page will
> > > >      result in a linear walk through all memslots.  I don't expect anyone to
> > > >      actually do something silly like that, but I also never expected there to be
> > > >      a legitimate usecase for thousands of memslots.
> > > > 
> > > >   2. This approach fails to provide the ability for KVM to ensure a guest has
> > > >      exclusive access to a page.  As discussed in the past, the kernel can rely
> > > >      on hardware (and maybe ARM's pKVM implementation?) for those guarantees, but
> > > >      only for SNP and TDX VMs.  For VMs where userspace is trusted to some extent,
> > > >      e.g. SEV, there is value in ensuring a 1:1 association.
> > > > 
> > > >      And probably more importantly, relying on hardware for SNP and TDX yields a
> > > >      poor ABI and complicates KVM's internals.  If the kernel doesn't guarantee a
> > > >      page is exclusive to a guest, i.e. if userspace can hand out the same page
> > > >      from a restrictedmem instance to multiple VMs, then failure will occur only
> > > >      when KVM tries to assign the page to the second VM.  That will happen deep
> > > >      in KVM, which means KVM needs to gracefully handle such errors, and it means
> > > >      that KVM's ABI effectively allows plumbing garbage into its memslots.
> > > 
> > > It may not be a valid usage, but in my TDX environment I do meet below
> > > issue.
> > > 
> > > kvm_set_user_memory AddrSpace#0 Slot#0 flags=0x4 gpa=0x0 size=0x80000000 ua=0x7fe1ebfff000 ret=0
> > > kvm_set_user_memory AddrSpace#0 Slot#1 flags=0x4 gpa=0xffc00000 size=0x400000 ua=0x7fe271579000 ret=0
> > > kvm_set_user_memory AddrSpace#0 Slot#2 flags=0x4 gpa=0xfeda0000 size=0x20000 ua=0x7fe1ec09f000 ret=-22
> > > 
> > > Slot#2('SMRAM') is actually an alias into system memory(Slot#0) in QEMU
> > > and slot#2 fails due to below exclusive check.
> > > 
> > > Currently I changed QEMU code to mark these alias slots as shared
> > > instead of private but I'm not 100% confident this is correct fix.
> > 
> > That's a QEMU bug of sorts.  SMM is mutually exclusive with TDX, QEMU shouldn't
> > be configuring SMRAM (or any SMM memslots for that matter) for TDX guests.
> 
> Thanks for the confirmation. As long as we only bind one notifier for
> each address, using xarray does make things simple.

In the past, I had patches for qemu to disable PAM and SMRAM, but they were
dropped for simplicity because SMRAM/PAM are disabled as reset state with unused
memslot registered. TDX guest bios(TDVF or EDK2) doesn't enable them.
Now we can revive them.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
