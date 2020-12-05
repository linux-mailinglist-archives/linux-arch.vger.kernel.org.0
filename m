Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9E2CFCAC
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 19:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgLESTT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 13:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLERic (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 12:38:32 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142C1C09425D;
        Sat,  5 Dec 2020 08:54:10 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id x25so8614230qkj.3;
        Sat, 05 Dec 2020 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIRoSEGJLf8joA0+34Z8WBxAWHJSo0r9QDagd8ox+Nc=;
        b=BVpGu4oj+2gagBMnBu5fD2tvH6kcIWlE4peCRgnJzfVLK+9RxA5P9FS6GqMqfuZv78
         sWDNKqVJqPeWWQCauATjKT4q0ZlHM0PYVyO0JFXfDwk9hLCoB+QOG9XKncu2kGfEHaFf
         848aUPFnkqR4zzUq7Rhm4Jk9SGJCGlrYnbHBXWe+065eWwWe7zjR5vzmzixGDP9GynHK
         8TokbuFMkyGkCxsrKq927pwBGqPVTAa/5iKLCqO98kYHLfRdNh+S9t1RwZNcNwqKsyum
         dxfpTDWHYfyxTyHpkTnkNpMfP+WCBl3DDFrB4C8bRaZDPO2MLIIwnawu1ygxoOT85CsZ
         2LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIRoSEGJLf8joA0+34Z8WBxAWHJSo0r9QDagd8ox+Nc=;
        b=KL4j8xZxoNi4qBpjduaP+aZtZU+ccn5jCIuKSB6e0DUhf49vwcy6UGduF8cU8sOfKq
         BnS99kYBKzSRsi+UaBGl7rH4OQEADZBp+qkvRTRgmZYvZjL+GTuSijD5dvfFVw/bznLV
         cHopqXCh/4E8hQf+Wxv0dWDd30r+YV96Uhdvk1sTjHn7FgXX7NKDUDgQ2iNM0AHvO43J
         nNW7d0Sc8VUh6C3YFsNvuIHax6+9ddZ0HEaN1cAZKuFL9OgA/VnRf5aLcjfBef4CC4HE
         UTTwTjGYs0PqKTZ9ZlvK566A9fVHUErgBIvzMTVjXZ5virriAy5CTBazTiSFRoHORch1
         yyhA==
X-Gm-Message-State: AOAM530aItOUNCIZ+fBGikLHtPwSPN/avWXbDgDhLGldR/Z1OnYfGNd2
        3aIVrnZKe4WHcKKh3uXvwKVcqj3zVU/rlw==
X-Google-Smtp-Source: ABdhPJziRERFUWIPA3cN72AJFivk2FJHGpMa80KMnN1GBZqAqPU3SLoRnHLbIkQ2NQ3W7XSTrN+r4A==
X-Received: by 2002:a37:2d05:: with SMTP id t5mr1146929qkh.187.1607187249235;
        Sat, 05 Dec 2020 08:54:09 -0800 (PST)
Received: from localhost ([12.221.2.200])
        by smtp.gmail.com with ESMTPSA id c138sm9114777qke.95.2020.12.05.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 08:54:08 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] arm64: enable  GENERIC_FIND_FIRST_BIT
Date:   Sat,  5 Dec 2020 08:54:06 -0800
Message-Id: <20201205165406.108990-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
enable it in config. It leads to using find_next_bit() which is less
efficient:

