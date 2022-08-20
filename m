Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF059AAF4
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 05:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbiHTDhg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 23:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiHTDhd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 23:37:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC62786DC;
        Fri, 19 Aug 2022 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xJYcXOv+CgsRN4P+QAHAq58LVmv61HTA+fEPni+K8TI=; b=wBzqOGUF2rAwr1ogsgBsPp1+sZ
        ORMfv3pAhjLZhjtLc0CTeWDWKZr09+Woae05C0RRmipWsuikbIRoVeznFC4yle8fsOXHXYQ9SiVCB
        d7aaVrw5elDCAMN9/7k8K/pPNxPt+uFf2zluEmOH99qo+5RJIFDIP4J96HlMSkqjkAxZSmWB8H+Ak
        dHy4znWXDAXE6QR61ZfaHkAAqzqbs2Gu6r6mJlBnZqLunfovPEU2y0hF0X+7NvAe4lB1ou1B/1ZcP
        l4Nx3QiDkAxzvnrM6Grx0FYVXbHxuipYVzrD7CBpHRbusSHl8vmQVy16GnpOhW0ixiCQLVJwBfsvt
        TT3crCpQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPFIg-006Hnj-Od;
        Sat, 20 Aug 2022 03:37:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/7] loongarch: remove generic-y += termios.h
Date:   Sat, 20 Aug 2022 04:37:24 +0100
Message-Id: <20220820033730.1498392-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <YwBWJYU9BjnGBy2c@ZenIV>
References: <YwBWJYU9BjnGBy2c@ZenIV>
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

