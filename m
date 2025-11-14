Return-Path: <linux-arch+bounces-14793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A38DEC5F046
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 20:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B05EE351446
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50723184A;
	Fri, 14 Nov 2025 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDv/yGil"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378462E091D
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147650; cv=none; b=n3930VLhTxoiCMENBCx4wALRsfLYcxjAkYa24QSa1YSf0sA1EJbXGpv2Xf8GGqIPaJYgOIXafybtE/UaZ/4EAxG5i9nWlrXTtREv2fDC+lH6QAz3H6AECdfjl2nmvIUPBQZP2HF8ycVGf+xBG7hlTGiOTw9oeLP3RMKz3RX5Kq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147650; c=relaxed/simple;
	bh=aI9onR+f63JFzaNIBKoGx3OAwegzLui4sLBarF2xej0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxxF/YS92IXDewlF5gK05QukXJ16qYwlF8+HEMuxcxpqaPMM1tFn9aq1AvU8EeLoLxdXkcZZsKcF0wulocSP4Y76SgeSlhzwXaWgETPzPfDOXQgVoOrwFiSnZMtBAA5yOB3TQ7c2QBxFcbxtxDNElSbNnaCJB5gyj7bZZQILCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDv/yGil; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so3648666a12.2
        for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763147647; x=1763752447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aI9onR+f63JFzaNIBKoGx3OAwegzLui4sLBarF2xej0=;
        b=mDv/yGilxm1t28vSlrre/2ltqEgfZcjvcB4hu8QNA/8xV80FIFn/c0aNSUre4ryXEq
         CvvXFpucKzKj215etP67wAyZfJIiaYsh35yDVgi1XAeciX6KncBmSiBNzODol0dTCixP
         +vzj6Nc7sfceoJqLdFjj+Tevf5kVtCW0G9cphFgQ8D5XIW+PW2HAEOXf7ZamiFGxWQlf
         jop4KKWm3xTg5IQWmFjy7wZqiLcEXpmSjJi1szpCLzVkmN0bm/TyXmpDQb+bkCMYbggB
         R6ZfxFXONOZC7zLWDJzwAmGpi7URO5Lv/Ld7FF9ZmMyFQQfLBzPpQhORyMrW/dsAqojt
         pBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763147647; x=1763752447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI9onR+f63JFzaNIBKoGx3OAwegzLui4sLBarF2xej0=;
        b=SFI+S/mIZeq4tOVAt0FVptXQkKFlce3nYGswEaljlvMa4i1qkcWBMyZMbrBsweOky2
         /+LrX6WMTgd/3RAHzJR2E3oRLPM32mEpFj292HqdcJYibov94Ed+TFwmu8McSSiNrjUG
         ZkFekqnwJovgVwmxkiOSY+vKoBqR4Ha05Mld0fBfmV5eb1g1ddR1iAN/YlpPOnL/m8Ww
         L8Jbmm0ZI8MYfMApXE88AyTRVBeyTcuXU+PeYPzJqFc68qynHaknjftoB8TMP+XCutND
         q2hfKo8O70eKnWdXzqWjlmn9Rrdl++9jGipvJo58Dn4aznIrUr52oaoxEcorxQ4IzNOi
         Rdvw==
X-Forwarded-Encrypted: i=1; AJvYcCWe+RBYKyEe8dBd7OwjOp/l6IHnSy7xOuqDu753PD0DMHmdSOQWvmdjDftX6MUqNUIy+7ZktbWP7PVa@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0a+/OtMaSC6OseuGx2Ke8A/NMYKBuTXzI3Xa/scHC5uxim4y
	blJofhsIxTTfJ9orAZh+LsbTyn6owOA8+RaQxQbvCkZHaXbiOppLiOJC1APL8LkY7EtEfxPmC48
	EoDcgfoM+ZlJpFYwBMxv1kKnRx6sHwAY=
X-Gm-Gg: ASbGncuz9gqVSsRaVnaVxl4dN4F5aocO2wnuzL8jVOGLjODlIuG2qmXPqpd2nBn8KC4
	WvRzxeFbxseyw7ktpcf3J7j5GIfieUWb5Zgnx/uINL2sZvD1wwdTj/IE8ZysQQyGG3NBDVfVL3n
	8uKjRcSAKSd07CPw/N3dxaaJ/gp25u7903BLk+UuZr/3UanEqDY5NY9dQ1hKpfElf1PZCgtmFzb
	TXB/j0jLOJ6hZaZL19Qs/3LCZ9i5e9BRTXkWwF6NYBTdJsmOTCbJ+v01XPh8w==
X-Google-Smtp-Source: AGHT+IEvBu7ESLrGNRMv2QiwL16IZgt6aUNJ72TYzx+vz9COzg0vAhK2L9oI/n3nL6QJ1JU+lRhqexZnJfrgTYt3DEI=
X-Received: by 2002:a05:6402:4603:b0:640:f974:7629 with SMTP id
 4fb4d7f45d1cf-64350e225e0mr3893696a12.15.1763147647239; Fri, 14 Nov 2025
 11:14:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763117269.git.zhengqi.arch@bytedance.com> <66cd5b21aecc3281318b66a3a4aae078c4b9d37b.1763117269.git.zhengqi.arch@bytedance.com>
In-Reply-To: <66cd5b21aecc3281318b66a3a4aae078c4b9d37b.1763117269.git.zhengqi.arch@bytedance.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 14 Nov 2025 20:13:55 +0100
X-Gm-Features: AWmQ_blqeEJIFeEqLe5Vq5SGpFC4UPadwiIAm270RAB9lR4JL9-RyEZ3PVaRM7w
Message-ID: <CA+=Fv5SGu_Y-zwryrQiTQDy32SipMk_dfjZezth1=aZmnDKNeA@mail.gmail.com>
Subject: Re: [PATCH 1/7] alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org, 
	david@redhat.com, ioworker0@gmail.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I applied your patches to a fresh pull of torvalds/linux.git repo but was unable
to build the kernel (on Alpha) with this patch applied.

I made the following changes in order to get it to build on Alpha:

diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
index 7e9455a18aae..6761b0c282bf 100644
--- a/mm/pt_reclaim.c
+++ b/mm/pt_reclaim.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/hugetlb.h>
-#include <asm-generic/tlb.h>
 #include <asm/pgalloc.h>
+#include <asm/tlb.h>

 #include "internal.h"


/Magnus

