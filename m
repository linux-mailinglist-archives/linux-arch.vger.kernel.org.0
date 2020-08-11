Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E101A2419C9
	for <lists+linux-arch@lfdr.de>; Tue, 11 Aug 2020 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHKKaz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Aug 2020 06:30:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:56193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgHKKay (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Aug 2020 06:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597141852;
        bh=TQiX4fEKRzWrITACzvC/FrFoTdfBi1/ynPROfWfjH60=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=g9iHXfC7Hbqjq4xllG/hEkRpg6y0VgDLgfmmMpQlsGASqPWeA+I32pfqpDtq4zvqY
         1/hJTkvtPTMPRm+DNR2fWxlFfXdqs6+i6DMQQnVLif1ucED77X8kVS0BRaXmR0zNPO
         m7wCK+sDR9fXvSUZrtPTZEcDvnYHw1I+iLbMV4HM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.143.39]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1kQYlt1S3h-00LFrv; Tue, 11
 Aug 2020 12:30:52 +0200
Date:   Tue, 11 Aug 2020 12:30:50 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH] sections.h: dereference_function_descriptor() returns void
 pointer
Message-ID: <20200811103050.GA6645@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:tds8f2G04nb1fmFYqSSVjheMpDt5sARFmYT6RzZdlJgXyFBIRDY
 luDxbKpOqQ1GeVg7MSTMM0jEjEY9+JnBUoiluaTZ/UgyM2+Rgu+9WEDbRFydBRIuX6dZxSS
 EFiyLjUk3O2w9f5d9XxQurFflQ96NgzZ1HDrcnqlNbKzX3txy7Dby2NPyiIhNObsI/HxLzC
 3jxZpZPfBEj1mwFfMOjBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X/koSh1x8uQ=:jAPyPkq6C4W6cncmr6rAXQ
 yhNwq7eHzKuZTz0C844DplMdGSNDuhNlAqTpAT1CDQDitiigU/6FYau4ep0NPAVv9hHZZahSy
 wJRrWSzJe1OPJq/BH6AjWbrfiW0FK2eWh0eIuFwnHNMius5Y8hiX5jEkpYligpT9t6JYULPB9
 WYayU0AdUlZsHftuWoLW0joft7JCEorhHuuJioREi8gAZA/ss7fJRepWGW7ikMtxeD/vFYG+c
 MjlJtotvrPipR5Jm0bCppyxio4FyjJXxNTeCdfygw774H4u5y7OrcU3ND8n3u12PZlZ6iTw42
 ts7NpJOH+lcOExiGSyPkGdXoeMY0EMvjMlenV9PlNhMB6KC3p1wuvKw7jTUTXdHlJJhvkniU9
 qCqxjdqmZrPtm4+3Okn01634OXibDqCqbNBtXx/3Scx26hkl/NqDoDr4IrCDrisVf8YAyDfGi
 6Vd7Dt5mIYaVpDoq7388YDSKBz3HSP8vwGV6Gwa8+jHaVUaG1WcDBcbAS4PLmRMSbQIlLEvNM
 nst6vH7bVQOAr2pw2gdNjf410mgNif/H4N42SyaktV4XnDYJRpmBF6LbZHYisD3g2dgZR4LKE
 TLzF6OLB+cvqbfygi5EvIP1NVKo8STqwxAlr6TEQ48RuWCZxYIqMQD80NZovSu40eqtXWnvvm
 4HL0MGj/uz43PyqZ5/RKKouBdKo8g0/DWe+bqX1nYchDptETkPlJq3bBmncY7dg1wwW3agNX2
 /VlqcMYtgcdI57bAYoP/uHQh2A/vzb5euPgB8LBIeBORsYjdIv+sCdcKvS1ZZlX3gefQTDuaA
 leu2wQxqk1lJAvzrDeJsl4bQmLlX12QxnC6LPNC1L0DjJyOmk8OXPYm3rPlQcWOfTivVml9XN
 Q0udJ1Yem2PDqZqLCzUNt+jDEHPQbNw07cqHVc3zaYyCgiUNYXMVMkdqGQMBKq0YxMNj1/gHq
 GnvbPXs0W3Phsm7nHlbm/f0yWKjrx5z2bKJPfLssbcbVrYW1mPbESKARFXJyMRGrpUXX+2Xee
 zGU7MxaqBbz8wTGg4bmhvA2O9pejokostlGggisQey/A1k4KDNZr7eE5+2DTJdPrQJOEzDyf1
 EhGL79s4ldV19J1i2zu6DsqriMnB7bK90oX2PY0YHF0qA0CGf/JAMnpplepAac38nID/IvYZz
 fD4G9wVqypWQ9Ln/fH3ze1ZnDqQa4BaDPptuUdDM3Ve4oftPyg6uUmhFEM7wToCgxgllY7ByY
 HecyWjFe7Y2grCW82
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The function dereference_function_descriptor() takes on hppa64, ppc64
and ia64 a pointer to a function descriptor and returns a (void) pointer
to the dereferenced function.
To make cross-arch coding easier, on all other architectures the
dereference_function_descriptor() macro should return a void pointer
too.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections=
.h
index 66397ed10acb..d16302d3eb59 100644
=2D-- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -60,8 +60,8 @@ extern __visible const void __nosave_begin, __nosave_end=
;

 /* Function descriptor handling (if any).  Override in asm/sections.h */
 #ifndef dereference_function_descriptor
-#define dereference_function_descriptor(p) (p)
-#define dereference_kernel_function_descriptor(p) (p)
+#define dereference_function_descriptor(p) ((void *)(p))
+#define dereference_kernel_function_descriptor(p) ((void *)(p))
 #endif

 /* random extra sections (if any).  Override
