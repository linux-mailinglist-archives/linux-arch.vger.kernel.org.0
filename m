Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B95486E67
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 01:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbiAGAOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 19:14:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:46757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343788AbiAGAOE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641514442;
        bh=GXWM4/EezVw90Q1yq7MNbtsLpD/+cAlg3y+cQMfbSB8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=KBQqBfx+qMimh6e1iBpYxrQK3KIejIMEpuVSvP+Z2Y6lEmYcHo+Zf3E4+R4jicWX5
         aqzKA7IClNDYPyf3xIO+lt5GayiGfq8AFNwt+0ImV7ptOUK5vwIPpJGq07VrBEa+di
         dGmBp/WzP/JqCUhqQjZtA3cYYPvbqQy4XNPGiv2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.152.191]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1mKb1V0ist-017CsJ; Fri, 07
 Jan 2022 01:14:02 +0100
Date:   Fri, 7 Jan 2022 01:13:02 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH] sections: Fix __is_kernel() to include init ranges
Message-ID: <YdeFjo1OyhAD3/+K@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:l2V/NFTYg4pHP7N2VuiFMzJsYgHSpjx30pzLTEnEda3F8gvjLKL
 sG+UTVajAWFLn1IBdDBF6nGOZ/lyt5DgZVfzMCaUd9G0Y+6V0zgFirWSfZE1ctmHszUFHor
 l6YYr8ywKFnMlJ5AFG9f4noleezH9C2fEjEecLWso2msGTl7WVA9y1vYNZUglxD5TQR5FxK
 +dCCLVu8H5dG2acMZfzow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z21eSQYKMPY=:47dF8xUytUfpRYmsQ81rzW
 ACNWxPFTYMe2o0CuQaNtnyjtYvgI37yQs6TTgZv3y4b3N2x59B3NHqfeFkJQWNI4yxxpOrVp5
 zkvp9fzL+wTiaVpxpMzoBxTpqCop1AinDfDXDXhkfVtwY01JdUXXnTR1lSAehThrkKnLtSSaw
 /8krTi1Yf7KfC6zMdJ2BpJ7Sx/9Nrdr5MUlLBBWHicNYk3Emv6IVcpoJK5L0UxqD6PjSIjIyH
 auvatjpwsxwuf5gvPWrG6obMwn7Q5UDO2/j9BkKynSda3wLqnCn4ZaxM2rckstgaAkPSaUaNO
 1uwapGPnHxvI77CncwS/1sMzNb/boOwiQ4v/5v81GZrcgSyxv2sKpF14sCzEbylO4aoVlJefL
 yyhYhIWrCvgDu/P68qEPTOao8tSHTOI2jD/oPuh2S8RuiSf7r28AUoocK/cJi+KHgAljXdAWA
 oM58TmLeti+cIOYUCl3Jr88Exxf2bqVB/TPSzBntchPiX9VvI/9zGiGzbBukIlmGOTYBp3D4x
 nfvi8tpPADDJV8mMt5vXHnsVQC/3i6rBUWVvASnxBHIGIXj6DBLXW92adUkrgpt/Z1AlJfSym
 LRgQmgYcw0YCgeA1sVuiVlclifSg/I11EzLw15whB1OFJBdataz/AZdvlwhUGc7OV6+lkIGEP
 q+l4UV4ymGaZNcQEJr6U7PPwOi7QwggvK4kj74slVgcrOWk+fVFQ4e1t7mB6lIrV0Cgy2Jn9d
 cpTYOY1sxU65KMf3meHIrnNrsJIyKnVcvz1E1M8yaMODjUfoKZF3b96OGyPPC+0XnoV72+vS2
 kt94w3evJC61duBiQdHJlf7AU9B6rf0lRoLjV8gk/VGWTByRhKb3I5kzFQBFZAgmmsBRMhSAy
 eG6nfe+3bGNOE/TugYY0AMHJk0OM1OXGT8O7kX3Zzzm9H9ZLu0n6hKj4vGzb2m4oPbTbqrAl8
 1Fz/Ec4AF3gmqa3TKmerX4hfMFK9s+dH76+tsUuUk04qH7dRIh3ronkEJbnlZiJi2av/6IUvI
 Mx12zqXlF9DuqVse1EZwRj81VqT0eyrZRlZdwO5VM1Szq5TwiNFmUWL4NhWsm9Mbpc9ekovhm
 Xo9pxNRoKtfIt4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_KALLSYMS_ALL=3Dy, the function is_ksym_addr() is used to
determine if a symbol is from inside the kernel range. For that the
given symbol address is checked if it's inside the _stext to _end range.

Although this is correct, some architectures (e.g. parisc) may have the
init area before the _stext address and as such the check in
is_ksym_addr() fails.  By extending the range check to include the init
section, __is_kernel() will now detect symbols in this range as well.

This fixes an issue on parisc where addresses of kernel functions in
init sections aren't resolved to their symbol names.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections=
.h
index 1dfadb2e878d..00566b1fd699 100644
=2D-- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -193,12 +193,16 @@ static inline bool __is_kernel_text(unsigned long ad=
dr)
  * @addr: address to check
  *
  * Returns: true if the address is located in the kernel range, false oth=
erwise.
- * Note: an internal helper, only check the range of _stext to _end.
+ * Note: an internal helper, check the range of _stext to _end,
+ *       and range from __init_begin to __init_end, which can be outside
+ *       of the _stext to _end range.
  */
 static inline bool __is_kernel(unsigned long addr)
 {
-	return addr >=3D (unsigned long)_stext &&
-	       addr < (unsigned long)_end;
+	return ((addr >=3D (unsigned long)_stext &&
+	         addr < (unsigned long)_end) ||
+		(addr >=3D (unsigned long)__init_begin &&
+		 addr < (unsigned long)__init_end));
 }

 #endif /* _ASM_GENERIC_SECTIONS_H_ */
