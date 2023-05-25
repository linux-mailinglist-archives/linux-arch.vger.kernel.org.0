Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFFF7117A6
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbjEYTvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbjEYTux (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 15:50:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CBB90;
        Thu, 25 May 2023 12:50:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 71A985C00F5;
        Thu, 25 May 2023 15:08:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 25 May 2023 15:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685041697; x=
        1685128097; bh=zaKPFfQtRUHYG9M1a5mHVEammKUzjYCsA0rv+VmXpGk=; b=C
        JVb1brA/wH0ZrEFKYQjInT06081NJopyKvHikdpM+3nBxZilNC9hBEce4bfXC+HQ
        okuNy6dplEpvBoxRo2J/kat0BxSCvdzIR7cW8Rh8f2m3L8N7kiCFrVwi/YQaEXC7
        yVMzih57OM0Dvg9Xi26BUz+jwaac4w8uAwhZgjcd/PZkagkEOJ49XrTCjeNqBNEm
        RSuqlERrvMUu6+0s7DSKr4S8ugACl0duyvHe8n7X3iRgBweJxsq17B1gZKcEYcaN
        HNWWq1rhd2pXvZ1FfFiXS6U/NbRrgMuHNbhu5fNCDW5I1w+hccyVxQYA0zUgUoPX
        q3WIbkf+vu4SG5CqIWL5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685041697; x=1685128097; bh=zaKPFfQtRUHYG
        9M1a5mHVEammKUzjYCsA0rv+VmXpGk=; b=JwW6psopPWKdWoWBP7Cz++IxIsEj6
        km2WZpqPPn6NHjG+bgOXTv8LFM23DuxzvtCaYF8VgFfG4zhFo/lfMEcUWLcs3VkT
        3lMCMRsbDRnEKEJCRJZxJRuQixfglrTyStnRwHhJ7xZT6tKNm5CvQEavEGGKUeJ5
        I9fqlHVjt4VcEMDc1j8VcEB4ezO0z9MEk3Mt9P8eoBhEgOYC7Bb+nbhjdbFtZRM6
        Ru0t25B1jM10JKaOiMha5DIi8VGwSOjnPN4gBbG0zN9pX3UJ4A/lvVDeIUk9XeFq
        +iAX19EE2SbAMFH3LAW1CH52Anc7AfiWmCtCHjfaig1eTp1se+3g2vD/w==
X-ME-Sender: <xms:ILJvZCCWBw1zarw5SCR_V4ph9BeA1fQGW5MZxcK9iEGHH0T0x6Fy5A>
    <xme:ILJvZMjHkcovdG9h2hq4K0VP7MuQcmymdRBEEvJQy0U2YO6JOZQqHY0WetrT9z89A
    00Lj78p3abHhye64Bc>
X-ME-Received: <xmr:ILJvZFkYUM2IRTnIowHBmppJyuCAxBSJ20XBhsAFuxbshakM4yFvsXCNU1XGHYbKepGZzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepkedvvdejffehteegtddvgfeijeeivdegjeei
    teejheeiheevffeukeefheffvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:ILJvZAzA6UVzSz9ngTN8n7Odc1kxdH3R4ii-_trvX37gwleRoj6uDA>
    <xmx:ILJvZHRRZXbWZnmXHgS28-uFZh7f043iIK7vZOZRkz9yvl7luRtHWw>
    <xmx:ILJvZLaCKKBBnBXepEXhlBuYPQMjl7hNQPxxBLUgHuGuPN5izL_50g>
    <xmx:IbJvZCl_PhXBvencnsBltNfTb-meNrFSjZ07cBH5sazR8ENF15ByBQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 15:08:15 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5098710C61D; Thu, 25 May 2023 22:08:12 +0300 (+03)
Date:   Thu, 25 May 2023 22:08:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     kirill.shutemov@linux.intel.com, Dexuan Cui <decui@microsoft.com>,
        ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com
Subject: Re: [PATCH v6 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Message-ID: <20230525190812.bz5hg5k3uaibtcys@box>
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-3-decui@microsoft.com>
 <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
 <20230523223750.botogigv6ht7p2zg@box.shutemov.name>
 <2d96a23f-a16a-50e1-7960-a2d4998ce52f@intel.com>
 <20230523232851.a3djqxmpjyfghbvc@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523232851.a3djqxmpjyfghbvc@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 24, 2023 at 02:28:51AM +0300, kirill.shutemov@linux.intel.com wrote:
> On Tue, May 23, 2023 at 03:43:15PM -0700, Dave Hansen wrote:
> > On 5/23/23 15:37, kirill.shutemov@linux.intel.com wrote:
> > >> How does this work with load_unaligned_zeropad()?  Couldn't it be
> > >> running around poking at one of these vmalloc()'d pages via the direct
> > >> map during a shared->private conversion before the page has been accepted?
> > > Alias processing in __change_page_attr_set_clr() will change direct
> > > mapping if you call it on vmalloc()ed memory. I think we are safe wrt
> > > load_unaligned_zeropad() here.
> > 
> > We're *eventually* OK:
> > 
> > >         /* Notify hypervisor that we are about to set/clr encryption attribute. */
> > >         x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
> > > 
> > >         ret = __change_page_attr_set_clr(&cpa, 1);
> > 
> > But what about in the middle between enc_status_change_prepare() and
> > __change_page_attr_set_clr()?  Don't the direct map and the
> > shared/private status of the page diverge in there?
> 
> Hmm. Maybe we would need to go through making the range in direct mapping
> non-present before notifying VMM about the change.
> 
> I need to look at this again in the morning.

Okay, I've got around to it finally.

Private->Shared conversion is safe: we first set shared bit in the direct
mapping and all aliases and then call MapGPA enc_status_change_finish().
So we don't have privately mapped pages that we converted to shared with
MapGPA.

Shared->Private is not safe. As with Private->Shared, we adjust direct
mapping before notifying VMM and accepting the memory, so there's short
window when privately mapped memory that is neither mapped into SEPT nor
accepted. It is a problem as it can race with load_unaligned_zeropad().

Shared->Private conversion is rare. I only see one call total during the
boot in my setup. Worth fixing anyway.


The patch below fixes the issue by hooking up enc_status_change_prepare()
and doing conversion from Shared to Private there.

enc_status_change_finish() only covers Private to Shared conversion.

The patch is on top of unaccepted memory patchset. It is more convenient
base. I will rebase to Linus' tree if the approach looks sane to you.

Any comments?

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32501277ef84..b73ec2449c64 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -713,16 +713,32 @@ static bool tdx_cache_flush_required(void)
 	return true;
 }
 
+static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
+					  bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!enc)
+		return true;
+
+	return tdx_enc_status_changed_phys(start, end, enc);
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
  * of the page in response.
  */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
+					 bool enc)
 {
 	phys_addr_t start = __pa(vaddr);
 	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
 
+	if (enc)
+		return true;
+
 	return tdx_enc_status_changed_phys(start, end, enc);
 }
 
@@ -753,9 +769,10 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= cc_mask - 1;
 
-	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
-	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
-	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
+	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
+	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
+	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
+	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
 
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 88085f369ff6..1ca9701917c5 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -150,7 +150,7 @@ struct x86_init_acpi {
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
  */
 struct x86_guest {
-	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
+	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d82f4fa2f1bf..64664311ac2b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -130,8 +130,8 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { }
-static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
+static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
+static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e0b51c09109f..4f95c449a406 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -319,7 +319,7 @@ static void enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 #endif
 }
 
-static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
+static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * To maintain the security guarantees of SEV-SNP guests, make sure
@@ -327,6 +327,8 @@ static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool
 	 */
 	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
 		snp_set_memory_shared(vaddr, npages);
+
+	return true;
 }
 
 /* Return true unconditionally: return value doesn't matter for the SEV side */
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7159cf787613..b8f48ebe753c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2151,7 +2151,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
+	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
+		return -EIO;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
