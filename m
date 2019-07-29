Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0795788EF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfG2Jz2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 05:55:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46998 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2Jz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 05:55:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so58793877edr.13
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 02:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NlP37yJWnRvCf/6oy+/WBuYp7kupTFflC6d63icZ58U=;
        b=SoSJIbaL6UDouyPmXQ0huDbosGSu9Isuwe7Yqkvh6mkGCDYVGNJaHf3FeflNwyWl6Z
         Wv2J+4M/SfwgRbBiUnN5KUugVWUN0x+VS4xkHGO6NT1GC481YsydBeXS37ZUBSr5UjSN
         PZIgQh84T+34fpWtHlHu00M9BS9EWty1FaHo0J3Nosdhfw9HZsWB10lC4DJoHXbdkMe/
         LQvuGA4PoWlBoFDskPtzyRRlJwzUv1WNpevPs4AdBl44Zi3Irhiw4ZYkrvRlfoute4b8
         GJ+Ij3deiTYyjsqP3UpGBD6HuRjlryiLzVVFTnrvIhQRlu/lQfD5Q3DRDbY3BQR6c2VF
         Mceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NlP37yJWnRvCf/6oy+/WBuYp7kupTFflC6d63icZ58U=;
        b=UdwGNWjC505jKbdqgCrT84g9xT5rT5DizljvUt9PWTtpoMoKFKvpa4uMmmXFpOIXLy
         V6UyvHmKL5yaYKB8I07+8kmfSkHc4adCRbKeeJxba5wZmiwHRoGjCUpoamHuum23uNR/
         3y7jlnMaGJw7TfvgS/fdsGmiTTQjJGZhJazj7XCWHf1C/Yh1EiV4afL3awHpiAoDBRCq
         qwgZR80naoClQTBd7yXZ8Z/3pBegzjdwm93qpOBveg9Jyq2N3kBTmsG0Kpyiy5hX9aMG
         kaQIBJwQYX8hT7NmQGGu5tDdAgWcfJUitfzj3A5sJ/Ciz+eBEm5+snFezVYgl7ImM4IW
         2d0w==
X-Gm-Message-State: APjAAAUEKdjDxNOGepmsBUHtBnwa0CT5qn+kmb59H4phJiwgfazrTTxo
        4eoKq0ossjaoLrMb4xaNEY9wwQ==
X-Google-Smtp-Source: APXvYqwXmKDINViOqoAIEQYx5JexZCPjcbfkFEi7sRznT6c+6VU/L37pWvagkWcdvYfA4JcjoAQWDw==
X-Received: by 2002:a50:a4ef:: with SMTP id x44mr96841532edb.304.1564394126141;
        Mon, 29 Jul 2019 02:55:26 -0700 (PDT)
Received: from mba13.hotspot.parkpalaceresidence.com ([212.92.108.154])
        by smtp.gmail.com with ESMTPSA id b15sm16211987edb.46.2019.07.29.02.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:55:25 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] asm-generic: make simd.h a mandatory include/asm header
Date:   Mon, 29 Jul 2019 12:55:21 +0300
Message-Id: <20190729095521.1916-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The generic aegis128 software crypto driver recently gained support
for using SIMD intrinsics to increase performance, for which it
uncondionally #include's the <asm/simd.h> header. Unfortunately,
this header does not exist on many architectures, resulting in
build failures.

Since asm-generic already has a version of simd.h, let's make it
a mandatory header so that it gets instantiated on all architectures
that don't provide their own version.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/asm-generic/Kbuild | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 6f4536d70b8e..adff14fcb8e4 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -3,3 +3,5 @@
 # asm headers that all architectures except um should have
 # (This file is not included when SRCARCH=um since UML borrows several
 # asm headers from the host architecutre.)
+
+mandatory-y += simd.h
-- 
2.17.1

