Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC016D4F81
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjDCRqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjDCRpz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:45:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A855740C4;
        Mon,  3 Apr 2023 10:44:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so33394278pjb.4;
        Mon, 03 Apr 2023 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMejaISgZo/X14mzAcVEleMXRw+S9JCsqKPVR2Pqb9E=;
        b=MN5PWqJJcDeLW7Mi7FTOujqRf1HNSdLofD2KRByg6HjTFDDpA569Ig5os+InWesOcr
         Gu9BwpU4YuWOyhRdGJsYB4gg5WMgjptMoOACYsSbtkdOq5Px+rdh3yqGH0ebDii4ZlXQ
         Q5KV2JNP8TH4KJ/kpKR8yvF8f0ZdEXLiFRQ0Y0jm1oJgoiV9H7Lsp4PC+aJ53U1MfEti
         OoIS9TkBFM3AoKnKPgwQixLNQYDQHSAvoVWn8mp6Ki3yAvAp2kIRAcN+/hbG2TOSxZ4m
         aLctnjnogBaiJhmkmLLkF878etMUtUZjoGxEMgo1NuH/dt1ERAw/pN7lKh0Vx/rp8w8b
         n6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMejaISgZo/X14mzAcVEleMXRw+S9JCsqKPVR2Pqb9E=;
        b=wb+W+StugMHXt+kiCuMi/4E7BFhINXGCyVraJ/pBmgqEiVKdDMTO9AfON9RLxcvO4X
         5xgZqBlud3vFmcV7iR6cJnA1siePrdxfINpFe3KDnAjeTBmciL9Jd5T3BWJiH5cKWmb/
         6TnbTIwIVLaG48zOEJXPhG5O7zuUEx4oGswr6Z3Wt4ydi8ZmhMRu1hXD4zd6Ycfsm8vZ
         77JXWutg+it7jcy7A8algRHL6UOoJaoeC86evfTj1/syCiwwfBKszD4G/plv5LlLZk98
         RaSIPSVp+wIKtUOKfsIasyG/Rh3MjdsZ7uWHMwp+JKCKZfhPGmdW2fjFL9QdMB0+PmSB
         ktuQ==
X-Gm-Message-State: AAQBX9fuiXFg6XzNCXaKUM0k+6ZuMvPeS/kKCGK7S6gvpToqhfwYJaJ4
        VrKd14V3lXCerUvsbEhLdM8=
X-Google-Smtp-Source: AKy350YtXShHvctrBUnf1VOJUMw1RbAjDXOMG87QyIRxfxsZNlIUqA3IijXEYlvxwureT0bkJrmQvw==
X-Received: by 2002:a17:902:e847:b0:19e:d6f2:feea with SMTP id t7-20020a170902e84700b0019ed6f2feeamr46661447plg.9.1680543872252;
        Mon, 03 Apr 2023 10:44:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:31 -0700 (PDT)
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
Subject: [RFC PATCH V4 17/17] x86/sev: Remove restrict interrupt injection from SNP_FEATURES_IMPL_REQ
Date:   Mon,  3 Apr 2023 13:44:05 -0400
Message-Id: <20230403174406.4180472-18-ltykernel@gmail.com>
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

Enabled restrict interrupt injection function. Remove MSR_AMD64_
SNP_RESTRICTED_INJ from SNP_FEATURES_IMPL_REQ to let kernel boot
up with this function.
---
 arch/x86/boot/compressed/sev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index d63ad8f99f83..a5f41301a600 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -299,7 +299,6 @@ static void enforce_vmpl0(void)
  */
 #define SNP_FEATURES_IMPL_REQ	(MSR_AMD64_SNP_VTOM |			\
 				 MSR_AMD64_SNP_REFLECT_VC |		\
-				 MSR_AMD64_SNP_RESTRICTED_INJ |		\
 				 MSR_AMD64_SNP_ALT_INJ |		\
 				 MSR_AMD64_SNP_DEBUG_SWAP |		\
 				 MSR_AMD64_SNP_VMPL_SSS |		\
-- 
2.25.1

