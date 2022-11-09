Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F096234F0
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKIUyI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKIUx6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:53:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE0228E26;
        Wed,  9 Nov 2022 12:53:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3080828pjk.1;
        Wed, 09 Nov 2022 12:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/uV3Yk7QEQIG4AAWZWtDVX6I1cGq9Idr+N8Gk7WSAI=;
        b=Y9sd73Z3OOE00lbI9KlQJl7i2qv9FOviFf/g9PfcDxAiDN9wyQY8AHIjAGUneT+JFN
         GCrz3LLIwgWCmuw/3GiYoUfklkb73pG/fN1bzNnT0v9kNSvvcQ5iu7mrn9Tzkd6DCdN5
         Hf3/gvUCLqy4H1Owx5O5sZuWpAfDw3LUgklSeMCk75EfRBFtY/FJyygGcoRZQ29VrlnV
         rcLz28wJfw+qnphKkCGigX5T931uqJbyNZk6IFVXQvRfzwwYnuEshpDvLFoNNAOUfcib
         S6JV6RwuPSfRchru9ieI2bL6h7XC6ERETkXIE2zdy5W1zbaIaDUIy8kJzBojE6w4z5JF
         hPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/uV3Yk7QEQIG4AAWZWtDVX6I1cGq9Idr+N8Gk7WSAI=;
        b=xkgSbIyY8TEmc7Xd3zN/3zg1TKtFiw5ydmOXijXvFjdh33pqgMsiHfIoxayyphZtPV
         voAMiUiYIAEuhvX5vRerLvBdoVyMkFpmYpnMgSRtCBxGynN99Shhpd+mwll2ewN74xpG
         YKFg+U+zzRj5NoYL3/zkDkC6n1piSxzaLpnXwEF4pfgVmxLROaX4W51NzM+zBomZZYOo
         ZIXrpe03DNV1R6iEndkAGfn0IINOgl0HUob7w8Vev+k8W6+5Ch4S1nOA3ovDymZRo5ax
         z+93wcbVVHAeTjKI1rJ9ZrJtzroLwx8TTE1an9gOgfN41LPmMTqZiX7aq356EfXagB1a
         l3xQ==
X-Gm-Message-State: ACrzQf23tMlkVJkDODaA6o6YoSTKuXpAOqVXDWlYBleodRDVL3ynEPud
        DSSEdFp+KyNPLuJ/edvdOwU=
X-Google-Smtp-Source: AMsMyM7UB8YbI18ZrcbwkZZev7qw+umTXxtq2dUco8FacikPxLwPpLFlJ2a03p2LpXccrXoiqjS4qQ==
X-Received: by 2002:a17:90b:3715:b0:213:2d7:3164 with SMTP id mg21-20020a17090b371500b0021302d73164mr81305132pjb.191.1668027237522;
        Wed, 09 Nov 2022 12:53:57 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:53:57 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH 01/17] x86/boot: Check boot param's cc_blob_address for direct boot mode
Date:   Wed,  9 Nov 2022 15:53:36 -0500
Message-Id: <20221109205353.984745-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hypervisor may pass cc blob address directly into boot param's cc
blob address in the direct boot mode. Check cc blcb hdr magic first
in the sev_enable() and use it as cc blob address if check successfully.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/boot/compressed/sev.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c93930d5ccbd..960968f8bf75 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -272,17 +272,24 @@ static void enforce_vmpl0(void)
 
 void sev_enable(struct boot_params *bp)
 {
+	struct cc_blob_sev_info *cc_info;
 	unsigned int eax, ebx, ecx, edx;
 	struct msr m;
 	bool snp;
 
 	/*
-	 * bp->cc_blob_address should only be set by boot/compressed kernel.
-	 * Initialize it to 0 to ensure that uninitialized values from
-	 * buggy bootloaders aren't propagated.
+	 * bp->cc_blob_address should only be set by boot/compressed
+	 * kernel and hypervisor with direct boot mode. Initialize it
+	 * to 0 after checking in order to ensure that uninitialized
+	 * values from buggy bootloaders aren't propagated.
 	 */
-	if (bp)
-		bp->cc_blob_address = 0;
+	if (bp) {
+		cc_info = (struct cc_blob_sev_info *)(unsigned long)
+			bp->cc_blob_address;
+
+		if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+			bp->cc_blob_address = 0;
+	}
 
 	/*
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
@@ -374,6 +381,10 @@ static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
+	/* Boot kernel would have passed the CC blob via boot_params. */
+	if (bp->cc_blob_address)
+		return (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
+
 	cc_info = find_cc_blob_efi(bp);
 	if (cc_info)
 		goto found_cc_info;
@@ -416,9 +427,11 @@ bool snp_init(struct boot_params *bp)
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
 	 * config table doesn't need to be searched again during early startup
-	 * phase.
+	 * phase. Hypervisor also may popualte cc_blob_address directyly
+	 * in direct boot mode.
 	 */
-	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+	if (!bp->cc_blob_address)
+		bp->cc_blob_address = (u32)(unsigned long)cc_info;
 
 	return true;
 }
-- 
2.25.1

