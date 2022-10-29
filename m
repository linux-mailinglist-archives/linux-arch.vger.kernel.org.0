Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A9D612665
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJ2XSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJ2XSx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BEA2F009;
        Sat, 29 Oct 2022 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LtCMl0coz3ZXBwuQZGamm/+d4rImPuW8bqG03cn45bs=; b=FCouf6HOx24I4JqBvfnQr3QcdO
        tD+iJyXjEnDyb508Tw9isA32KpLCv0WOb+ufmsE5oIMaf+c+WS8relTu3PVcqkcjo2X5F1EZ49SJp
        ebTIw/jYNxMy9v6VcAagQDXdvghQ5sYhnwVlamNZef1OvUqO2YObwFIOL6WqV36P7FarOhHWM5aYu
        6zaXidyY2Lz3BvtwM4ryo/QC962yJlh843x9RkmPKok63TbJvF1R9cOEOuKtVjPYmvuy2OxECfagu
        SoBw720NBnY00CR5sMJvfLwXH+FY7rPtbetQQwUgGLkVf8z+dPZ54MsHiLiMPxvUwP20Dec5/syPU
        qK+nOT+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6J-00FOKa-1G;
        Sat, 29 Oct 2022 23:18:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] kill extern of vsyscall32_sysctl
Date:   Sun, 30 Oct 2022 00:18:43 +0100
Message-Id: <20221029231850.3668437-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221029231850.3668437-1-viro@zeniv.linux.org.uk>
References: <Y120X8dWqe15FPPG@ZenIV>
 <20221029231850.3668437-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

it's been dead for years.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/elf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index cb0ff1055ab1..289aa3ca4a05 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -226,7 +226,6 @@ do {								\
 /* I'm not sure if we can use '-' here */
 #define ELF_PLATFORM       ("x86_64")
 extern void set_personality_64bit(void);
-extern unsigned int sysctl_vsyscall32;
 extern int force_personality32;
 
 #endif /* !CONFIG_X86_32 */
-- 
2.30.2

