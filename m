Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910146A6797
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 07:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCAGXm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 01:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAGXl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 01:23:41 -0500
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2150.outbound.protection.outlook.com [40.92.63.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80044EB7B;
        Tue, 28 Feb 2023 22:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN8NtEZSp0JKqxR7ZfucynchWuqL0oRmQKRIA0eHalIsPgGw1cCIq+1noP8FqPZRvWEpd5NK2IgoWrnLsiNN8nd2IwC5Qkypr6i4BQYhyT0fdTxMpYkgnbPsc1OeHExa+gSP6c4HPKt0CqwEZSLOLAfEMi/lQoRAKAFtPk071ZiLpBaQbkMmFZ3e5edmVEgqcyzCwfKLV4hz0AVJo6KI/rl8kENTqZnHsZZDuV+KR11kf1U8gWrise1dioqtXVG/UapWGzUV/4VFFZi9Rs6VhwqW1mptooIzSu2SM6tHb1qMs5MZCMxWqXN0v4PB1tMPmHxXIHQLUn1o6hYOc4HzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC3tAVvI/Z+WmYJP+we926ax8u1Ty2KNZwp4XoYmORU=;
 b=dGClSGGX04aSMM4OcYJk8kPXKO4qwXYle0VS1XVMm8oVrviRSNdRV7Zr4rUfOhgJ+5j3TDCbQdwwi6yPZMqKzG8CeHdqKOrIU0cUbnSO9jM0HjegTSqlxn7pH/Bp4IyCcv+xsGVNiaHsxBWSTvg5R0tL1xjeDx3UVFbKL9sSBBFq4FYduSWC6uXOrVfKTIrbGtNCCKl/5afTAk7leJJjXH0RDLIjJhxngYD54Imhp5dACgcwV662DgrSHE0GFaPCbY8BR0POu/FoYrCfdw+S9HwD5JTYwBXYAgcu/GbzTe+pgyF5xRoSCIkl8uosTQsxo4hCKg+IL9M6YT2zfYbBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC3tAVvI/Z+WmYJP+we926ax8u1Ty2KNZwp4XoYmORU=;
 b=TbgFQRIVq91fCiKaWtvUSndtk5dQhCaHB4GSkjpcaASc4MBbyWFHWjpqL87rcc5t65TxUS7U6HHGp4g6mAm+lxzCVyPB3xoF7NfdLJJ0t4n08t/umKJE/nHt0gTYnNJy8pq3KQYzjqRMqZ0Fm0Gyufq1vQnllv3S7Clf/H3E7LgRdcE5hTcIpfAZzy3JNJXDYNFcqhhZtsImyCgtpLc7sSLaFv9ylu5wHvyHzS9sx547ZzaMEYMSzNg9556OqBfD2PeTSegO0IrTQsYxSICJRBWxrE+O5pebsPa0LikpobuEdQMNKkJ8rxBhgof4o2sEMov2rC5EmIYJAMeCiOOKCA==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 SYBP282MB2253.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:99::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Wed, 1 Mar 2023 06:23:35 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::637e:ae7f:4307:e5ab]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::637e:ae7f:4307:e5ab%9]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 06:23:35 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     arnd@arndb.de
