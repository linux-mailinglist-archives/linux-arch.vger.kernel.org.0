Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6422D6D4F5B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjDCRoz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjDCRoY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4BB1BE4;
        Mon,  3 Apr 2023 10:44:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso33392482pjb.3;
        Mon, 03 Apr 2023 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsgF+fleeMgXLp1N/FMCJ16iEQR8VAMoZKtj7f5mA3o=;
        b=ATr4I3dpzC3Rv85kph1+DyvP/Xloo8gEXAVXj2pB2xgpmn8x4gqj9HLVDwaALBpBy6
         PBbosgvXZaNsXzZjYK+ihXBaamk6u5FJCBENQPf9smRkAtpvOqupBkdPXvvvjPN8kjsl
         ubhXjgZiwOime42tJtk1gcB8B5A9q1yfLWn8rOSAdnr6WaKoXpcye22w/5zOj5Uzk/y7
         KwewgboeilHtseZtdn6OmJvyUoelZvEClIAxiSmsbof8W4xO4cDz2GHf7R9AN55mM+qk
         GPBRi7Ahh7Lh5H4VxWPSvm6HQSBFGjjNpekjWyKGFCwv1NA68kBuXvQ0a6+0lXq9KA4w
         F2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsgF+fleeMgXLp1N/FMCJ16iEQR8VAMoZKtj7f5mA3o=;
        b=5Sy0grfkS5Y0S/jUCofZXoRvmrDtns2KDgA9v2TU0GbMMl7nu/lLMBWFu5h5Szz9/D
         Pb0ZtEG6CmgiER90uP78CRD/JEB9u3Pw38tVhQywl2Ogz9ryMDFHGwWKNTiv9qUUHlPh
         jJ7XHLbyQvBqVIb//rLZRRN0nsTCxR16BQlikbAqRoDN7JlOSh+ECJJ0Gdp8mvQvYFDe
         obNwr6eMXiy03x2bkh+S74KGWE1EIPtdP1eZfEYdsWcAfTVYzMYFHZrLtnblzjDHYfLs
         RbJU8aeIj+M3W6tG4iZ77XCgRWi9T4rIIv1JfSoreh/lZF8XEUlHQ/FOy89CH8+0YLad
         6+2Q==
X-Gm-Message-State: AAQBX9cuQCcst5bMggA6JgDZjOKwFaWO7H2VxlO6Iq0Yv8AkPl5LO8WR
        eaJmnTajCnw7M29M2EXMNHw=
X-Google-Smtp-Source: AKy350aQjZRe/EhCQZ0EpcgcQEibFK4Vfiii/+iB44zCAGt9hyxo/gC92OGQRZWtdLbas9BUxvMl2A==
X-Received: by 2002:a17:902:e882:b0:1a1:f413:70b1 with SMTP id w2-20020a170902e88200b001a1f41370b1mr45509775plg.18.1680543861931;
        Mon, 03 Apr 2023 10:44:21 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:21 -0700 (PDT)
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V4 09/17] x86/hyperv: SEV-SNP enlightened guest don't support legacy rtc
Date:   Mon,  3 Apr 2023 13:43:57 -0400
Message-Id: <20230403174406.4180472-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

SEV-SNP enlightened guest doesn't support legacy rtc. Set
legacy.rtc, x86_platform.set_wallclock and get_wallclock to
0 or noop(). Make get/set_rtc_noop() to be public and reuse
them in the ms_hyperv_init_platform().

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c           | 3 +++
 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/x86_init.c      | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index fa4de2761460..c0f3fa924163 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -391,6 +391,9 @@ __init void hv_sev_init_mem_and_cpu(void)
 	 * bios regions and reserve resources are not
 	 * available. Set these callback to NULL.
 	 */
+	x86_platform.legacy.rtc = 0;
+	x86_platform.set_wallclock = set_rtc_noop;
+	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.legacy.reserve_bios_regions = 0;
 	x86_init.resources.probe_roms = x86_init_noop;
 	x86_init.resources.reserve_resources = x86_init_noop;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6f873c686cd3..e5a6f9baec67 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -330,5 +330,7 @@ extern void x86_init_uint_noop(unsigned int unused);
 extern bool bool_x86_init_noop(void);
 extern void x86_op_int_noop(int cpu);
 extern bool x86_pnpbios_disabled(void);
+extern int set_rtc_noop(const struct timespec64 *now);
+extern void get_rtc_noop(struct timespec64 *now);
 
 #endif
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 95be3831df73..d82f4fa2f1bf 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
-static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static __init void get_rtc_noop(struct timespec64 *now) { }
+int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+void get_rtc_noop(struct timespec64 *now) { }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.25.1

