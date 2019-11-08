Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC506F5944
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 22:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKHVIy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 16:08:54 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHVIy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 16:08:54 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N5mSj-1hrrj32IW3-017H8q; Fri, 08 Nov 2019 22:08:46 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH 02/23] y2038: add __kernel_old_timespec and __kernel_old_time_t
Date:   Fri,  8 Nov 2019 22:07:22 +0100
Message-Id: <20191108210824.1534248-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b5N3TpWxS8V8FWtAAfXOHjyNkW2dd6vsCxc3KrZ6/bDozC0UzGX
 z868QcmcxcXwLNvP/3j81Fa4z9V7PlenxpvccLoVz4hKjdilYMaDe/ddhT2s8zuc6t343yp
 NWgkAlequJ80TyMQU6XoRmbEi9koTAj5AzKTrifgQcLBQRXriFwCnD+Qaqn8hJqr6IlGUan
 MybHnAEMRxVEmgjwINzdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q5HMqU+dZb4=:uY+qkO0lXE59wSs58wgWT+
 9hOYnpRnXLK3Q5CA7O6So4C2b7pZDg8dPtx9dcZ0BzX9ToZrv84PD++2Y366m7viED6W2R8by
 Jt9dhtGloAaPP3DuCRY0+vmILayaAm7UraXmlPaw+ToPZ/OFZ/6VOO16cGYzLvuFECU3nUNhQ
 AIcjQ0GkQo5E1LaNXdF622Vyj2QD+tBUemLVc7vlTY7as80tyjmrgBKD1KtVWfy8OJH6yeTkU
 G7hwfS4qvnRAYdRa+9VJY5W/J3QNbGtkyp7audhrk4nnvxldr6Lj44Lal8YJLRiBMhHhq7AbA
 1NgnLMS3UZkLRCIxIIfCp3KLHep5m+IAtOfdjKs5hUEM1ueWJiP8PAKkLmaDFGp5W18s4yHWF
 MYUO/mvHXcvYTUe9/jn2VjWe5MZaVQ/JiCpRfI0zV/lnH6Fg7BbfegkwiUwdifmCpiWhRfnjH
 KEbL1KDCUiVrLJkWgNPfiHoRqEz57pn64uYrV+bNK7cpswlfQU13Wi3vRPNyfsiKFyc3tgP2m
 7iSEfQqLqADbdHdhiy3wm7nYVDEXWzU8NG9DFm+Xl/pb5/UG+YspYxTvsfO4GjZiHOp9QVg7+
 pf7Va5/5mNKVJTbSjHuhGd3BxU8vsw/7V/AX0s2alLrCJeg0Dmlj53MWdBEqcJGZbaLuLiV5J
 rGKQZb34B2HxnRMnKEp3LyYiBV7ltEEQLUDq2Lv8Og6C0VgHuOJV68fpNj4MG6rtF9JF7rfHI
 dWxx0lRApWFEtY/5cWnHsJorajJ0X7o/DPVdd0yQGLCJgwJJHwPfxQk8CCJRDu+dHnbB40MKh
 6U2XmdRyQoyHCsXkr4TeAFe2JZbkwjMe66DT8QLzALG9LVsfhFh1j4HmvkK8vYUosdOTd35wW
 +m0gcm31rHmV5xpdHInQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 'struct timespec' definition can no longer be part of the uapi headers
because it conflicts with a a now incompatible libc definition. Also,
we really want to remove it in order to prevent new uses from creeping in.

The same namespace conflict exists with time_t, which should also be
removed. __kernel_time_t could be used safely, but adding 'old' in the
name makes it clearer that this should not be used for new interfaces.

Add a replacement __kernel_old_timespec structure and __kernel_old_time_t
along the lines of __kernel_old_timeval.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/posix_types.h | 1 +
 include/uapi/linux/time_types.h        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index f0733a26ebfc..2f9c80595ba7 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -86,6 +86,7 @@ typedef struct {
  */
 typedef __kernel_long_t	__kernel_off_t;
 typedef long long	__kernel_loff_t;
+typedef __kernel_long_t	__kernel_old_time_t;
 typedef __kernel_long_t	__kernel_time_t;
 typedef long long __kernel_time64_t;
 typedef __kernel_long_t	__kernel_clock_t;
diff --git a/include/uapi/linux/time_types.h b/include/uapi/linux/time_types.h
index 27bfc8fc6904..60b37f29842d 100644
--- a/include/uapi/linux/time_types.h
+++ b/include/uapi/linux/time_types.h
@@ -28,6 +28,11 @@ struct __kernel_old_timeval {
 };
 #endif
 
+struct __kernel_old_timespec {
+	__kernel_time_t	tv_sec;			/* seconds */
+	long		tv_nsec;		/* nanoseconds */
+};
+
 struct __kernel_sock_timeval {
 	__s64 tv_sec;
 	__s64 tv_usec;
-- 
2.20.0

