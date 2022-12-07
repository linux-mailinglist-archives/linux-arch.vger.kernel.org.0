Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BF7645D68
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 16:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiLGPPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 10:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLGPPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 10:15:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F9C6176A;
        Wed,  7 Dec 2022 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670426131; x=1701962131;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UstGtsdKp8X/+EEmxGFdNKEV+VS9OLDAxwbRaUcC+4g=;
  b=Lg1QnhLxYuBfdd7mYx+sNwCDYP1Jaj3/7OeYv9CwW2Jtw602Mg7Asyea
   tteHLA5Oahdkd1eOdS5pfz0NKjgAKu6EiqVuu9qhETPW1PhQG09ovYNTv
   gzWf5phKoaRqBDNHnmK850LaxPeLtsECGKbpwlybKVuK0AIeHYmWu8Vxe
   +/PXKvyKMxK8DI66iuNNbImQFw5stFSAwVxjwgTkES5In8+0Bi54EQj+U
   1s+Noe6gCQ5l8Czol5m106hiJ2u153/Om8ZjW5PjLkEL9xCiHD53rDT7y
   xpgdL4Hpxq5G5tbj594vTAKM5eb1Kj0CjsqwSvknFg9LYSLoRzOodSxOn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343947342"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343947342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:14:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="710095491"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="710095491"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2022 07:14:48 -0800
Date:   Wed, 7 Dec 2022 23:10:29 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20221207151029.GD1275553@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <CA+EHjTyuQSa9YKkGd1OqtEzobuf6Bcghwiz00aaL15ikz7J2Vw@mail.gmail.com>
 <20221206115356.GA1216605@chaop.bj.intel.com>
 <CA+EHjTyczU4b8c2_X39+qLW96V-spaYtAMp=OCFubMr8VAccww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EHjTyczU4b8c2_X39+qLW96V-spaYtAMp=OCFubMr8VAccww@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 06, 2022 at 12:39:18PM +0000, Fuad Tabba wrote:
> Hi Chao,
> 
> On Tue, Dec 6, 2022 at 11:58 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
> > On Mon, Dec 05, 2022 at 09:03:11AM +0000, Fuad Tabba wrote:
> > > Hi Chao,
> > >
> > > On Fri, Dec 2, 2022 at 6:18 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > > >
> > > > In memory encryption usage, guest memory may be encrypted with special
> > > > key and can be accessed only by the guest itself. We call such memory
> > > > private memory. It's valueless and sometimes can cause problem to allow
> > > > userspace to access guest private memory. This new KVM memslot extension
> > > > allows guest private memory being provided through a restrictedmem
> > > > backed file descriptor(fd) and userspace is restricted to access the
> > > > bookmarked memory in the fd.
> > > >
> > > > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > > > additional KVM memslot fields restricted_fd/restricted_offset to allow
> > > > userspace to instruct KVM to provide guest memory through restricted_fd.
> > > > 'guest_phys_addr' is mapped at the restricted_offset of restricted_fd
> > > > and the size is 'memory_size'.
> > > >
> > > > The extended memslot can still have the userspace_addr(hva). When use, a
> > > > single memslot can maintain both private memory through restricted_fd
> > > > and shared memory through userspace_addr. Whether the private or shared
> > > > part is visible to guest is maintained by other KVM code.
> > > >
> > > > A restrictedmem_notifier field is also added to the memslot structure to
> > > > allow the restricted_fd's backing store to notify KVM the memory change,
> > > > KVM then can invalidate its page table entries or handle memory errors.
> > > >
> > > > Together with the change, a new config HAVE_KVM_RESTRICTED_MEM is added
> > > > and right now it is selected on X86_64 only.
> > > >
> > > > To make future maintenance easy, internally use a binary compatible
> > > > alias struct kvm_user_mem_region to handle both the normal and the
> > > > '_ext' variants.
> > > >
> > > > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > > Reviewed-by: Fuad Tabba <tabba@google.com>
> > > > Tested-by: Fuad Tabba <tabba@google.com>
> > >
> > > V9 of this patch [*] had KVM_CAP_PRIVATE_MEM, but it's not in this
> > > patch series anymore. Any reason you removed it, or is it just an
> > > omission?
> >
> > We had some discussion in v9 [1] to add generic memory attributes ioctls
> > and KVM_CAP_PRIVATE_MEM can be implemented as a new
> > KVM_MEMORY_ATTRIBUTE_PRIVATE flag via KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES()
> > ioctl [2]. The api doc has been updated:
> >
> > +- KVM_MEM_PRIVATE, if KVM_MEMORY_ATTRIBUTE_PRIVATE is supported (see
> > +  KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES ioctl) ��
> >
> >
> > [1] https://lore.kernel.org/linux-mm/Y2WB48kD0J4VGynX@google.com/
> > [2]
> > https://lore.kernel.org/linux-mm/20221202061347.1070246-3-chao.p.peng@linux.intel.com/
> 
> I see. I just retested it with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES,
> and my Reviewed/Tested-by still apply.