Cc:     hjl.tools@gmail.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Tianyi Liu <i.pear@outlook.com>
Subject: [PATCH] Discard .note.gnu.property in vmlinux
Date:   Wed,  1 Mar 2023 14:22:32 +0800
Message-ID: <SY4P282MB108446E9ED9FB180AE717D5F9DAD9@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9WsfBkK33D7GDnVh1VWQAspsnhWr/um8ZmmcqDRnlIE3zu6sTDEp/A==]
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20230301062232.2708155-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|SYBP282MB2253:EE_
X-MS-Office365-Filtering-Correlation-Id: 46010a48-f4e7-413c-5275-08db1a1d7c9c
X-MS-Exchange-SLBlob-MailProps: dx7TrgQSB6dAG8fEwqdvu3P4kJ8WfkSHJ/VyhTx8G9lQ63vz0cpjlF0PTPFU90JWrhUDsZh2UrTbxav7ZEEqVMwz6tVouVW6S0jVrctywqGkGCm394seECzmhJOGIKyC0t9p7P+HNshvJZCo5L0egl8WVf1UOiAfNwAmqPysfxrzs8RgBOnpDFtxKMmsSP4RlHJcCazNeW9x48el0TfxU4WWyHt+oDWEnlL+4X4e8PGF+a3i62aVZzUK9jEafJMNTir4NPAdBha5bNTXxVDETkpblzopb4c5UcA8JfYQ8Hv5nKKlH/ZoUJz3L8MN+Z8/KqLyY718xminA2ewHeMurD1mtZrKXRtH3GXKXbZZ0uHXt9LvEHULqJmK2KM2ScI69f+ZPdQQ/Esqkq3sbrNypMd9i6pfXkT6Ao4lCLy/PMJpsCY4JtC7vBbF9j0vb0iqChvglhlDjY5TGd8WnADfqEtZXdHhqWCihA/g1uE4HPqc6aYdiUcCK8jKW4z9nc/UzvFBSVlq6xckSdbdjexmwefRsiUvNS13RI8i6tpsgaX6NkMnFQvkUkmAszF8pSj7Ll5BAVfYt9eyggmuDGoYNndqayAGpIc+B2XJsAnuSXS7SEx6GYomMPvbZUrL36WJlpyLJw28ehev0VgrhXktyRBnZvypKhIJzbuN5WPwD4htY3Yb6I4BkrkfJ0rfDfvEm9cFYNPOslyfBupw2LvapTlNPdJdx8zzyMFVs/Nv/kCIuJG6CE9OQLxgVLvWRDT3vtQ8adSEYAA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERm/MND+5l46Mg9aenW+YCkEL+FTZdSY1pKwsJqLoUor0rj3Lx18SJTKaQJ3A7hxG/VuOjXiiVFfETf1brk0hp6U3cg4xb9uDpp5BaWz/tOaLjOsXo9o23NXS5H7bqB2rbQkXzI4c+uL0vI/YUwb6P6Ddt/K82YpZeI61701eBDxG0/3S264NuerRA5ERzXp6ZGYFI10Y2OkV5tj6m5mk7sQnHpSBMn0E8EyMaylWSCbC0u8YxXws6p81OWqCneMx1A2+p4LRHI0DzfoQPSpQOAsrZ9JFDgYZ4BCfFWZm/CHJ9que2BIiN2gteEYlUIr9X02JJpLltcDPyq4kZDUSRtuKQ5QXVaylM0dllAARN6fgAO8jMyqG4qxUCyl1eQub0bqb5656Ks++e+WonNcV19fY4Rmf8evBFuh2p8xwyB3fMtuVCKKIhpzXIXGcjZQrRIueII11MEZww/cs/6dwFm7ibPwYmJpF1IOp0bOPrNyR0gD+Zq7MFz8Xd3iiftlJ+kQKxstM30tZxik2MQDceFNijLl1p+LpFhHReKYFNMwtt+OcdKdpBG+RKmdTabMj0+DZKLe8sEZWPsHy/e+DxA5RO2stSMdc5Pm10W/9Eha/6rtJGESTuva7HzpJxosdClPF9ljUYRBERgcVmXYcQM4MHlSrUXVJmJLD/MGJB+USE7+/x82HzBO9lgANLEh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U00cSVtQtoK1N2vZAExvgRYj/caskImZMiYAKc1qxb7sAEpxj7AxGlnzedyi?=
 =?us-ascii?Q?pcj9dAPAjuJdkmIuFK2d2XaErW2z3OR7SXk450d9dwNsALrIGyn4zsY1t0Uu?=
 =?us-ascii?Q?xgmyJs+cQkYfFWiUQTWsQ4xt4IAZj8+Lgcc2DPFnB23K2EsVllf+By8BJ7gk?=
 =?us-ascii?Q?IBBkmF4eFJfgoaEn7qr7fA+1rPIJEgjU98PbR2PvgiK/YZ0QqZfeo1PtS5q2?=
 =?us-ascii?Q?xEWTqMCq/zJxPF2hhEI8xoU3ATMwRxPd+8FeE9ryG75gVUTJZkD2me+a7z7u?=
 =?us-ascii?Q?RMCM9tjViMEHjvZ9MdeluOD/5+wf/UXBsb8SFcHvS479ezKaIjkvsZ7q252s?=
 =?us-ascii?Q?mXeb9LE1R3iPT6QjlxxKDym7Rd28qfasNWpK8FjczY5LOzueigyi8fUwUWRt?=
 =?us-ascii?Q?j7orfR4SXFNLAQVVGS/HoynhmeQUk2IBiXBFwfIbV1PkLMD7fRqw94S3yxcA?=
 =?us-ascii?Q?HEqRncHS/DXuGdiBVexN6hv/f918M3zbYBQ6U9YFzAPQHbX7YKQcClI+WkIq?=
 =?us-ascii?Q?cUCzIFWHXxLyUsobUnwYgKPQLLjwzZgnPcs56B8hu3+wHkPlR3GxPGYFWYeW?=
 =?us-ascii?Q?1BQrUOiLXDsY2rc2MSwEfalM3GgF4wVvIlc9vigpLlVHQ9lYTVYwHz9yo5ra?=
 =?us-ascii?Q?2+gyxYYgltxFC61csOOqrrTMAYaLmOQ+akSOKOY+npPq16caVC6deWew9HDM?=
 =?us-ascii?Q?icbyk7fbDGA1VnC3weSO6wLxJP4oaIcTw0BALnRRKQaCt71DJomdIU+kHb1r?=
 =?us-ascii?Q?/3rr57KSA04Bf2Mx07LuywPH9biUCDqGZ96Gb3tCmm8EXES76pggOOq48SMs?=
 =?us-ascii?Q?vY2SLP7rJrAZmKwGU0N4lWNTyp475CDYAdST0WTU/IFggHom0lLg3/1KXqMg?=
 =?us-ascii?Q?gxveG6/Qs528kblzsW/mI8Ahe8WSac1BxvGNRJRpCP4LhGwrxvnVibHrZ0vp?=
 =?us-ascii?Q?fepqYpnkO1g/EIO6NKzdmMssIaAjfRbYFqXyL1WpLYU+89mKnu03QgslzK3f?=
 =?us-ascii?Q?Zf8pHixHjzToxQNoWjwjljrFZzVOlrUVFhnwVUjkMIDQuiTvDz5mRxVwEX2L?=
 =?us-ascii?Q?t5LxTIjyqeHkYeGrYlA4BEkEvqMchOR3PFlP2MgBPb/qOLmhQljzRTXTYZkR?=
 =?us-ascii?Q?1MgUNVuwrrtJnpY1llPFFEpRkYCIOW72lQdr/5049EpJ6MvG9qlzvv8adls1?=
 =?us-ascii?Q?byqiL0JsJEL0bAJ34L4FkfIB4ejWasF2OEI1TnmT8FKmvRWqdN9Br08W8yNR?=
 =?us-ascii?Q?Fa2rAY2ssXryVDOLBEz954UQqDAW+6VPEwfg89m+kasypEKYKICJTRQD5GQW?=
 =?us-ascii?Q?cis=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46010a48-f4e7-413c-5275-08db1a1d7c9c
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 06:23:35.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When the kernel image is finally linked, all the notes are packed into a
single .notes section, but these notes may have different alignments.

