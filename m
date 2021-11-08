Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24E448214
	for <lists+linux-arch@lfdr.de>; Mon,  8 Nov 2021 15:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbhKHOsA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Nov 2021 09:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbhKHOrw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Nov 2021 09:47:52 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A181C061570
        for <linux-arch@vger.kernel.org>; Mon,  8 Nov 2021 06:45:08 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z19so13768294lfd.8
        for <linux-arch@vger.kernel.org>; Mon, 08 Nov 2021 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o8ACBTFUs1u+Tu+HSqZ/Bgtc3Mxdv1DOZfd1HtE9MhI=;
        b=SSMxAUf89rUnNVbNGy3A336IliPjR+Nql1b6FMZQ3CAZAPpyiWnTasF0SnwZXgmc1y
         BqbNPEbtGA99ppTCaKfBe89qdo0lA/IduTOv4VSHUD8jdmS5ur5ig5kmaE0Nx/uaMvqp
         kNWhbwFpv4ozrVRf/1IWb7YdNwcBO1HQE2ii7ChI+tlnP86Yj7MxEN0Fe5tkdJJn++qm
         KdixhE51YAtCPJF1p9jcDxFgtq8vSQ/vRTWOBeN0v8lEd0O0BxHPje9OJMxpE+5B5fOo
         huY0AOns10N09ELwQXu4jbcwD1g0DXpMv87v/nUS1HrouSwNHFQNDOybGK9W8+qNEivA
         avsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o8ACBTFUs1u+Tu+HSqZ/Bgtc3Mxdv1DOZfd1HtE9MhI=;
        b=NNbNucGc3huHBareF5us/oWAhNJ1RrtNmFvdPGimqp5A8DOlc/MzMMWOeraxmIqMO+
         KcH5orT4nDher92vQ+5Bc0hc4KFNQv9aTjSW6CS4Hvp4aF8tlNrJuGxJT1CqMfUmcg/M
         zfhxL5YbopyYD903Q+W/SU8RL2If4HTsVHwhTMNm6hqzbcZpl7M4xce3ra/DCIHM/TlV
         LuB9iwb2WxRl80e5luNgpSDIctx/PBUtL64rKDFPuBW8pvXFQV05gqfdEoAK6dP5gL8A
         QJDljCIxZTXxTE2yi49x7b0+ElALuCm2lDGlw/PvBv/hOZClxEBaMYC7I4BfLkAiLSGM
         Cvww==
X-Gm-Message-State: AOAM531++JtWJnYjtuz2BRGBKlJ4w8JDtE3SK5a2KBNnb7jO+1Pl2G8E
        1kmKhJVoHkz9EGdba1XF2Wd7Pw==
X-Google-Smtp-Source: ABdhPJzyLniPUCEsE0z/ygrYUi5HbWdGlisrZNzen5mCC1grWOhH8f4dxQ7pTSdWId8QL2qzkXju6w==
X-Received: by 2002:a19:c706:: with SMTP id x6mr18874044lff.113.1636382705340;
        Mon, 08 Nov 2021 06:45:05 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o23sm1572844ljg.70.2021.11.08.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:45:04 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E8C4C1034BA; Mon,  8 Nov 2021 17:45:05 +0300 (+03)
Date:   Mon, 8 Nov 2021 17:45:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 03/16] x86/tdx: Exclude Shared bit from physical_mask
Message-ID: <20211108144505.fz3p4fw4q2efj32r@box.shutemov.name>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YYWsJFP31vpCAVFg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYWsJFP31vpCAVFg@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 05, 2021 at 10:11:48PM +0000, Sean Christopherson wrote:
> On Fri, Oct 08, 2021, Kuppuswamy Sathyanarayanan wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Just like MKTME, TDX reassigns bits of the physical address for
> > metadata.  MKTME used several bits for an encryption KeyID. TDX
> > uses a single bit in guests to communicate whether a physical page
> > should be protected by TDX as private memory (bit set to 0) or
> > unprotected and shared with the VMM (bit set to 1).
> > 
> > Add a helper, tdx_shared_mask() to generate the mask.  The processor
> > enumerates its physical address width to include the shared bit, which
> > means it gets included in __PHYSICAL_MASK by default.
> 
> This is incorrect.  The shared bit _may_ be a legal PA bit, but AIUI it's not a
> hard requirement.

Good point, will fix.

