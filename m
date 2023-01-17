Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA566DEAA
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jan 2023 14:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjAQNUz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Jan 2023 08:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjAQNUx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jan 2023 08:20:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3439BA0;
        Tue, 17 Jan 2023 05:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673961653; x=1705497653;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=ydzl4pu/BnSzLPZ1RlJR0Y9KESs9mzMw8rQlYf4Kzvo=;
  b=Wa1lDjtgpSU4uygKkHIz1Dsj/E2ZHLW/CrnpG91ieGgCT0zvuxJQAYrm
   vp7y+IQ70RsSj6ArReb10U+53BXVsw95KCrBJ+YsOOC2mpHB0uQRXE57S
   2zMR+fAhwQUWwOKViE41UUL4EeKgWn4ZB214VWlwiDajl0WibgXPzK00P
   PCdx/qV8X7kAPsNxnxx98C8F/lrLeSIpHZgHMDHKgEZXe/ghiDSXDLjos
   s9xQMBGwkomNSbhpjWGeguhCQCsLjT7cG1KK+B+ppPntvBmbp+iAGuyXV
   GYO1uWKPbN6iHsjNy4fj9BUXIDp/MXS9HL70CkVpMPDmhCmcqKmHubRCk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="305067244"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="305067244"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 05:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="689797088"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="689797088"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by orsmga008.jf.intel.com with ESMTP; 17 Jan 2023 05:20:39 -0800
Date:   Tue, 17 Jan 2023 21:12:51 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20230117131251.GC273037@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-10-chao.p.peng@linux.intel.com>
 <Y8HwvTik/2avrCOU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8HwvTik/2avrCOU@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 14, 2023 at 12:01:01AM +0000, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Chao Peng wrote:
> > @@ -10357,6 +10364,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >  
> >  		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
> >  			static_call(kvm_x86_update_cpu_dirty_logging)(vcpu);
> > +
> > +		if (kvm_check_request(KVM_REQ_MEMORY_MCE, vcpu)) {
> > +			vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
> 
> Synthesizing triple fault shutdown is not the right approach.  Even with TDX's
> MCE "architecture" (heavy sarcasm), it's possible that host userspace and the
> guest have a paravirt interface for handling memory errors without killing the
> host.

Agree shutdown is not the correct choice. I see you made below change:

send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva, PAGE_SHIFT, current)

The MCE may happen in any thread than KVM thread, sending siginal to
'current' thread may not be the expected behavior. Also how userspace
can tell is the MCE on the shared page or private page? Do we care?

> 
> > +			r = 0;
> > +			goto out;
> > +		}
> >  	}
> 
> 
> > @@ -1982,6 +2112,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
> >  			mem->memory_size))
> >  		return -EINVAL;
> > +	if (mem->flags & KVM_MEM_PRIVATE &&
> > +		(mem->restricted_offset & (PAGE_SIZE - 1) ||
> 
> Align indentation.
> 
> > +		 mem->restricted_offset > U64_MAX - mem->memory_size))
> 
> Strongly prefer to use similar logic to existing code that detects wraps:
> 
> 		mem->restricted_offset + mem->memory_size < mem->restricted_offset
> 
> This is also where I'd like to add the "gfn is aligned to offset" check, though
> my brain is too fried to figure that out right now.
> 
> > +		return -EINVAL;
> >  	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
> >  		return -EINVAL;
> >  	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> > @@ -2020,6 +2154,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
> >  			return -EINVAL;
> >  	} else { /* Modify an existing slot. */
> > +		/* Private memslots are immutable, they can only be deleted. */
> 
> I'm 99% certain I suggested this, but if we're going to make these memslots
> immutable, then we should straight up disallow dirty logging, otherwise we'll
> end up with a bizarre uAPI.

But in my mind dirty logging will be needed in the very short time, when
live migration gets supported?

> 
> > +		if (mem->flags & KVM_MEM_PRIVATE)
> > +			return -EINVAL;
> >  		if ((mem->userspace_addr != old->userspace_addr) ||
> >  		    (npages != old->npages) ||
> >  		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
> > @@ -2048,10 +2185,28 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  	new->npages = npages;
> >  	new->flags = mem->flags;
> >  	new->userspace_addr = mem->userspace_addr;
> > +	if (mem->flags & KVM_MEM_PRIVATE) {
> > +		new->restricted_file = fget(mem->restricted_fd);
> > +		if (!new->restricted_file ||
> > +		    !file_is_restrictedmem(new->restricted_file)) {
> > +			r = -EINVAL;
> > +			goto out;
> > +		}
> > +		new->restricted_offset = mem->restricted_offset;

I see you changed slot->restricted_offset type from loff_t to gfn_t and
used pgoff_t when doing the restrictedmem_bind/unbind(). Using page
index is reasonable KVM internally and sounds simpler than loff_t. But
we also need initialize it to page index here as well as changes in
another two cases. This is needed when restricted_offset != 0.

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 547b92215002..49e375e78f30 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2364,8 +2364,7 @@ static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
                                             gfn_t gfn, kvm_pfn_t *pfn,
                                             int *order)
 {
-       pgoff_t index = gfn - slot->base_gfn +
-                       (slot->restricted_offset >> PAGE_SHIFT);
+       pgoff_t index = gfn - slot->base_gfn + slot->restricted_offset;
        struct page *page;
        int ret;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 01db35ddd5b3..7439bdcb0d04 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -935,7 +935,7 @@ static bool restrictedmem_range_is_valid(struct kvm_memory_slot *slot,
                                         pgoff_t start, pgoff_t end,
                                         gfn_t *gfn_start, gfn_t *gfn_end)
 {
-       unsigned long base_pgoff = slot->restricted_offset >> PAGE_SHIFT;
+       unsigned long base_pgoff = slot->restricted_offset;
 
        if (start > base_pgoff)
                *gfn_start = slot->base_gfn + start - base_pgoff;
@@ -2275,7 +2275,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
                        r = -EINVAL;
                        goto out;
                }
-               new->restricted_offset = mem->restricted_offset;
+               new->restricted_offset = mem->restricted_offset >> PAGE_SHIFT;
        }
 
        r = kvm_set_memslot(kvm, old, new, change);

Chao
> > +	}
> > +
> > +	new->kvm = kvm;
> 
> Set this above, just so that the code flows better.
