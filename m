Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FB8688833
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 21:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjBBUXU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 15:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjBBUXS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 15:23:18 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CB96B34E;
        Thu,  2 Feb 2023 12:23:17 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 312KLhl02116280
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 2 Feb 2023 12:21:43 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 312KLhl02116280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1675369310;
        bh=dXToUAE7pJaQg5q02/GLa3Mz5KxM6AhfOCiviB9LkQ0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=UFfeQLpd1CqaHNn2oWCKbjD/Ifu3loYs//M/YBH4IzNZ5zM+uQu+ca+o7wZeN5w3F
         DsbUdz66y666X/uc3jG3vgwkg5rRf6GtVkLag+fJE2MvpK5A0UNEmO1M3fnQXeE1Lo
         Fnl4Ppvdj9DkLLQ/AJYxM7e3cAS5zRrO/+4y12Pny3EZtxFITNqL4C9j1UlDEGI9HH
         V7hreJiSU/iR392Npg1nWQoPfZXJyKUx9354wvJDSamVNEibIAyoENMY/UFznsWzLs
         NKi29eZOby3JTQ76f7S8MgceIaH2aMGDaJX/L7Onx4h96zynB+LoMD69Q9XjMUGe2n
         iFW315XTSuLfQ==
Date:   Thu, 02 Feb 2023 12:21:41 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org
CC:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 01/10] cyrpto/b128ops: Remove struct u128
User-Agent: K-9 Mail for Android
In-Reply-To: <20230202152655.250913242@infradead.org>
References: <20230202145030.223740842@infradead.org> <20230202152655.250913242@infradead.org>
Message-ID: <6B45ADCF-4E3C-4D01-92AB-87BFF6BEE744@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On February 2, 2023 6:50:31 AM PST, Peter Zijlstra <peterz@infradead=2Eorg>=
 wrote:
>Per git-grep u128_xor() and its related struct u128 are unused except
>to implement {be,le}128_xor()=2E Remove them to free up the namespace=2E
>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>---
> include/crypto/b128ops=2Eh |   14 +++-----------
> 1 file changed, 3 insertions(+), 11 deletions(-)
>
>--- a/include/crypto/b128ops=2Eh
>+++ b/include/crypto/b128ops=2Eh
>@@ -50,10 +50,6 @@
> #include <linux/types=2Eh>
>=20
> typedef struct {
>-	u64 a, b;
>-} u128;
>-
>-typedef struct {
> 	__be64 a, b;
> } be128;
>=20
>@@ -61,20 +57,16 @@ typedef struct {
> 	__le64 b, a;
> } le128;
>=20
>-static inline void u128_xor(u128 *r, const u128 *p, const u128 *q)
>+static inline void be128_xor(be128 *r, const be128 *p, const be128 *q)
> {
> 	r->a =3D p->a ^ q->a;
> 	r->b =3D p->b ^ q->b;
> }
>=20
>-static inline void be128_xor(be128 *r, const be128 *p, const be128 *q)
>-{
>-	u128_xor((u128 *)r, (u128 *)p, (u128 *)q);
>-}
>-
> static inline void le128_xor(le128 *r, const le128 *p, const le128 *q)
> {
>-	u128_xor((u128 *)r, (u128 *)p, (u128 *)q);
>+	r->a =3D p->a ^ q->a;
>+	r->b =3D p->b ^ q->b;
> }
>=20
> #endif /* _CRYPTO_B128OPS_H */
>
>

Can we centralize these ordered types, too?
