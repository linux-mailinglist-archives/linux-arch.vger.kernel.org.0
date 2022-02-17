Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B74BA8CF
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiBQSu3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A714532DC;
        Thu, 17 Feb 2022 10:50:07 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bg10so9440255ejb.4;
        Thu, 17 Feb 2022 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0f0QJvPY6l0YYLP/JaHLlRhitBBVJpxHfsxb6a5gC7w=;
        b=NOHnBOOXAe/1NOKIQEtHf1BD/jt26baU7KPvJ3ZJu0lACzvjtWpWH0bHsrMSFrMiG4
         fbsIYo888fQ1/DhUvWC4j4rq17q3qLHPiZH8GljDv9JANH/ilWYaaKyjm+ySqwluPLHO
         ycesZ4+dZL1mP39QZkzjg22+FQtYM+/WEG71sWfD3bLEwjDThIvdGADqEnV50FVzYDXB
         t6pFv+LYM07FfktZxJQIMr0tpsLM5HsZCIBpwyg7u7T5t+qA6zrvHtU4Fa+ur+Anf14n
         6NpdYq57CtPS5KKpw5dVGov8WfN+u2ZVvY9VjVWEvIb7fWIOjk3hj0MWQblEhoHzT9yl
         wNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0f0QJvPY6l0YYLP/JaHLlRhitBBVJpxHfsxb6a5gC7w=;
        b=duq8XzKXq1ywrdUaSHoTlph8PgdwqWPkbQ7Wfew+O8zSj4NEajZAQukeC3uPlB7XFV
         fCW0kNOKdpEe7gQSkO7ZexaYnt9KQnid54I2ni1UtRyT/VN6fEH9cWAkrNuLt3ViKOSf
         unK73Od5Sb82lo94b0uqEYie8yaBgOjeulqoXle3YtBOArgwf7jas1BUDTze+RhgYzud
         hrOkTsL8/oZ0WyDtci0ymmVyo9akyCgYFSx85HC+tfpzwW2AAHcNWyoYThn1hQC9iM//
         QE5fajwovhHg294u9AYmmEdcePXsLs733V43tzPli/m/lIOSqMOq4UkyWM0i9HjnV992
         WHGw==
X-Gm-Message-State: AOAM531zQCLajO7cAQU1uk/hdOzhH26iwGs9s9V0WjMpqj1sV7VnP+Q/
        EkHpYR3UODzsw/ZY1RASYek=
X-Google-Smtp-Source: ABdhPJxjICCO3Vhtu+h5/lwmu13mORMlDwV7qSQHPyl3AlJ7a6Vo6Bk6htNd9lAOcvIdXee4sR6crQ==
X-Received: by 2002:a17:906:eb4a:b0:6cf:bb0e:69fb with SMTP id mc10-20020a170906eb4a00b006cfbb0e69fbmr3501911ejb.149.1645123805842;
        Thu, 17 Feb 2022 10:50:05 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:05 -0800 (PST)
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
Subject: [RFC PATCH 08/13] net: dsa: future proof usage of list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:24 +0100
Message-Id: <20220217184829.1991035-9-jakobkoschel@gmail.com>
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

With the speculative safe version of the list iterator p will be NULL if
the terminating condition was hit and needs to be reset to p derived
from the head, before using p->list.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/net/dsa/sja1105/sja1105_vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_vl.c b/drivers/net/dsa/sja1105/sja1105_vl.c
index f5dca6a9b0f9..a4f2b95b09c4 100644
--- a/drivers/net/dsa/sja1105/sja1105_vl.c
+++ b/drivers/net/dsa/sja1105/sja1105_vl.c
@@ -40,6 +40,8 @@ static int sja1105_insert_gate_entry(struct sja1105_gating_config *gating_cfg,
 			if (e->interval < p->interval)
 				break;
 		}
+		if (!p)
+			p = list_entry(p, &gating_cfg->entries, list);
 		list_add(&e->list, p->list.prev);
 	}
 
-- 
2.25.1

