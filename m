Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5A835631C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348695AbhDGFeq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348698AbhDGFep (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:34:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5942D613B8;
        Wed,  7 Apr 2021 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773676;
        bh=B51G6VIlXTzxHLkCKj6iCowgp4FQbLOr7V65C4Er3Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFc2gDty79xu113KxeHIcAEPjptzuOie6tR1Fs+nqswq/li8v5D5Ea7D5oteZuOtm
         uHqLR7wBeV0Vap9ZL+fHU5d4C+zUi+NRH34SuPbTvFwjcmgo31F887/jiDn4pWxPtt
         EqVgM2jaKfBUhY/O+gPZ1iMId2IcQHvNQvR93WC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH 01/20] kbuild: move x86 install script to scripts/install.sh
Date:   Wed,  7 Apr 2021 07:34:00 +0200
Message-Id: <20210407053419.449796-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To unify the different architecture kernel installation scripts, start
out with the one they all were based on, the x86 script.  Move it from
arch/x86/boot/ into scripts/ so that all architectures can call it in
the future.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/Makefile                | 2 +-
 {arch/x86/boot => scripts}/install.sh | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {arch/x86/boot => scripts}/install.sh (100%)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index fe605205b4ce..17c7718c1a4a 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -157,5 +157,5 @@ bzlilo:
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
 install:
-	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
+	sh $(srctree)/scripts/install.sh $(KERNELRELEASE) $(obj)/bzImage \
 		System.map "$(INSTALL_PATH)"
diff --git a/arch/x86/boot/install.sh b/scripts/install.sh
similarity index 100%
rename from arch/x86/boot/install.sh
rename to scripts/install.sh
-- 
2.31.1

