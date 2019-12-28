Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0142112BD4E
	for <lists+linux-arch@lfdr.de>; Sat, 28 Dec 2019 11:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfL1KeE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Dec 2019 05:34:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47028 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfL1KeE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Dec 2019 05:34:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id m8so27592776edi.13;
        Sat, 28 Dec 2019 02:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lpAQbHq8g6hcvfoq54Da1G6S7tfv48hgOJnTAd1NDNs=;
        b=L5MEbVAIdT5xfjKUxKtH7Pi5NGIwnWPsudMdVO+c8vQAZPIXuuu9jvPKIhB4V8vaoj
         fbzf1xwtlL7SRYzaLM3BpUsM6bZRcnaGojfsFIzSmaVpjzgWjgeishqT4WJeqV6A7l6e
         Pe/HLjvHVqF7gLB6P30ZBgOscp7t3m100SgyAaaNdOTMyEjkyJZubF8Goak+f6iYKd5F
         rrfEzH8nmu7XG4ySkLKPJMv8wtKXN8f8enXFm49SRbGSuoOJh92HrRe2vrNz18QXOaFc
         wDOMi7ldGmelter4N57ICLkNUERfQGCDpUj1PwChsFOvthtbsevxfl0hv/SsbGsPdK6K
         wJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lpAQbHq8g6hcvfoq54Da1G6S7tfv48hgOJnTAd1NDNs=;
        b=FGKN4YllRwMjKTdPnLK3eLVyoqnv6FnAq9QMI+4OICqDc8/Z5PX0UPWGgqTvg5UWc4
         NCkZv3WPGGu0+cw8ObBgx2vMKx1LALkPI9O1H8J7rRf0cCUvDyl5DWPfo3mOTNDahhS0
         DxiuhP0Hg5nNsOXM04sEwa5qEkfORtV+6czzT3lFH6Z1sV9e12R/59n91DAM7v91t4LJ
         BiRtjccqq8lx6zBqj9loLoPk3rPihLveAcPYPDC63VyJ2+LJNMILW6yrr+HhF4sRkHgt
         sAwMEX8zp2e9TKKU9f1inR1tGPSaMcsFSU6xyTMxnP9XvVRO9ndsn882JQHJnlmkDebU
         l1hg==
X-Gm-Message-State: APjAAAUFOuvpg4l3sCtIQqgBYyVssddA0m2xrLogJTxi+hGenFzAsJX3
        jWilaPECEsz84qwKxC8h2RE=
X-Google-Smtp-Source: APXvYqwejBvbImOwxjtvBAgWEp4PBHbXfcL4qImmZuBEVyXuen8MZIRRimp2ajrUwFleM63cCvicBQ==
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr59379615edr.223.1577529241977;
        Sat, 28 Dec 2019 02:34:01 -0800 (PST)
Received: from localhost.localdomain ([85.107.87.79])
        by smtp.googlemail.com with ESMTPSA id o88sm4223486eda.41.2019.12.28.02.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 02:34:01 -0800 (PST)
From:   isidentical <batuhanosmantaskaya@gmail.com>
Cc:     isidentical <batuhanosmantaskaya@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: ensure signedness of large numbers
Date:   Sat, 28 Dec 2019 13:33:56 +0300
Message-Id: <20191228103357.23904-1-batuhanosmantaskaya@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This change introduces a sanitity helper for
numbers that are larger than 2^5.

Signed-off-by: isidentical <batuhanosmantaskaya@gmail.com>
---
 include/uapi/asm-generic/hugetlb_encode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
index b0f8e87235bd..42c06c62ae17 100644
--- a/include/uapi/asm-generic/hugetlb_encode.h
+++ b/include/uapi/asm-generic/hugetlb_encode.h
@@ -31,6 +31,6 @@
 #define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(UINT32_C(34) << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
-- 
2.20.1

