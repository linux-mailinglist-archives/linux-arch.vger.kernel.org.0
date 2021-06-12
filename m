Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3403A4ED4
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFLMi6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhFLMi6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 08:38:58 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7C2C061574;
        Sat, 12 Jun 2021 05:36:45 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id ew3so1834554qvb.13;
        Sat, 12 Jun 2021 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsrrNxvqr0ZVyyHIEhpRBEc6nR3RPUyX6D/adRK9t7c=;
        b=kQy3FMTZw31dJK7+ceEfeRjNFZcKYVle64U+QOKWZaFd9kaP90pEkX7eF8NqhMfO3C
         PKIHBAbDuKBEANuW5x/gbmHGymEHDRtoBQjG0Bc69jro9fq5LxQdffPPEtjlO8XrjI2V
         Zd4JNOS3AWQm5+b47fI/JkDYuOGku5cXsEYRwkFj+tq59tfhtBynt/XHPlN+0qA/p9zR
         py8Etw2QygNagX/i4XMkDAUOyalXSHXSvYtshdVTQUq21Aq6/aVo5Aby81lMeJq5oJ8z
         ZiRf4ZSUqll2V0nKuzgRB/ws13eX66sLz2XpRJATxZMPW+Zbp2pbpGDcCUGLt159mNZV
         cEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsrrNxvqr0ZVyyHIEhpRBEc6nR3RPUyX6D/adRK9t7c=;
        b=sGTB/geS9Xx0KWMdnignrxxhg67qQ/ndZNQgnFirYlQPVJVC8aAFHT2dwKDe9UGz59
         ab42YsQGIMK4w+Z++HuEXmnXA5QeYSQhDQQ48Zj6MtZTwPwfCrmxT9ks3gH4aBCOoDtS
         Cqw899l8nfcoo1xCCS4q404z82mWOKWpkGkMNwuzgajitlp2H8XolObhotEF+77N46cl
         CLK+b9BJyeOvHYP421OXOmhG5Kf5v1cLhNyApo9I3ynQev18klMk7qqc/502XYX/Fe99
         u4E49Td7oCODh/tl+3uGPCRmJxDTUWoMyj2l8YQ3PzV/CgewGOaOOtf+K0eP02k/S8H7
         +h5w==
X-Gm-Message-State: AOAM53304TPb32rhWVrLjkeiKpK9GU+Eaa8TJgivfi66+yuGlNJgJMCW
        l0fNiOeq7Mp6gCoSUmIjoUL9fI8eSZpBww==
X-Google-Smtp-Source: ABdhPJyGmmW9UlWc6YCiOYMRnBakAtj6/HBbmRgJ9ZBVdGlvS+DCOnOpJnNsDWajoOkJPn4P3NRsbA==
X-Received: by 2002:a05:6214:1791:: with SMTP id ct17mr9405660qvb.21.1623501404873;
        Sat, 12 Jun 2021 05:36:44 -0700 (PDT)
Received: from localhost ([70.127.84.75])
        by smtp.gmail.com with ESMTPSA id 144sm6283699qkk.103.2021.06.12.05.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:36:44 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/8] bitops: protect find_first_{,zero}_bit properly
Date:   Sat, 12 Jun 2021 05:36:32 -0700
Message-Id: <20210612123639.329047-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_first_bit() and find_first_zero_bit() are not protected with
ifdefs as other functions in find.h. It causes build errors on some
platforms if CONFIG_GENERIC_FIND_FIRST_BIT is enabled.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitops/find.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 0d132ee2a291..835f959a25f2 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -97,6 +97,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 
 #ifdef CONFIG_GENERIC_FIND_FIRST_BIT
 
+#ifndef find_first_bit
 /**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
@@ -116,7 +117,9 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 
 	return _find_first_bit(addr, size);
 }
+#endif
 
+#ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
  * @addr: The address to start the search at
@@ -136,6 +139,8 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 
 	return _find_first_zero_bit(addr, size);
 }
+#endif
+
 #else /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
 #ifndef find_first_bit
-- 
2.30.2

