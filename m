Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8D572D61D
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbjFMAR6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbjFMAQv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:16:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84830E6;
        Mon, 12 Jun 2023 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615228; x=1718151228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qj0G4UwqkNNGQlR4Z3X67pikfZ5WOGk4HokEGvo8sro=;
  b=JAetgpkgtOB33AnSsLsZ6l+U4GY9rrlYZYi4fpJkFOIa7Kr9KAjCNHBY
   SV/PxNHe8T509ZqE4kY6TLxDxCPSjnm+/PiboySFlE+BGU14sWnH+iyJ3
   1kSvKqdatfafqbNOrVnumH79hDvXzDG/7IDRCytLvnR4L7L5iwPK/FrX7
   tZ29VfZcOZwPBQTF4eYNNOCLV6AahxgWbIlwDwj7j89ccJFJm0wl9t9O1
   lE8wFzjrGRhmeM3UfPl9kY8ZuzEd9opmzaCuybQJjdryPargw0Q7Srwiq
   puDrwQ0mc0+eCy5ThXSDfw8yLTgpJSz9TiulNRpfUpM9ng1hTGrunyRm0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557411"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557411"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671113"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671113"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:35 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v9 32/42] x86/shstk: Check that SSP is aligned on sigreturn
Date:   Mon, 12 Jun 2023 17:10:58 -0700
Message-Id: <20230613001108.3040476-33-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The shadow stack signal frame is read by the kernel on sigreturn. It
relies on shadow stack memory protections to prevent forgeries of this
signal frame (which included the pre-signal SSP). It also relies on the
shadow stack signal frame to have bit 63 set. Since this bit would not be
set via typical shadow stack operations, so the kernel can assume it was a
value it placed there.

However, in order to support 32 bit shadow stack, the INCSSPD instruction
can increment the shadow stack by 4 bytes. In this case SSP might be
pointing to a region spanning two 8 byte shadow stack frames. It could
confuse the checks described above.

Since the kernel only supports shadow stack in 64 bit, just check that
the SSP is 8 byte aligned in the sigreturn path.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v9:
 - New patch
---
 arch/x86/kernel/shstk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index f02e8ea4f1b5..a8705f7d966c 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -252,6 +252,9 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	unsigned long token_addr;
 	int err;
 
+	if (!IS_ALIGNED(*ssp, 8))
+		return -EINVAL;
+
 	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
 	if (unlikely(err))
 		return err;
-- 
2.34.1

