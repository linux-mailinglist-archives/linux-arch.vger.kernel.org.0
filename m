Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88B10A50A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfKZUGb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 15:06:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51258 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZUGb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 15:06:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so4606512wme.1;
        Tue, 26 Nov 2019 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+b+NNqbOQ+HR3F7WJkh1g/uLtoPIfDf6gFrchEKK20Y=;
        b=aKmqPxE4zIAdduzRXnIUY21W9nSOe8k6KRd48MpoAU20mxNwrJXZNK4vEAEFOGGeQh
         WW+Ylag3O6N/yRHqMWnFMEGopbNbN8SkOeM+UpM4vrWMXtn6qi8irrbTEAPx62Ad+PGp
         amu8scDh/uVEQH2bgfSiDFap4zQnJo24z4ib0dwWMcO7shGwNMhW5Up+u/+Bwo/FBWrB
         BuQsLzmWau0FzArJ2NZSvboeLRnGXVwBgS0OfvMo9GcmeY3XwnAJekXoInVgZGjEj0Lj
         ElNUAKiPjzARWuXOOk7PbMY2mxU93uZgwUl/vf2qEZWhknHcvy0BnrQ1BNgNaqLDJTu4
         auzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+b+NNqbOQ+HR3F7WJkh1g/uLtoPIfDf6gFrchEKK20Y=;
        b=Hhyp0VLTAVD0bVO7IakCg44QN7rv44Lo/n9dMpvmgu1a3ZsZh18XJwPMAI3uvVEZ32
         LOAdRBkZi+dZks14IsLtEOqzIw5WivJEJa4gQT5kNbV6OeBvroEm7g5mfcR3/JyPKee3
         m8vCjq4UrrHEmR4i5jprQIfxxW/q11Q+uknyFsFXH/6ZMIm95zPUmVqv+tuyS9cU6I+G
         HwdDLeRE4cAP2QBeA2FfU1/zX1xO2Fb0Bdy5UrJ8OxzYZzOTzsq13zbEh/dhilERpeOI
         jJsepg/0Nla6t1lo0dNJDvkLjshau4tr1bL6KKovtYGhQ6j+1gqqQTbmXI7XTOH/34Rb
         E1aQ==
X-Gm-Message-State: APjAAAWnQrQxoB8bgblN+d/NIbD+/hum8XG/hZb2D3hKINAL5XlZvTgz
        Ml3fVNIz5W5FiN9P12Z7BtouvLCa
X-Google-Smtp-Source: APXvYqyPpnIXTMhVWKAsXk68HQq7lXaM4TgV4PwH/MbLYfdIOlPwyV43g2zR3Y6A4iXqEzbNrxPzgA==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr791140wmo.7.1574798788866;
        Tue, 26 Nov 2019 12:06:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:404e:f500:ac14:4c10:6104:457f])
        by smtp.gmail.com with ESMTPSA id b3sm4134274wmj.44.2019.11.26.12.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 12:06:27 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] fix __percpu annotation in asm-generic
Date:   Tue, 26 Nov 2019 21:06:19 +0100
Message-Id: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The generic implementation of raw_cpu_generic_add_return() is:

        #define raw_cpu_generic_add_return(pcp, val)            \
        ({                                                      \
                typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));       \
                                                                \
                *__p += val;                                    \
                *__p;                                           \
        })

where the 'pcp' argument is a __percpu lvalue.
There, the variable '__p' is declared as a __percpu pointer
the type of the address of 'pcp') but:
1) the value assigned to it, the return value of raw_cpu_ptr(), is
   a plain (__kernel) pointer, not a __percpu one.
2) the variable is dereferenced just after while a __percpu pointer
   is implicitly __noderef.

So, fix the declaration of the 'pcp' variable to its correct type:
the plain (non-percpu) pointer corresponding to its address.
Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
raw_cpu_generic_cmpxchg_double().

This remove 209 warnings on ARM, 460 on x86 & 2600+ on ppc64.

Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/asm-generic/percpu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index c2de013b2cf4..4ae5f89a0e61 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -74,7 +74,7 @@ do {									\
 
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) __kernel __force *__p = raw_cpu_ptr(&(pcp));	\
 									\
 	*__p += val;							\
 	*__p;								\
@@ -82,7 +82,7 @@ do {									\
 
 #define raw_cpu_generic_xchg(pcp, nval)					\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) __kernel __force *__p = raw_cpu_ptr(&(pcp));	\
 	typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	*__p = nval;							\
@@ -91,7 +91,7 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) __kernel __force *__p = raw_cpu_ptr(&(pcp));	\
 	typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	if (__ret == (oval))						\
@@ -101,8 +101,8 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 ({									\
-	typeof(&(pcp1)) __p1 = raw_cpu_ptr(&(pcp1));			\
-	typeof(&(pcp2)) __p2 = raw_cpu_ptr(&(pcp2));			\
+	typeof(pcp1) __kernel __force *__p1 = raw_cpu_ptr(&(pcp1));	\
+	typeof(pcp2) __kernel __force *__p2 = raw_cpu_ptr(&(pcp2));	\
 	int __ret = 0;							\
 	if (*__p1 == (oval1) && *__p2  == (oval2)) {			\
 		*__p1 = nval1;						\
-- 
2.24.0

