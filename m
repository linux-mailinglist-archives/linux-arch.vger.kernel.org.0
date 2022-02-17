Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFAE4BA8C3
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244625AbiBQSu0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244640AbiBQSuR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:17 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDA1522EF;
        Thu, 17 Feb 2022 10:50:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vz16so9556606ejb.0;
        Thu, 17 Feb 2022 10:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=unUH0vvyOBECU4IrGGURVauaUXMQWjJ7wkWDp8rOwCg=;
        b=Fl3qxwWQ5BLecyc2lLwyIjWUBs0RQaVZrk6sfZcHIjbYnBUMpeF0Gsv2igqs1xjD+9
         5v1Kdd57Q35HedaFP09/Iom0huFuGfh0uCygJnKVLHh/wtbFHE6Nsa/itVlT5w+v36I2
         8y+V8HUoVwJQV8aRG8ne216+yVcyYjqM3PIFBDoeZFAkMw1+S+0ka2O55icCeOCF3Yuy
         68LKEqYcjBsZwc2MQpzC6/1bFen/+5+9/QiER2lfM6mEezOTo2t4SYFQuaIaCo7jaugC
         aCan1E2p2RnHQVIE92rWEdYnl7vYnBzK5wDkbdzhY4pKP8g3kluE8ubdW6sifyYxUzup
         qzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=unUH0vvyOBECU4IrGGURVauaUXMQWjJ7wkWDp8rOwCg=;
        b=yvGPBavcbXt+SGR1HfCz6jubsiRCKXxUTymhu1B2Pc09ZuQ0PoPRAoT44b63N2RMKn
         JhQF/xNXPBpSHNtv7F0RVbO7YWMMG016Kx6nnK8YPnRSedg2QxtroMpXu5n1SHrm7KgP
         knny13f4hm+oJtIsHMltFY7FFr3K+2wLA61r929/dT1cuOhY0OHzieWLQqItIsrG73D5
         Jq5ZzSUL3v5Z29zUTH/DwkOowxOYdi/1Ltl1Gb95/t/zZXEUEI+/rf1BDE177q0Y5S4J
         wsNvVVvZR43DjfRoVepzyKmRjlHTEcxU25T1jmNTjZvnSqwMRoUzFx6qZiojfxpiAV2k
         Sf2A==
X-Gm-Message-State: AOAM531Xm+Ize6ZdCWDI/utSl9iwmz/ctbY5BWRDkokUxemKCMetpBtz
        8GPV9BUllE+r+0s6NqK4UhA=
X-Google-Smtp-Source: ABdhPJyDAa1AKzFWhHhYKIS5pXEt6jcYgUa5Vbkg43ImUDfsxSd5kyjg4MEf2hS5UQ9eOXQTcGseeA==
X-Received: by 2002:a17:906:27db:b0:6ce:6f8:d0e3 with SMTP id k27-20020a17090627db00b006ce06f8d0e3mr3515168ejc.455.1645123800878;
        Thu, 17 Feb 2022 10:50:00 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:00 -0800 (PST)
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
Subject: [RFC PATCH 03/13] usb: remove the usage of the list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:19 +0100
Message-Id: <20220217184829.1991035-4-jakobkoschel@gmail.com>
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

It is unsafe to assume that &req->req != _req can only evaluate
to false if the break within the list iterator is hit.

When the break is not hit, req is set to an address derived from the
head element. If _req would match with that value of req it would
allow continuing beyond the safety check even if the _req was never
found within the list.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/gr_udc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 4b35739d3695..18ae2c7a1656 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -1695,6 +1695,7 @@ static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct gr_udc *dev;
 	int ret = 0;
 	unsigned long flags;
+	bool found = false;
 
 	ep = container_of(_ep, struct gr_ep, ep);
 	if (!_ep || !_req || (!ep->ep.desc && ep->num != 0))
@@ -1711,10 +1712,12 @@ static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	/* Make sure it's actually queued on this endpoint */
 	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req)
+		if (&req->req == _req) {
+			found = true;
 			break;
+		}
 	}
-	if (&req->req != _req) {
+	if (!found) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

