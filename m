Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C74BA8CD
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiBQSu1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244638AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D57527F3;
        Thu, 17 Feb 2022 10:50:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m3so5339901eda.10;
        Thu, 17 Feb 2022 10:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/mv9B9kxz/tt3t/iKJDekMmwgu1k+2+Z11dWvEyqL7k=;
        b=av0CaKWg58n1u8l2MX25kTvxriQU1FjdWcRy3ytXNxDPTdn6WlupCBzzE3n7vKJqSt
         IhsjEAeZPT/42YQY3xgbSqtx4HJNHEQxtDd3esD4RvaqbYZOf7fi1L7DyjBtpz4sW0td
         sdX0tvcndQudy/z90Ixcr4VVEKOy9cpCSieLUgMZ3xgHQxcc6N0DdT5tyBPowZxvruEo
         M888EBYjCyS6er67ljHe0C/33gdlHGweJ//8owWNohAwU3EW4FXcdVcnVFlm+8G8tpzm
         SgyVdyS+gfbPNM00S0W/eT7S2WBdrU3UQPdq1pcOHLI9JEUEwPE4So0jVFe6AzrJkJ8X
         0k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/mv9B9kxz/tt3t/iKJDekMmwgu1k+2+Z11dWvEyqL7k=;
        b=2cEosemwdVmJCbiummqbMkF9OqYVA2X8QqHcrtzKrv4q+dTXxginKE+e4zkVXUSaYT
         z0UUQo8v5qC7wRljI+I3H67GfAXt+kV53sxZxpXkyh/skNgyw6dA0+406sxBjaO0bGVO
         GS4he+oAGU3eL15EUDHGZcOJmfL4m12yaM8CVplE6Tv5CQMAeZ104kVTtjLkjOMNm7ve
         mA6mPq53LKbsfSZQ2RuqwtB6D1T+P3EB3o6XExZpl38cy6Mn/Z0toQndlIwVmxKM5Z3h
         uBNncX/deotCJ2EbzA8MNiK2yn0+dCnLXK3ExOa+7G+nxmxSvczbM6Q7ZulqVjyGWWv5
         DYAw==
X-Gm-Message-State: AOAM53051kUtthWz1Slsd4ufYN4rUSPKGaHx6pWTzFLpAP1olzOZXDcD
        cVgP08cy7zh/AyqMtP4zh8A=
X-Google-Smtp-Source: ABdhPJzemAhA0rQEUpJoQjey9TRCNS6UoffyAf+yvFAIbn8s6zmCTPE3XwgpAURBlOBHcOsTJ5YheA==
X-Received: by 2002:aa7:c612:0:b0:40f:2a41:bddb with SMTP id h18-20020aa7c612000000b0040f2a41bddbmr4120824edq.291.1645123803138;
        Thu, 17 Feb 2022 10:50:03 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:02 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [RFC PATCH 05/13] drivers/perf: remove the usage of the list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:21 +0100
Message-Id: <20220217184829.1991035-6-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217184829.1991035-1-jakobkoschel@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To introduce a speculative safe list iterator, the iterator variable will
be set to NULL when the terminating condition of the loop is hit.

The code before assumed rentry would only be NULL if the break is
hit, this assumption no longer holds. Once the speculative safe list
iterator is merged the condition could be replace with if (!entry)
instead.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/perf/xgene_pmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 2b6d476bd213..523ff5c53103 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1463,6 +1463,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 	struct resource_entry *rentry;
 	int enable_bit;
 	int rc;
+	bool found = false;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -1478,13 +1479,13 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 	list_for_each_entry(rentry, &resource_list, node) {
 		if (resource_type(rentry->res) == IORESOURCE_MEM) {
 			res = *rentry->res;
-			rentry = NULL;
+			found = true;
 			break;
 		}
 	}
 	acpi_dev_free_resource_list(&resource_list);
 
-	if (rentry) {
+	if (!found) {
 		dev_err(dev, "PMU type %d: No memory resource found\n", type);
 		return NULL;
 	}
-- 
2.25.1

