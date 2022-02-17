Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC24BA8C8
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiBQSug (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244649AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6775522F1;
        Thu, 17 Feb 2022 10:50:11 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p9so9428087ejd.6;
        Thu, 17 Feb 2022 10:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zM+Hp2WVjXIaMPVWa2mQUV9ISK0HqYCrHac37DPF8pw=;
        b=BolWhcpS/6HTOxCBDIDuBl/h5hPvE9JkG/muCPtASmFx6+y5sndVaFYhkOPuPssfkn
         N+WkOdD+19aO763ei3Eu2WU9ftQN1kp2LK8+YjHnTP+d1bzQRvVcFvzir84VaaZy28qh
         snuYfFYT79MuLmapUWJYpxEHds4dVHjeyRv0d+6T2s9RwEDKe+ZQu7lgo9gpCtIbQU/4
         3A+2aUTEa797Akyg/0hLzZ8eZn+p9LnYhoJV8TN3b6tuVbcogD/UXwv+tlWJ9SDzZCrg
         +P8c0Giv0WWtwBFlUZ0Oq0JXsY7DLui47NCMGSowRFKP1k4VtDZGpz5Ldv6bL7JB4BA9
         14Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zM+Hp2WVjXIaMPVWa2mQUV9ISK0HqYCrHac37DPF8pw=;
        b=lAJM+uUNMVavKbvgr28gZUaExTKc9uT1rHYnMG69Fhw0oJBm7L2q0ivNkcFybxExHh
         LR4uRJTpQNdFOtvUDnIzrj0AmoyICsyE4ChUrbm9fOeeEQTE+lUG2eYRJzRnVb6ft14j
         SucmcA9lwClWjVtJw92O1ayd7gx8UTeuuU8Ak9sitMhooQHeP1rDGwBtfmhWpB8GS0z3
         M8IRzh937gDGCMla1rYyEr2LDXWvXICDZcKbdbPihNsTHUjtuNd5wBV53rJ3wkVBQo3K
         7Gx1P+82R7x3kx5yWnYIVcnUOQ84zkhnC6rCZwOE+DDZ8QRQ53i4JhD1IFtbC9s+oWU+
         DLKQ==
X-Gm-Message-State: AOAM533hD4jvIIYgmzjWvGha5J/zTEofD4EJhVCDlgGJulOfsyK9ykFh
        QSZ209r1ahSqWVAniECldU32OKfK9Aj1Ok0bZmrk0Q==
X-Google-Smtp-Source: ABdhPJxAa77nD+43PdtywudpGPQcktl4VzQxfGah+xpGfQDtyZvDMsYlyiTUJn8yQjbvV3UEVOkWiA==
X-Received: by 2002:a17:906:82c4:b0:6b7:e0fc:c9e0 with SMTP id a4-20020a17090682c400b006b7e0fcc9e0mr3507573ejy.555.1645123810477;
        Thu, 17 Feb 2022 10:50:10 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:10 -0800 (PST)
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
Subject: [RFC PATCH 13/13] scsi: mpt3sas: comment about invalid usage of the list iterator
Date:   Thu, 17 Feb 2022 19:48:29 +0100
Message-Id: <20220217184829.1991035-14-jakobkoschel@gmail.com>
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

Since the list iteration never exists early, reply_q is guaranteed to
be an invalid variable and should not be used within
_base_process_reply_queue(). Since I'm not sure what this code was
supposed to do, I just marked this with this comment.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 511726f92d9a..a6746e124226 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2013,7 +2013,7 @@ mpt3sas_base_sync_reply_irqs(struct MPT3SAS_ADAPTER *ioc, u8 poll)
 		}
 	}
 	if (poll)
-		_base_process_reply_queue(reply_q);
+		_base_process_reply_queue(reply_q); // COMMENT
 }
 
 /**
-- 
2.25.1