> > Remove the shared mask from 'physical_mask' since any bits in
> > tdx_shared_mask() are not used for physical addresses in page table
> > entries.
> 
> ...
> 
> > @@ -94,6 +100,9 @@ static void tdx_get_info(void)
> >  
> >  	td_info.gpa_width = out.rcx & GENMASK(5, 0);
> >  	td_info.attributes = out.rdx;
> > +
> > +	/* Exclude Shared bit from the __PHYSICAL_MASK */
> > +	physical_mask &= ~tdx_shared_mask();
> 
> This is insufficient, though it's not really the fault of this patch, the specs
> themselves botch this whole thing.
> 
> The TDX Module spec explicitly states that GPAs above GPAW are considered reserved.
> 
>     10.11.1. GPAW-Relate EPT Violations
>     GPA bits higher than the SHARED bit are considered reserved and must be 0.
>     Address translation with any of the reserved bits set to 1 cause a #PF with
>     PFEC (Page Fault Error Code) RSVD bit set.
> 
> But this is contradicted by the architectural extensions spec, which states that
> a GPA that satisfies MAXPA >= GPA > GPAW "can" cause an EPT violation, not #PF.
> Note, this section also appears to have a bug, as it states that GPA bit 47 is
> both the SHARED bit and reserved.  I assume that blurb is intended to clarify
> that bit 47 _would_ be reserved if it weren't the SHARED bit, but because it's
> the shared bit it's ok to access.
> 
>     1.4.2
>     Guest Physical Address Translation
>     If the CPU's maximum physical-address width (MAXPA) is 52 and the guest physical
>     address width is configured to be 48, accesses with GPA bits 51:48 not all being
>     0 can cause an EPT-violation, where such EPT-violations are not mutated to #VE,
>     even if the “EPT-violations #VE” execution control is 1.
> 
>     If the CPU's physical-address width (MAXPA) is less than 48 and the SHARED bit
>     is configured to be in bit position 47, GPA bit 47 would be reserved, and GPA
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                    
>     bits 46:MAXPA would be reserved. On such CPUs, setting bits 51:48 or bits
>     46:MAXPA in any paging structure can cause a reserved bit page fault on access.
> 
> The Module spec also calls out that the effective GPA is not to be confused with
> MAXPA, which combined with the above blurb about MAXPA < GPAW, suggests that MAXPA
> is enumerated separately by design so that the guest doesn't incorrectly think
> 46:MAXPA are usable.  But that is problematic for the case where MAXPA > GPAW.
> 
>     The effective GPA width (in bits) for this TD (do not confuse with MAXPA).
>     SHARED bit is at GPA bit GPAW-1.
> 
> I can't find the exact reference, but the TDX module always passes through host's
> MAXPHYADDR.  As it pertains to this patch, just doing
> 
> 	physical_mask &= ~tdx_shared_mask()
> 
> means that a guest running with GPAW=0 and MAXPHYADDR>48 will have a discontiguous
> physical_mask, and could access "reserved" memory.  If the VMM defines legal memory
> with bits [MAXPHYADDR:48]!=0, explosions may ensue.  That's arguably a VMM bug, but
> given that the VMM is untrusted I think the guest should be paranoid when handling
> the SHARED bit.  I also don't know that the kernel will play nice with a discontiguous
> mask.

I expect it to be buggy.

> Specs aside, unless Intel makes a hardware change to treat GPAW as guest.MAXPHYADDR,
> or the TDX Module emulates on EPT violations to inject #PF(RSVD) when appropriate,
> this mess isn't going to be truly fixed from the guest perspective.
> 
> So, IMO all bits >= GPAW should be cleared, and the kernel should warn and/or
> refuse to boot if the host has defined legal memory in that range.

Right. But only >= GPAW-1 as shared bit is the MSB within GPAW:

	physical_mask &= GENMASK_ULL(td_info.gpa_width - 2, 0);

'2' here smells bad, but well...

Given that physical_mask is now contiguous we can truncate anything from
e820 that cannot be addressed with adjusted __PHYSICAL_MASK:

iff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..16d57a8769e8 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -833,6 +833,9 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 	unsigned long last_pfn = 0;
 	unsigned long max_arch_pfn = MAX_ARCH_PFN;

+	if (max_arch_pfn > PHYS_PFN(__PHYSICAL_MASK + 1))
+		max_arch_pfn = PHYS_PFN(__PHYSICAL_MASK + 1);
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];
 		unsigned long start_pfn;

Does it look reasonable?

> FWIW, from a VMM perspective, I'm pretty sure the only sane approach is to force
> GPAW=1, a.k.a. SHARED bit == 51, if host.MAXPHYADDR>=49.  But on the guest side,
> I think we should be paranoid.

-- 
 Kirill A. Shutemov