Thanks for the info.

Chao
> 
> Cheers,
> /fuad
> 
> >
> > Thanks,
> > Chao
> > >
> > > [*] https://lore.kernel.org/linux-mm/20221025151344.3784230-3-chao.p.peng@linux.intel.com/
> > >
> > > Thanks,
> > > /fuad
> > >
> > > > ---
> > > >  Documentation/virt/kvm/api.rst | 40 ++++++++++++++++++++++-----
> > > >  arch/x86/kvm/Kconfig           |  2 ++
> > > >  arch/x86/kvm/x86.c             |  2 +-
> > > >  include/linux/kvm_host.h       |  8 ++++--
> > > >  include/uapi/linux/kvm.h       | 28 +++++++++++++++++++
> > > >  virt/kvm/Kconfig               |  3 +++
> > > >  virt/kvm/kvm_main.c            | 49 ++++++++++++++++++++++++++++------
> > > >  7 files changed, 114 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > > > index bb2f709c0900..99352170c130 100644
> > > > --- a/Documentation/virt/kvm/api.rst
> > > > +++ b/Documentation/virt/kvm/api.rst
> > > > @@ -1319,7 +1319,7 @@ yet and must be cleared on entry.
> > > >  :Capability: KVM_CAP_USER_MEMORY
> > > >  :Architectures: all
> > > >  :Type: vm ioctl
> > > > -:Parameters: struct kvm_userspace_memory_region (in)
> > > > +:Parameters: struct kvm_userspace_memory_region(_ext) (in)
> > > >  :Returns: 0 on success, -1 on error
> > > >
> > > >  ::
> > > > @@ -1332,9 +1332,18 @@ yet and must be cleared on entry.
> > > >         __u64 userspace_addr; /* start of the userspace allocated memory */
> > > >    };
> > > >
> > > > +  struct kvm_userspace_memory_region_ext {
> > > > +       struct kvm_userspace_memory_region region;
> > > > +       __u64 restricted_offset;
> > > > +       __u32 restricted_fd;
> > > > +       __u32 pad1;
> > > > +       __u64 pad2[14];
> > > > +  };
> > > > +
> > > >    /* for kvm_memory_region::flags */
> > > >    #define KVM_MEM_LOG_DIRTY_PAGES      (1UL << 0)
> > > >    #define KVM_MEM_READONLY     (1UL << 1)
> > > > +  #define KVM_MEM_PRIVATE              (1UL << 2)
> > > >
> > > >  This ioctl allows the user to create, modify or delete a guest physical
> > > >  memory slot.  Bits 0-15 of "slot" specify the slot id and this value
> > > > @@ -1365,12 +1374,29 @@ It is recommended that the lower 21 bits of guest_phys_addr and userspace_addr
> > > >  be identical.  This allows large pages in the guest to be backed by large
> > > >  pages in the host.
> > > >
> > > > -The flags field supports two flags: KVM_MEM_LOG_DIRTY_PAGES and
> > > > -KVM_MEM_READONLY.  The former can be set to instruct KVM to keep track of
> > > > -writes to memory within the slot.  See KVM_GET_DIRTY_LOG ioctl to know how to
> > > > -use it.  The latter can be set, if KVM_CAP_READONLY_MEM capability allows it,
> > > > -to make a new slot read-only.  In this case, writes to this memory will be
> > > > -posted to userspace as KVM_EXIT_MMIO exits.
> > > > +kvm_userspace_memory_region_ext struct includes all fields of
> > > > +kvm_userspace_memory_region struct, while also adds additional fields for some
> > > > +other features. See below description of flags field for more information.
> > > > +It's recommended to use kvm_userspace_memory_region_ext in new userspace code.
> > > > +
> > > > +The flags field supports following flags:
> > > > +
> > > > +- KVM_MEM_LOG_DIRTY_PAGES to instruct KVM to keep track of writes to memory
> > > > +  within the slot. For more details, see KVM_GET_DIRTY_LOG ioctl.
> > > > +
> > > > +- KVM_MEM_READONLY, if KVM_CAP_READONLY_MEM allows, to make a new slot
> > > > +  read-only. In this case, writes to this memory will be posted to userspace as
> > > > +  KVM_EXIT_MMIO exits.
> > > > +
> > > > +- KVM_MEM_PRIVATE, if KVM_MEMORY_ATTRIBUTE_PRIVATE is supported (see
> > > > +  KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES ioctl), to indicate a new slot has private
> > > > +  memory backed by a file descriptor(fd) and userspace access to the fd may be
> > > > +  restricted. Userspace should use restricted_fd/restricted_offset in the
> > > > +  kvm_userspace_memory_region_ext to instruct KVM to provide private memory
> > > > +  to guest. Userspace should guarantee not to map the same host physical address
> > > > +  indicated by restricted_fd/restricted_offset to different guest physical
> > > > +  addresses within multiple memslots. Failed to do this may result undefined
> > > > +  behavior.
> > > >
> > > >  When the KVM_CAP_SYNC_MMU capability is available, changes in the backing of
> > > >  the memory region are automatically reflected into the guest.  For example, an
> > > > diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> > > > index a8e379a3afee..690cb21010e7 100644
> > > > --- a/arch/x86/kvm/Kconfig
> > > > +++ b/arch/x86/kvm/Kconfig
> > > > @@ -50,6 +50,8 @@ config KVM
> > > >         select INTERVAL_TREE
> > > >         select HAVE_KVM_PM_NOTIFIER if PM
> > > >         select HAVE_KVM_MEMORY_ATTRIBUTES
> > > > +       select HAVE_KVM_RESTRICTED_MEM if X86_64
> > > > +       select RESTRICTEDMEM if HAVE_KVM_RESTRICTED_MEM
> > > >         help
> > > >           Support hosting fully virtualized guest machines using hardware
> > > >           virtualization extensions.  You will need a fairly recent
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index 7f850dfb4086..9a07380f8d3c 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -12224,7 +12224,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
> > > >         }
> > > >
> > > >         for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> > > > -               struct kvm_userspace_memory_region m;
> > > > +               struct kvm_user_mem_region m;
> > > >
> > > >                 m.slot = id | (i << 16);
> > > >                 m.flags = 0;
> > > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > > index a784e2b06625..02347e386ea2 100644
> > > > --- a/include/linux/kvm_host.h
> > > > +++ b/include/linux/kvm_host.h
> > > > @@ -44,6 +44,7 @@
> > > >
> > > >  #include <asm/kvm_host.h>
> > > >  #include <linux/kvm_dirty_ring.h>
> > > > +#include <linux/restrictedmem.h>
> > > >
> > > >  #ifndef KVM_MAX_VCPU_IDS
> > > >  #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
> > > > @@ -585,6 +586,9 @@ struct kvm_memory_slot {
> > > >         u32 flags;
> > > >         short id;
> > > >         u16 as_id;
> > > > +       struct file *restricted_file;
> > > > +       loff_t restricted_offset;
> > > > +       struct restrictedmem_notifier notifier;
> > > >  };
> > > >
> > > >  static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
> > > > @@ -1123,9 +1127,9 @@ enum kvm_mr_change {
> > > >  };
> > > >
> > > >  int kvm_set_memory_region(struct kvm *kvm,
> > > > -                         const struct kvm_userspace_memory_region *mem);
> > > > +                         const struct kvm_user_mem_region *mem);
> > > >  int __kvm_set_memory_region(struct kvm *kvm,
> > > > -                           const struct kvm_userspace_memory_region *mem);
> > > > +                           const struct kvm_user_mem_region *mem);
> > > >  void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
> > > >  void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
> > > >  int kvm_arch_prepare_memory_region(struct kvm *kvm,
> > > > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > > index 5d0941acb5bb..13bff963b8b0 100644
> > > > --- a/include/uapi/linux/kvm.h
> > > > +++ b/include/uapi/linux/kvm.h
> > > > @@ -103,6 +103,33 @@ struct kvm_userspace_memory_region {
> > > >         __u64 userspace_addr; /* start of the userspace allocated memory */
> > > >  };
> > > >
> > > > +struct kvm_userspace_memory_region_ext {
> > > > +       struct kvm_userspace_memory_region region;
> > > > +       __u64 restricted_offset;
> > > > +       __u32 restricted_fd;
> > > > +       __u32 pad1;
> > > > +       __u64 pad2[14];
> > > > +};
> > > > +
> > > > +#ifdef __KERNEL__
> > > > +/*
> > > > + * kvm_user_mem_region is a kernel-only alias of kvm_userspace_memory_region_ext
> > > > + * that "unpacks" kvm_userspace_memory_region so that KVM can directly access
> > > > + * all fields from the top-level "extended" region.
> > > > + */
> > > > +struct kvm_user_mem_region {
> > > > +       __u32 slot;
> > > > +       __u32 flags;
> > > > +       __u64 guest_phys_addr;
> > > > +       __u64 memory_size;
> > > > +       __u64 userspace_addr;
> > > > +       __u64 restricted_offset;
> > > > +       __u32 restricted_fd;
> > > > +       __u32 pad1;
> > > > +       __u64 pad2[14];
> > > > +};
> > > > +#endif
> > > > +
> > > >  /*
> > > >   * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
> > > >   * other bits are reserved for kvm internal use which are defined in
> > > > @@ -110,6 +137,7 @@ struct kvm_userspace_memory_region {
> > > >   */
> > > >  #define KVM_MEM_LOG_DIRTY_PAGES        (1UL << 0)
> > > >  #define KVM_MEM_READONLY       (1UL << 1)
> > > > +#define KVM_MEM_PRIVATE                (1UL << 2)
> > > >
> > > >  /* for KVM_IRQ_LINE */
> > > >  struct kvm_irq_level {
> > > > diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> > > > index effdea5dd4f0..d605545d6dd1 100644
> > > > --- a/virt/kvm/Kconfig
> > > > +++ b/virt/kvm/Kconfig
> > > > @@ -89,3 +89,6 @@ config KVM_XFER_TO_GUEST_WORK
> > > >
> > > >  config HAVE_KVM_PM_NOTIFIER
> > > >         bool
> > > > +
> > > > +config HAVE_KVM_RESTRICTED_MEM
> > > > +       bool
> > > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > > index 7f0f5e9f2406..b882eb2c76a2 100644
> > > > --- a/virt/kvm/kvm_main.c
> > > > +++ b/virt/kvm/kvm_main.c
> > > > @@ -1532,7 +1532,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
> > > >         }
> > > >  }
> > > >
> > > > -static int check_memory_region_flags(const struct kvm_userspace_memory_region *mem)
> > > > +static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
> > > >  {
> > > >         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> > > >
> > > > @@ -1934,7 +1934,7 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
> > > >   * Must be called holding kvm->slots_lock for write.
> > > >   */
> > > >  int __kvm_set_memory_region(struct kvm *kvm,
> > > > -                           const struct kvm_userspace_memory_region *mem)
> > > > +                           const struct kvm_user_mem_region *mem)
> > > >  {
> > > >         struct kvm_memory_slot *old, *new;
> > > >         struct kvm_memslots *slots;
> > > > @@ -2038,7 +2038,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> > > >  EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
> > > >
> > > >  int kvm_set_memory_region(struct kvm *kvm,
> > > > -                         const struct kvm_userspace_memory_region *mem)
> > > > +                         const struct kvm_user_mem_region *mem)
> > > >  {
> > > >         int r;
> > > >
> > > > @@ -2050,7 +2050,7 @@ int kvm_set_memory_region(struct kvm *kvm,
> > > >  EXPORT_SYMBOL_GPL(kvm_set_memory_region);
> > > >
> > > >  static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
> > > > -                                         struct kvm_userspace_memory_region *mem)
> > > > +                                         struct kvm_user_mem_region *mem)
> > > >  {
> > > >         if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
> > > >                 return -EINVAL;
> > > > @@ -4698,6 +4698,33 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
> > > >         return fd;
> > > >  }
> > > >
> > > > +#define SANITY_CHECK_MEM_REGION_FIELD(field)                                   \
> > > > +do {                                                                           \
> > > > +       BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=             \
> > > > +                    offsetof(struct kvm_userspace_memory_region, field));      \
> > > > +       BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) !=         \
> > > > +                    sizeof_field(struct kvm_userspace_memory_region, field));  \
> > > > +} while (0)
> > > > +
> > > > +#define SANITY_CHECK_MEM_REGION_EXT_FIELD(field)                                       \
> > > > +do {                                                                                   \
> > > > +       BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=                     \
> > > > +                    offsetof(struct kvm_userspace_memory_region_ext, field));          \
> > > > +       BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) !=                 \
> > > > +                    sizeof_field(struct kvm_userspace_memory_region_ext, field));      \
> > > > +} while (0)
> > > > +
> > > > +static void kvm_sanity_check_user_mem_region_alias(void)
> > > > +{
> > > > +       SANITY_CHECK_MEM_REGION_FIELD(slot);
> > > > +       SANITY_CHECK_MEM_REGION_FIELD(flags);
> > > > +       SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
> > > > +       SANITY_CHECK_MEM_REGION_FIELD(memory_size);
> > > > +       SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
> > > > +       SANITY_CHECK_MEM_REGION_EXT_FIELD(restricted_offset);
> > > > +       SANITY_CHECK_MEM_REGION_EXT_FIELD(restricted_fd);
> > > > +}
> > > > +
> > > >  static long kvm_vm_ioctl(struct file *filp,
> > > >                            unsigned int ioctl, unsigned long arg)
> > > >  {
> > > > @@ -4721,14 +4748,20 @@ static long kvm_vm_ioctl(struct file *filp,
> > > >                 break;
> > > >         }
> > > >         case KVM_SET_USER_MEMORY_REGION: {
> > > > -               struct kvm_userspace_memory_region kvm_userspace_mem;
> > > > +               struct kvm_user_mem_region mem;
> > > > +               unsigned long size = sizeof(struct kvm_userspace_memory_region);
> > > > +
> > > > +               kvm_sanity_check_user_mem_region_alias();
> > > >
> > > >                 r = -EFAULT;
> > > > -               if (copy_from_user(&kvm_userspace_mem, argp,
> > > > -                                               sizeof(kvm_userspace_mem)))
> > > > +               if (copy_from_user(&mem, argp, size))
> > > > +                       goto out;
> > > > +
> > > > +               r = -EINVAL;
> > > > +               if (mem.flags & KVM_MEM_PRIVATE)
> > > >                         goto out;
> > > >
> > > > -               r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
> > > > +               r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
> > > >                 break;
> > > >         }
> > > >         case KVM_GET_DIRTY_LOG: {
> > > > --
> > > > 2.25.1
> > > >
