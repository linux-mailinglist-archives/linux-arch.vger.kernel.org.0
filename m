Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06E928010A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgJAONo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 10:13:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36927 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732420AbgJAONH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 10:13:07 -0400
Received: from threadripper.lan ([46.223.126.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N7zNt-1kSR3A338F-0153Zr; Thu, 01 Oct 2020 16:12:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 01/10] mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
Date:   Thu,  1 Oct 2020 16:12:24 +0200
Message-Id: <20201001141233.119343-2-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201001141233.119343-1-arnd@arndb.de>
References: <20201001141233.119343-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JIkXMdpDR0ur20R0TfErz+SS7ek7hvlvdV08ZHXeS+8QM4q5qK6
 oT9S3UUAu8+kuKQ310bTrvgZsTPi8oFqjkMnDCgDogD5CTA1129uIhJSRz66AIMQ6yGzpwV
 VZ7gSDOe+HZl0q0ILFE1GDKaBjPyI0M+DNF+78LaWKBU+07VvQz5UeP0edPN78w8PRlI3rm
 B1KVNZjXcwcfTqz40kzbw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qrUogoUvLLw=:+pbjXbqQxUCpKCme1RZhl2
 zc7bJzX+2DAGkGh5VmN+7gSpTBJPbC7RolI8bMF2Z+DDea3ZJF0kR6Ld4B3RfHVd7vPkaUMdp
 0WNymXhXx9vd7jZDICIyZnrsBgtxCbzP6LcRMb4SqZhoxOh8wfn+W4eOuPpBuDI5WGBRc9MDO
 ixnj2wBXKRn+HqufENoX5QQHVVntKLkjakka7wvZvZLtdl4EqZDo6/CjGsmQGxtqA9kRHlXV0
 sr74KwumQ3Xz6zPbZgANxK06SwKVY/My6ROTRnnrIBDI/cBpMXATnpv5phPBGDFSacF9dD5JJ
 MzPNeuOItveG9UFf35QfuUyer+jFhh5+c9ObUBKal9r8zByMU+MCHHc5TgqIut6/rfmRHgLm2
 Sir1y2RGYkDtmy0tqy69PraNN5UdK30CrCGbzFtwem0Xqg6+Am2xwZe6zvdErMVmmoMLe4mE8
 iNv7MGsq3+S9z+0FP3drVF0zuapLhZlZ6Rh4JYT+ehx/Q6CUkDmXC75hnG+ai94YFqkJPb6TL
 rfoz2Exakbgw+hN6w7QJceYdHmDsTkluvtyvFleqZqH9w42ZOGiE54PSm4btuAcKS+gXEbEPa
 uGmo8WsfKwITSzMLnlPhmghA1NiwJs3P7E2IcvmyL67yRlcSLrV4VPfPkYmjOKRjK1AdmoMTe
 cj4x989Ytn+yfkYcdMT2v3CA0U/KIilQZb9AYID1UvZOBm53SCy50RwDtw8DYd/vFC91+4WH6
 K2/pebXwCupnWz1vbQk4cDs4H47oFOSHca74ZXpDQH8HDxeRQrvhaBgeudfixDl6iiSZOVCke
 0wTJXd3yoRzjMH5PXfMOcM4a1cFCkerlUapMYjUCpadICOCeAEuHGAiIvHtnRwtHtC7NLJL
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On machines such as ARMv5 that trap unaligned accesses, these
two functions can be slow when each access needs to be emulated,
or they might not work at all.

Change them so that each loop is only used when both the src
and dst pointers are naturally aligned.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

