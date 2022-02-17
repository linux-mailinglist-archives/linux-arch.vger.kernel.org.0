Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8207F4BA8D2
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244676AbiBQSud (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D1532E3;
        Thu, 17 Feb 2022 10:50:08 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hw13so9370984ejc.9;
        Thu, 17 Feb 2022 10:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpBWiiaR04aEkFVsFIobErPGGU69qIWZRAZ0zLpDwAk=;
        b=c2asecRRx+vL9d/KAaw+7Qk8bKQr682XQKiP5ncBROE8yBceEkrg0vF+KZLEYtf+pX
         48yxCW7KEp60jqF3eLYktmaWDbJJWD95L2rkthySbEBpvfi1kfKxXAfK8jqMd8d3Vu12
         2B8E4S5QY9CT2EAc0EIXFSqZWiqkeN7ySwzW8EuBtyQh3/xeRTgWs+/etLtCKQWvgZ/+
         Hfn4wDSW4QsCU8X2IfzlBqaCUq+B+Y/L4MzXxcQfqhYoQuGk0gxYPnIJOIZ3FNd9KGWE
         LtEswyev4pT+5dHSMcW3T0dT7zsjsAzP3T4SAfXdnVi2dVVB77Yyn+F8O5dYZgUnqILe
         IpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpBWiiaR04aEkFVsFIobErPGGU69qIWZRAZ0zLpDwAk=;
        b=tORuIJ3pxf9q14Xj8tVi3bdLhV113jC5rngIKXoQ9JwkptKI9abO+Tsz+0jFmlt7vm
         j3t09bQu1REak2V1JmW5JfIJfFK2bntaTVBZTeyQiiB5MLwq/inTMtZq4BldbqFmD1rf
         IgoLJ7JpsYKLvsvAa8up5yCKItgxQgQ4/mxzlozwpF17PnwPEuzC6F1iEsju8vEFqh8j
         ZwWfdTX7Sp/jW5a5PsSOmg59v82w3t+Huqh6RXec1/dVLZe255WRxml749LckDBuDKZE
         g+ki82JHm5QjtU7xHYze1lDN3N7fg7Cof3pXl+wrgN5aIYu4Os198rPNgi0XRxIo9ht+
         6gHQ==
X-Gm-Message-State: AOAM531pbyKExd0CM07tet4UTGR7qCn5L3efatm3Jz7gsKCCl4/gafKo
        oBGzKPjhujA4PqJt706ILRY=
X-Google-Smtp-Source: ABdhPJw7pGHg63Wd6YbBVyy9xUXridLW6IguhuGjOhd6bVObozVss8jPIV3gNzSSkSPXYpbSgDgcqg==
X-Received: by 2002:a17:906:3bcb:b0:6cf:cf86:28d7 with SMTP id v11-20020a1709063bcb00b006cfcf8628d7mr3441587ejf.274.1645123806736;
        Thu, 17 Feb 2022 10:50:06 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:06 -0800 (PST)
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
Subject: [RFC PATCH 09/13] drbd: future proof usage of list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:25 +0100
Message-Id: <20220217184829.1991035-10-jakobkoschel@gmail.com>
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

With the speculative safe version of the list iterator req will be NULL
if the terminating condition was hit and needs to be reset to req
derived from the head, before calling list_for_each_entry_safe_from().

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6f450816c4fa..d98205b46f59 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -227,6 +227,8 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 	list_for_each_entry(req, &connection->transfer_log, tl_requests)
 		if (req->epoch == expect_epoch)
 			break;
+	if (!req)
+		req = list_entry(req, &connection->transfer_log, tl_requests);
 	list_for_each_entry_safe_from(req, r, &connection->transfer_log, tl_requests) {
 		if (req->epoch != expect_epoch)
 			break;
-- 
2.25.1

