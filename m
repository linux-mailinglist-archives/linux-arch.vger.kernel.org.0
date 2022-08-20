Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD459AAF7
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 05:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiHTDhe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 23:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHTDhd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 23:37:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41D786E5;
        Fri, 19 Aug 2022 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AYoIFZmzW17r2ecvwnK7DPifTfpRbcH4SrwDD4xgfY8=; b=MMT2UpYGaMtZ4aVqIY/+gZnRam
        AINTjSgHQzMI1AhkisstpzqPVqYPhvJtC2nb1ifEhkzPqzTVdyM5MR54rfqwq4+4tEFRYetwxy1oy
        qLO6Mg6WgUXddcB3BVoKMerNoipAsLwbYngtPQNOSS9JH3jfhgisTsj0ArYT5LNCEJn2JdJ5Qjlsv
        McoMgRbq2vUfnUAzHHQR4V1vJ4MEIYb4eMEUzrJGb1EbPR3gtj+i0PXhbTd1H9H04HjlcpU2ltUXc
        ggvbCtHH+aVESbeInSI/PMZCybLfPfqpb6WHkEmwyTfUMQal+LShFJWpLz7dHWJgj/5yfxxejH5Iq
        zWaglX0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPFIh-006Hnl-04;
        Sat, 20 Aug 2022 03:37:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/7] termios: get rid of stray asm/termios.h include in n_hdlc.c
Date:   Sat, 20 Aug 2022 04:37:25 +0100
Message-Id: <20220820033730.1498392-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820033730.1498392-1-viro@zeniv.linux.org.uk>
References: <YwBWJYU9BjnGBy2c@ZenIV>
 <20220820033730.1498392-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

that's the only one outside of include/uapi/linux/termios.h and it's
not even needed there - we have linux/tty.h already pulled and that
pulls linux/termios.h

Normally I would not consider that a sufficient reason, but there's a
plenty of linux/tty.h users, and this is the only one that follows that
with asm/termios.h.  The situation with termios.h is genuinely convoluted,
and this complicates it for no good reason.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/tty/n_hdlc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 94c1ec2dd754..5540d9be65ea 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -98,7 +98,6 @@
 #include <linux/if.h>
 #include <linux/bitops.h>
 
-#include <asm/termios.h>
 #include <linux/uaccess.h>
 #include "tty.h"
 
-- 
2.30.2

