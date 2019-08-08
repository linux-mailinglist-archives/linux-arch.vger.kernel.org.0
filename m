Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A3868A7
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfHHSUM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 14:20:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:38375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbfHHSUM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 14:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565288409;
        bh=/OhppohmKGbNitwqmMUrBTx3Nb1KGU1IbYsutCsyOVc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ctQdRF6vFr6pool5icswOzOzRBsguyOK3sEl3v3QlNbOz+DTg23D5idup80W8N1q/
         69ceIDl+fHclDXozo5JawtikbIzf7DJcwZI9quEsFUJMe2VPsfaLFZ0C5fFeGKZFiY
         qwxLyX5zrs1SeTaIHEH7QLfxvoS88bLvgvgTi0is=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ld0E0-1idtDF2B6G-00iEjt; Thu, 08
 Aug 2019 20:20:09 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH v2] div64.h: Fix description of do_div parameter
Date:   Thu,  8 Aug 2019 20:19:48 +0200
Message-Id: <20190808181948.27659-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YkjB0YyGHTyXPdmDZ5RM2Pl3WYEtY6yAqEj1Y5afIbyJOXLHnnA
 LlnlokemuBSkUIqMGtHJT1ha4TmT/K2pgadc5EeFLZXQKJb2XAqg+7HYj04sD4EVG2hTc08
 AmhErxPSOtBwGpr8qP2nqocRDRtLXCoXsKLmKjgpN/DdC3XnBx5Auoh+NaXuH3ARphSYGy9
 aWtFJS1gTsn3XstvyxFlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EdlkLztQgIk=:4qdi546uAqqOW4IduF61sI
 8GMRH3PZkCuegyMO/HJYGT/5h5Cf8nDhWwk6pFynGWNVdQhTIXelftsG/laS/peTupYaMerkO
 rr+snVA91Zr8CTU8wDEqWKHAjRRAKu3dMNhw7a7Z3Z49OgDTleAXRFeQdpISDxCvyY/SXky8+
 bsf8H2nR053gLeV7LqU4okhRLC2IqqW2+D3GF1tIXp6MUBQSp94RALE57/Yf1IuBnUPdN2+kC
 iTABmt3jbQk2B3c5g9wXSvsb2eJbTq5raKcZ0Yw6Dq5MHxu71nHeFtpFn5xcG1LKWxywYIcE0
 VemKEWKBQDyGgI2xTwcOUGEOMn4IDC3EsUMPcf+x4Bbh0mC+uH82i7bBsZ3Hom1QXslj0dgWP
 KHUFbN/Jb/wxtjrwri2h+b2dKk4aFGxKCBSBne47WoCr1eGmW6kWQ7jQ6JRRa+gSJccP4JyJR
 vIWsIRj8I780A0O4/szoFbVj7qA4r0YUBmeOA2dTnO9NNgN9Ez0uf0JuNKOM7GKAZTNlxac/j
 QLw4wpvtDS/R/AE5IFuMMOJtImwpdsaoDthrRVCX3Oz8actAA/3+3hZfnlkxmal5h+j5Q5Bpx
 lk6vWc1/HHoPEqS6VNlXcJw0CI9oEGJLM1uUfsiC4dWZKiVDvytM8Ksgn6J3vVZA9HMsdZdqi
 GYfygGro9rwnHC3+qcxN4gr3jHe2ziuGU3rQSLnzm/OqaXLiCfPKRy08kc0J7F/sw1jBlrcKX
 ANNVXhDtSnN5O+EqKp/E7q02YajGXmagW6UD/0MS8nvuRNBJu2RDlpN0hcKwazE88/rLIFLiT
 RodTfDf5unHHzUJdR1P8+Vu/nLtH8+enEnZIkngi5DX/JUj2GkGdk/2tO4C8sgs+GOpK/U9fo
 j9fGAg6bEk2sABbp2LmDn+K2o5QyCT0ivuzYk7BVMphFS8N2VdPh/iig6OvcwpCJ6wtGnRmgW
 M932YyaAx1w6DHmOLlPVrRtnivYeriOI4BDQeEvhY3/Be75ItJtoA5hbHwfzEi79ffh8HQht5
 xMw7PX36JA6FHga8wBweQyTSi6oRI59xw5H14oupCjBrnkAGxSbdw70XT4U+lM+P2K9yIqTAL
 bA0D7zuBzCU/QeKMMddyo47127rpmmaX/drOp7WIzV2wQ+0ljEnJBIoZuqV7hGwVWm/Yfj9wH
 WUBCo=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Contrary to the description, the first parameter (n) should not be
passed as a pointer, but directly as an lvalue. This is possible because
do_div is a macro.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
=2D--

v2:
- add Geert Uytterhoeven's R-b

v1:
- https://lore.kernel.org/lkml/20190225140355.4335-1-j.neuschaefer@gmx.net=
/
=2D--
 include/asm-generic/div64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index dc9726fdac8f..b2a9c74efa55 100644
=2D-- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -28,12 +28,12 @@

 /**
  * do_div - returns 2 values: calculate remainder and update new dividend
- * @n: pointer to uint64_t dividend (will be updated)
+ * @n: uint64_t dividend (will be updated)
  * @base: uint32_t divisor
  *
  * Summary:
- * ``uint32_t remainder =3D *n % base;``
- * ``*n =3D *n / base;``
+ * ``uint32_t remainder =3D n % base;``
+ * ``n =3D n / base;``
  *
  * Return: (uint32_t)remainder
  *
=2D-
2.20.1