0000000000000000 <find_first_bit>:
   0:	aa0003e4 	mov	x4, x0
   4:	aa0103e0 	mov	x0, x1
   8:	b4000181 	cbz	x1, 38 <find_first_bit+0x38>
   c:	f9400083 	ldr	x3, [x4]
  10:	d2800802 	mov	x2, #0x40                  	// #64
  14:	91002084 	add	x4, x4, #0x8
  18:	b40000c3 	cbz	x3, 30 <find_first_bit+0x30>
  1c:	14000008 	b	3c <find_first_bit+0x3c>
  20:	f8408483 	ldr	x3, [x4], #8
  24:	91010045 	add	x5, x2, #0x40
  28:	b50000c3 	cbnz	x3, 40 <find_first_bit+0x40>
  2c:	aa0503e2 	mov	x2, x5
  30:	eb02001f 	cmp	x0, x2
  34:	54ffff68 	b.hi	20 <find_first_bit+0x20>  // b.pmore
  38:	d65f03c0 	ret
  3c:	d2800002 	mov	x2, #0x0                   	// #0
  40:	dac00063 	rbit	x3, x3
  44:	dac01063 	clz	x3, x3
  48:	8b020062 	add	x2, x3, x2
  4c:	eb02001f 	cmp	x0, x2
  50:	9a829000 	csel	x0, x0, x2, ls  // ls = plast
  54:	d65f03c0 	ret

  ...

0000000000000118 <_find_next_bit.constprop.1>:
 118:	eb02007f 	cmp	x3, x2
 11c:	540002e2 	b.cs	178 <_find_next_bit.constprop.1+0x60>  // b.hs, b.nlast
 120:	d346fc66 	lsr	x6, x3, #6
 124:	f8667805 	ldr	x5, [x0, x6, lsl #3]
 128:	b4000061 	cbz	x1, 134 <_find_next_bit.constprop.1+0x1c>
 12c:	f8667826 	ldr	x6, [x1, x6, lsl #3]
 130:	8a0600a5 	and	x5, x5, x6
 134:	ca0400a6 	eor	x6, x5, x4
 138:	92800005 	mov	x5, #0xffffffffffffffff    	// #-1
 13c:	9ac320a5 	lsl	x5, x5, x3
 140:	927ae463 	and	x3, x3, #0xffffffffffffffc0
 144:	ea0600a5 	ands	x5, x5, x6
 148:	54000120 	b.eq	16c <_find_next_bit.constprop.1+0x54>  // b.none
 14c:	1400000e 	b	184 <_find_next_bit.constprop.1+0x6c>
 150:	d346fc66 	lsr	x6, x3, #6
 154:	f8667805 	ldr	x5, [x0, x6, lsl #3]
 158:	b4000061 	cbz	x1, 164 <_find_next_bit.constprop.1+0x4c>
 15c:	f8667826 	ldr	x6, [x1, x6, lsl #3]
 160:	8a0600a5 	and	x5, x5, x6
 164:	eb05009f 	cmp	x4, x5
 168:	540000c1 	b.ne	180 <_find_next_bit.constprop.1+0x68>  // b.any
 16c:	91010063 	add	x3, x3, #0x40
 170:	eb03005f 	cmp	x2, x3
 174:	54fffee8 	b.hi	150 <_find_next_bit.constprop.1+0x38>  // b.pmore
 178:	aa0203e0 	mov	x0, x2
 17c:	d65f03c0 	ret
 180:	ca050085 	eor	x5, x4, x5
 184:	dac000a5 	rbit	x5, x5
 188:	dac010a5 	clz	x5, x5
 18c:	8b0300a3 	add	x3, x5, x3
 190:	eb03005f 	cmp	x2, x3
 194:	9a839042 	csel	x2, x2, x3, ls  // ls = plast
 198:	aa0203e0 	mov	x0, x2
 19c:	d65f03c0 	ret

 ...

0000000000000238 <find_next_bit>:
 238:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
 23c:	aa0203e3 	mov	x3, x2
 240:	d2800004 	mov	x4, #0x0                   	// #0
 244:	aa0103e2 	mov	x2, x1
 248:	910003fd 	mov	x29, sp
 24c:	d2800001 	mov	x1, #0x0                   	// #0
 250:	97ffffb2 	bl	118 <_find_next_bit.constprop.1>
 254:	a8c17bfd 	ldp	x29, x30, [sp], #16
 258:	d65f03c0 	ret

Enabling this functions would also benefit for_each_{set,clear}_bit().
Would it make sense to enable this config for all such architectures by
default?

Signed-off-by: Yury Norov <yury.norov@gmail.com>

---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..2b90ef1f548e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -106,6 +106,7 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
-- 
2.25.1

