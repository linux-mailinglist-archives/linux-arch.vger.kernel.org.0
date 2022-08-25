Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4965A0FFD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiHYMKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 08:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiHYMKI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 08:10:08 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB46501B8
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 05:10:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id 1706724BD076
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 14:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661429040;
        bh=hOvUGidUUrGrMUjmPI+/XMer+oQNBymwrHhnXuuUqOc=;
        h=Date:Subject:References:To:Reply-To:From:In-Reply-To;
        b=Jp9sWZnGSYY0wjfdbqI9Ei/enJHPRP5M5h5mjsQJrFhsIDRWVovzkbSxrFm66I9JK
         Zx72OKTV01pDpk4gwi4bA8sBEVVHJW/WSMX4L7m0AW8wQ9h7FrjhbPbmytJkIJQURO
         KhzcmjCzQ+jXdfU/LOv+27QpN24uqSWGyC9tJXoU=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id B968224BD0F7; Thu, 25 Aug 2022 14:03:59 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx301.security-mail.net (Postfix) with ESMTPS id 260D424BD0F9; Thu, 25 Aug
 2022 14:03:58 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id C2F5F27E0396; Thu, 25 Aug 2022
 14:03:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id AD93B27E0394; Thu, 25 Aug 2022 14:03:58 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 QC7bRFxmXFkQ; Thu, 25 Aug 2022 14:03:58 +0200 (CEST)
Received: from [127.0.0.1] (unknown [192.168.37.161]) by zimbra2.kalray.eu
 (Postfix) with ESMTPSA id 823AE27E038A; Thu, 25 Aug 2022 14:03:58 +0200
 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <15fe8.6307652e.e7776.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu AD93B27E0394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661429038;
 bh=tJ4vaRP0xdN5QKdKCiqGvZMJGCe16Dw/5xFo9C5p/ts=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=i5kVvfkP8GsHt8oXaeYOqIC1halbeIsdvECJD7CNMk6OZGOHQ/5dH2VDbhE7vCpV5
 m+CI03JwaNYsqMDaegszr4Ok5wK2EXBa65CFptOFKDoAqLBdUTBrbKHuXpDz/PfNzx
 bQ4dSptLg70wZN1YUhj/fEVixzAM5UUlPEoItySI=
Message-ID: <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
Date:   Thu, 25 Aug 2022 14:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Fwd: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
References: <20220817161438.32039-2-ysionneau@kalray.eu>
Content-Language: en-us
To:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Reply-To: 20220817161438.32039-1-ysionneau@kalray.eu
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <20220817161438.32039-2-ysionneau@kalray.eu>
X-Forwarded-Message-Id: <20220817161438.32039-2-ysionneau@kalray.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Forwarding also the actual patch to linux-kbuild and linux-arch

-------- Forwarded Message --------
Subject: 	[RFC PATCH 1/1] Fix __kcrctab+* sections alignment
Date: 	Wed, 17 Aug 2022 18:14:38 +0200
From: 	Yann Sionneau <ysionneau@kalray.eu>
To: 	linux-kernel@vger.kernel.org
CC: 	Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada 
<masahiroy@kernel.org>, Jules Maselbas <jmaselbas@kalray.eu>, Julian 
Vetter <jvetter@kalray.eu>, Yann Sionneau <ysionneau@kalray.eu>



Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
include/linux/export-internal.h | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/export-internal.h 
b/include/linux/export-internal.h
index c2b1d4fd5987..d86bfbd7fa6d 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -12,6 +12,6 @@
/* __used is needed to keep __crc_* for LTO */
#define SYMBOL_CRC(sym, crc, sec) \
- u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
+ u32 __section("___kcrctab" sec "+" #sym) __used __aligned(4) 
__crc_##sym = crc
#endif /* __LINUX_EXPORT_INTERNAL_H__ */

-- 
2.37.2





