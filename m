Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F432510E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBYN5x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 08:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhBYN5q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 08:57:46 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66444C06174A;
        Thu, 25 Feb 2021 05:57:06 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id w1so4099148qto.2;
        Thu, 25 Feb 2021 05:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+Er2AMgvvg9wNih89ONA7/yh52BeqTQADmg6hQCNNk=;
        b=oANFhxvwcRf+H93mDQVdIHtrafrmXMO69qpuNH5wFtBiIk65oCljFf3wn0j9jWD8Jf
         xn773fkXJ5cBecoo8uOiGVpVCd00OKIG+d/kDiqhzaL2TAP9FyYPMdmUPtcF+ogzFkPL
         es0Tc7y/WEes/sMCApl5bUip4fDutrrP3R0PZJ4JgJ00N+RMCEqK+DNA9AdpAnhPfl+w
         dVIhFJFqSCTCZEepp/T3/mXx1z5U3ubcmCMBf6t5yJxmvT7cZUHy6rjLdJh6/PzYLgG9
         yFiuCDoMYIdVI33U7YCIGPueqX1+1YpI0ifvCK5aWl7TbDuBok5CUIQ0bNVadRTvBEgI
         bgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+Er2AMgvvg9wNih89ONA7/yh52BeqTQADmg6hQCNNk=;
        b=FNQm+WEof1rMAzjgc9um6m5fLF+EexfiVUb+VilvmsYLjkM6hjUVDLafcCET1lt9Xv
         KW8E8VA8SwBP3MoIit9u01TSBrL1TgV/uvH97duhmIhK4EDNJPG+gZ6IOyLWnREqmCgE
         r09J0OlgcZsG4AMexm7bm+REuej2Mt48RnA/d1R6jiGTAce6VoShGkKi3Ecbdp89x6BA
         cohy3+R9CDLXkpzzaF21+r+CYo7QrjXPk6BRQQtCkkqU5RhP6ZUVBeZx1GFpZuHNDqzY
         63yVBmEdLIsbGkaVaHvSJtk8AV0/h8Qprn3e60wlhOjG5myT6h0WjLCMY3GVVE2YUjAo
         3vNQ==
X-Gm-Message-State: AOAM532fgdBOwFpDebfhImAtwMnntzl0k/EcfqUQEixymIdzYXpjgb6+
        Rw1DvEDHVddQM4wpYny01s0=
X-Google-Smtp-Source: ABdhPJx245qzXjqscdkfz2xTv/fJGcyhYJpB7sYfuTawFg2dSpSKA/6rKwLo4Qv96QoYYrlnwcVfbw==
X-Received: by 2002:ac8:6958:: with SMTP id n24mr2377747qtr.110.1614261425391;
        Thu, 25 Feb 2021 05:57:05 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id f17sm3514072qtv.93.2021.02.25.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 05:57:05 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [RESEND PATCH 1/2] ARM64: enable GENERIC_FIND_FIRST_BIT
Date:   Thu, 25 Feb 2021 05:56:59 -0800
Message-Id: <20210225135700.1381396-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225135700.1381396-1-yury.norov@gmail.com>
References: <20210225135700.1381396-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
enable it in a config. It leads to using find_next_bit() which is less
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

Enabling find_{first,next}_bit() would also benefit for_each_{set,clear}_bit().
On A-53 find_first_bit() is almost twice faster than find_next_bit(), according
to lib/find_bit_benchmark (thanks to Alexey for testing):

GENERIC_FIND_FIRST_BIT=n:
[7126084.948181] find_first_bit:               47389224 ns,  16357 iterations
[7126085.032315] find_first_bit:               19048193 ns,    655 iterations

GENERIC_FIND_FIRST_BIT=y:
[   84.158068] find_first_bit:               27193319 ns,  16406 iterations
[   84.233005] find_first_bit:               11082437 ns,    656 iterations

GENERIC_FIND_FIRST_BIT=n bloats the kernel despite that it disables generation
of find_{first,next}_bit():

        yury:linux$ scripts/bloat-o-meter vmlinux vmlinux.ffb
        add/remove: 4/1 grow/shrink: 19/251 up/down: 564/-1692 (-1128)
        ...

Overall, GENERIC_FIND_FIRST_BIT=n is harmful both in terms of performance and
code size, and it's better to have GENERIC_FIND_FIRST_BIT enabled.

Tested-by: Alexey Klimov <aklimov@redhat.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 31bd885b79eb..5596eab04092 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -108,6 +108,7 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
-- 
2.25.1

