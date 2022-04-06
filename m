Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A64F6ED6
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiDFXsL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 19:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbiDFXsK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2022 19:48:10 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD4150415
        for <linux-arch@vger.kernel.org>; Wed,  6 Apr 2022 16:46:12 -0700 (PDT)
Date:   Wed, 06 Apr 2022 23:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1649288767;
        bh=msv3nOGjLIGTrH1A0ydlYoFmzBEnAkJ0hjTDqARjFZY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=VO5Vhnal3btdccM03/zjx2HXeh90LnPQtZxVlbYpXI/CIiB1agDAywbdGZh5hywcq
         ABZlR70nWy5Ow9CkEO/b7fi6iEkoZCzmSITCMiB7MjVivjekK659yX21GM2dNVOIRA
         mh59hg3iMWpa2Z+NfVHe3TPbA6B69hxMVJR5JzD8ZsZ1nW2u9MIUMZBgDT1MsW60lq
         A+aMAv9jOnBanleUgziFJ7IbNKttao6DHkEcfLY675fWBdkapXa3bm8kOBxcieAygi
         9GJ9QNw4ZrZLFW2iSKAgXg0dG1qMEwHClLk4n7XC6K8HFN/eb1kQPE6jYtGllJ3H9d
         6DkQR7EZW/BwQ==
To:     Arnd Bergmann <arnd@arndb.de>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <alobakin@pm.me>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH] asm-generic: fix __get_unaligned_be48() on 32 bit platforms
Message-ID: <20220406233909.529613-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

While testing the new macros for working with 48 bit containers,
I faced a weird problem:

32 + 16: 0x2ef6e8da 0x79e60000
48: 0xffffe8da + 0x79e60000

All the bits starting from the 32nd were getting 1d in 9/10 cases.
The debug showed:

p[0]: 0x00002e0000000000
p[1]: 0x00002ef600000000
p[2]: 0xffffffffe8000000
p[3]: 0xffffffffe8da0000
p[4]: 0xffffffffe8da7900
p[5]: 0xffffffffe8da79e6

that the value becomes a garbage after the third OR, i.e. on
`p[2] << 24`.
When the 31st bit is 1 and there's no explicit cast to an unsigned,
it's being considered as a signed int and getting sign-extended on
OR, so `e8000000` becomes `ffffffffe8000000` and messes up the
result.
Cast the @p[2] to u64 as well to avoid this. Now:

32 + 16: 0x7ef6a490 0xddc10000
48: 0x7ef6a490 + 0xddc10000

p[0]: 0x00007e0000000000
p[1]: 0x00007ef600000000
p[2]: 0x00007ef6a4000000
p[3]: 0x00007ef6a4900000
p[4]: 0x00007ef6a490dd00
p[5]: 0x00007ef6a490ddc1

Fixes: c2ea5fcf53d5 ("asm-generic: introduce be48 unaligned accessors")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 include/asm-generic/unaligned.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligne=
d.h
index 8fc637379899..df30f11b4a46 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -143,7 +143,7 @@ static inline void put_unaligned_be48(const u64 val, vo=
id *p)

 static inline u64 __get_unaligned_be48(const u8 *p)
 {
-=09return (u64)p[0] << 40 | (u64)p[1] << 32 | p[2] << 24 |
+=09return (u64)p[0] << 40 | (u64)p[1] << 32 | (u64)p[2] << 24 |
 =09=09p[3] << 16 | p[4] << 8 | p[5];
 }

--
2.35.1


