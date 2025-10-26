Return-Path: <linux-arch+bounces-14346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B637CC0B2D5
	for <lists+linux-arch@lfdr.de>; Sun, 26 Oct 2025 21:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485CD3AA2D4
	for <lists+linux-arch@lfdr.de>; Sun, 26 Oct 2025 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F42FE04F;
	Sun, 26 Oct 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b="bOW5E/Ds"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000BA347C7
	for <linux-arch@vger.kernel.org>; Sun, 26 Oct 2025 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510068; cv=none; b=bb1gQBBcNcYGuOoticFa1AaReFacwCA+4WxcbKfdUYCdr8NcxXt3vAkBOMj0zXVDV3MUp6C3aT9cUWOj/adSQ9ERfeV9xc+LN01QHTh7NoBAau2FfPo3aMnSQza1syGDRhvrT5RdpPbhIi73sw9qaLmtgvWdDF8c2ESr5XKWJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510068; c=relaxed/simple;
	bh=6cmkGw7ridHGA5Ra0Gam2hWHwDUIPtc7nwY9+savRes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3zco3grjJfMNR43eHs8Ykfid/MEVKLfXxkUAmKJFsq/Gk9jfCxGb3M0QGWf1ANZO0B4sG6sPnk3pLBUl8ZLvC8O29Ri4Xu5CbLqEAK3NpRUi16gjByamn9B6NUxlKm6fPlgO5w1ZPWexMNF29CPieiVUniS2wtmCvobFlC/a2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk; spf=pass smtp.mailfrom=surgut.co.uk; dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b=bOW5E/Ds; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surgut.co.uk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso9524635e9.0
        for <linux-arch@vger.kernel.org>; Sun, 26 Oct 2025 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=surgut.co.uk; s=google; t=1761510062; x=1762114862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hc8hIMVlXblSUQKCczS0qplI2IZPcuMR2yk3IdKjDio=;
        b=bOW5E/Dsq5ajNQvpPTOuJBQQloZ8fFeBiyHmd+G+JEJXqSV8Km5Rbacw8AhA9h/uKH
         2YmvpI8uIUvZ++TQsHiOf5dY5CugEEHiRS3cSsBgjje0PcylXVV9FAH6xWsLYqUUDJHq
         BZ02yESLchOi7BAsegWQ9DsS3lnrZwjeOaou0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510062; x=1762114862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hc8hIMVlXblSUQKCczS0qplI2IZPcuMR2yk3IdKjDio=;
        b=eXuvX8NroQwRUdrigAzC6s3nR6SXMqd+nq/XnxfgbgcON7t99ywrfC18MBu9UJDbu5
         ciA8R8ePt6huajiDjnBU2PCPEmRHdsp/hf1qra588Ut1rT/SYLe2CzSySMHD6bSrC/os
         yzCHdVsQmgtonkPP7Zt8mQ9urTCTpSkCpwXXIX6zJds5+/u43kp+/MNgCKAoECTzvJTO
         +ejEZVvMxFvfHVQZ1veSw4MtyHpa5Gn1hce8GAhmgfuIudq/Eh5vYx7FsEQeDhglS+Zc
         juLZBxOjloyBlZPfYg/4zm79TOK0eMRvK2B/oGDb1f3p2GQDg+m5/NGH7F8iHtMF53J1
         6qvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaZXMZNMPe1NhEBRsxKwopxqkGkYtq2pRKlsI7X+CwWV9kIC3rjsmNj4arZ2ZTCs93zomY0gIC27DD@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoQN9dFJ9WOFO/pOKE0pgGYon9qQmLs4IzlDtDEix/BMpDh0W
	Ph8Quhpu84bijvWQXVH4MQXn7DZ+vsJTPbAb/2/NjaxQfv3E47wMJTG6IaMEPQAexKhb+6FhKId
	2APyEqL8=
X-Gm-Gg: ASbGncvRHg38yTTMhQh+N1tujJUeX/ItPljBhXv9GFjjuE4Qo9DQCfxujI8ZJspm2m6
	TIOSnJavWTfCdmdJU6LTp8ybYkGOahJbK+N83wSLex57621tGcqoFE7VEzkM1vZkbtESUD1Uymn
	Ffq0W+fwWyhyhewVl0ysvsJyL6o+L4Q4r85Dm7YPDrCsrGRWAM2OvIwhCS/Z2SWR6oQ4Rqjmd1d
	4PDDiwu2DVZXv6bicQHn75uXLVHvlLGAOEGB/GE351tTKkvwlL2tshUEx5OmgMVw6L3fOUqNyso
	GaQv+2zlLd2r6m+w4onxb5Bys1ALjnb63pw0Pbd2EamNCu2DpBRVBQ9+oCUjJ8Dw/pPfPiZeQ7b
	j8ykpAEhnkkQVcep2cOQD2P3jAbQzPsNKSJQ2yR8fRMjCBwM93+U4SFSc3KTiD1lzeX6aYBxLRd
	rYvB56TWKI9qqgZA==
X-Google-Smtp-Source: AGHT+IG8s5HQE3d4ses2cZsHHAgP37V3gTadPVocMJn0oepp1TxOzMppA7/tFk8b1MYo9yP7ey0bWQ==
X-Received: by 2002:a05:600c:3513:b0:471:1415:b545 with SMTP id 5b1f17b1804b1-4711786d625mr282847025e9.7.1761510061672;
        Sun, 26 Oct 2025 13:21:01 -0700 (PDT)
Received: from chainguard ([2a01:4b00:b911:bf00:459d:eae2:cf7e:1a5f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd035e05sm97042815e9.7.2025.10.26.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:21:01 -0700 (PDT)
From: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: masahiroy@kernel.org,
	arnd@arndb.de
Subject: [PATCH] kbuild: align modinfo section for Secureboot Authenticode EDK2 compat
Date: Sun, 26 Oct 2025 20:21:00 +0000
Message-ID: <20251026202100.679989-1-dimitri.ledkov@surgut.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously linker scripts would always generate vmlinuz that has sections
aligned. And thus padded (correct Authenticode calculation) and unpadded
calculation would be same. As in https://github.com/rhboot/pesign userspace
tool would produce the same authenticode digest for both of the following
commands:

    pesign --padding --hash --in ./arch/x86_64/boot/bzImage
    pesign --nopadding --hash --in ./arch/x86_64/boot/bzImage

The commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
vmlinux.unstripped") added .modinfo section of variable length. Depending
on kernel configuration it may or may not be aligned.

All userspace signing tooling correctly pads such section to calculation
spec compliant authenticode digest.

However, if bzImage is not further processed and is attempted to be loaded
directly by EDK2 firmware, it calculates unpadded Authenticode digest and
fails to correct accept/reject such kernel builds even when propoer
Authenticode values are enrolled in db/dbx. One can say EDK2 requires
aligned/padded kernels in Secureboot.

Thus add ALIGN(8) to the .modinfo section, to esure kernels irrespective of
modinfo contents can be loaded by all existing EDK2 firmware builds.

Fixes: 3e86e4d74c04 ("kbuild: keep .modinfo section in vmlinux.unstripped")
Cc: stable@vger.kernel.org
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8a9a2e732a65b..e04d56a5332e6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -832,7 +832,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
-		.modinfo : { *(.modinfo) }				\
+		.modinfo : { *(.modinfo) . = ALIGN(8); }		\
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
-- 
2.51.0


