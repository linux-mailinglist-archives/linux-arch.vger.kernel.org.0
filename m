Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785254274FD
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 02:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbhJIAkH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 20:40:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:5254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244148AbhJIAjm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 20:39:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213756524"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213756524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="624905379"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:44 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 09/16] x86/tdx: Enable shared memory confidential guest flags for TDX guest
Date:   Fri,  8 Oct 2021 17:37:04 -0700
Message-Id: <20211009003711.1390019-10-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In TDX guest, since the memory is private to guest, it needs some
extra configuration before sharing any data with VMM. AMD SEV also
implements similar features and hence code can be shared. Currently
memory sharing related code in the kernel is protected by
CC_ATTR_GUEST_MEM_ENCRYPT and CC_ATTR_GUEST_SHARED_MAPPING_INIT flags.
So enable them for TDX guest as well.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v4:
 * Rebased on top of Tom Lendacky's CC guest
   changes (https://www.spinics.net/lists/linux-tip-commits/msg58716.html)

 arch/x86/kernel/cc_platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index d13188e8eb2c..deac0a7d7d37 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -20,6 +20,9 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	switch (attr) {
 	case CC_ATTR_GUEST_TDX:
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_SHARED_MAPPING_INIT:
+	case CC_ATTR_MEM_ENCRYPT:
 		return is_tdx_guest();
 	default:
 		return false;
-- 
2.25.1

