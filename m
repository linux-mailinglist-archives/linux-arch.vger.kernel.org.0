Return-Path: <linux-arch+bounces-14927-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1FCC6FD0C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 951F334FC15
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F8A3538BF;
	Wed, 19 Nov 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N97gHFJI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D535E53D
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567135; cv=none; b=g+uPbBEruQpc3IxOBcLNk5xdgl7cWQKO2JdZ4BX+xGpmp52WNkrK8kNcTbS15Fzas6P8QE0pWS9Iequo3TEHDGD5f+lrClaw1er5LXRQpXOgzUo6fVoSfDFuqTTlBiXGp85iPltTACIQzUY/qqXRP05C+s7u0/Hk3x43OQUYRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567135; c=relaxed/simple;
	bh=o6BmMGmoTbTaL/NtdpUUmzGGU5vJ7cVEMCY9+Mbhsuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiFAGZNqcpvyGYIWrHaQSUsdZY2ksQjGWCtrdihd0grX7QvCtGdl0tcXU6tTEzWq9zVnBgJb4RsT/Gdhw0g2R7Z8l8Bc6GwtFFV8qQxdPRYA1+8TnPAeXbVvZAi5b6UAZGiMKMKMoDGP6GHopWfAG3uCgBd396I+MOjn8sdMYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N97gHFJI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so50230095e9.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567129; x=1764171929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgfZoRmCPzcZDOEfTe8kWXd16fGbdAbRWXioprv0N44=;
        b=N97gHFJInsFrGAqWXSOC/t/ip/ZFunAGSLYV+sKzWA5YLMvcNzF4HcIjkZQ30w+/8l
         b2NEkLl+5wQZEeu2dyGiiYvoGvRCs9uxQGYtRFf2HU7fxvjIk4olW8WnAVRi8eVxFZx1
         UlSE+dC4+lWgzhgCrkKaUvADoNcSRGotpAoValiwpGmbEaFUryttt3FwhmktPXVdic/A
         vsUycPOVgkU2YZZgl4vqzYcWvwH/bfSrTDwhlAI/HbZ3WDsvUwLkf+NrIuto02BJ/h0d
         eIzrHPrz8EVcC6kjiBrbDOdboOa8zfoPHPFQMvNaobGZfCEACLBLqBnUpMX2REFiOVt4
         D1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567129; x=1764171929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QgfZoRmCPzcZDOEfTe8kWXd16fGbdAbRWXioprv0N44=;
        b=sjoMgu3mvGYseHsiLGtKR/E5h2UOmQYeK5R2f7JflzTujFZCuEuKjDePs2uFCmaCev
         U++u2F+XMLTTjI/JM4Nin5D9eZgF7j5quWyFi6RU6UNjXPYgZd3v7OF52FDTe4XaDucJ
         IGWQtNgoG+DUw343PfM5nDlHNh+Fc2vl9gPkZRaPt6sDjnqW799wqIDTDsmzM7fQLH4n
         lhvkVg0WTH1yYhJm07T9+Eaq2rZ0dHw+sSk8irwadB+41IQLnULw+NBT0F2EIz4AyrMc
         7bAjnVPfbR2aoc3tIx9+JH6a7vvASRj3Blde4O2ygfWaXkuCaJg9kgRwwZGfYmkaPx72
         wfEw==
X-Forwarded-Encrypted: i=1; AJvYcCWBI2BRTjPExNdFI3mqnkwCJLwsavNLGosqICJy4eamh/sEmjDmxdcZA8ky34D7zPEyOPO9J0bXUyGL@vger.kernel.org
X-Gm-Message-State: AOJu0YzA82OLj5J7EY5Wk6YU8IIZ7YTpcy3tgDNoSNm1cZPHwtHTiU6N
	P32AMxb/4sP40BIAiz/tUx8PIX5ZrdrbmCn0sZ+AtpaRgivEu9xUgLDncHF4hZSOIVs=
X-Gm-Gg: ASbGncuoxKRJVydky7og0qfFl31OzhpAMuEHZ/Pr4Hv4ihugJu4XdbBZMEjuzTXwqI+
	txp9RMpHrKiNZ8vsS5zHJuZCsJ2lWixbF/C4otQRiKLfDSyrRHMlB/7ahtM9pMOKNmFifR5xXoI
	R33dqzdX35o7+flD2zH7MczEvKrlfKLeasPDbKVLwa8BvLUglGdOFC1rLherxmGXZgg0DwYKPp0
	xB/U1dQ6KGOp2p1yKYPbRTqJbkylLuAB/wdL3EW2t6U2gyE5e7oImIRZ2TFnUFFPDSFNAaU+FfH
	aSB4tbSRW8Q7jZBuVJuG3gRVHiqge5npIMtPWxa/tjwJ/oVCShvokVtiBe3bdbh7ShhxyufNq8W
	PEbLdvSm2qfdEtnbTnfiBGOUSV+FcybaYczpVsFnCb73tZm6xK469TrCQknaC8Ym/buzluNrz1j
	HwWRmJYDWHprAu3y+W+tSTa3YPN+2NHQ==
X-Google-Smtp-Source: AGHT+IEsAcddfcsUUvEjJGVD9iD03mMaqDkbeYnd/gOudjAAgUoPc2H5D0xayvELD1uec3MJtxxFcg==
X-Received: by 2002:a05:600c:4585:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4778fe59a0bmr205474775e9.2.1763567128896;
        Wed, 19 Nov 2025 07:45:28 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:28 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 07/26] kernel/fork: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:08 +0200
Message-ID: <20251119154427.1033475-8-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - nr_threads

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..c85948804aa7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -106,6 +106,7 @@
 #include <linux/pidfs.h>
 #include <linux/tick.h>
 #include <linux/unwind_deferred.h>
+#include <linux/meminspect.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -138,6 +139,7 @@
  */
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 int nr_threads;			/* The idle threads do not count.. */
+MEMINSPECT_SIMPLE_ENTRY(nr_threads);
 
 static int max_threads;		/* tunable limit on nr_threads */
 
-- 
2.43.0


