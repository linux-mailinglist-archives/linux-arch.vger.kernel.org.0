Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD862C835
	for <lists+linux-arch@lfdr.de>; Wed, 16 Nov 2022 19:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKPSwi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Nov 2022 13:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiKPSvI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2022 13:51:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F549B5D
        for <linux-arch@vger.kernel.org>; Wed, 16 Nov 2022 10:48:47 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso3262737pjc.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Nov 2022 10:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0w6P3/5rWNmrPimfeWShNgQxfD7eWOB8psbtgB4eNM=;
        b=iuHU2XySbRBXDBvmb7KGdjsTrJ11MtKm8XUWbJgiH+mJZH0mrNKnmVkYWIqEN8KH+D
         TMTSgskSxS+dz6pqJQ/6lU5YOrdG2ZlIZWDOaRJRiQwsbQA3PrerGAmObwm4ynhLdSAK
         ipQyS23YgpxwcwZ6vh4k2Bq/MDUW0MakaENRTi4n4z7trqezhQAU1VBvvRliz6hMutEA
         9nByJ3f7EiBHZeDsD30/pNhrYplPoCDi15C49ph/4Z5Ug6emFwiauN/3keUjTSc8xjjS
         9rhI8o2gCdwKZQMaSLBrQFcQ5PC0p5wqf3PICwkpXgJE4dUBiCSgdG/Zg1bcsS/uJXqa
         0yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0w6P3/5rWNmrPimfeWShNgQxfD7eWOB8psbtgB4eNM=;
        b=rvHRG+/qXNTnLnOey0bpFadpCSlMaLP9PPRCRr5mNAd8V4ISJuiVTP1GRLmoI8Z03V
         i9Ptp+fVzKNGiZ0ebgzaQJSyiAwThAuys+BPOIRQtG83we+k3OzwyjlWGauzk1cECshE
         S6zwTTQRgdU1hK38vw/R7Suv4UGJCppIwLx+8Uk1zGNxJ/IkhUbDXrK4ZOy3xqtKgtzw
         83c5AmgUVcYjFUtr33RurPs/TYsrdWlbKrAzPKQivzsLVdphhpXg/0lzXhDOncGZDebb
         XOnEtiHJz5vQPqRk/DnzcfrbI86KYnCSaHwz6lWtaH2aBflYmhNWjK61O82OEKBCvPla
         EEgw==
X-Gm-Message-State: ANoB5pkcXQig4Gbb5BrHQFrm/EtWqDPrzr5g/UKS6zdhfJcJfE9AwPAT
        GsQzNpeanXOdON2Lvp6Nrku6Bg==
X-Google-Smtp-Source: AA0mqf7gsXMWPLCwPxYnb+HvqYNLX3WPvDWV8mKDKQpAZsMJhL2t5iqRN/vftj6zV72w0hUj24psag==
X-Received: by 2002:a17:90b:3c0d:b0:20d:478a:9d75 with SMTP id pb13-20020a17090b3c0d00b0020d478a9d75mr5030085pjb.149.1668624527166;
        Wed, 16 Nov 2022 10:48:47 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 7-20020a621507000000b0056c0b98617esm11265827pfv.0.2022.11.16.10.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:48:46 -0800 (PST)
Date:   Wed, 16 Nov 2022 18:48:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Wei W Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <Y3Uwi2lc4NDrdzML@google.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <2e252f4f-7d45-42ac-a88f-fa8045fe3748@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e252f4f-7d45-42ac-a88f-fa8045fe3748@app.fastmail.com>
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

On Wed, Nov 16, 2022, Andy Lutomirski wrote:
> 
> 
> On Tue, Oct 25, 2022, at 8:13 AM, Chao Peng wrote:
> > diff --git a/Documentation/virt/kvm/api.rst 
> > b/Documentation/virt/kvm/api.rst
> > index f3fa75649a78..975688912b8c 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6537,6 +6537,29 @@ array field represents return values. The 
> > userspace should update the return
> >  values of SBI call before resuming the VCPU. For more details on 
> > RISC-V SBI
> >  spec refer, https://github.com/riscv/riscv-sbi-doc.
> > 
> > +::
> > +
> > +		/* KVM_EXIT_MEMORY_FAULT */
> > +		struct {
> > +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> > +			__u32 flags;
> > +			__u32 padding;
> > +			__u64 gpa;
> > +			__u64 size;
> > +		} memory;
> > +
> 
> Would it make sense to also have a field for the access type (read, write,
> execute, etc)?  I realize that shared <-> private conversion doesn't strictly
> need this, but it seems like it could be useful for logging failures and also
> for avoiding a second immediate fault if the type gets converted but doesn't
> have the right protection yet.

I don't think a separate field is necessary, that info can be conveyed via flags.
Though maybe we should go straight to a u64 for flags.  Hmm, and maybe avoid bits
0-3 so that if/when RWX info is conveyed the flags can align with
PROT_{READ,WRITE,EXEC} and the EPT flags, e.g.

	KVM_MEMORY_EXIT_FLAG_READ	(1 << 0)
	KVM_MEMORY_EXIT_FLAG_WRITE	(1 << 1)
	KVM_MEMORY_EXIT_FLAG_EXECUTE	(1 << 2)

> (Obviously, if this were changed, KVM would need the ability to report that
> it doesn't actually know the mode.)
> 
> --Andy
