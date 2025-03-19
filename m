Return-Path: <linux-arch+bounces-10939-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E14A68124
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 01:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5019E3BD03D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF03594D;
	Wed, 19 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c15ZypT8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6DF134B0
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343340; cv=none; b=brwGunJyzrIv3mhNVWK+S1xLioaq221LsZl18uYb2QEATJkPQRK0ketDuBLwx6Hy/rAhfVqL9ZNc7mROR4ilYviRvFYwBPZAczYUuxmkw7X29Prww10cyqi/Kw8JDorYKm3fAmPHWn0Ee4iOGcwOLH/QRUNhFIxe7RJBziq+HhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343340; c=relaxed/simple;
	bh=F+Fl+hJmeyq3YWzTs6D9ZDaWGOG6IPUOQDfOlysIeuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2P7sWwGdjURUIiGxPDrGHj9XOHRs7BOA/65AVYInKcm/APc3QxKugURWFYI9KRvfnj+4aXK25bQlRQOVKzqvUaVpybwUqXwMrHurjE1ddaM1DSIM6CWsyLCHvn6Ar3fGMmVTjMjdSKJobk+o05mUPIWIB38kT/cmH/gbbMAUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c15ZypT8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso6173235a91.3
        for <linux-arch@vger.kernel.org>; Tue, 18 Mar 2025 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343338; x=1742948138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciean/zWrbirFJ6x0i1/pN9FA0IKn0ZUFy/flQBxt2c=;
        b=c15ZypT8L1mzw749Vu6yvbOQWTg1d566iXrxBwFUrtc04MkaXhvFKCRKYekK66oUAe
         hniCMAklfD3Okow66BOahdsnXukn+F4oQMvLgsBOSizEUMOcBMjoBpiUQYnPgv6OUxjM
         DqbVqJAsPDX3z3pJnmykkXGWnIM9tc5E4SuiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343338; x=1742948138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciean/zWrbirFJ6x0i1/pN9FA0IKn0ZUFy/flQBxt2c=;
        b=GOU9rHELdLq3E50wcPETTcf1US03JK1kfuTzJQ2BdDl6Hl2zZDs3b+0Xyj133PNsje
         lHI/SjEO6HcZKX6rvr4CZasBGTD/AhXlTEGeIukVo0Z6D4OmQc2TBf8GhNE8hi5+MSYx
         hEJfIlbkSAzcmrWqS2cZfiiiK4/ZKHTHjgYcxmfg0QUr4NFqHT17GHPaQKks4FxI+lIw
         zh6FRXXu47CLdu6vrGzaWaL4vCsD1ZMXN5oAHaBmVjM2P7cGCuVVW2TBFnovW4iTKP5/
         KZHLtlRHN8ab34pA/0iohq1dpNGMUuHQfOssEJfg6Rk643H7I5kfGP93xfa7JdkpiT+I
         wfjA==
X-Forwarded-Encrypted: i=1; AJvYcCWs2uLKrkhgD2VShW58LD1eKf3b8pRguD9FhRYOsmnVJEmMJa2Rs4xY1WZyx1B8IJ6itUYSnpovqEY4@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYzDUzKAoUDsWVkr4ZhuITfxzyKsqibRM89FQvPaSgPsJbYqD
	fo77s1zbzN/1BhqHFp46c8PbzdLgzy5or7jSMUQVIRVdCAUDTu2GYZnTpIMe5k0=
X-Gm-Gg: ASbGncs1WWkdtiT9K9gzH2/Pa+VyQs+UBmlqBsO1mjbnq6e3rH3lfn5WJm+T755VZ1b
	TRXxeTLr68fyD79HrkCpK5fsKo3+RtghqpyI3mU7eF1Gi7E2qzgdvWvz80Dj+3g2ruP5x6iCYD0
	FUZf2O9SD1FmefVOpz7vJxmHUM+c7Z1l32PU71cOVctas9iIO8JWI9ZVzw7ZGYYtOzyMCEwPm25
	JiGGjnNzV6CPbJGwxVaxpT71gb8MyidsZiN1nsUcmkFUF1w9qe3ePspd1LrO8lb5skJ42wiUPCP
	tvd9/Z72Rf5z+oONZlA5IP3PyggYVORzbas8Aa6+ZqMo/Y0C18V4NaloNP++/MM=
X-Google-Smtp-Source: AGHT+IHkLC7P0qxfNOZ7am8oGQAhk+QCLx5pooxaYbMLyunCN1d9iFhe6ACMIi4+onLyvuY52I93jw==
X-Received: by 2002:a17:90b:17c5:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-301be205cfamr891476a91.29.1742343337829;
        Tue, 18 Mar 2025 17:15:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:37 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 01/10] splice: Add ubuf_info to prepare for ZC
Date: Wed, 19 Mar 2025 00:15:12 +0000
Message-ID: <20250319001521.53249-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update struct splice_desc to include ubuf_info to prepare splice for
zero copy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/splice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/splice.h b/include/linux/splice.h
index 9dec4861d09f..7477df3916e2 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -10,6 +10,7 @@
 #define SPLICE_H
 
 #include <linux/pipe_fs_i.h>
+#include <linux/skbuff.h>
 
 /*
  * Flags passed in from splice/tee/vmsplice
@@ -43,6 +44,7 @@ struct splice_desc {
 	loff_t *opos;			/* sendfile: output position */
 	size_t num_spliced;		/* number of bytes already spliced */
 	bool need_wakeup;		/* need to wake up writer */
+	struct ubuf_info *ubuf_info;    /* zerocopy infrastructure */
 };
 
 struct partial_page {
-- 
2.43.0


