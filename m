Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6130799DB8
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 12:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346602AbjIJKxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 06:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345116AbjIJKxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 06:53:48 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA4BCCC;
        Sun, 10 Sep 2023 03:53:44 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-573429f5874so2099354eaf.0;
        Sun, 10 Sep 2023 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694343223; x=1694948023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yO8wM+copFRJxZm/8kwNOn/72vUaPl/xBNJjFh2sxHE=;
        b=kzjFoLiwk7CTzyzFzadNhv+N8C49p+AoipqVUZ6KlgWAgeHydKhs4rKVQTn3uOU9rN
         enLgRGKO0Z9JNO+j8S0clFLVX411PgJ7dqPFVCZPoalV4oRDZhB9xvNpk/xE12Dy/mUR
         CSgaqvsg9FF1d9B6th4Drzwoz0V5jisCZfSREvx6DpI1soE5oSaZC6/aNNcbutfYUMpH
         l4iayx4hsKLvrL1Femu5EZ0pPJE5/dm3DJhdzSYTgy18dltFQiGOYUIWYuQQ/mxtJD3d
         ONlfTv1jUG3mQnmPlIW7tXLZt/ghioY7i8gl9t6PfmLj2Tw+CmypGXvLJPAt979cfv2y
         PXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694343223; x=1694948023;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yO8wM+copFRJxZm/8kwNOn/72vUaPl/xBNJjFh2sxHE=;
        b=MhHEz75Y9KBBbkMbBC1Es31eQKX79C0NjkQ3i5gISGv0Ue4Xud3evf3fvT6Zqu2UF8
         FnOqgv69s+vgrHZ+zpyDyrHOzCL0iYidM/WNYP9ODnKbRrX0L23rtlAstIxCFCGWTVE1
         Oy1dZtiXP2ZJhCClf223bQzJe+4li3mHOX8zBUBgdb9X/N/NMicBvJxmIpxZ5k04WZcl
         ONSkOI2QFrLacjyyD+fQ2y8/bfCbEevgNY1Xea4YLbOmr9bYrFLDq2qH1WWRd4Ail6E7
         sltu5K3PoYOOvIgNihFEooz/SG9D5JU1g8p0tKmHqnhtjFbp8l4BuEXmDh8jvYEeWNCh
         Bdrw==
X-Gm-Message-State: AOJu0YycFDYS295kQwOWVbFIv5EkW0UDHcUN4eQuir4VZCJsU4rwSpmY
        GxIZe8mi/TOU757gohd3LYPAFrzgQxBsbieWWlbIMRNa
X-Google-Smtp-Source: AGHT+IGPajXUmUDPLR8w4irxOkNT7upmeHZXoXKapDCb1gdDGStc/HY3Blw1Ed/Ygxr/uMDioTuMqd4TT9CA278JH0E=
X-Received: by 2002:a4a:9111:0:b0:56c:820e:7f02 with SMTP id
 k17-20020a4a9111000000b0056c820e7f02mr5646231oog.0.1694343223503; Sun, 10 Sep
 2023 03:53:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:9d8:0:b0:4f0:1250:dd51 with HTTP; Sun, 10 Sep 2023
 03:53:42 -0700 (PDT)
In-Reply-To: <9a5dd401bf154a0aace0e5f781a3580c@AcuMS.aculab.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
 <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com> <9a5dd401bf154a0aace0e5f781a3580c@AcuMS.aculab.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 10 Sep 2023 12:53:42 +0200
Message-ID: <CAGudoHEuY1cMFStdRAjb8aWbHNqy8Pbeavk6tPB+u=rYzFDF+Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     David Laight <David.Laight@aculab.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/3/23, David Laight <David.Laight@aculab.com> wrote:
> ...
>> When I was playing with this stuff about 5 years ago I found 32-byte
>> loops to be optimal for uarchs of the priod (Skylake, Broadwell,
>> Haswell and so on), but only up to a point where rep wins.
>
> Does the 'rep movsq' ever actually win?
> (Unless you find one of the EMRS (or similar) versions.)
> IIRC it only ever does one iteration per clock - and you
> should be able to match that with a carefully constructed loop.
>

Sorry for late reply, I missed your e-mail due to all the unrelated
traffic in the thread and using gmail client. ;)

I am somewhat confused by the question though. In this very patch I'm
showing numbers from an ERMS-less uarch getting a win from switching
from hand-rolled mov loop to rep movsq, while doing 4KB copies.

Now, one can definitely try to make a case the loop is implemented in
a suboptimal manner and a better one would outperform rep. I did note
myself that such loops *do* beat rep up to a point, last I played with
this it was south of 1KB. It may be higher than that today.

Normally I don't have access to this particular hw, but I can get it again.

I can't stress again one *can* beat rep movsq as plopped in right
here, but only up to a certain size.

Since you are questioning whether movsq wins at /any/ size vs an
optimal loop, I suggest you hack it up, show the win on 4KB on your
uarch of choice and then I'll be happy to get access to the hw I
tested my patch on to bench your variant.

That said, as CPUs get better they execute this loops faster,
interestingly rep is not improving at an equivalent rate which is
rather funny. Even then, there is a limit past which rep wins AFAICS.

-- 
Mateusz Guzik <mjguzik gmail.com>