binutils above 2.32 adds a ".note.gnu.property" section to the compiled
output, which is 4-byte aligned on 32-bit, but 8-byte aligned on 64-bit.
At present, the notes generated by both the ELFNOTE macro and the VDSO
linker script are 4-byte aligned. So in a 64-bit kernel, packing segments
with different alignments will cause LibElf and tools like readelf to
crush or to read wrong values [1][2].

This patch discards ".note.gnu.property" from vmlinux.

Note that H.J. Lu has submitted a similar patch in the past[3],
but it was not merged.

[1] https://lore.kernel.org/bpf/57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com/
[2] https://lore.kernel.org/linux-arm-kernel/20210428172847.GC4022@arm.com/
[3] https://lore.kernel.org/lkml/20180924201459.35923-1-hjl.tools@gmail.com/

Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
 include/asm-generic/vmlinux.lds.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed..6db0f664c7d6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -891,9 +891,13 @@
 /*
  * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
  * Otherwise, the type of .notes section would become PROGBITS instead of NOTES.
+ *
+ * Discard .note.gnu.property, which is 8-byte aligned and emitted by the
+ * compiler. Otherwise, the .notes section will be 8-byte aligned and other
+ * notes cannot be read.
  */
 #define NOTES								\
-	/DISCARD/ : { *(.note.GNU-stack) }				\
+	/DISCARD/ : { *(.note.GNU-stack) *(.note.gnu.property) }				\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		BOUNDED_SECTION_BY(.note.*, _notes)			\
 	} NOTES_HEADERS							\
-- 
2.39.2

