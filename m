Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE67549E2E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbiFMT45 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbiFMT4T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 15:56:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4746C89
        for <linux-arch@vger.kernel.org>; Mon, 13 Jun 2022 11:27:52 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655144870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sV7a5iB51yvWYbQTRw3TPg61Jwh+ZZqltJsonhrETTI=;
        b=RyHEnt/q//Vwe+/oJzBn8MP5WfqCsPAbN1Ysx9dV1iLvgbNh3yT/HwUft2nVRj60zOKjy/
        Sd8u0dUb7XxX89lQD42evD7m8CTG9WAk5/eNqU5TOpOqkA3AMCdBJqunLYrE7l0sjKFQOv
        g/nmvzkDQouOnV2fWoYqQRpTfJsWEmghwrrCs4de01gPies0lDLvF/W+pMOIuTRyR2XemB
        M4xV/xI5XhcubAbrJGdlmc5FserK2mPKJqR+fVpcfZREyAIqJZ/BiCHxyq1gxal2y64Frv
        6z7io7LDNFk+NUfBViYiQNC5v2PYFEG43gJ3ZpgORbqQXKO2AzUgy04G0QGCJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655144870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sV7a5iB51yvWYbQTRw3TPg61Jwh+ZZqltJsonhrETTI=;
        b=jOqKSvQ0AlaZTQ+RxAxZomy36bY8mUA6A9yV1zxPB65uFVDxemRcsEjJ5dAwfFInY9jpxt
        udoMc66O7qBaqLDA==
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] generic/softirq: Disable softirq stacks on PREEMPT_RT
Date:   Mon, 13 Jun 2022 20:27:46 +0200
Message-Id: <20220613182746.114115-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

PREEMPT_RT preempts softirqs and the current implementation avoids
do_softirq_own_stack() and only uses __do_softirq().

Disable the unused softirqs stacks on PREEMPT_RT to safe some memory and
ensure that do_softirq_own_stack() is not used which is not expected.

[bigeasy: commit description.]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/asm-generic/softirq_stack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/softirq_stack.h b/include/asm-generic/soft=
irq_stack.h
index eceeecf6a5bd8..d3e2d81656e04 100644
--- a/include/asm-generic/softirq_stack.h
+++ b/include/asm-generic/softirq_stack.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_SOFTIRQ_STACK_H
 #define __ASM_GENERIC_SOFTIRQ_STACK_H
=20
-#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+#if defined(CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK) && !defined(CONFIG_PREEMPT_R=
T)
 void do_softirq_own_stack(void);
 #else
 static inline void do_softirq_own_stack(void)
--=20
2.36.1

