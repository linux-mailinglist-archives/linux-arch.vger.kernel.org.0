Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4808623502
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiKIUyR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiKIUyL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:11 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D775821E19;
        Wed,  9 Nov 2022 12:54:10 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id l2so18196781pld.13;
        Wed, 09 Nov 2022 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN6eB0wxJRf6zzRxY6T7pa65W2+E1oedx78oWdQ5Oug=;
        b=cauI3nQmhA4WSX/OaYCTewup7EB+F5FVDFiGvtURXi1E84Ze0iEtTgzD8Rbx2nblxT
         2By8+l78vIEz0KaH7vJAwyjM9pmU9ZGJOmOI383sd6iM2L74tJ9tJel90eh7b9aeUuqk
         jBDlH33hr7pj1RVARknPKi6p4zY/yv+KPeKP1y/JrhdC8Sb7j7O/xk2hEXpiVy8zqzl9
         ieSVotSG6yWbedtJP99u8AfkIbg5oPex7F5QEp1bzPUKYz9GHLoiytc78f7cl++wnzfY
         YlkOGWJ+4m3OU/f+KTPyRBiR+D8bvjmcZXc2iP0tM7201E70469rEtO8RHtJ6GDsA/Yd
         olhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN6eB0wxJRf6zzRxY6T7pa65W2+E1oedx78oWdQ5Oug=;
        b=G6Bcdwpcmdvz0PjZfG0SeqbuTmjo2aUGN3IC1WRNYxtcboIKN0iukH+oVOnSo2uWiP
         /oPrngJij+C+JMjARV65yHuG/LXOu6R0ZhbS5lVcm1jg7gqOJNr/pxLLlbXHlcyq9Irk
         XaagS6VVPoymTUgm00wou6ZukGoTSSbdNkupdxftwNhhwqLwP9oXdi1GCOMPe8rxJjfE
         K9r7DX/Sj/m2bdcpDsC8HllKsZrLH6Wu8Q1mdihVdTBHpwIjj2Xq5Ug0JulMSyVHVY8X
         gvPXbEPjUGarUinfSuJjLkBAeG65ZBdXAJRj3JarlzxIoNGHkkKzGjhpqPwPyiC57662
         UCHQ==
X-Gm-Message-State: ACrzQf3oBpsCWKUxX0CL81cIYOTJ6qdm1fJCs+2Y8ek89LAMWRj9TJVN
        SLZx58PfYuMcFQpsPweOQBg=
X-Google-Smtp-Source: AMsMyM4luDAJu7PT7s5+o53Wz7Ymth7QCE0nP0qncCs9XPoDxi+wgcbfnkDK829znHHtTSew3IYeWw==
X-Received: by 2002:a17:902:cac3:b0:186:6ce4:f94a with SMTP id y3-20020a170902cac300b001866ce4f94amr61537422pld.145.1668027250367;
        Wed, 09 Nov 2022 12:54:10 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:09 -0800 (PST)
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
Subject: [RFC PATCH 10/17] x86/hyperv: set target vtl in the vmbus init message
Date:   Wed,  9 Nov 2022 15:53:45 -0500
Message-Id: <20221109205353.984745-11-ltykernel@gmail.com>
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

Set target vtl (Virtual Trust Level) in the vmbus init message.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/connection.c | 1 +
 include/linux/hyperv.h  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 43141225ea15..09a1253b539a 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 	 */
 	if (version >= VERSION_WIN10_V5) {
 		msg->msg_sint = VMBUS_MESSAGE_SINT;
+		msg->msg_vtl = ms_hyperv.vtl;
 		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
 	} else {
 		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3b42264333ef..2be0b5efd1ea 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -665,8 +665,8 @@ struct vmbus_channel_initiate_contact {
 		u64 interrupt_page;
 		struct {
 			u8	msg_sint;
-			u8	padding1[3];
-			u32	padding2;
+			u8	msg_vtl;
+			u8	reserved[6];
 		};
 	};
 	u64 monitor_page1;
-- 
2.25.1

