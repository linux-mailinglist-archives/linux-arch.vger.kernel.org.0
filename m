Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA536915A9
	for <lists+linux-arch@lfdr.de>; Fri, 10 Feb 2023 01:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjBJAhM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Feb 2023 19:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBJAg6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2023 19:36:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7607303C0
        for <linux-arch@vger.kernel.org>; Thu,  9 Feb 2023 16:36:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so4001452pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Feb 2023 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7YPU86kRh43fh/B9xA9EKXQH40cZnkadx8AsjXbI3M=;
        b=n02O/fL0+7AmXTmeiZ+eZ9d5ZT/GiXiS4usm8YWkyYIOPv66XejcWTG/tLJzS4ejkM
         ovnmjNf+/V4WMPR5hJhke3vD4GplhYtvL9vEmYS6rKRFRInOWY36YmcSGRlRlXtIqk2x
         zyyYNZ5RPe7YC1b4z/lhTrlqaQI8TZd/6fcFdDffIo1BEQ/N3P7wZXdRNFCaaVDVEmaC
         k7EM7JL4YwRd8/j1fpMwi0Sv19KAavj/Z3Lox3YCddOW/BESEhsEfDKnGobVr1uu+fRI
         IcumcKWqHnYFfcFoEuc9ODLNMlqMcGwYmuqo7O/bx2Pw8Bf2iZVjEA7+bSDnR5xz4m5D
         EuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7YPU86kRh43fh/B9xA9EKXQH40cZnkadx8AsjXbI3M=;
        b=F+i2EA42Uk4RCEEW1zcg/VLQtAFPchJ6StIO3+ZUG3XUAx89PpsL+QQhDnZF7kCYiT
         PklMtTyuovRU9WCqZ3Aruduxsy+v7OkeDowuzkooVB/96mTWdB/2X89hDJA+JgmastLt
         ImXhIlS7NUwUycM9GeGB+hYweEuJE8nF3rEcwhh9e/a9XGzEaPC/kzt1XNPIhmSTCF6U
         iInhmc9MfAHAF7lMbYot4jsZhEyZx2J8gt09Xm4wlWiGGGBfgSzZU/d1Xgo/5ap9jV4v
         b3mE2hqkk3bSgx4icPr13uVnCMLBMnP3YGbq1tcAljoQNDjhjXLD+04t7KqUUPWvITxu
         moNQ==
X-Gm-Message-State: AO0yUKWGYUuwZFqJiSqNDOQMeF2NY/hbwunOfX41++V4egxrKk7ajIO7
        HF7IJUqj7J3n5r1SDmBSBxn5UA8FLw1N8fnwsXE=
X-Google-Smtp-Source: AK7set/11E4jpVghRlgOmElBR2Eplp/YT9s1l5QVxf/giHCfieVdfEaQkx8Mgi5PszE54dGY0TW/bw==
X-Received: by 2002:a17:902:e551:b0:19a:6cd2:a658 with SMTP id n17-20020a170902e55100b0019a6cd2a658mr34785plf.7.1675989335399;
        Thu, 09 Feb 2023 16:35:35 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b00189b2b8dbedsm2069302pln.228.2023.02.09.16.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 16:35:34 -0800 (PST)
Date:   Fri, 10 Feb 2023 00:35:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Message-ID: <Y+WRUriIoan/XChx@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
 <20230209072529.GB4175971@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209072529.GB4175971@ls.amr.corp.intel.com>
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

On Wed, Feb 08, 2023, Isaku Yamahata wrote:
> On Fri, Dec 02, 2022 at 02:13:40PM +0800,
> Chao Peng <chao.p.peng@linux.intel.com> wrote:
> 
> > +static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> > +					   struct kvm_memory_attributes *attrs)
> > +{
> > +	gfn_t start, end;
> > +	unsigned long i;
> > +	void *entry;
> > +	u64 supported_attrs = kvm_supported_mem_attributes(kvm);
> > +
> > +	/* flags is currently not used. */
> > +	if (attrs->flags)
> > +		return -EINVAL;
> > +	if (attrs->attributes & ~supported_attrs)
> > +		return -EINVAL;
> > +	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
> > +		return -EINVAL;
> > +	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> > +		return -EINVAL;
> > +
> > +	start = attrs->address >> PAGE_SHIFT;
> > +	end = (attrs->address + attrs->size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
> > +
> > +	entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
> > +
> > +	mutex_lock(&kvm->lock);
> > +	for (i = start; i < end; i++)
> > +		if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> > +				    GFP_KERNEL_ACCOUNT)))
> > +			break;
> > +	mutex_unlock(&kvm->lock);
> > +
> > +	attrs->address = i << PAGE_SHIFT;
> > +	attrs->size = (end - i) << PAGE_SHIFT;
> > +
> > +	return 0;
> > +}
> > +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
> > +
> 
> If memslot isn't private, it should return error if private attribute is set.

Why?  I'd rather keep the two things separate.  If we enforce this sort of thing
at KVM_SET_MEMORY_ATTRIBUTES, then we also have to enforce it at
KVM_SET_USER_MEMORY_REGION.
