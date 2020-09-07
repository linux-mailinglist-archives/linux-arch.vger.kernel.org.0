Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC75B25FD44
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgIGPjS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 11:39:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbgIGPil (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 11:38:41 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBltK-1kPFtF1hMq-00CCY9; Mon, 07 Sep 2020 17:37:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
Date:   Mon,  7 Sep 2020 17:36:42 +0200
Message-Id: <20200907153701.2981205-2-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200907153701.2981205-1-arnd@arndb.de>
References: <20200907153701.2981205-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:31/POUWQp1frtERuDjS9nzjZRuMNBQ7Hl3VxeiobYDrtzHzJ2GM
 9wXwMRq/o9LvfehtVxWSMILv/LQI5+kUntODj1eCkVxeCYq5Lrz/gGasQFrjKx+LO0h/Qf6
 pjokHD1+IYoLYtmU2LohgFAguxtZa3LdkAiQyIOU8lZ6+niqwzeZQNVYkR+L7T4UuZdL8Zf
 gsLsiO7j5MDIewk++Z/ow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aItepcr89DA=:aiAcRLMkq0gHgO7TDTGkcb
 uZEMfKxb/i/P9Ubbqltgx+eWjZotocAHZ6qMJ6MtcmtFoSW/uCpn3Zs8e9ruuMRzn1XGLJk1g
 oxfQ/Gw5UpJhnV0SR73Ld0iVUA5Q2M8lo9SD/j1cf5y9wQ4iJ34KKpBZLkzGMwnuxYe6/X3rV
 DEylejz1mpw7B4lGzkTN891jykp3fRJHx9pw4/CsgeTQntVMBFyMzmNurX9MOXelYvtdc2jLu
 e8acewZxxgXxvvSrl2kVxbyg5PfHhc7ShUvPVErZFaQxlDipp4PvwR0eHB/2kEiS3NZc/27hU
 SFjh94GcA8w+/n4sEnYYDCAaML4bjRvTkWKQf4nGnepuRWYswuBcf4xNhSFdk8KsWQnXt65D8
 UNfjEVJCc0Wd16VxUE1hDSX4TzHlhoRwgaKJH6PudhgLkDQqCwVLjewc4cc+5gFX+cjhbphQo
 P/Er+fCNyKiuGLgO7cMIr0z/FXBjHXiK2OCJE5dVyaBJqusIvJblWEaKBKkSa5c70fTkBd3GH
 OG0LoaYDZ3mK/Yy4y66vHYgs8tf3Y/heXTXtFaRgcctWAYHLcvBj7rQX/PhFCnuhepHUC0GbE
 WUrtPFQfdltMfXembr86ptRtpjfcfwKhLVZ23UA3kIxcDrGRjet8CxNdQ+oTD3X/jLx0JTVf0
 folBd4CNWLTkLl6F+jFElPI9kgbia3Vqr3sMU8qOTKzdHw7kl5z93oUwI0fIPhuwMCi7xGOkm
 gnWLik9otETPdKt4WZxfP++KnRgPaaIVeGb3qjiOv2I5lk1qWl/AaISjzVPgpqAvCXJyYkOtc
 zovMuSd2ZTY1/lfXKqRhtcE0uDKI5q7wwwW+/00cUI/XyCFxTYGFzh6EryfpzIvgexCu69y
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On machines such as ARMv5 that trap unaligned accesses, these
two functions can be slow when each access needs to be emulated,
or they might not work at all.

Change them so that each loop is only used when both the src
and dst pointers are naturally aligned.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/maccess.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 3bd70405f2d8..d3f1a1f0b1c1 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -24,13 +24,21 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 
 long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 {
+	unsigned long align = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+		align = (unsigned long)dst | (unsigned long)src;
+
 	if (!copy_from_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
 	pagefault_disable();
-	copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
-	copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
-	copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
+	if (!(align & 7))
+		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
+	if (!(align & 3))
+		copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
+	if (!(align & 1))
+		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
 	pagefault_enable();
 	return 0;
@@ -50,10 +58,18 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 
 long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 {
+	unsigned long align = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+		align = (unsigned long)dst | (unsigned long)src;
+
 	pagefault_disable();
-	copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
-	copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
-	copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
+	if (!(align & 7))
+		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
+	if (!(align & 3))
+		copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
+	if (!(align & 1))
+		copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
 	pagefault_enable();
 	return 0;
-- 
2.27.0

