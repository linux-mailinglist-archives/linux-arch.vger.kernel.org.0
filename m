Return-Path: <linux-arch+bounces-5380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D992F811
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6831F221A8
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06BB13CA8E;
	Fri, 12 Jul 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y/eOyjZT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07B143C51
	for <linux-arch@vger.kernel.org>; Fri, 12 Jul 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720776937; cv=none; b=grXnTKb40hNsP3x6+bjkpWH/xcuR208CjvrC2Ibsw9PTdBhC4KHvBB0AUcMnFg/EhjjiDX27F8EuwJbHZ3INoIXtc8WL7Hr5TQU38boQmDDQhFAjcgvOxH6TpgVxVPs8c0bt4SoR8lPtf49pSrwi5CY4FhGsWOkFSwkBkFE9+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720776937; c=relaxed/simple;
	bh=kXV0109FCOzso+L559vqF0BSPt0UUb6aogVBVgHjZvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m4zKSlBhw1jux5YCYAsKdPZ59eqd4kpjS/yugPfgIuIeWdlVeckORcc/oyvAKku6854veAd0+q5VPjm6BgWtmqBnsjq1IwGbAebCG1K/978xOiu+hYARmtqqHYesZukttf/3v5GEYljzwkpFXaYkW8d/EXOHpB4qD5vE2WQFeu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y/eOyjZT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a728f74c23dso258855566b.1
        for <linux-arch@vger.kernel.org>; Fri, 12 Jul 2024 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720776933; x=1721381733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wn8z9cRdOEh+xpEHyWfRewfBG/LWm9irdSwzJQPt4vg=;
        b=Y/eOyjZThmcsdw6Hs5Fxg2/ty7n1UbXh1E9545jEWIOAYdXgug5ZpTkA8Lvg2e2h+R
         Y5HR4L8gwKUlpMapiyRxRLiGoWgDzgMN28UTRm+rxVl/KE+sxsin3Ug4WrHgxoYVliWc
         KH2TXcFTLb2bObM8sSVTcVRlR3+9w8Kml0E8XpBMmuBSYXqhFtGhpvIbNKw8wAZPjlvc
         qKqh/8UCN9nEDhs0xUj7F5LUk7J8VEpDsNtWF5tzcp8N7awPa0uNyQv5wVy/vWiXm3Fy
         8LrryUtoN94wC8G0vVT53eMB+2Sgsmj7feJn2+1zS1+7Yfi6GMGLv032xVQ4tJxOaazL
         9LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720776933; x=1721381733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn8z9cRdOEh+xpEHyWfRewfBG/LWm9irdSwzJQPt4vg=;
        b=Wj1JAY9AQ35SQY1wnxmPcQfizk9we2fVqTD0lkvwC4HWrriEktzKLQup612J0U9Gwt
         xJhRwCfRHzqG3aVy81bAoSGKdhDptbvq1jScV3fxyaeJzUw55HVIFKgjWDTj2IqWVc/e
         s8zWGyJbHqrB3AzBFKcD+/il6PZg5yKugQ2BUoqaqD4LnG8BGdiLvWEh50i6NJFSXMDO
         YO9ePxsfdzQraVrFbOTm7wSWX6djwc48213R/rIz79SOuivHtE90tgilwvXn+iRYpiez
         /pU1f8fcnwso7SzrS2o0WKKgtdDW5fzJfEbSQRFEXbhiE2VvPAagTZLm7K3Bx5xzCPch
         RGxg==
X-Gm-Message-State: AOJu0YxMg5GJeAkGLfznBKVPBtOkBXUP0/1z9ZUPxAdAhbd/JnVEjZ08
	8buHqX7tZTHHbdXW/wR2CrCAgRmEtD4kaXz7KiH9ZiXUphaqh+KiBMwk5yb4reA=
X-Google-Smtp-Source: AGHT+IHSQezVZTQQW1YWOTobbr+S5uTMZDEaxVRC5FiDnpQtUZO1W5xkFdreFDBnucdlNuc1el1aSg==
X-Received: by 2002:a17:906:128d:b0:a77:e2e3:354f with SMTP id a640c23a62f3a-a780b6b180dmr793845966b.23.1720776932757;
        Fri, 12 Jul 2024 02:35:32 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7300a5sm330569366b.94.2024.07.12.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 02:35:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] UAPI/ioctl: Improve parameter name of ioctl request definition helpers
Date: Fri, 12 Jul 2024 11:35:23 +0200
Message-ID: <20240712093524.905556-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=kXV0109FCOzso+L559vqF0BSPt0UUb6aogVBVgHjZvk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmkPjdS6x38g4I61Cvhedr2EMZsoXcs7g4Pv0tO SONUGjNnLSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpD43QAKCRCPgPtYfRL+ Tvk/CAChvDEQCj5h5oxdkskTo+bNDeXrjti5iVsuEITNMn2N53JRn/kfWCAavFKe+AJPEKhy9rX brrBDiHCQ9nnDaRmA8f9p0iX0mnaDTlMs1PczrrS8YfZRMAP0QyMHXgiV/YlK/kUiSZTn/5z9v4 PFrD9Q4ogmKYm/n5aO7YwwBewnJThBjfTxs8uOijks8qLdrRQn79kqNiKnPe1IwQLnbhiLx6waY v8gW6Ep0LCrU1pyDSTIpiGaJcL5mv4wwBto8Lw8FzdA6lhGeqFsH3+FAEg9idYCME8SD6ZuIJzG QNsTpTqGcr2qXR8tGfbZaszEE2869L+MtVpCRrEbyxssqFxC
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The third parameter to _IOR et al is a type name, not a size. So the
parameter being named "size" is irritating. Rename it to "argtype"
instead to reduce confusion.

There is a very minor chance that this breaks stuff. It only hurts
however if there is a variable (or macro) in userspace that is called
"argtype" *and* it's used in the parameters of _IOR and friends. IMHO
this is negligible because usually definitions making use of these
macros are provided by kernel headers (i.e. us) or if they are
replicated in userspace code, they are replicated and so supposed to
match the kernel definitions (e.g. to make them usable by programs
without the need to update the kernel headers used to compile the
program).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

if there are doubts about using "argtype": Would "_argtype" be better?

Best regards
Uwe

 include/uapi/asm-generic/ioctl.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/asm-generic/ioctl.h b/include/uapi/asm-generic/ioctl.h
index a84f4db8a250..e3290a5824c9 100644
--- a/include/uapi/asm-generic/ioctl.h
+++ b/include/uapi/asm-generic/ioctl.h
@@ -82,13 +82,13 @@
  * NOTE: _IOW means userland is writing and kernel is reading. _IOR
  * means userland is reading and kernel is writing.
  */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IO(type,nr)			_IOC(_IOC_NONE,(type),(nr),0)
+#define _IOR(type,nr,argtype)		_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(argtype)))
+#define _IOW(type,nr,argtype)		_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(argtype)))
+#define _IOWR(type,nr,argtype)		_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(argtype)))
+#define _IOR_BAD(type,nr,argtype)	_IOC(_IOC_READ,(type),(nr),sizeof(argtype))
+#define _IOW_BAD(type,nr,argtype)	_IOC(_IOC_WRITE,(type),(nr),sizeof(argtype))
+#define _IOWR_BAD(type,nr,argtype)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(argtype))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)

base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
prerequisite-patch-id: 816efa50518af0814a168f7f0ac5904b7128e5b1
-- 
2.43.0


