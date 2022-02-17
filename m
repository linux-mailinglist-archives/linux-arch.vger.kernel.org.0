Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134334BA8CE
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiBQSu3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E77532D9;
        Thu, 17 Feb 2022 10:50:06 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk11so9473224ejb.2;
        Thu, 17 Feb 2022 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QtTQzoKh6SHELhVbK7UgiDGo5+sChsVz7qZ/mZQ4wRk=;
        b=LfG5Bww0Oy3sfjvyo7UZik9CTOze3VJSleCGeTzqBYFQBb7GCb81WoeNFCcwMDHAf2
         6KDyRC9FbU54q681hajrooEUs1aUj1/X/WjuVoV3omcO+G34AxBIxo5VUbbH/vgctNu5
         1nPnBsA8HLXrB09j1Wal4ffV2IdeaqW/EDGtqMw6CEptfUVX/9wu9p6LShOkI46d0IfV
         f3qb+rqVCZPlnikjHQsgKr/voCZUNSLcpsDDevv90CtSx//A6/d3IEgX3w+q0SNjp1ng
         d7OUNelVCif/q3zsuV5zwuSk4/D/XArrjWCtU6hHhewjLLju4BupSa/6nftUykdH73+X
         JYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QtTQzoKh6SHELhVbK7UgiDGo5+sChsVz7qZ/mZQ4wRk=;
        b=wn0sqvOmQxI0h5noPo+XCYO52Gj+7O66j323rHL6/4f68W/mx2ECsONeQmrqgkfHpr
         YYHTRCYJkYfXopX70g4jKzeW/3Ag6kOgfufGkKgKdtjfP8TOMn92JBpwBOVg5sZtavwk
         USFwyFisy8Efj/OoErFXyrN/uU/EC8xMuf3bcwHVceQq63vwygpRsvhL2AE7R8uYCva8
         9VeFJ0W1f3cD607iOPjvHHVGwhzdFIL9xxPS8FqH8AAcGX0kPdtL4+LWBQOXD+tW3YWU
         wnClr9WQMBekTCu8lU2RJtIBG0j6x4qufWkPl+818hxJHwwz6iU9Gp+gUlltc41zZ8Vy
         ZRlw==
X-Gm-Message-State: AOAM530xyLyQNaDStFYAEKpaZViBoEdHdmG9A9PVLH52kb5ZnhAvMDCL
        q6iqQfSzOzpaIyFAgdzpOWk=
X-Google-Smtp-Source: ABdhPJwmtpAYY/5eTeVCIMOnvNGpPiD0a5ljZK65FIzDqh88/jSCNF3UR1fL3OrGOhT7yseUT8jxJw==
X-Received: by 2002:a17:906:284b:b0:6ae:9d05:e904 with SMTP id s11-20020a170906284b00b006ae9d05e904mr3341561ejc.345.1645123804953;
        Thu, 17 Feb 2022 10:50:04 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:04 -0800 (PST)
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
Subject: [RFC PATCH 07/13] udp_tunnel: remove the usage of the list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:23 +0100
Message-Id: <20220217184829.1991035-8-jakobkoschel@gmail.com>
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

The usage of node->dev after the loop body is a legitimate type
confusion if the break was not hit. It will compare an undefined
memory location with dev that could potentially be equal. The value
of node->dev in this case could either be a random struct member of the
head element or an out-of-bounds value.

Therefore it is more safe to use the found variable. With the
introduction of speculative safe list iterator this check could be
replaced with if (!node).

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 net/ipv4/udp_tunnel_nic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index b91003538d87..c47f9fb36d29 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -842,11 +842,14 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 	 */
 	if (info->shared) {
 		struct udp_tunnel_nic_shared_node *node, *first;
+		bool found = false;
 
 		list_for_each_entry(node, &info->shared->devices, list)
-			if (node->dev == dev)
+			if (node->dev == dev) {
+				found = true;
 				break;
-		if (node->dev != dev)
+			}
+		if (!found)
 			return;
 
 		list_del(&node->list);
-- 
2.25.1

