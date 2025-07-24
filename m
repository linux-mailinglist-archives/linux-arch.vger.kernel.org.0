Return-Path: <linux-arch+bounces-12915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067CB10C6B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BE43B8B87
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6EB2E3B18;
	Thu, 24 Jul 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEOHDd7Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FB2E4256
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365395; cv=none; b=JoPDkR/9La77JHdt1Hffkgvbj3mVFeDPOfbx+Li5ZaXLpbYSFQu9QCIOnUNvZpjRr1iXSU+O7nBk40RVAhjgGuVrADukCX/uor9FCA1EkdN8I3GZOO9tzz1ENr3oULlpSgvEpVCKjTHBJuaSPsBBJ9G6xpDjbbY17AzOcTN/Erk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365395; c=relaxed/simple;
	bh=ghY+GwpjKzXQo2zgURX2uB3oB2874ijEbWShVaN08k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdcH/o0yjCVk74vo8ZFhoO5juFjhwbPc+MN7YHCJdg0qNHvuam3AbNeVp40q5oOVdyD6TferWJcHFg6rHoXnvqh1M9w2Tia5WvC8pyqmQ1EVbJ5IClGGup/gwLgLg+9XP8S0oA2vG/HNiIttQPUSaRFN+nwj36z/nMnHWzRsXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rEOHDd7Q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54700a46eso497425f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365390; x=1753970190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SReSPaHbR3saXb697Yp9wPF5rwCm4qBMUK6NGh7oWew=;
        b=rEOHDd7Q8N2mYG5T6Unnixnoe176QqAN/bsTATidQzaTXYl8x6Fl7kfvxRo+ZWK4pc
         qMPiNcCtEXI/oOonec1lsGzrOXHoDqJ3VDuKDkuiRI9iifVqADHi3VMHybE8rEeRnfT2
         craY5TpZD6e5/X0OKbBzvy6zU6R5MiPYMHWfNs9a8ertibJByaQ1NYIaJ6koM5ZnZ0Sn
         7NpwjIqHtMAAtK6Y5G8b20QQ9wWOoneaAVnyoKgbSWe+n7xqx4hzWKiNTIIeQU3fJn6l
         eshPWsHMwEdHl5/6TtzTyIIVGndSQqVeaTyF7w88+qvU/tpL7QZ0qI2fL+YnilChs3qE
         Y+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365390; x=1753970190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SReSPaHbR3saXb697Yp9wPF5rwCm4qBMUK6NGh7oWew=;
        b=X7ct7x9mQXAzW5HHzAPdFgORDM7WXbXa3tZYjHdV7f+k+xiKSWqMwXMgMHjvOLAv/c
         h4wm6VIoWFJP0dDubRCgEkcij1vv0nQSsr5GmaMU16rDoG1HmRzGD6HKMM+WQ5g/HfyX
         y53WkyG/j44co91BuxhT6ZV+i74zOvMRb07Kojy1I5gSTSIY1nNH7pzdXbZtcejWNYnz
         yo36kpuyEZ2w4frvQqY3FbyEjK4U2yennDTQG2PWMU+qmcMclP1J9kNadyxYrj5l6Ksf
         mG0r9eigLbiQ/Z0vVdJqrsPH1NGsqbTfQGvw+yCbzLS/WdbB0Qpd9SgWV0GC3qg6dzOZ
         qmWg==
X-Forwarded-Encrypted: i=1; AJvYcCXYmiE5Kl9E/sL0pVrvRW/a+2/10hfPlBZ72BkA593u9R1k8OyTKD/2uW2MOegeugvgrLHMGqL8Gfjv@vger.kernel.org
X-Gm-Message-State: AOJu0YzefVfWr2/s5FlDZ+fMxnQKAFgK2hlbWUAxCsAonqld5TkKkPrb
	MOr0k0I3sBcLGyZhsUxF+tYELxOSDaMZ8vP6rW+cmUC54xy7wqlCPXBfutbCAMdFeVE=
X-Gm-Gg: ASbGncu0wGIkGZeMH2JcBFOC8vLV/Oo1NNsxM47Jj27oktPS/ZZO9W7rkqjAKZ52a/g
	gOBBXcj2E5v9pNwoL6zOfhkttqStKyxP7Jia6cG5o0pgkNz+hFtHxqV8exMRbZtzbqVITkjiCuD
	K+PuF+N8aRuVwHyWMgDOcwgz48iF9oI0rjw+LwPBs1XZrhtyHxXjekqSsEHvQEHh1xl65Vw4euh
	HcbCQtAFG1AzCagQy9SIL+ajbuDR6v957oS2TZaFqI488HsawXAkNIn9ouzumlhfK9TQ6ZAAYub
	zZDjFiSWM60rj5+Xlv1a1qB5Ybrg0Nf/XzhPlqAcbV/ZHOPXk4Zi4K/cTDAegpe9eEeyh7/S/3X
	4VT2IBKqdCrXW502QYoI19354SmESfv3oE3m4H5eSjlORM0oGwcXZAaOZ5Jrw946DcrjhlA6PRp
	01A2u52qNpwdAM
X-Google-Smtp-Source: AGHT+IE5OpzTZyLft1dF8PAF1zWD0A9y1GJkIKlmiY5JcqmC3+aHq3C9hKZiU8MWr3uj6ilv3EjyHA==
X-Received: by 2002:a05:6000:2c0c:b0:3b6:333:256f with SMTP id ffacd0b85a97d-3b768f27e15mr5395112f8f.58.1753365390310;
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 09/29] genirq/irqdesc: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:52 +0300
Message-ID: <20250724135512.518487-10-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - nr_irqs

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/irq/irqdesc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b64c57b44c20..6d11b85be2b3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/kmemdump.h>
 #include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
@@ -140,6 +141,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 }
 
 static unsigned int nr_irqs = NR_IRQS;
+KMEMDUMP_VAR_CORE(nr_irqs, sizeof(nr_irqs));
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.
-- 
2.43.0


