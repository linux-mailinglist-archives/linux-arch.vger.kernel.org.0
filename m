Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9259B125
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 03:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiHUBCn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 21:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHUBCm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 21:02:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271411F2F3;
        Sat, 20 Aug 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xJYcXOv+CgsRN4P+QAHAq58LVmv61HTA+fEPni+K8TI=; b=qzNqzIgSDzXp90+sbsulPF91ro
        yyY7zIfy2/bFwJ/poRpNq4oKPVnGKejz+F1j70oUWHl43RPAXRg+81b3c9pC/061ZwkAP+q0rhrvm
        Nreyium+KFIPOejJ1ESH+KFb2cldN5LF5LN7UmTgwfuPAuLy+Wdt9gaMaH6XuHrofin3v4Q5+gbvI
        VDdOtZdWqxhTFG6/Q+4QFfX928Yj9ZzEk+FBA1NGCLijYS7JkXKkMTCQFcbvDNXgzHNanMJnZRZA3
        zmuqFRoYOrXyxeMpTvYnfOWplcPKj6mLrZSVU8z29lxgy8Qegg5TXQWCfXD2pqw0wpwDuKl25g3c4
        /Bj2F6Og==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPZMN-006WIl-6C;
        Sun, 21 Aug 2022 01:02:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/8] loongarch: remove generic-y += termios.h
Date:   Sun, 21 Aug 2022 02:02:32 +0100
Message-Id: <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <YwF8vibZ2/Xz7a/g@ZenIV>
References: <YwF8vibZ2/Xz7a/g@ZenIV>
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

not really needed - UAPI mandatory-y += termios.h is sufficient...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/loongarch/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 83bc0681e72b..f2bcfcb4e311 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -21,7 +21,6 @@ generic-y += shmbuf.h
 generic-y += statfs.h
 generic-y += socket.h
 generic-y += sockios.h
-generic-y += termios.h
 generic-y += termbits.h
 generic-y += poll.h
 generic-y += param.h
-- 
2.30.2

