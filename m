Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D184FC55C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 22:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbiDKUDW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 16:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244932AbiDKUDV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 16:03:21 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDB1A074;
        Mon, 11 Apr 2022 13:01:01 -0700 (PDT)
Date:   Mon, 11 Apr 2022 20:00:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1649707256;
        bh=/M7BzW/s7Vzq7EWhCycKAddwYFL6mUxNmXasegv2RH4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=X8gG6RCKUyhRjECpDPWqnHxSZ4C8smmo8/Q+wT1xje58nBjiIhOryAIC6Odf2knlL
         IwOyieEp/xBtQRdMRhlFNFFWTS5DeVhEFDbtbLZUM6wu74fHVC0IUjtNjT+zF8mEff
         bpY3RGI1HYvgcsimqfPR/DxlIi2XBWi+a+Y9EpUNt6WYSD4j8U2djLjkQgz3IyNWeA
         +KMVawUS55opL4z17k33WqvrpkWgcuBOEN936FrhyMdk7cv1hZtw0etI3BFs8J9Iit
         yki/XCMX2R+eww5d7Ym6FtuuBsNayy8wQOkZwGl9jXY5BtSRIPq6IAd+NAeXKJNJ4n
         14FvnFwPCt88Q==
To:     Arnd Bergmann <arnd@arndb.de>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH] asm-generic: fix __get_unaligned_be48() on 32 bit platforms
Message-ID: <20220411195403.230899-1-alobakin@pm.me>
In-Reply-To: <20220406233909.529613-1-alobakin@pm.me>
References: <20220406233909.529613-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>
Date: Wed, 06 Apr 2022 23:46:04 +0000

> While testing the new macros for working with 48 bit containers,
> I faced a weird problem:
>
> 32 + 16: 0x2ef6e8da 0x79e60000
> 48: 0xffffe8da + 0x79e60000
>
> All the bits starting from the 32nd were getting 1d in 9/10 cases.
> The debug showed:
>
> p[0]: 0x00002e0000000000
> p[1]: 0x00002ef600000000
> p[2]: 0xffffffffe8000000
> p[3]: 0xffffffffe8da0000
> p[4]: 0xffffffffe8da7900
> p[5]: 0xffffffffe8da79e6
>
> that the value becomes a garbage after the third OR, i.e. on
> `p[2] << 24`.
> When the 31st bit is 1 and there's no explicit cast to an unsigned,
> it's being considered as a signed int and getting sign-extended on
> OR, so `e8000000` becomes `ffffffffe8000000` and messes up the
> result.
> Cast the @p[2] to u64 as well to avoid this. Now:
>
> 32 + 16: 0x7ef6a490 0xddc10000
> 48: 0x7ef6a490 + 0xddc10000
>
> p[0]: 0x00007e0000000000
> p[1]: 0x00007ef600000000
> p[2]: 0x00007ef6a4000000
> p[3]: 0x00007ef6a4900000
> p[4]: 0x00007ef6a490dd00
> p[5]: 0x00007ef6a490ddc1
>
> Fixes: c2ea5fcf53d5 ("asm-generic: introduce be48 unaligned accessors")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Uhm, ping?

> ---
>  include/asm-generic/unaligned.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unalig=
n=3D
> ed.h
> index 8fc637379899..df30f11b4a46 100644
> --- a/include/asm-generic/unaligned.h
> +++ b/include/asm-generic/unaligned.h
> @@ -143,7 +143,7 @@ static inline void put_unaligned_be48(const u64 val, =
v=3D
> oid *p)
>
>  static inline u64 __get_unaligned_be48(const u8 *p)
>  {
> -=09return (u64)p[0] << 40 | (u64)p[1] << 32 | p[2] << 24 |
> +=09return (u64)p[0] << 40 | (u64)p[1] << 32 | (u64)p[2] << 24 |
>  =09=09p[3] << 16 | p[4] << 8 | p[5];
>  }
>
> --
> 2.35.1

Thanks,
Al

