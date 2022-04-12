Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8CF4FEACB
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 01:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiDLXSq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 19:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiDLXSg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 19:18:36 -0400
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 808053DA45
        for <linux-arch@vger.kernel.org>; Tue, 12 Apr 2022 15:06:18 -0700 (PDT)
Date:   Tue, 12 Apr 2022 21:59:16 +0000
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="M2J2L0iK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1649800761;
        bh=JJtIRzBfNpDrJ/fFtvW6vi1j9+8vDctIDP1NHWiTvOk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=M2J2L0iK2Kc/JQTIjkwhDUkVqWiZJr3O/27pjBoOkV0WQ7k3QLKoWiEY4P8AO2cMT
         OApMkeZx7jZ147jSo5zdtUJ4MYUQI3LZGgFLt5lQy2IbjAyfDr3JdfIat6WFFXrrpK
         w6L6qXuzVppbmyai1QnXQf3zVPlwQmukLWSYtXStunKKc6w2+Je+8XmI1/jRXcuKZM
         ugzbjMCdqaBj+SICra5VB2NALMPCUFd/dOxLuvqDVK4p7PmM55sl91uTxRYp3lYwIP
         Wplktu5ck2NSYZL+AmRdzhMhpS9KKb3ZVDMPNH0oQPlAk2NVHCT0SYTlSBPdbNDOXO
         jnYDIIyAsO8UQ==
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <alobakin@pm.me>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH RESEND] asm-generic: fix __get_unaligned_be48() on 32 bit platforms
Message-ID: <20220412215220.75677-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Resend: target linux-block, expand Ccs a bit

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
2.35.2


