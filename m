Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75975B363
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jul 2023 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGTPse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jul 2023 11:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjGTPsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jul 2023 11:48:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A722FE0
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2023 08:48:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6HCb44q2zBRDss
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2023 23:48:27 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689868107; x=1692460108; bh=FCfGaRF8sQuOTlQAjSKKOx92Dn2
        EwgkeElpAb7gMRi0=; b=YHh8VwRokVe6wpkuZOLkAiv771a91qQJVRZ+JB9QoBG
        a92HLEQFVn6bhB++Nl2QO0ax0awk/DJ1ii1XP2XjuS491uCdePXQ2dinZLXYwEnA
        x7m8ZE1TUb6hMebr/wYe+L1Xmo2fZBx33UfZmoXJaKqDmNmR/g07lUK1X+aTyPWY
        LyzwBi7qGlQ6mLr5V5C7z7MWVUfhA6Gpn5fA+GIm8ixI/MYIOKUhHlD0z51LT3m7
        pfpNDu1iBr9/T8KF2lHWU1ycTV0+toDL2QdPCnZWeILZcXqw7uXLARceJuNRKg7h
        NtQAdNqxPMK7mh4bKnkrH3P7QTtifTZmXaFe3yXXBjA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m37YrXfqgnqo for <linux-arch@vger.kernel.org>;
        Thu, 20 Jul 2023 23:48:27 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6HCb1vPRzBHXgs;
        Thu, 20 Jul 2023 23:48:27 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 23:48:27 +0800
From:   pangzizhen001@208suo.com
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uapi/asm-generic: Fix typos in comments
In-Reply-To: <20230720154658.54221-1-wangjianli@cdjrlc.com>
References: <20230720154658.54221-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <4844516f7400749da9805c3c7ad9722a@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  include/uapi/asm-generic/fcntl.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/fcntl.h 
b/include/uapi/asm-generic/fcntl.h
index 80f37a0d40d7..1c7a0f6632c0 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -142,7 +142,7 @@
   * record  locks, but are "owned" by the open file description, not the
   * process. This means that they are inherited across fork() like BSD 
(flock)
   * locks, and they are only released automatically when the last 
reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
   */
  #define F_OFD_GETLK    36
  #define F_OFD_SETLK    37
