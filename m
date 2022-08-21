Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718AF59B129
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 03:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiHUBCn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 21:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiHUBCm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 21:02:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A31F22534;
        Sat, 20 Aug 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AYoIFZmzW17r2ecvwnK7DPifTfpRbcH4SrwDD4xgfY8=; b=EUX3sfnRTNC1sSh57ev1tEp/dG
        zidSyh0ux/Kj//9JjG+a4nIWLaVlp6e88c5XehWFEbVljOM1DEeBotO6Ewk8T1eGE45eBmVCV703s
        GuTQhYERRnsgb7bta7988COpc78Oe1inMBI1jff3YUKBZ55KsO9JkZdrKrkuLkqeNmBs7iquDvMu/
        kmO2K/X8lpinALHaAnFvPwhRgF1qYVLJZGZ1lNncbccDMiNw5JFBTeKE3maCBtuhoI0cUrOH4jp6O
        ar+Qg8mIefEUvs4ypjmZ2jXIkfUi6py71RPB6F6HTe6gadbsDJr5DomV9wYGzQ8nRruwiQPJK7wIN
        6ENVlBTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPZMN-006WIn-EA;
        Sun, 21 Aug 2022 01:02:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/8] termios: get rid of stray asm/termios.h include in n_hdlc.c
Date:   Sun, 21 Aug 2022 02:02:33 +0100
Message-Id: <20220821010239.1554132-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
References: <YwF8vibZ2/Xz7a/g@ZenIV>
 <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
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

