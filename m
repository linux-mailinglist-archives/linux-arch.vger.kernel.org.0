Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27615446AD0
	for <lists+linux-arch@lfdr.de>; Fri,  5 Nov 2021 23:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbhKEWOf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Nov 2021 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhKEWOe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Nov 2021 18:14:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F2C06120C
        for <linux-arch@vger.kernel.org>; Fri,  5 Nov 2021 15:11:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o10-20020a17090a3d4a00b001a6555878a8so4301989pjf.1
        for <linux-arch@vger.kernel.org>; Fri, 05 Nov 2021 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aRWHdkO4dgpMyzRiXJIktqcg8FedigSvLDnV+7jJnn4=;
        b=Nsce8GFJmQXR6UHyWFvn08hSzEM7iGBG5ByWUwahEd+E5Oi5y5F5s5kXfuHSA3O8jH
         0g5rwgrhkqsbTuBAi4kvic7gFjNdoyFwoUSX8NEPZug00B5rwPZd4+X7iOkq2V2UNQCg
         4rqo5zho64yPY0krZNwheBUWot15iJ+bFG7h7eXJT9vcCF4cqaJPv0sLz4uV4zywUa65
         hJJubI8n/+Mp1bb8fun+E7+Q8ZtJ3oj/5S/LLu87HovDhA3dnSnFuml2XJUQYnS/WCAX
         wdSAo7BO/xFKbTMNu3iGHg1PZXJCss3+1AStP69KCnVFVKOBZDFqHgHpzOsOp/1t0hjM
         cQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aRWHdkO4dgpMyzRiXJIktqcg8FedigSvLDnV+7jJnn4=;
        b=LajtIJViOBLn7hvt0vXzBVClaPpXV5EwVshG/BnpJYI52/YxPpA5UB1HiXuY63iwBP
         brYxvHfn+RAtnEecTx6iblxzqaQWTvyXGslH9rX/hT5Rid/bJHEXY89tjezQTg98G1p6
         DhCNV0Vkog2E0TdjERfR98zbScoimCTXDj9ZKkSO6yQBlTFcAO6hJjmeR3HSBT3QcWbs
         5+6j/r14NPIsyY/Xo+G01EQdWEE24klpfLxgw74JZ5+OzV2yEjXsYbWiJK/D7HF7+4jc
         FgYInVnm0lqZo/rEwM9Zx+MaKC1Ta70xd772DyoceUwtuchwt0B+N8b2eyCFigQjx6sJ
         1lvQ==
X-Gm-Message-State: AOAM530GKcxYQYm2mo2ZTEulAm8iH2CwptHaEvVw1c1FL9HSitm9VjH7
        rZbyRo4JrdaVglFiatbwCNuMuQ==
X-Google-Smtp-Source: ABdhPJyVKs/T2QwL39fgWmZUlOvRz4SLMTN3hO5qCDkrTrsDVvK6eCTxiKcLCJLtAK4yipcbA0ThcQ==
X-Received: by 2002:a17:90a:134f:: with SMTP id y15mr33461963pjf.158.1636150313440;
        Fri, 05 Nov 2021 15:11:53 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p15sm4391051pjh.1.2021.11.05.15.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:11:52 -0700 (PDT)
Date:   Fri, 5 Nov 2021 22:11:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YYWsJFP31vpCAVFg@google.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211009003711.1390019-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Just like MKTME, TDX reassigns bits of the physical address for
> metadata.  MKTME used several bits for an encryption KeyID. TDX
> uses a single bit in guests to communicate whether a physical page
> should be protected by TDX as private memory (bit set to 0) or
> unprotected and shared with the VMM (bit set to 1).
> 
> Add a helper, tdx_shared_mask() to generate the mask.  The processor
> enumerates its physical address width to include the shared bit, which
> means it gets included in __PHYSICAL_MASK by default.

This is incorrect.  The shared bit _may_ be a legal PA bit, but AIUI it's not a
hard requirement.

> Remove the shared mask from 'physical_mask' since any bits in
> tdx_shared_mask() are not used for physical addresses in page table
> entries.

...

> @@ -94,6 +100,9 @@ static void tdx_get_info(void)
>  
>  	td_info.gpa_width = out.rcx & GENMASK(5, 0);
>  	td_info.attributes = out.rdx;
> +
> +	/* Exclude Shared bit from the __PHYSICAL_MASK */
> +	physical_mask &= ~tdx_shared_mask();

This is insufficient, though it's not really the fault of this patch, the specs
themselves botch this whole thing.

The TDX Module spec explicitly states that GPAs above GPAW are considered reserved.

    10.11.1. GPAW-Relate EPT Violations
    GPA bits higher than the SHARED bit are considered reserved and must be 0.
    Address translation with any of the reserved bits set to 1 cause a #PF with
    PFEC (Page Fault Error Code) RSVD bit set.

But this is contradicted by the architectural extensions spec, which states that
a GPA that satisfies MAXPA >= GPA > GPAW "can" cause an EPT violation, not #PF.
Note, this section also appears to have a bug, as it states that GPA bit 47 is
both the SHARED bit and reserved.  I assume that blurb is intended to clarify
that bit 47 _would_ be reserved if it weren't the SHARED bit, but because it's
the shared bit it's ok to access.

    1.4.2
    Guest Physical Address Translation
    If the CPU's maximum physical-address width (MAXPA) is 52 and the guest physical
    address width is configured to be 48, accesses with GPA bits 51:48 not all being
    0 can cause an EPT-violation, where such EPT-violations are not mutated to #VE,
    even if the “EPT-violations #VE” execution control is 1.

    If the CPU's physical-address width (MAXPA) is less than 48 and the SHARED bit
    is configured to be in bit position 47, GPA bit 47 would be reserved, and GPA
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                    
    bits 46:MAXPA would be reserved. On such CPUs, setting bits 51:48 or bits
    46:MAXPA in any paging structure can cause a reserved bit page fault on access.

The Module spec also calls out that the effective GPA is not to be confused with
MAXPA, which combined with the above blurb about MAXPA < GPAW, suggests that MAXPA
is enumerated separately by design so that the guest doesn't incorrectly think
46:MAXPA are usable.  But that is problematic for the case where MAXPA > GPAW.

    The effective GPA width (in bits) for this TD (do not confuse with MAXPA).
    SHARED bit is at GPA bit GPAW-1.

I can't find the exact reference, but the TDX module always passes through host's
MAXPHYADDR.  As it pertains to this patch, just doing

	physical_mask &= ~tdx_shared_mask()

means that a guest running with GPAW=0 and MAXPHYADDR>48 will have a discontiguous
physical_mask, and could access "reserved" memory.  If the VMM defines legal memory
with bits [MAXPHYADDR:48]!=0, explosions may ensue.  That's arguably a VMM bug, but
given that the VMM is untrusted I think the guest should be paranoid when handling
the SHARED bit.  I also don't know that the kernel will play nice with a discontiguous
mask.

Specs aside, unless Intel makes a hardware change to treat GPAW as guest.MAXPHYADDR,
or the TDX Module emulates on EPT violations to inject #PF(RSVD) when appropriate,
this mess isn't going to be truly fixed from the guest perspective.

So, IMO all bits >= GPAW should be cleared, and the kernel should warn and/or
refuse to boot if the host has defined legal memory in that range.

FWIW, from a VMM perspective, I'm pretty sure the only sane approach is to force
GPAW=1, a.k.a. SHARED bit == 51, if host.MAXPHYADDR>=49.  But on the guest side,
I think we should be paranoid.
