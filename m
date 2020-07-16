Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0367022267C
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgGPPHd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGPPHc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 11:07:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA83EC061755
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 08:07:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so7371527wrw.12
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k5K4JVLgAWN8MXhgEOCvgA0UlIhXTRBJEiv3tL9R3rg=;
        b=tH9ktcN12P46E6ApuPGUoyvnzH2E2th2kh40XGNX4k8iM8no7a+s0FV7F+FCDpfTHr
         Wr5FS6ieqFbOPl8MzqMWYXPUm+PpEeOc2ndZGy4d8i7H43/i0wB0wSclSrebRIPIzR2W
         DbGSllnO3UA0b0ulfYo24MJN6Z8eqKcDx+6X2OttiaWZB1WpL+FXKLtIIPlfyhdf+Bni
         a5T06Sobj5n5MR7BpjtmWaV64Y9rRzTkiAyt3jOICkL+B+Za5VQU+vBM+90acYba4CMS
         KFf5uNn1iwtG/u7+TH0qv7F/eibowIcJ6Aku1oc5q0HS4762yQ2WQRp8v+4z1ASQ16EZ
         X9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k5K4JVLgAWN8MXhgEOCvgA0UlIhXTRBJEiv3tL9R3rg=;
        b=S5UFPAa2fEQOv7bcuflpawlaTwcTrpGdCHWjlhUVFqvpahEogeoHpYQi6uDOWWLOv8
         2w3ZrvWJIED0XgSDUr1z+d1xNzz0i0z1dsz8qaB/gJhKi4UQCE0hYtsQhcwawyC3nLlz
         2RGkQnfJw6aevr4meXtEWFZPKfCPCV/Ck2fxhUxHjBKe4BsT5OHfQMykwxfatHUMuWrW
         9FOXBUU9OuhGaBycl1D2DiHzJuuwPOEQpNPdP8XyK6lFPBf5Tnr+ycsg/gl1MeeBX5Nb
         BO6Jt/aJMWM9VZswSvnozS36Je0bNnAcg3pCqp2izdcKSEVVkpHHyCklHhfPxXdPCB2u
         e0QA==
X-Gm-Message-State: AOAM533KC3g6H4KAbfJzvdC4YKyZ0LMRzesV/eathhTcbiI8KkFgNTk7
        xZ5XoV8Idt0Ps2pu/4YD7l8HFgReRg==
X-Google-Smtp-Source: ABdhPJzfH0gJAdUum+zexeKADRJslWPQ0rn3StclWShURwDj7HhipMxMfF2t+Vie9f+1p2bxxWHyxg==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr5573136wrq.263.1594912049806;
        Thu, 16 Jul 2020 08:07:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id c25sm8505784wml.18.2020.07.16.08.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:07:28 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Alex Bee <knaerzche@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] linux: arm: vdso: nullpatch vdso_clock_gettime64 for non-virtual timers
Date:   Thu, 16 Jul 2020 17:07:23 +0200
Message-Id: <20200716150723.9389-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Along with commit commit 74d06efb9c2f ("ARM: 8932/1: Add clock_gettime64
entry point") clock_gettime64 was added for ARM platform to solve the
y2k38 problem on 32-bit platforms. glibc from version 2.31 onwards
started using this vdso-call on ARM platforms.
However it was (probably) forgotten to "nullpatch" this call, when no
reliable timer source is available, for example when
"arm,cpu-registers-not-fw-configured" is defined in devicetree for
"arm,armv7-timer".
This results in erratic time jumps whenever "gettimeofday" gets called,
since the (non-working) vdso-call will be used instead of a syscall.

This patch adds clock_gettime64 to get nullpatched as well. It has been
verified to work and solve this issue on Rockchip RK322x, RK3288 and
RPi4 (32-bit kernel build) platforms.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 6bfdca4769a7..fddd08a6e063 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -184,6 +184,7 @@ static void __init patch_vdso(void *ehdr)
 	if (!cntvct_ok) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
 	}
 }
 
-- 
2.17.1

