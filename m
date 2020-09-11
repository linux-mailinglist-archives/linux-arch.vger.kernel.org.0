Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB17D267647
	for <lists+linux-arch@lfdr.de>; Sat, 12 Sep 2020 01:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgIKXAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 19:00:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:19245 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgIKXAP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Sep 2020 19:00:15 -0400
IronPort-SDR: UKkKOmgGpwMUJ6WBfHgD93QuWKLpz7l94fKsWOP3h20gNoOfA1LbR3HpcMKQAApC1+RvGvQXI1
 Gf3bV+xc4khg==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="223055368"
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="223055368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 16:00:08 -0700
IronPort-SDR: gjV2IAbCK+5QITdKA7WMzvCSEvXaQlPGUyhAEFA6sASH1O/4f91fTEIulHtiP+5a5tzCktpG0d
 lV5zvsXShGGQ==
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="481500091"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 16:00:07 -0700
Message-ID: <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Fri, 11 Sep 2020 15:59:56 -0700
In-Reply-To: <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
         <20200826164604.GW6642@arm.com> <87ft892vvf.fsf@oldenburg2.str.redhat.com>
         <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
         <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
         <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
         <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
         <20200901102758.GY6642@arm.com>
         <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
         <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
         <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com>
         <46dffdfd-92f8-0f05-6164-945f217b0958@intel.com>
         <ed929729-4677-3d3b-6bfd-b379af9272b8@intel.com>
         <6e1e22a5-1b7f-2783-351e-c8ed2d4893b8@intel.com>
         <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com>
         <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
         <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com>
         <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
         <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com>
         <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-09-09 at 16:29 -0700, Dave Hansen wrote:
> On 9/9/20 4:25 PM, Yu, Yu-cheng wrote:
> > On 9/9/2020 4:11 PM, Dave Hansen wrote:
> > > On 9/9/20 4:07 PM, Yu, Yu-cheng wrote:
> > > > What if a writable mapping is passed to madvise(MADV_SHSTK)?  Should
> > > > that be rejected?
> > > 
> > > It doesn't matter to me.  Even if it's readable, it _stops_ being even
> > > directly readable after it's a shadow stack, right?  I don't think
> > > writes are special in any way.  If anything, we *want* it to be writable
> > > because that indicates that it can be written to, and we will want to
> > > write to it soon.
> > > 
> > But in a PROT_WRITE mapping, all the pte's have _PAGE_BIT_RW set.  To
> > change them to shadow stack, we need to clear that bit from the pte's.
> > That will be like mprotect_fixup()/change_protection_range().
> 
> The page table hardware bits don't matter.  The user-visible protection
> effects matter.
> 
> For instance, we have PROT_EXEC, which *CLEARS* a hardware NX PTE bit.
> The PROT_ permissions are independent of the hardware.
> 
> I don't think the interface should be influenced at *all* by what whacko
> PTE bit combinations we have to set to get the behavior.

Here are the changes if we take the mprotect(PROT_SHSTK) approach.
Any comments/suggestions?

---
 arch/x86/include/uapi/asm/mman.h | 26 +++++++++++++++++++++++++-
 mm/mprotect.c                    | 11 +++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index d4a8d0424bfb..024f006fcfe8 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -4,6 +4,8 @@
 
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
+#define PROT_SHSTK	0x10		/* shadow stack pages */
+
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 /*
  * Take the 4 protection key bits out of the vma->vm_flags
@@ -19,13 +21,35 @@
 		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
 		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
 
-#define arch_calc_vm_prot_bits(prot, key) (		\
+#define pkey_vm_prot_bits(prot, key) (			\
 		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
 		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
 		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+#else
+#define pkey_vm_prot_bits(prot, key)
 #endif
 
+#define shstk_vm_prot_bits(prot) ( \
+		(static_cpu_has(X86_FEATURE_SHSTK) && (prot & PROT_SHSTK)) ? \
+		VM_SHSTK : 0)
+
+#define arch_calc_vm_prot_bits(prot, key) \
+		(pkey_vm_prot_bits(prot, key) | shstk_vm_prot_bits(prot))
+
 #include <asm-generic/mman.h>
 
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
+{
+	unsigned long supported = PROT_READ | PROT_EXEC | PROT_SEM;
+
+	if (static_cpu_has(X86_FEATURE_SHSTK) && (prot & PROT_SHSTK))
+		supported |= PROT_SHSTK;
+	else
+		supported |= PROT_WRITE;
+
+	return (prot & ~supported) == 0;
+}
+#define arch_validate_prot arch_validate_prot
+
 #endif /* _ASM_X86_MMAN_H */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index a8edbcb3af99..520bd8caa005 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -571,6 +571,17 @@ static int do_mprotect_pkey(unsigned long start, size_t
len,
 				goto out;
 		}
 	}
+
+	/*
+	 * Only anonymous mapping is suitable for shadow stack.
+	 */
+	if (prot & PROT_SHSTK) {
+		if (vma->vm_file) {
+			error = -EINVAL;
+			goto out;
+		}
+	}
+
 	if (start > vma->vm_start)
 		prev = vma;
 
-- 

