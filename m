Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA42A280107
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbgJAONn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 10:13:43 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732429AbgJAONI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 10:13:08 -0400
Received: from threadripper.lan ([46.223.126.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfYDO-1kusF41PTs-00fzfk; Thu, 01 Oct 2020 16:12:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 09/10] ARM: provide a TASK_SIZE_MAX definition
Date:   Thu,  1 Oct 2020 16:12:32 +0200
Message-Id: <20201001141233.119343-10-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201001141233.119343-1-arnd@arndb.de>
References: <20201001141233.119343-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DOv13eMPHGqZxsnqif/m3T728BfBiW7qrK545tQGFsrb67TUR3n
 7fs2n1e5laks2MZCVMQQVC1K0fF+GjnDwY6oQsmjBjoLd2f9YmAbdG9jXPHlBQj/RZX8CcU
 E2uCvfGVtswAxxKV5jbZPMeAaY8cHzsVphcg4rjL+AXg+2Nag/2ozWU/GlMgZnlb7uLfLiH
 DoQlYgSLJ6ZLPRZPNRyVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:12YauErV9iU=:TZwvRNoGMGw5djDk2HmyRa
 UWQe8fCOetDIAV+KKYlye+zJA/In/18cThHGpcQh0D9HPmf3SskcnOhNE9t0793eJ24DZap3K
 uhTbM8OhF5aayQi8dR2sDdYVMIp4LAgzAvO6SycJkvaXxOQ383GZBEA3XwB3fBljAr6igjFYH
 SyOrZ3jgO8lLdmo0uxYx9rAopH+hs4Lx92KE/oBPjxnphzvOk5cMs4og4Yyy3fbCZrKrBccUn
 65ap1JVwcBL5/8fy+ZFWK0blWlz8GoWU5PEcjTUV8nqWV9NX8Hfu+tlfmStRUzECdc1cq+zca
 I8RDzqQYlkVnrQMc0hgbpIQuwnFH1EF9DnGCK5uuH70RIF5NFHZPXuALCFn/seJO6a/EZAODt
 Vsp632APiOepMYYMj0UAkmsSvhYrUNghiFzBs4FpUM48+xpdf6WRNZi3jfM9gCxz9WvAZcdmu
 OCPnPFNb3JIlnCzI2dh2iTKfYSXY/mWB7l5XVsJdA4IQqAmncpUbu4IXoITrQFl7xAdmSV9yq
 UIkuZ8tLyOtQUCQU8JlprBRbYzJGHwlFfdW7ajO67G8q34cO11caDG09Ey6o4Fo99HTtn+Nbs
 0ObcBGDz4iXU5OUYT6vRC3hgo8iVwmogy62ve0ulTUue2dE2mvKuTNwCuDhP4isM6XVrAADw1
 yIG4W6u0UeHMR55UzugDQPzmqolne9ytc0VCVA01om0AgIul0UsrKy83HrWUND620LHfeSZx0
 8XjfvP2grTlNSWF2RUbI3k5fb2omHv/8CeA5vbMAmQfaaoc7UHf68NjaYBWo1bWgumbXxGZzo
 QVLryn5PDC3SDp3LNw9GFhGvvTIGIqKyYbNB75t8DNWQpJqf4zCSdrTh9El1xuKdd/fAydx
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define TASK_SIZE_MAX to allow building without CONFIG_SET_FS

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 99035b5891ef..285b32fd1a12 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -29,6 +29,7 @@
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
  */
 #define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
+#define TASK_SIZE_MAX		TASK_SIZE
 #define TASK_UNMAPPED_BASE	ALIGN(TASK_SIZE / 3, SZ_16M)
 
 /*
@@ -91,6 +92,7 @@ extern unsigned long vectors_base;
  * Fortunately, there is no reference for this in noMMU mode, for now.
  */
 #define TASK_SIZE		UL(0xffffffff)
+#define TASK_SIZE_MAX		TASK_SIZE
 
 #ifndef TASK_UNMAPPED_BASE
 #define TASK_UNMAPPED_BASE	UL(0x00000000)
-- 
2.27.0

