Return-Path: <linux-arch+bounces-14504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B9C32712
	for <lists+linux-arch@lfdr.de>; Tue, 04 Nov 2025 18:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98EDD4F6C6C
	for <lists+linux-arch@lfdr.de>; Tue,  4 Nov 2025 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5048265CAD;
	Tue,  4 Nov 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl04om6l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600633375F
	for <linux-arch@vger.kernel.org>; Tue,  4 Nov 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278508; cv=none; b=oQY6AUUlXS8Z3jFD8IZMnQV80PARRLXeAIoVK8LKcFrYSiXivFBQ3rSzDBAPYz81ljmahu3VwcqEQeQryrxJAe6iIcSVi7AQAnHm09PnyA6Wcs728xQT4Tt+ORmFhdCf939xQozEM3wOTLbolEJOv/4iAr7JWUEbLLfTpv192e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278508; c=relaxed/simple;
	bh=pShB2wGmw9UVAjvo4Af9ENCGF7h74zxwzh2zJGAYYVY=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=EySTRSUSnrsO2v/2ZsXAquj+kBW363L6aHrnFspZDhSSaFCJvyOJ0rIXEXOhi/5eO+HEuuhHni2tqAqzDUmzg0VQm0/eAAwNIG6t+Jq615/1aRrKB/FEaNejHvz42Hi5czq+QNQ2bA+GsrIOdjDEabkL6czjwIZRAf6J6qJiMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl04om6l; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4775638d819so5110875e9.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762278504; x=1762883304; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pShB2wGmw9UVAjvo4Af9ENCGF7h74zxwzh2zJGAYYVY=;
        b=Pl04om6lgClQtQS0A2XvazosOatX2XZ0FTon8AwEI/PqCkK42GnKky9zimz7YaZ6d7
         YydLxJ3HvQ31/BCbTb5MG9MamZ5Yc+J3hKGCtuVFycOKLbR+DifPmkIvdLZ7hzCr775S
         uzGo9JXYhBIc/PwUmjHw9bZpRhI9UoTbd7Djsy+X5CB0VHhAhsaK3PSbEk43hHCT9Ott
         Y0ZV6qXYoD17/DjUDt2Bz1ZCd8AUwUNQKF86fewW/iDjRNHHP7YImeVI/n4P68CqlxCN
         rAa4fIYa3oih1NVMUiL8qg10falxYxnHeb7VoHpXaucbXJ3VDgdrBFQwoohTvyKI7hi1
         x4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278504; x=1762883304;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pShB2wGmw9UVAjvo4Af9ENCGF7h74zxwzh2zJGAYYVY=;
        b=dFgDGmjChoHUGlaH/Zt099QG9aE4Lh2Ga3nyO3ARxOLqI3NJHLYjR+YbTCAn53YuCH
         DT5rf4vQYJLHE6vy3mV+xboAudr20O1a64zxuSlWPJdH3PohH0Il46J87NC4depePXkU
         rIyy3lnJAv0nWcgkx/I9ZngWCOrKtenzaS5jUedURMvz+HL7xpzjE3ZbdvhBBSIAQRFv
         jCkVy6HRPhje05YOsJ5yVlZIyQnC0samb2Y+1Gy8DL3dWr9uF33bjZXj8NpBxaQ2GfOe
         BmHLkD7lw+KNkDJD/RGGHNPqDwdtR3EruftIbpQIlaSL6KAZ24Oj3LR1XB8CU8rYHPnR
         V7jg==
X-Gm-Message-State: AOJu0YxmcSjIVLWy/GulH3I+1PEA5t5E24XkuA/Zb5iYSTtKLBob4HSN
	Re0nejY1xJSuqxSpRtpBvKdcOkuxJ6h5Om2F7DorXCwXxctqFZ6k5jXVCn/SxmOm
X-Gm-Gg: ASbGnctgxLkjFpb8MQ82ebbaeqFPAjJ2JfYDjgvsC5QMP0YdjUCMVqtbfm21VeOY03D
	t+V4TXatm75YOKs0ENg99ARuOxKBVifFihz0NBaInvDdZoviF3286Op1SfUzL1Qctmq/Z1+LOJM
	wVHQMS+rb/SNHIKtPAMHUcaF/ZHwfjm6oUYM/Ufejx1YCn5zQVzEIxfroxHRZ+0YLjM86MEQd+0
	TqQRnPEFmFq7iuyqxvXXA5XYhPKr+91vVRutNgpTKymjhukH3xx1IZIx/kw5J/M8/B8qcNLTKQ6
	rQwL/myLop9EpIzqp8h8wMk/KsV7eI5h9qfWhKXNTnuOEubFYalilXR0PXTwyjQKZQAI4wFx3U+
	Gkl1hocJa7Gx2ZMF/vKX3Xa2JcuVN3ZgbIK5x1VLClFvVPKkUXzYxhwUJDXs1ETjgxyyFPDkmbv
	fXzK4asYN1hrDsiy7S+Nq/VQ37
X-Google-Smtp-Source: AGHT+IFtRzBcrd8akJDo1daUc7o2w19qJbIw8xil1OMWR4+JnC4B5ZxFSMeKTl1VSNwYlLn1uz+UkQ==
X-Received: by 2002:a05:600c:b8a:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-4775cdd134bmr1644055e9.18.1762278503579;
        Tue, 04 Nov 2025 09:48:23 -0800 (PST)
Received: from [127.0.0.1] ([154.80.6.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755932d9csm23024725e9.3.2025.11.04.09.48.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 09:48:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: Carl Thomas <liam.intelservices80@gmail.com>
To: linux-arch@vger.kernel.org
Reply-To: carlthomasces@gmail.com
Subject: Estimating & Takeoff Services
Message-ID: <84c4a57d-7d7a-e416-20e7-9c7da18feca3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Nov 2025 17:48:20 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Are you looking to estimate your projects?

We offer construction =
estimating services and quantity takeoffs to contractors, sub-contractors, =
developers, architects, etc.

Get accurate takeoffs at competitive rates =
with a quick turnaround and win more bids. Thanks.

Regards,
Carl Thomas
Marketing Executive
City Estimating, LLC

